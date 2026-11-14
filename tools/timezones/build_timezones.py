"""Genera el índice de zonas horarias sin conexión para geo_kit.

Fuente de los polígonos: timezone-boundary-builder (con océanos), datos
© OpenStreetMap contributors, licencia ODbL 1.0, tal como los empaqueta
el paquete PyPI `timezonefinder-data` (versión de datos en data_version.txt).

Uso (desde la raíz del repo):
    pip install timezonefinder==9.2.0 timezonefinder-data==4.2026.6 shapely==2.2.0
    python3 tools/timezones/build_timezones.py [tolerancia_grados]

Salida: packages/geo_kit/assets/timezones.bin.gz

Formato binario (little-endian), coordenadas en enteros de 1e-5 grados:
    "PSTZ" | u16 versión=1 | u16 nZonas | por zona: u8 largo + nombre UTF-8
    | u8 largo + versión de datos | u32 nPolígonos
    por polígono: u16 zona | i32 minLon, minLat, maxLon, maxLat | u16 nAnillos
      por anillo: u32 nPuntos | i32 lon0, lat0 | (nPuntos−1) pares de
      deltas zigzag-varint (dLon, dLat)
Las zonas de tierra van antes que las de océano (Etc/...).
"""
import gzip
import io
import os
import struct
import sys

import timezonefinder_data
from shapely.geometry import MultiPolygon, Polygon
from timezonefinder import TimezoneFinder

SCALE = 100_000
OUT = "packages/geo_kit/assets/timezones.bin.gz"


def zigzag(n):
    return (n << 1) ^ (n >> 63)


def varint(n, buf):
    while True:
        b = n & 0x7F
        n >>= 7
        if n:
            buf.write(bytes([b | 0x80]))
        else:
            buf.write(bytes([b]))
            return


def to_shape(geometry):
    polys = []
    for poly in geometry:
        outer = list(zip(poly[0][0], poly[0][1]))
        holes = [list(zip(h[0], h[1])) for h in poly[1:]]
        if len(outer) >= 3:
            polys.append(Polygon(outer, holes))
    return MultiPolygon(polys).buffer(0) if polys else None


def main(tolerance):
    tf = TimezoneFinder()
    names = sorted(tf.timezone_names, key=lambda n: (n.startswith("Etc/"), n))
    data_version = open(os.path.join(os.path.dirname(timezonefinder_data.__file__),
                                     "data", "data_version.txt")).read().strip()
    polygons = []
    for zi, name in enumerate(names):
        shape = to_shape(tf.get_geometry(tz_name=name, coords_as_pairs=False))
        if shape is None or shape.is_empty:
            continue
        simple = shape.simplify(tolerance, preserve_topology=True)
        parts = getattr(simple, "geoms", [simple])
        for p in parts:
            if p.is_empty or p.geom_type != "Polygon" or p.area == 0:
                continue
            rings = [p.exterior.coords] + [r.coords for r in p.interiors]
            polygons.append((zi, p.bounds, rings))
    buf = io.BytesIO()
    buf.write(b"PSTZ" + struct.pack("<HH", 1, len(names)))
    for n in names:
        b = n.encode()
        buf.write(struct.pack("<B", len(b)) + b)
    v = data_version.encode()
    buf.write(struct.pack("<B", len(v)) + v)
    buf.write(struct.pack("<I", len(polygons)))
    points = 0
    for zi, (minx, miny, maxx, maxy), rings in polygons:
        buf.write(struct.pack("<H4iH", zi, *(round(c * SCALE) for c in (minx, miny, maxx, maxy)),
                              len(rings)))
        for ring in rings:
            pts = [(round(x * SCALE), round(y * SCALE)) for x, y in ring][:-1]
            buf.write(struct.pack("<I2i", len(pts), *pts[0]))
            for (x0, y0), (x1, y1) in zip(pts, pts[1:]):
                varint(zigzag(x1 - x0), buf)
                varint(zigzag(y1 - y0), buf)
            points += len(pts)
    raw = buf.getvalue()
    with gzip.open(OUT, "wb", compresslevel=9) as f:
        f.write(raw)
    print(f"datos {data_version}: {len(names)} zonas, {len(polygons)} polígonos, "
          f"{points} puntos, {len(raw)/1e6:.2f} MB sin comprimir, "
          f"{os.path.getsize(OUT)/1e6:.2f} MB gzip")


if __name__ == "__main__":
    main(float(sys.argv[1]) if len(sys.argv) > 1 else 0.005)

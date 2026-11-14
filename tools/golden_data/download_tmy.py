"""Descarga el año meteorológico típico (TMY) de PVGIS 5.3 para los 6 sitios
y lo guarda comprimido como entrada fija de las pruebas golden.

Uso (desde la raíz del repo):  python3 tools/golden_data/download_tmy.py

Salida: packages/solar_engine/test/golden/tmy/<sitio>.csv.gz con columnas
  epoch_start  inicio de la hora, segundos UTC desde 1970
  ghi,dni,dhi  W/m²
  temp_air     °C
  wind_speed   m/s (10 m)
Datos: PVGIS © Unión Europea, 2001-2026 (CC BY 4.0).
"""
import gzip
import io
import json
import urllib.request
from datetime import datetime, timezone

from sites import SITES, TMY_DIR

URL = "https://re.jrc.ec.europa.eu/api/v5_3/tmy?lat={lat}&lon={lon}&outputformat=json"


def main():
    for key, s in SITES.items():
        with urllib.request.urlopen(URL.format(**s), timeout=60) as r:
            data = json.load(r)
        rows = data["outputs"]["tmy_hourly"]
        buf = io.StringIO()
        buf.write("epoch_start,ghi,dni,dhi,temp_air,wind_speed\n")
        for row in rows:
            t = datetime.strptime(row["time(UTC)"], "%Y%m%d:%H%M").replace(tzinfo=timezone.utc)
            buf.write(f"{int(t.timestamp())},{row['G(h)']},{row['Gb(n)']},{row['Gd(h)']},"
                      f"{row['T2m']},{row['WS10m']}\n")
        with gzip.open(f"{TMY_DIR}/{key}.csv.gz", "wt", compresslevel=9) as f:
            f.write(buf.getvalue())
        meta = data["inputs"]["meteo_data"]
        print(key, len(rows), meta["radiation_db"], meta["year_min"], meta["year_max"])


if __name__ == "__main__":
    main()

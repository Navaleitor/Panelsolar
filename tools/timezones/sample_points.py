"""Genera puntos de prueba con la zona correcta según timezonefinder (datos
sin simplificar) para validar el índice simplificado de geo_kit.

Uso (desde la raíz): python3 tools/timezones/sample_points.py
Salida: packages/geo_kit/test/golden/timezones_sample.csv
"""
import csv
import random

from timezonefinder import TimezoneFinder

CITIES = {
    "Hermosillo": (29.0729, -110.9559), "Cancún": (21.1619, -86.8515),
    "Tijuana": (32.5149, -117.0382), "Monterrey": (25.6866, -100.3161),
    "CDMX": (19.4326, -99.1332), "Chihuahua": (28.6353, -106.0889),
    "Mérida": (20.9674, -89.5926), "Mexicali": (32.6245, -115.4523),
    "Ciudad Juárez": (31.6904, -106.4245), "La Paz BCS": (24.1426, -110.3128),
    "Phoenix": (33.4484, -112.0740), "Madrid": (40.4168, -3.7038),
    "Bogotá": (4.7110, -74.0721), "Santiago": (-33.4489, -70.6693),
    "Sídney": (-33.8688, 151.2093), "Atlántico": (20.0, -40.0),
}


def main():
    tf = TimezoneFinder()
    rows = [(name, la, lo, tf.timezone_at(lat=la, lng=lo)) for name, (la, lo) in CITIES.items()]
    rnd = random.Random(42)
    for i in range(3000):
        la, lo = rnd.uniform(-60, 75), rnd.uniform(-180, 180)
        rows.append((f"r{i}", round(la, 5), round(lo, 5), tf.timezone_at(lat=la, lng=lo)))
    # Más densidad en México (la app empieza ahí).
    for i in range(1000):
        la, lo = rnd.uniform(14.5, 32.7), rnd.uniform(-117.1, -86.7)
        rows.append((f"mx{i}", round(la, 5), round(lo, 5), tf.timezone_at(lat=la, lng=lo)))
    with open("packages/geo_kit/test/golden/timezones_sample.csv", "w", newline="") as f:
        w = csv.writer(f)
        w.writerow(["name", "lat", "lon", "zone"])
        w.writerows(rows)


if __name__ == "__main__":
    main()

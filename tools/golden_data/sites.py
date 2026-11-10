"""Sitios de referencia del plan maestro (sección B.6 / D).

Coordenadas del centro de cada ciudad; altitud aproximada (m).
"""

SITES = {
    "monterrey": dict(name="Monterrey", lat=25.6866, lon=-100.3161, alt=540, tz=-6),
    "cdmx": dict(name="Ciudad de México", lat=19.4326, lon=-99.1332, alt=2240, tz=-6),
    "hermosillo": dict(name="Hermosillo", lat=29.0729, lon=-110.9559, alt=210, tz=-7),
    "madrid": dict(name="Madrid", lat=40.4168, lon=-3.7038, alt=667, tz=1),
    "bogota": dict(name="Bogotá", lat=4.7110, lon=-74.0721, alt=2640, tz=-5),
    "phoenix": dict(name="Phoenix", lat=33.4484, lon=-112.0740, alt=331, tz=-7),
}

# Rutas relativas a la raíz del repositorio.
GOLDEN_DIR = "packages/solar_engine/test/golden"
TMY_DIR = GOLDEN_DIR + "/tmy"

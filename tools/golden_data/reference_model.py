"""Cadena de modelos de referencia con pvlib, idéntica en convenciones al
motor Dart (packages/solar_engine/lib/src/simulation/simulator.dart).

Convenciones compartidas (documentadas en docs/formulas/12-simulacion-horaria.md):
- Cada registro horario es el promedio de la hora que empieza en epoch_start;
  el Sol se evalúa a la mitad de la hora (epoch_start + 30 min).
- NREL SPA con ΔT calculado (calculate_deltat), presión estándar a la altitud
  del sitio (alt2pres) y 12 °C para la refracción; se usa el cenit aparente.
- Extraterrestre de Spencer, masa de aire de Kasten y Young (1989).
- Si el cenit aparente ≥ 90°: directa = 0 y difusa del cielo = 0.
- Albedo constante 0.2.
"""
import numpy as np
import pandas as pd
import pvlib
from pvlib import atmosphere, iam, inverter, irradiance, pvsystem, temperature

ALBEDO = 0.2

# Dos sistemas de prueba: uno "típico" y otro que fuerza recorte del inversor
# y usa los modelos alternativos.
SYSTEMS = {
    "s1": dict(tilt="lat", azimuth=180.0, pdc0=1000.0, gamma=-0.0035,
               dc_ac=1.2, eta_nom=0.96, transposition="perez",
               thermal=("faiman", 25.0, 6.84), iam_b0=0.05,
               losses=dict(soiling=2, shading=0, snow=0, mismatch=2, wiring=2,
                           connections=0.5, lid=1.5, nameplate_rating=1,
                           age=0, availability=3)),
    "s2": dict(tilt=10.0, azimuth=135.0, pdc0=1000.0, gamma=-0.004,
               dc_ac=1.4, eta_nom=0.97, transposition="haydavies",
               thermal=("noct", 45.0), iam_b0=0.05,
               losses=dict(soiling=0, shading=0, snow=0, mismatch=0, wiring=0,
                           connections=0, lid=0, nameplate_rating=0,
                           age=0, availability=0)),
}


def load_tmy(path):
    return pd.read_csv(path)


def solar_geometry(epoch_start, site):
    times = pd.to_datetime(np.asarray(epoch_start) + 1800, unit="s", utc=True)
    sp = pvlib.solarposition.spa_python(
        times, site["lat"], site["lon"], altitude=site["alt"],
        pressure=atmosphere.alt2pres(site["alt"]), temperature=12.0,
        delta_t=None)
    return times, sp


def tilt_of(system, site):
    return round(abs(site["lat"])) if system["tilt"] == "lat" else system["tilt"]


def run(df, site, system):
    times, sp = solar_geometry(df["epoch_start"], site)
    zen = sp["apparent_zenith"].to_numpy()
    az = sp["azimuth"].to_numpy()
    up = zen < 90
    ghi = df["ghi"].to_numpy(float)
    dni = np.where(up, df["dni"].to_numpy(float), 0.0)
    dhi = df["dhi"].to_numpy(float)
    dni_extra = irradiance.get_extra_radiation(times).to_numpy()
    am = atmosphere.get_relative_airmass(zen)
    tilt = tilt_of(system, site)
    azim = system["azimuth"]
    if system["transposition"] == "perez":
        sky = irradiance.perez(tilt, azim, dhi, dni, dni_extra, zen, az, am)
    else:
        sky = irradiance.haydavies(tilt, azim, dhi, dni, dni_extra, zen, az)
    sky = np.where(up, np.nan_to_num(np.asarray(sky, float)), 0.0)
    ground = irradiance.get_ground_diffuse(tilt, ghi, ALBEDO)
    aoi = irradiance.aoi(tilt, azim, zen, az)
    direct = np.maximum(dni * np.cos(np.radians(aoi)), 0)
    poa = direct + sky + ground
    mod = iam.ashrae(aoi, system["iam_b0"])
    eff = direct * mod + sky + ground
    temp, wind = df["temp_air"].to_numpy(float), df["wind_speed"].to_numpy(float)
    th = system["thermal"]
    if th[0] == "faiman":
        tc = temperature.faiman(poa, temp, wind, th[1], th[2])
    else:
        tc = temperature.ross(poa, temp, noct=th[1])
    loss = pvsystem.pvwatts_losses(**system["losses"])
    pdc = pvsystem.pvwatts_dc(eff, tc, system["pdc0"], system["gamma"])
    pdc = np.maximum(pdc, 0) * (1 - loss / 100)
    pac_max = system["pdc0"] / system["dc_ac"]
    pac = inverter.pvwatts(pdc, pac_max / system["eta_nom"], system["eta_nom"])
    return pd.DataFrame(dict(
        epoch_start=df["epoch_start"], zenith=zen, azimuth=az,
        poa_global=poa, poa_direct=direct, poa_sky=sky, poa_ground=ground,
        aoi=aoi, iam=mod, temp_cell=tc, pdc=pdc, pac=pac))

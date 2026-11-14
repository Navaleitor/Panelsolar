"""Valores de referencia externos para la validación cruzada (plan D):
energía anual de un sistema de 1 kWp en los 6 sitios según

1. PVWatts v8 de NREL (motor SAM, vía PySAM, ejecutado localmente con el
   mismo TMY de PVGIS que usan las pruebas golden), y
2. la calculadora PVcalc de PVGIS 5.3 (en línea, con sus propios datos y
   modelos).

Sistema común: tilt = |latitud| redondeada, azimut sur, rack abierto,
módulo estándar (γ = −0.37 %/°C), pérdidas 14.08 % (desglose por defecto de
PVWatts), DC/AC 1.2, inversor 96 %.

Uso (desde la raíz):
    pip install nrel-pysam==7.1.1.post1 pandas
    python3 tools/golden_data/cross_validation.py
Salida: tools/golden_data/out/cross_reference.csv
"""
import json
import os
import urllib.request

import numpy as np
import pandas as pd
import PySAM.Pvwattsv8 as pvwatts

from sites import SITES, TMY_DIR

LOSSES = 14.0757
DC_AC = 1.2
INV_EFF = 96.0
PVCALC = ("https://re.jrc.ec.europa.eu/api/v5_3/PVcalc?lat={lat}&lon={lon}"
          "&peakpower=1&loss=14.08&angle={tilt}&aspect=0&mountingplace=free"
          "&outputformat=json")


def pysam_annual(key, site, tilt):
    df = pd.read_csv(f"{TMY_DIR}/{key}.csv.gz")
    # TMY en UTC (cada mes de otro año) → hora estándar local de un año
    # sin bisiesto, empezando el 1 de enero a las 00:00.
    t = pd.to_datetime(df["epoch_start"], unit="s", utc=True)
    local = t + pd.Timedelta(hours=site["tz"])
    order = np.lexsort((local.dt.hour, local.dt.day, local.dt.month))
    df = df.iloc[order].reset_index(drop=True)
    local = local.iloc[order].reset_index(drop=True)
    m = pvwatts.default("PVWattsNone")
    m.SolarResource.solar_resource_data = dict(
        lat=site["lat"], lon=site["lon"], tz=site["tz"], elev=site["alt"],
        year=[1990] * len(df), month=local.dt.month.tolist(),
        day=local.dt.day.tolist(), hour=local.dt.hour.tolist(),
        minute=[30] * len(df), dn=df["dni"].tolist(), df=df["dhi"].tolist(),
        gh=df["ghi"].tolist(), tdry=df["temp_air"].tolist(),
        wspd=df["wind_speed"].tolist(), albedo=[0.2] * len(df))
    m.SystemDesign.system_capacity = 1.0
    m.SystemDesign.tilt = tilt
    m.SystemDesign.azimuth = 180
    m.SystemDesign.array_type = 0
    m.SystemDesign.module_type = 0
    m.SystemDesign.losses = LOSSES
    m.SystemDesign.dc_ac_ratio = DC_AC
    m.SystemDesign.inv_eff = INV_EFF
    m.execute()
    # Salidas horarias en W y W/m² → kWh y kWh/m².
    return sum(m.Outputs.ac) / 1000, sum(m.Outputs.poa) / 1000


def pvgis_annual(site, tilt):
    with urllib.request.urlopen(PVCALC.format(tilt=tilt, **site), timeout=60) as r:
        d = json.load(r)
    fixed = d["outputs"]["totals"]["fixed"]
    return fixed["E_y"], fixed["H(i)_y"], d["inputs"]["meteo_data"]["radiation_db"]


def main():
    rows = []
    for key, site in SITES.items():
        tilt = round(abs(site["lat"]))
        e_sam, h_sam = pysam_annual(key, site, tilt)
        e_pvgis, h_pvgis, db = pvgis_annual(site, tilt)
        rows.append(dict(site=key, tilt=tilt, pvwatts_kwh=e_sam,
                         pvwatts_poa_kwh_m2=h_sam, pvgis_kwh=e_pvgis,
                         pvgis_poa_kwh_m2=h_pvgis, pvgis_db=db))
    os.makedirs("tools/golden_data/out", exist_ok=True)
    out = pd.DataFrame(rows)
    out.to_csv("tools/golden_data/out/cross_reference.csv", index=False,
               float_format="%.2f")
    print(out)


if __name__ == "__main__":
    main()

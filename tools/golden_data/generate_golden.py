"""Genera los CSV de referencia (golden) con pvlib para las pruebas de
packages/solar_engine.

Uso (desde la raíz del repo):
    pip install pvlib==0.16.1 pandas numpy
    python3 tools/golden_data/download_tmy.py      # solo si se quiere renovar el TMY
    python3 tools/golden_data/generate_golden.py

Salidas en packages/solar_engine/test/golden/:
- solar_position.csv   posición solar (cada 23 h del TMY de cada sitio)
- hourly_s1.csv/_s2    detalle horario (cada 10.ª hora diurna) por sitio
- annual.csv           totales de toda la serie por sitio y sistema
- formulas.csv         casos sueltos por fórmula (Erbs, IAM, temperatura, ...)
- meta.csv             versiones de pvlib, pandas y numpy usadas
"""
import gzip
import platform

import numpy as np
import pandas as pd
import pvlib
from pvlib import atmosphere, iam, inverter, irradiance, pvsystem, temperature

from reference_model import SYSTEMS, load_tmy, run, solar_geometry, tilt_of
from sites import GOLDEN_DIR, SITES, TMY_DIR


def site_tables():
    pos, annual, hourly = [], [], {k: [] for k in SYSTEMS}
    for key, site in SITES.items():
        df = load_tmy(f"{TMY_DIR}/{key}.csv.gz")
        sel = df.iloc[::23]
        _, sp = solar_geometry(sel["epoch_start"], site)
        pos.append(pd.DataFrame(dict(
            site=key, sample_epoch=sel["epoch_start"].to_numpy() + 1800,
            zenith=sp["zenith"].to_numpy(),
            apparent_zenith=sp["apparent_zenith"].to_numpy(),
            azimuth=sp["azimuth"].to_numpy())))
        for name, system in SYSTEMS.items():
            out = run(df, site, system)
            out.insert(0, "row", np.arange(len(out)))
            day = out[out["zenith"] < 90].iloc[::10]
            day.insert(0, "site", key)
            hourly[name].append(day)
            annual.append(dict(
                site=key, system=name, tilt=tilt_of(system, site),
                poa_kwh_m2=out["poa_global"].sum() / 1000,
                dc_kwh=out["pdc"].sum() / 1000,
                ac_kwh=out["pac"].sum() / 1000))
    pd.concat(pos).to_csv(f"{GOLDEN_DIR}/solar_position.csv", index=False,
                          float_format="%.8f")
    for name, frames in hourly.items():
        pd.concat(frames).drop(columns=["epoch_start"]).to_csv(
            f"{GOLDEN_DIR}/hourly_{name}.csv", index=False, float_format="%.6f")
    pd.DataFrame(annual).to_csv(f"{GOLDEN_DIR}/annual.csv", index=False,
                                float_format="%.4f")


def formula_table():
    rows = []

    def add(formula, inputs, output):
        rows.append(dict(formula=formula, **{f"in{i}": v for i, v in enumerate(inputs)},
                         out=output))

    for doy in [1, 32, 81, 172, 266, 355, 365]:
        add("extra_spencer", [doy], float(irradiance.get_extra_radiation(doy)))
    for z in [0, 30, 60, 75, 85, 89.5]:
        add("airmass_ky", [z], float(atmosphere.get_relative_airmass(z)))
    for alt in [0, 540, 2240, 2640]:
        add("alt2pres", [alt], float(atmosphere.alt2pres(alt)))
    for tilt, saz, z, az in [(25, 180, 30, 160), (40, 180, 70, 250), (10, 135, 50, 90),
                             (90, 270, 20, 100), (0, 180, 45, 200)]:
        add("aoi", [tilt, saz, z, az], float(irradiance.aoi(tilt, saz, z, az)))
    for ghi, z, doy in [(50, 80, 15), (300, 60, 100), (600, 40, 172), (950, 15, 200),
                        (1050, 10, 180), (150, 86, 300), (400, 88, 10)]:
        r = irradiance.erbs(np.array([ghi]), np.array([z]), np.array([doy]))
        for k in ["dni", "dhi", "kt"]:
            add(f"erbs_{k}", [ghi, z, doy], float(np.asarray(r[k])[0]))
    for a in [0, 30, 60, 80, 87, 89.9, 95]:
        add("iam_ashrae", [a, 0.05], float(iam.ashrae(np.array([a]), 0.05)[0]))
    for poa, ta, ws in [(0, 20, 1), (800, 30, 2), (1000, 35, 0.5), (500, 10, 5)]:
        add("faiman", [poa, ta, ws], float(temperature.faiman(poa, ta, ws)))
        add("ross_noct45", [poa, ta], float(temperature.ross(poa, ta, noct=45)))
    for e, tc in [(1000, 25), (800, 50), (200, 10), (0, 30)]:
        add("pvwatts_dc", [e, tc, 5000, -0.0035],
            float(pvsystem.pvwatts_dc(e, tc, 5000, -0.0035)))
    for pdc in [0, 20, 1000, 3000, 4800, 5200, 7000]:
        add("inverter_pvwatts", [pdc, 5000 / 0.96, 0.96],
            float(inverter.pvwatts(np.array([pdc], float), 5000 / 0.96, 0.96)[0]))
    add("losses_default", [], float(pvsystem.pvwatts_losses(
        soiling=2, shading=0, snow=0, mismatch=2, wiring=2, connections=0.5,
        lid=1.5, nameplate_rating=1, age=0, availability=3)))
    # Difusa del cielo: (tilt, saz, dhi, dni, dni_extra, zen, az)
    cases = [(30, 180, 120, 700, 1400, 35, 170), (20, 180, 300, 50, 1350, 60, 120),
             (45, 200, 80, 850, 1410, 25, 190), (10, 135, 200, 400, 1380, 70, 250),
             (60, 180, 150, 600, 1320, 80, 230)]
    for c in cases:
        am = float(atmosphere.get_relative_airmass(c[5]))
        add("perez", list(c), float(irradiance.perez(*c, am)))
        add("haydavies", list(c), float(irradiance.haydavies(*c)))
    pd.DataFrame(rows).to_csv(f"{GOLDEN_DIR}/formulas.csv", index=False,
                              float_format="%.10f")


def meta():
    pd.DataFrame([dict(pvlib=pvlib.__version__, pandas=pd.__version__,
                       numpy=np.__version__, python=platform.python_version())]
                 ).to_csv(f"{GOLDEN_DIR}/meta.csv", index=False)


if __name__ == "__main__":
    site_tables()
    formula_table()
    meta()
    print(pd.read_csv(f"{GOLDEN_DIR}/annual.csv"))

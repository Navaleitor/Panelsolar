"""Genera las tablas de términos periódicos del NREL SPA en Dart a partir de
pvlib.spa (que a su vez las toma de Reda y Andreas, 2004).

Uso (desde la raíz del repo):  python3 tools/golden_data/gen_spa_tables.py
Después: dart format packages/solar_engine/lib
"""
import pvlib.spa as s

OUT = "packages/solar_engine/lib/src/position/"
HDR = """// Tablas de términos periódicos del algoritmo NREL SPA (Reda y Andreas, 2004,
// NREL/TP-560-34302, {tabla}). Generado desde pvlib.spa con
// tools/golden_data/gen_spa_tables.py; no editar a mano.
// Ficha: docs/formulas/01-posicion-solar-spa.md
// Cada fila de las tablas L/B/R es [A, B, C] para el término A·cos(B + C·JME).
"""


def fmt(name, arr, doc):
    out = [f"/// {doc}", f"const List<List<double>> {name} = ["]
    for r in arr:
        out.append("  [" + ", ".join(repr(float(x)) for x in r) + "],")
    out.append("];\n")
    return "\n".join(out)


def main():
    earth = HDR.format(tabla="tablas A4.2 y A4.3") + "\n"
    for n in ["L0", "L1", "L2", "L3", "L4", "L5"]:
        earth += fmt("spa" + n, getattr(s, n), f"Longitud heliocéntrica, serie {n}.") + "\n"
    for n in ["B0", "B1"]:
        earth += fmt("spa" + n, getattr(s, n), f"Latitud heliocéntrica, serie {n}.") + "\n"
    for n in ["R0", "R1", "R2", "R3", "R4"]:
        earth += fmt("spa" + n, getattr(s, n), f"Radio vector Tierra-Sol, serie {n}.") + "\n"
    with open(OUT + "spa_earth_terms.dart", "w") as f:
        f.write(earth.rstrip() + "\n")
    nut = HDR.format(tabla="tabla A4.3 (nutación)") + "\n"
    nut += fmt("spaNutationAbcd", s.NUTATION_ABCD_ARRAY,
               "Coeficientes [a, b, c, d] de nutación en longitud y oblicuidad.") + "\n"
    nut += fmt("spaNutationY", s.NUTATION_YTERM_ARRAY,
               "Multiplicadores Y0..Y4 de los argumentos X0..X4.")
    with open(OUT + "spa_nutation_terms.dart", "w") as f:
        f.write(nut.rstrip() + "\n")


if __name__ == "__main__":
    main()

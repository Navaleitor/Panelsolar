"""Revisa que un reporte lcov tenga la cobertura de líneas mínima.

Uso: python3 tools/ci/check_coverage.py <lcov.info> <mínimo %>
Imprime la cobertura por archivo (solo los que no están al 100 %) y falla
(código 1) si el total queda por debajo del mínimo.
"""
import sys


def main(path, minimum):
    files, current = {}, None
    with open(path) as f:
        for line in f:
            line = line.strip()
            if line.startswith("SF:"):
                current = line[3:]
                files[current] = [0, 0]
            elif line.startswith("DA:") and current:
                hits = int(line[3:].split(",")[1])
                files[current][0] += 1
                files[current][1] += hits > 0
    total = sum(v[0] for v in files.values())
    hit = sum(v[1] for v in files.values())
    for name, (n, h) in sorted(files.items()):
        if h < n:
            print(f"{100 * h / n:6.1f} %  {name}")
    pct = 100 * hit / total if total else 0
    print(f"Cobertura total: {pct:.1f} % ({hit}/{total} líneas); mínimo {minimum} %")
    return 0 if pct >= minimum else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], float(sys.argv[2])))

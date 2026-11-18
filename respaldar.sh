#!/usr/bin/env bash
# Respaldo de los materiales de UNA aplicación: la oferta, el CV adaptado y la cover letter.
# Copia todo a aplicaciones/<app-id>_<empresa>/ en este repo (privado). No hace commit:
# el commit va con el respaldo normal de la sesión (ver README).
#
#   ./respaldar.sh <app-id> "<Empresa>" [--oferta oferta.md] [--cv tailored.md] [--keywords keywords.txt]
#                  [--cl letter.md] [--out ruta/a/cv-toolkit/out]
#
# --out (por defecto ../cv-toolkit/out) es donde make.sh deja los PDF y el .docx de la cover letter;
# el script toma de ahí los archivos con el nombre de la empresa.
# Si se vuelve a correr para la misma aplicación, sobrescribe: el historial de git guarda cada versión.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
app="${1:?app-id, ej. app-92}"; company="${2:?nombre de la empresa, igual que en make.sh}"; shift 2
oferta=""; cv=""; kw=""; cl=""; out="$HERE/../cv-toolkit/out"
while [ $# -gt 0 ]; do
  case "$1" in
    --oferta) oferta="$2"; shift 2 ;;
    --cv) cv="$2"; shift 2 ;;
    --keywords) kw="$2"; shift 2 ;;
    --cl) cl="$2"; shift 2 ;;
    --out) out="$2"; shift 2 ;;
    *) echo "argumento desconocido: $1" >&2; exit 2 ;;
  esac
done

slug="$(python3 -c 'import sys,re,unicodedata; s=unicodedata.normalize("NFKD",sys.argv[1]).encode("ascii","ignore").decode().lower(); print(re.sub(r"[^a-z0-9]+","-",s).strip("-"))' "$company")"
dest="$HERE/aplicaciones/${app}_${slug}"
mkdir -p "$dest"

copy() { [ -n "$1" ] && { [ -f "$1" ] || { echo "no existe: $1" >&2; exit 1; }; cp "$1" "$dest/$2"; echo "  + $2"; }; return 0; }
copy "$oferta" "oferta.md"
copy "$cv" "cv.md"
copy "$kw" "keywords.txt"
copy "$cl" "cover-letter.md"

for f in "Resume - David Prado - $company.pdf" \
         "Cover Letter - David Prado - $company.docx" \
         "Cover Letter - David Prado - $company.pdf"; do
  if [ -f "$out/$f" ]; then cp "$out/$f" "$dest/$f"; echo "  + $f"; fi
done

echo "respaldo en: aplicaciones/${app}_${slug}/"
ls -1 "$dest"
[ -f "$dest/oferta.md" ] || echo "AVISO: falta oferta.md (el texto completo de la oferta)"

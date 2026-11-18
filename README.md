# Tracker de aplicaciones

Todo lo necesario para el tracker de búsqueda laboral de David Prado, publicado como artifact de Claude:
https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5

Los datos vivos están en la base del artifact (capacidad `db`). Este repo guarda el código, las reglas y copias de los datos para poder rehacer todo si el artifact se pierde, como pasó el 15–16 de noviembre de 2026.

## Archivos
| Ruta | Qué es |
|---|---|
| `index.html` | La página completa (HTML, CSS y JS en un solo archivo, sin dependencias). Pestañas: Aplicaciones, Métricas, Tecnologías y puestos, Descartes, Búsquedas y Rúbrica. Botones para exportar la base a JSON y CSV. |
| `docs/rubrica-clasificacion.md` | Rúbrica para clasificar cada oferta (filtros, encaje, prioridad, estado, campos del tracker). En el artifact se publica como `rubrica.md`, que la pestaña Rúbrica carga por ruta relativa. |
| `docs/busqueda-urls-linkedin.md` | URLs de LinkedIn del run diario con Apify, configuración del actor, aprendizajes e historial de pruebas. |
| `docs/tracker-busquedas.md` | Cómo se llenan las colecciones `busquedas` y `runs` en cada run diario. |
| `docs/barrido-posts-linkedin.md` | Prueba del barrido de posts de reclutadores (actor `harvestapi/linkedin-post-search`). |
| `docs/cv-structure.md` | Reglas para adaptar el CV a cada oferta y pasos de build con `cv-toolkit`. |
| `cv/master-cv.md` | Copia del CV maestro. **La fuente de verdad sigue siendo `davitpra/cv-toolkit/master-cv.md`**: para cambiar el CV se edita allá; esta copia es solo respaldo. |
| `data/<colección>/<id>.json` | Copia de la base del tracker, un archivo por documento (`applications/app-N.json`, `busquedas/<id>.json`, `runs/<fecha>_<busqueda>.json`). El historial de git guarda cada versión. |

Los documentos de `docs/` son copias de los del proyecto "Aplicaciones Tech" en claude.ai (carpeta `claude/` y `cv/`). Si cambian allá, hay que actualizar la copia aquí.

## Cómo se mantiene el respaldo (decisión del 2026-11-18)
No hay tarea programada. En toda sesión de Claude que trabaje el tracker, antes de terminar:
1. Leer `settings/backup` en la base del artifact (`ultimo` = fecha del último respaldo).
2. Consultar los documentos de `applications` con `updatedAt` posterior a `ultimo` (incluye los que David editó a mano en la página) y escribir cada uno en `data/applications/<id>.json`. Lo mismo con `busquedas` y `runs` creados o cambiados en la sesión. Borrar el archivo de los documentos eliminados.
3. Si cambió la rúbrica, el CV maestro u otro documento del proyecto, actualizar su copia en `docs/` o `cv/`.
4. Commit ("Respaldo AAAA-MM-DD: …") y push a `main`.
5. Actualizar `settings/backup` con `ultimo` = hora del commit y `commit` = su hash.

La página muestra arriba la fecha del último respaldo y cuántos cambios faltan subir.

## Capacidades que declara el artifact
```json
{
  "db": { "rules": [{ "path": "", "read": "view", "write": "interact" }] },
  "user": {},
  "downloads": true
}
```

## Colecciones de la base
- `applications/app-N`: una oferta por documento (empresa, puesto, estado, encaje, prioridad, fechas, señal, contacto, notas, `clasif`, `cvVersiones`, `motivoDescarte`, salario normalizado…). Ver Paso 5 de la rúbrica.
- `busquedas/<id>`: una ficha por URL de búsqueda de LinkedIn.
- `runs/<fecha>_<busqueda>`: resultado de cada run diario.
- `settings/rubrica`: versión y lista de cambios de la rúbrica.
- `settings/taxonomia`: `perfil`, las tecnologías que David ya tiene (nombres canónicos). La pestaña Tecnologías y puestos marca como brecha todo lo que no esté ahí. Copia en `data/settings/taxonomia.json`.

## Restaurar
1. Publicar `index.html` y `docs/rubrica-clasificacion.md` (como `rubrica.md`) en un artifact nuevo.
2. Declarar las capacidades de arriba.
3. Cargar los documentos de `data/` con `db_write` (50 operaciones por llamada; la ruta del archivo es la ruta del documento). `settings/rubrica` se rehace con la versión y los cambios de `docs/rubrica-clasificacion.md`.
4. Actualizar el link del tracker en las instrucciones del proyecto y en `docs/`.

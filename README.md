# Tracker de aplicaciones

Código de la página del tracker de búsqueda laboral de David Prado, publicada como artifact de Claude:
https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5

Los datos no viven aquí: están en la base del artifact (capacidad `db`). Este repo guarda el código para poder republicarlo si el artifact se pierde, como pasó el 15–16 de noviembre de 2026.

## Archivos
- `index.html`: la página completa (HTML, CSS y JS en un solo archivo, sin dependencias). Pestañas: Aplicaciones, Métricas, Tecnologías y puestos, Descartes, Búsquedas y Rúbrica. Botones para exportar la base a JSON y CSV.
- `rubrica.md`: el texto de la rúbrica de clasificación que muestra la pestaña Rúbrica (la página lo carga por ruta relativa).

## Capacidades que declara el artifact
```json
{
  "db": { "rules": [{ "path": "", "read": "view", "write": "interact" }] },
  "user": {},
  "downloads": true
}
```

## Colecciones de la base
- `applications/app-N`: una oferta por documento (empresa, puesto, estado, encaje, prioridad, fechas, señal, contacto, notas, `clasif`, `cvVersiones`, `motivoDescarte`, salario normalizado…).
- `busquedas/<id>`: una ficha por URL de búsqueda de LinkedIn.
- `runs/<fecha>_<busqueda>`: resultado de cada run diario.
- `settings/rubrica`: versión y lista de cambios de la rúbrica.

## Restaurar
1. Publicar `index.html` y `rubrica.md` como un artifact nuevo.
2. Declarar las capacidades de arriba.
3. Cargar los documentos de un respaldo JSON con `db_write`.

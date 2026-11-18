# Pestaña Búsquedas del tracker

Agregada el 2026-10-28 a pedido de David. Complementa `claude/busqueda-urls-linkedin.md` (el detalle de cada prueba sigue allí).

**Tracker actual (desde el 2026-11-18):** https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5 (slug `127d32ff-931e-43a0-bacb-ea91ac08e75c`). El tracker anterior (FsyQMtsZNsn3QTk84ypRpB) desapareció el 15–16 de noviembre; cualquier mención a ese link en otros documentos está vieja.

## Qué guarda
- Colección `busquedas`: una ficha por URL con `nombre`, `estado` (Validada, En prueba, Pendiente de decisión, Histórico, Descartada), `fechaEstado`, `desde`, `keywords`, `ubicacion`, `modalidad`, `ventana`, `limite`, `url`, `proposito`, `vigilar`, `orden`. Ids cargados tras la reconstrucción: `nucleo`, `backend`, `contratos` (validadas), `nextjs` (descartada) y `posts` (barrido de posts, en prueba).
- Colección `runs`: un documento por run y URL, id `<fecha>_<busqueda>`, con `fecha`, `busqueda`, `total`, `limite`, `utiles`, `nota`, `utilesFuente` ("historial" o "tracker") y `dataset`. La pestaña muestra solo las URLs validadas y no muestra el costo (decisión de David). Tras la reconstrucción solo están los runs de validación (14–20 oct y 2–4 nov) y el del 16 nov (`todas`, sin reparto por URL).
- Campo `busqueda` en cada aplicación que vino de Apify: el id de la URL que la trajo. `sin-dato` = no se sabe cuál.

## Qué hacer en cada run diario
1. Al agregar cada oferta al tracker, poner `busqueda` según el `inputUrl` del dataset (`nucleo`, `backend` o `contratos`). Si la misma oferta sale en dos URLs el mismo día, la primera que la trajo.
2. Al terminar, escribir un documento en `runs` por URL: total del dataset por URL, `limite` 60, útiles (Por aplicar + Evaluar de esa URL), costo real del run repartido por total (`costoUsd`), `dataset` y `utilesFuente: "tracker"`.
3. Si una URL cambia de estado (se valida, se descarta, entra una en prueba), actualizar su ficha en `busquedas` y agregar la fila en `claude/busqueda-urls-linkedin.md`.
4. Deduplicar contra el tracker por `linkedinId`, por empresa + título y por descripción. Ojo: tras la reconstrucción faltan casi todas las descartadas anteriores al 18 nov, así que pueden reaparecer ofertas ya vistas.

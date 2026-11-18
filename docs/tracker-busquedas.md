# Pestaña Búsquedas del tracker

Agregada el 2026-10-28 a pedido de David. Complementa `claude/busqueda-urls-linkedin.md` (el detalle de cada prueba sigue allí).

**Tracker actual (desde el 2026-11-18):** https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5 (slug `127d32ff-931e-43a0-bacb-ea91ac08e75c`). El tracker anterior (FsyQMtsZNsn3QTk84ypRpB) desapareció el 15–16 de noviembre; cualquier mención a ese link en otros documentos está vieja.

## Qué guarda
- Colección `busquedas`: una ficha por URL con `nombre`, `estado` (Validada, En prueba, Pendiente de decisión, Histórico, Descartada), `fechaEstado`, `desde`, `keywords`, `ubicacion`, `modalidad`, `ventana`, `limite`, `url`, `proposito`, `vigilar`, `orden`. Ids cargados tras la reconstrucción: `nucleo`, `backend`, `contratos` (validadas), `nextjs` (descartada) y `posts` (barrido de posts, en prueba).
- Colección `runs`: un documento por run y URL, id `<fecha>_<busqueda>`, con `fecha`, `busqueda`, `total`, `limite`, `utiles`, `nota`, `utilesFuente` ("historial" o "tracker") y `dataset`. La pestaña muestra solo las URLs validadas y no muestra el costo (decisión de David). Tras la reconstrucción solo están los runs de validación (14–20 oct y 2–4 nov) y el del 16 nov (`todas`, sin reparto por URL).
- Campo `busqueda` en cada aplicación que vino de Apify: el id de la URL que la trajo. `sin-dato` = no se sabe cuál.

## Qué hacer en cada run diario
1. Al agregar cada oferta al tracker, poner `busqueda` según el `inputUrl` del dataset (`nucleo`, `backend` o `contratos`). Si la misma oferta sale en dos URLs el mismo día, la primera que la trajo.
2. **Tecnologías de cada oferta (desde el 2026-11-18).** Para *todas* las ofertas del run que entren al tracker, incluidas las Descartadas, leer la descripción completa (`descriptionText` del dataset) y cargar:
   - `techReq`: array con las tecnologías requeridas (must-have, "required", "X+ years of").
   - `techDes`: array con las deseables ("nice to have", "bonus", "familiarity with", "preferred").
   - Usar siempre los nombres canónicos de la taxonomía de la pestaña Tecnologías y puestos: TypeScript, JavaScript, Python, Java, Go, C# / .NET, PHP, Ruby / Rails, Kotlin, Rust, SQL · React, Next.js, Angular, Vue, Redux, Tailwind, HTML / CSS, Storybook · Node.js, NestJS, Express, GraphQL, REST APIs, Microservicios, Prisma · PostgreSQL, MySQL, MongoDB, Redis, DynamoDB, Elasticsearch, Kafka / colas · AWS, GCP, Azure, Docker, Kubernetes, Terraform, CI/CD · IA / LLM, Machine learning · Jest, Vitest, Cypress, Playwright · React Native, iOS / Android nativo · Shopify, Stripe. Si algo no está en la lista, escribirlo con su nombre común (sale como "Otras").
   - Solo tecnologías concretas: nada de soft skills ni "Agile". Una tecnología va en req o en des, no en las dos.
   - No hace falta cargar `familia`: sale del título. Cargarla solo si el título engaña.
3. Al terminar, escribir un documento en `runs` por URL: total del dataset por URL, `limite` 60, útiles (Por aplicar + Evaluar de esa URL), costo real del run repartido por total (`costoUsd`), `dataset` y `utilesFuente: "tracker"`.
4. Si una URL cambia de estado (se valida, se descarta, entra una en prueba), actualizar su ficha en `busquedas` y agregar la fila en `claude/busqueda-urls-linkedin.md`.
5. Deduplicar contra el tracker por `linkedinId`, por empresa + título y por descripción. Ojo: tras la reconstrucción faltan casi todas las descartadas anteriores al 18 nov, así que pueden reaparecer ofertas ya vistas.

## Pestaña Tecnologías y puestos (rediseñada el 2026-11-18)
- Cuenta solo `techReq` y `techDes`; si una oferta no los tiene, lee lo que reconozca en el texto de `stack`. Nunca cuenta el título.
- Lo que David ya tiene vive en el doc de la base `settings/taxonomia` (campo `perfil`, nombres canónicos). Todo lo que no esté ahí se marca como brecha. Si David suma una skill, agregarla allí.
- Vista por defecto: "Mercado: todo lo visto" (todas las ofertas, incluidas las descartadas). También hay "Solo las aplicadas" y "Las que tuvieron señal o respuesta".
- Secciones: tecnologías más pedidas (requerida/deseable), brechas principales, cuánto del stack pedido ya tiene, pares de tecnologías frecuentes, familias de puesto por nivel, títulos más repetidos y tendencia semanal. Las de tecnologías se muestran desde 10 ofertas con datos; la tendencia, desde 2 semanas con 5 o más.
- "Lo que pagan" se movió a Métricas (sección Salarios), con todas las ofertas con salario.

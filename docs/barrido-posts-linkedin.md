# Barrido de publicaciones de LinkedIn (reclutadores que contratan tech)

Prueba iniciada el 2026-11-13 a pedido de David, a partir de un post de Reddit sobre contactar a quien publica "we're hiring" en las primeras horas. Objetivo: encontrar personas (reclutadores, hiring managers, fundadores) que publican puestos que encajan, para escribirles directo. Complementa el run diario de avisos (`claude/busqueda-urls-linkedin.md`) y el plan de agencias (`claude/plan-reclutadores-agencias.md`).

## Actor y configuración
- Actor: `harvestapi/linkedin-post-search` (sin cookies: no usa la cuenta de David). ~$0.002 por publicación; $0.001 por consulta sin resultados.
- Input: `searchQueries` (lista), `maxPosts` 50, `postedLimit` "24h", `sortBy` "date", `profileScraperMode` "short". `callOptions.maxTotalChargeUsd` 0.45.
- Campos útiles al leer el dataset: query.search, author.name, author.info (titular), author.linkedinUrl, postedAt.postedAgoShort, engagement.likes, engagement.comments, linkedinUrl, job.title, job.location, content.
- Filtro opcional no usado todavía: `authorKeywords` (palabras en el titular del autor, p. ej. "recruiter").
- Para escribir en el tracker con db_write hay que pasar la URL completa del artifact como slug (el ID corto solo sirve para db_query).

## Criterio de validación (igual que las URLs de avisos)
3 días seguidos. Se queda si trae en promedio al menos 2 contactos útiles nuevos por día (publicación que pasa la rúbrica y no está en el tracker ni en el run de avisos).

## Flujo con cada contacto útil
1. Agregar al tracker con la rúbrica (`busqueda`: "posts", `fuente`: "LinkedIn (post de reclutador, Apify)").
2. CV adaptado con cv-toolkit.
3. Email corto con el CV si el post da email (li-human hasta PASS).
4. Invitación de LinkedIn de menos de 200 caracteres que diga que el CV ya está en su correo (li-dm + li-human). Primero el email, después la invitación, el mismo día.

## Historial
| Fecha | Run / dataset | Consultas | Total (únicas) | Útiles | Notas |
|---|---|---|---|---|---|
| 2026-11-13 (día 1/3) | BLFMv8bfgmZ6ehDkm / wJlGus6yeQlbUeyuy | 1. hiring full stack developer react typescript canada · 2. contract react developer canada · 3. hiring node.js typescript developer canada · 4. hiring bilingual spanish developer react | 26 (22) | 1 | Útil: Vishnu Yadav, Sr. Technical Recruiter (3B Staffing): Mid-Level Full Stack, Canadá remoto, contrato, Node/TS/Next.js/NestJS + React Native, NX, AWS/GCP; pide CV por DM o a vishnu@3bstaffing.com. Salió en 3 de las 4 consultas. Tracker app-549 (Alto, prioridad 1). **Resultado:** email con CV a las ~11:50, invitación a las 11:51; aceptó y respondió en 1 minuto ("I am checking David."). Dudosa: Jobswithdexa (agregador, Senior React remoto contrato, solo link). Ruido: 8 copias del mismo post de Krox Technologies (Java FS, "comenta Interested"), 3 de GLUSVOX (junior, mismo formato), 3 del mismo puesto en Mumbai, Java/Senior 8+ presencial (Amber IT, Tekgence, Raas Infotek), entry-level presencial (Pentabay), un BD de Pakistán y un "open to work". Consulta 4 (español): 0 resultados. Con 24 h ninguna consulta llegó a 50. Costo ~$0.05 |

## Aprendizajes
- Con ventana de 24 h el volumen es bajo (26 publicaciones con 4 consultas): se pueden sumar consultas sin que el costo suba mucho.
- El ruido dominante son agencias de "placement" de India que publican el mismo texto desde muchos perfiles de Business Development y piden comentar "Interested". Se filtran gratis al leer: titular "Business Development", texto repetido, "comment ... below".
- Cuando el autor pone email en el post, el contacto directo ya está resuelto.
- Escribir en la primera hora funciona: el primer contacto respondió en 1 minuto (2026-11-13).
- Propuesta para el día 2: cambiar la consulta de español por "nearshore developer react node" y sumar "hiring react developer remote canada", "nestjs developer hiring" y "next.js developer hiring canada".

Nota (2026-11-18): en el tracker reconstruido, el contacto de 3B Staffing es app-89 (antes app-549).

# Búsqueda de URLs de LinkedIn para el scraper de Apify

Documento de trabajo del chat dedicado a comparar y descubrir URLs de búsqueda. Cada prueba agrega una fila al historial.

## Objetivo
Encontrar el set mínimo de URLs que, corrido una vez al día, traiga la mayor cantidad de ofertas útiles (nivel intermedio, Next.js / full stack TypeScript, remoto Canadá) con el menor ruido, repetición y costo. No hay tarea programada: el run se hace solo cuando David lo pide (decisión del 2026-10-16).

## Actor y configuración
- Actor: `curious_coder/linkedin-jobs-scraper` (pago por resultado, ~$0.001–0.002 por oferta)
- Input base:
  - `limitPerSource`: **60 en el run diario** (aprobado el 2026-10-16; confirmado por David el 2026-10-20, que decidió no subirlo a 80); 40 se usó en la validación y 20 en pruebas exploratorias. Es un límite global: aplica igual a las tres URLs
  - `scrapeCompany`: false
  - `autoConvertToAiSearch`: true
  - `splitByLocation`: false, `under10Applicants`: false, `datePosted`: "anyTime", `companyIds`: []
- `callOptions.maxTotalChargeUsd`: **0.40 en el run diario** (con 3 URLs: hasta 180 ofertas ≈ $0.18–0.36); 0.25 en pruebas
- Leer datasets con `get-dataset-items` usando `fields` (id,title,companyName,location,postedAt,applicantsCount,salary,employmentType,inputUrl) y luego `descriptionText` solo de las que pasan el filtro por título. Leer datasets no cuesta crédito.

## Lo que sabemos del actor y de LinkedIn
- Con `autoConvertToAiSearch: true`, solo la fecha (`f_TPR`), la empresa, Easy Apply y "<10 solicitantes" se mantienen como filtros reales. Los demás (`f_WT` modalidad, `f_E` nivel) se convierten en texto y se agregan a las keywords. **No filtran.**
- Los operadores booleanos (`OR`, `NOT`, comillas) se ignoran: la búsqueda con IA de LinkedIn no los respeta.
- El nivel funciona mejor escrito en lenguaje natural dentro de las keywords. "mid level" funciona; "intermediate" no (encoge o no filtra).
- La búsqueda con IA ordena por relevancia, no excluye. Siempre se cuelan algunos Senior/Staff, roles en francés de Quebec y gigs de entrenamiento de IA (AfterQuery, Alignerr, YO HR). Eso lo filtra la rúbrica, sin costo.
- La misma oferta puede aparecer con distinto job ID en otra ciudad (Marqeta, Kake): deduplicar por empresa + título, no solo por ID.
- `applicantsCount` viene con tope ("25" = menos de 25, "200" = más de 200). `seniorityLevel` casi siempre es "Not Applicable".
- La velocidad importa: Pest Share pasó de <25 a 200+ solicitantes en un día.
- Las agencias republican el mismo contrato con texto casi idéntico (Techedin, NearSource y Applicantz el 2026-10-15): deduplicar también por descripción, no solo por empresa + título.
- `next.js` como única keyword es inestable: atrae puestos no técnicos que mencionan Next.js (marketing, diseño, producto). El 2026-10-16 solo 3 de 40 fueron útiles.
- `location=Latin America` sí funciona como región (trajo Brasil, Chile, México, Colombia, Perú, Argentina, Venezuela, Costa Rica y Puerto Rico). Brasil domina, incluso con keywords en español. Casi todas las ofertas exigen vivir en un país concreto ("remote within Colombia", "based in Brazil or Portugal", "anywhere in LATAM") o ir a una oficina local (2026-10-16).
- `bilingual spanish` en las keywords no orienta la búsqueda en EE.UU.: trajo puestos presenciales de corporativos que exigen autorización de trabajo. `location=Worldwide` escrito como texto devolvió 0 resultados (2026-10-16).
- `geoId=92000000` (Worldwide) tampoco devolvió resultados con `remote americas` en las keywords: Worldwide queda descartado (2026-10-16).
- El actor no devuelve el ID numérico de la empresa (ni con `scrapeCompany: true`) y LinkedIn bloquea leer la página de empresa. Para usar `f_C` hay que copiar el ID desde la URL de LinkedIn tras filtrar por empresa a mano (2026-10-16).
- Toptal y Andela publican en LinkedIn solo puestos internos (marketing, operaciones). Sus redes de desarrolladores se postulan en sus propios sitios. BairesDev y X-Team sí publican puestos de desarrollo en LinkedIn (2026-10-16).
- `nestjs` como única keyword trae poco propio: en 7 días, 8 de 20 ya habían salido en las URLs validadas, y el resto fue Staff/Principal, .NET y puestos de producto. `mid level backend developer node.js typescript` sí aporta ofertas nuevas, casi todas sin Python como requisito (2026-10-16).
- El filtro de 24 h no garantiza ofertas nuevas: LinkedIn resube avisos. El 2026-10-15, 10 de 40 de la URL next.js ya habían salido en días anteriores.
- `product engineer` atrae sobre todo Senior y Staff: el título "Product Engineer" en Canadá casi siempre es Staff (Ashby, Mozilla, PolarGrid). Con `typescript react` agregado trae puestos Senior full-stack de producto de empresas grandes (Pinterest, Tubi, BioRender) que no salen en las URLs validadas. En 7 días: 10 útiles nuevas de 40, unas 1–1,5 por día, por debajo del criterio de 2 por día para el run diario (2026-10-26).
- **Contrato escrito en las keywords sí funciona**: `contract full stack developer typescript react` trajo 17 de 20 avisos de contrato o plazo fijo, casi todos con 25–60 solicitantes. El ruido son contratos Senior de Java/.NET para bancos (2026-10-31).
- **Con ventana de 24 h, "contract" trae sobre todo otra cosa** (2026-11-02 al 04): solo un tercio son contratos (19, 16 y 21 de ~60), y casi todos de Java/.NET o gigs. Lo que sí trae, y las URLs "mid level" no, son agencias y empresas medianas con títulos genéricos ("Software Developer"): PRI, IDENTOS, Google Early Career, AppDirect. La repetición con núcleo y backend es de ~3 %.
- **`under10Applicants: true` no filtra** (al menos con URL): con las keywords de núcleo, 18 de 20 avisos tenían de 25 a 200+ solicitantes (2026-10-31).
- **`autoConvertToAiSearch: false` no devuelve los filtros clásicos**: con `f_JT=C` solo 2 de 20 fueron contratos. Los filtros de tipo de empleo, nivel y modalidad quedan descartados (2026-10-31).
- `bilingual spanish software developer` en Canadá tampoco sirve: 0 de 20 piden español; trajo Java de bancos y puestos de Quebec (2026-10-31).
- `software engineer II typescript react` trae títulos de nivel intermedio, pero 12 de 20 ya estaban en el tracker por las URLs validadas (2026-10-31).
- El dataset trae `employmentType` (Contract, Full-time, Temporary, Other): sirve para contar contratos sin leer las descripciones (2026-10-31).
- Los lunes por la mañana la ventana de 24 h solo cubre el domingo: el 2026-11-02 la URL de contratos trajo 9 avisos a la mañana y 59 a la noche. Los lunes, correr el run una sola vez y más tarde.

## URLs del run diario (a pedido)
Desde el 2026-10-31: next.js sale del run diario (decisión de David) y entra la de contratos con ventana de 24 h (propuesta de Claude, tras la duda de David sobre correr semanal). Se descartó correr URLs semanales con ventana de 7 días: la oferta vale más si se aplica el día que sale, y el costo diario es bajo.
1. **Núcleo, nivel intermedio** (validada)
   `https://www.linkedin.com/jobs/search/?keywords=mid%20level%20full%20stack%20developer%20typescript%20react&location=Canada&f_WT=2&f_TPR=r86400`
2. **Backend Node/TypeScript, nivel intermedio** (validada, sin `f_WT`)
   `https://www.linkedin.com/jobs/search/?keywords=mid%20level%20backend%20developer%20node.js%20typescript&location=Canada&f_TPR=r86400`
3. **Contratos** (validada el 2026-11-04, decisión de David; en prueba desde el 2026-10-31)
   `https://www.linkedin.com/jobs/search/?keywords=contract%20full%20stack%20developer%20typescript%20react&location=Canada&f_TPR=r86400`
   Se queda por lo que trae de agencias y empresas medianas, más que por los contratos (ver su validación abajo). Criterio usado: 1 útil nueva por día.

Descartada del run diario el 2026-10-31: next.js (`https://www.linkedin.com/jobs/search/?keywords=next.js&location=Canada&f_WT=2&f_TPR=r86400`), con ~1,5 útiles nuevas por día del 22 al 30 de octubre, casi todo marketing, diseño y producto.

Las URLs núcleo y next.js se validaron el 2026-10-16 tras correrlas 3 días seguidos (desde el 2026-10-14) con `limitPerSource` 40. La URL backend se validó el 2026-10-20 tras 3 runs (2026-10-17, 19 y 20) con `limitPerSource` 60. La URL de contratos se validó el 2026-11-04 tras los runs del 2, 3 y 4 de noviembre con `limitPerSource` 60.

### Resultado de la validación (2026-10-14 al 2026-10-16)
| | Núcleo (mid level…) | next.js |
|---|---|---|
| Útiles por día | 7 / 9 / 14 (promedio 10) | 12 / 12 / 3 (promedio 9) |
| Tasa útil por día | 18 % / 23 % / 35 % (25 % en total) | 31 % / 30 % / 8 % (23 % en total) |
| Repetidas con la otra URL | 1 / 0 / 0 | 2 avisos / 0 / 0 |
| Llegó al tope de 40 | No / Sí / Sí | No / Sí / Sí |
| Repetidas con días anteriores | 1 / 1 / 4 | 2 / 10 / 2 |

Decisión (aprobada por David el 2026-10-16): mantener las dos URLs, con `limitPerSource` 60 y `maxTotalChargeUsd` 0.40, porque las dos llegaron al tope 2 de 3 días. Sin tarea programada. Deduplicar contra el tracker y contra los runs anteriores (por ID, por empresa + título y por descripción). Vigilar next.js: el 2026-10-16 trajo sobre todo puestos de marketing, diseño y producto.

### Resultado de la validación de la URL backend (2026-10-17, 19 y 20)
| | Backend (mid level backend…) |
|---|---|
| Total por día | 60 / 58 / 59 (a 0–2 del tope de 60 los tres días) |
| Útiles por día | 19 / 11 / 9 (6 con el filtro de Python del 2026-10-20) |
| Tasa útil por día | 32 % / 19 % / 15 % |
| Útiles únicas (no salen en las otras dos URLs) | 18 / 10 / 9 (6 con el filtro de Python); promedio 12,3 (11,3 con el filtro) |
| Repetición con la núcleo | 3 % / 7 % / 2 % de los avisos |
| Útiles sin Python obligatorio | 17 de 19 / 9 de 11 / 5 de 9 |
| Útiles únicas en las primeras 40 (orden del dataset) | 10 / 3 / 5 (4 con el filtro de Python) |
| Aplicadas por David (días 1 y 2) | 13, contra 1 de la núcleo y 3 de next.js |

Decisión (aprobada por David el 2026-10-20): pasa a validada. Cumple los dos criterios con margen (útiles únicas muy por encima de 2 por día y repetición con la núcleo muy por debajo del 70 %). `limitPerSource` se queda en 60 y `maxTotalChargeUsd` en 0.40 (decisión de David), aunque backend quedó a 0–2 del tope los tres días y next.js llegó al tope el 2026-10-20. Desde el 2026-10-20, Python como núcleo es filtro eliminatorio en la rúbrica.

### Resultado de la validación de la URL de contratos (2026-11-02, 03 y 04)
| | Contratos (contract full stack…) |
|---|---|
| Total por día | 9 + 59 (dos runs el lunes) / 59 / 60 |
| Contratos de verdad (`employmentType`) | 4 gigs + 19 / 16 / 21 (~un tercio) |
| Útiles | 3 (Google Early Career, IDENTOS, PRI) / 2 (Jobgether = AppDirect, SS&C) / 2 (Twine, Gigafest) |
| Útiles únicas (no salen en núcleo ni backend) | 3 / 1 (SS&C también salió en backend) / 2 → ~1,3 por día |
| Repetición con núcleo y backend | ~3 % de los avisos (2 de 57 el 2026-11-04) |
| Aplicadas por David | 5 (Google, IDENTOS, PRI, AppDirect, SS&C); de ellas solo IDENTOS es contrato. Twine y Gigafest las descartó |
| Señales | PRI pidió 5 videos de 60 s el 2026-11-03: la única respuesta de la semana, y es un puesto permanente |
| Costo | ~$0.09–0.10 por día |

Decisión (aprobada por David el 2026-11-04): pasa a validada sin cambiar las keywords. Cumple el criterio de 1 útil única por día y casi no repite con las otras dos. Su valor no son los contratos (varios contratos llegaron por núcleo y backend: Pelmorex, NearSource, BeachHead), sino los puestos de agencias y empresas medianas con títulos genéricos que las URLs "mid level" no traen.

### Desgaste de las validadas (22 al 30 de octubre)
Desde el 22 de octubre las útiles nuevas por día bajaron a ~3,5 en núcleo, ~1,5 en next.js y ~5 en backend (en la validación eran 10, 9 y 12). Según David, la causa principal es que endureció el criterio: dejó de buscar puestos Senior y se enfocó en nivel intermedio (lo que la rúbrica del 2026-10-27 refleja con el tope Medio para Senior). También influyen que desde el 22 solo se cuentan las que no estaban en el tracker y que se repiten avisos (Affirm en ~15 ciudades). Por eso la caída no indica que núcleo y backend estén agotadas. next.js ya no cumple el criterio de 2 útiles únicas por día.

## URLs descartadas y por qué
| Keywords | Motivo |
|---|---|
| Booleanos `("full stack" OR ...) NOT (...)` | `NOT` y `OR` ignorados; trajo .NET y Tech Leads |
| `("forward deployed" OR "ai engineer" OR shopify) AND (...)` | Casi todo ruido (Applied Scientist, Staff, Python LLM); 0 Shopify |
| `full stack` en British Columbia con `f_WT=3` | El filtro de modalidad no aplica; trajo gigs de IA y roles no técnicos |
| `full stack typescript` | Funciona, pero mucho Java/.NET; reemplazada por la versión "mid level" |
| `intermediate next.js developer` | Solo 8 resultados, 0 útiles |
| `intermediate full stack developer typescript` | No filtra nivel (5 Senior); 2 útiles de 20 |
| `mid level frontend developer next.js typescript` | 16 de 19 repetidas con la URL núcleo; 0 nuevas |
| London ON local (propuesta, no corrida) | Muy pocas posiciones; decisión de David el 2026-10-16 |
| `nestjs` | En 7 días, 2 útiles nuevas de 20; 8 repetidas con las URLs validadas y el resto Staff, .NET o producto. Decisión de David el 2026-10-16 |
| `software engineer II typescript react` | 12 de 20 ya estaban en el tracker; 1 útil nueva en 7 días (2026-10-31) |
| Núcleo con `under10Applicants: true` | El filtro no se aplicó (25 a 200+ solicitantes) (2026-10-31) |
| `bilingual spanish software developer` en Canadá | 0 de 20 piden español (2026-10-31) |
| Búsqueda clásica (`autoConvertToAiSearch: false`) con `f_JT=C` | Solo 2 de 20 contratos: LinkedIn ya no aplica el filtro (2026-10-31) |
| `product engineer typescript react` | Casi todo Senior/Staff: con la rúbrica del 27, 2 aplicadas y 10 descartadas de 12 (2026-10-31) |
| `mid level product engineer typescript react` | Mismos avisos que núcleo y SWE II; 0 útiles nuevas de 18 (2026-10-31) |
| `remote contract full stack developer typescript react` en United States (con y sin `canada`) | ~19 de 38 exigen W2 o autorización de EE.UU.; ninguno acepta Canadá de forma explícita; 1 en Evaluar (2026-10-31) |

## Exploración EE.UU. y LatAm (inglés + español)
Corrida el 2026-10-16 (resultados en el historial): casi todo exige autorización de EE.UU. o vivir en LatAm; la única útil fue BairesDev. Pendiente: probar el filtro por empresa (`f_C`) con BairesDev, X-Team y Kake cuando David pase los IDs. Las URLs probadas fueron:
- A: `full stack developer typescript react bilingual spanish` en United States
- B: `full stack developer typescript react` en Latin America (si LinkedIn no resuelve la región, México y Colombia por separado)
- C: `next.js developer bilingual english spanish` en Latin America

Regla ya decidida: las ofertas que exigen autorización de trabajo en EE.UU. y no aceptan trabajar desde Canadá se descartan.

**Contratos en EE.UU. (2026-10-31).** A pedido de David, por si los contratos (C2C, 1099) aceptan contractors desde Canadá, como fue Delphi vía Randstad. Dos URLs con ventana de 7 días: `remote contract full stack developer typescript react` y la misma con `canada`, location United States. De 38 avisos, ~19 exigen expresamente W2, ciudadanía o autorización de EE.UU. ("W2 only", "USC only", "no C2C", "ONLY US"); ~10 son Java, .NET, Python o 7+ años; ninguno dice que acepta Canadá. Agregar `canada` no ayudó. Solo DeWinter AI Product Engineer quedó en Evaluar (app-443), y hay que preguntar si acepta Canadá. Lazer, ya aplicada, es el único que dice "worldwide". **Descartada:** los contratos de EE.UU. que sí aceptan Canadá llegan por reclutadores o marketplaces, no por la búsqueda.

## Exploración "product engineer" (2026-10-26)
A pedido de David, tras hablar del rol de Product Engineer. Dos URLs con ventana de 7 días y `limitPerSource` 20 (resultados en el historial):
- A: `https://www.linkedin.com/jobs/search/?keywords=product%20engineer&location=Canada&f_WT=2&f_TPR=r604800`
- B: `https://www.linkedin.com/jobs/search/?keywords=product%20engineer%20typescript%20react&location=Canada&f_TPR=r604800`

B rindió mucho más que A (7 útiles de 19 contra 3 de 21). Revisión del 2026-10-31: las 12 útiles del 26 de octubre eran casi todas Senior o Staff. Con la rúbrica del 27 quedaron 2 aplicadas (Tubi, rechazo al día siguiente; Pinterest Sr Full Stack) y 10 descartadas (6 por Senior o 5+ años). La variante `mid level product engineer typescript react` (2026-10-31) trajo los mismos avisos que núcleo y SWE II, con 0 útiles nuevas: "mid level" borra el perfil de producto. **Ambas descartadas.** El ángulo "end to end" se usa en el CV y en el pitch, no como keyword.

## Prueba de hipótesis: contratos, nivel y competencia (2026-10-31)
A pedido de David. Hipótesis: como las respuestas vienen de contratos (3 señales de 15 contra 1 de 97) y no de puestos Senior, conviene buscar URLs que traigan contratos, nivel intermedio, poca competencia o español, en vez de más volumen. Cinco pruebas con ventana de 7 días y `limitPerSource` 20 (sábado, por eso 7 días):

| Prueba | Keywords / ajuste | Resultado |
|---|---|---|
| Contratos | `contract full stack developer typescript react` | **Funciona.** 17 de 20 contrato o plazo fijo, casi todos con 25–60 solicitantes. 2 útiles nuevas (Techedin Muy alto, Kongsberg en Evaluar) y 4 que ya estaban (Apex React y Lazer aplicadas, MethodHub y Russell Tobin descartadas) |
| SWE II | `software engineer II typescript react` | No aporta: 12 de 20 ya en el tracker; 1 útil nueva (Jobgether Full Stack) |
| Menos de 10 solicitantes | núcleo + `under10Applicants: true` | El filtro no se aplicó |
| Español en Canadá | `bilingual spanish software developer` | 0 de 20 piden español |
| Búsqueda clásica | `autoConvertToAiSearch: false` + `f_JT=C` | Solo 2 de 20 contratos: no filtra |

Conclusión: la única palanca que funciona es escribir "contract" en las keywords. En 7 días trajo 6 ofertas que valían la pena, pero 4 ya las habían encontrado las validadas, así que a diario daría alrededor de 1 útil nueva por día. Tras la objeción de David (2026-10-31: correr semanal significa aplicar a ofertas de hasta 7 días), entra al run diario con ventana de 24 h en lugar de next.js. La ventana de 7 días queda solo para pruebas. Se usa también para encontrar reclutadores de agencia (Apex, Pacer, Kelly, Russell Tobin, Techedin, Direct IT) para el plan de agencias. El español y la competencia baja no se resuelven con URLs: van por reclutadores y por aplicar el mismo día. Agregadas al tracker como app-440 a app-442 (solo las útiles).

## Métricas por prueba
- Ofertas totales por URL y si llegó al tope
- Útiles según la rúbrica (`claude/rubrica-clasificacion.md`): Por aplicar + Evaluar
- Únicas de cada URL (no aparecen en la otra)
- Repetidas contra días anteriores (comparar job IDs con los datasets del historial)
- Ya presentes en el tracker (colección `applications` del artifact https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5; el tracker anterior, FsyQMtsZNsn3QTk84ypRpB, se perdió el 15–16 nov 2026 y los números app-N de este documento son del tracker viejo)
- Costo aproximado
- Tasa útil = útiles / totales

## Criterio de decisión
- Una URL se queda si aporta ofertas útiles únicas de forma constante (al menos 2 por día en promedio) con tasa útil razonable.
- Si llega al tope de 40 con frecuencia y la tasa útil es buena, subir el límite.
- Si una URL repite más del 70 % de lo que trae la otra, se elimina.

## Historial de pruebas
| Fecha | Run / dataset | URL (keywords) | Total | Útiles | Notas |
|---|---|---|---|---|---|
| 2026-10-12 | fUn3LUbY7Q09XAcgU | Booleanos núcleo (A) | 20 (tope) | ~6 | `NOT` ignorado |
| 2026-10-12 | fUn3LUbY7Q09XAcgU | Booleanos AI + Shopify (B) | 20 (tope) | 2–3 | Ruido |
| 2026-10-12 | fUn3LUbY7Q09XAcgU | Booleanos BC híbrido (C) | 4 | 1 | |
| 2026-10-12 | 6IsHWurpuhxdlgshr | full stack typescript | 40 (tope) | ~4 | Mucho Java/.NET |
| 2026-10-12 | 6IsHWurpuhxdlgshr | next.js | 40 (tope) | 7 | Mejor del día (7 de 9 "Por aplicar") |
| 2026-10-12 | 6IsHWurpuhxdlgshr | full stack, BC, f_WT=3 | 15 | 0–1 | Gigs de IA |
| 2026-10-13 | jQ7SljTUl3nWrAhO6 | intermediate next.js developer | 8 | 0 | |
| 2026-10-13 | jQ7SljTUl3nWrAhO6 | intermediate full stack developer typescript | 20 (tope) | 2 | Luxury Presence, matcha.fm |
| 2026-10-13 | jQ7SljTUl3nWrAhO6 | mid level full stack developer typescript react | 20 (tope) | 7 | Slice, Sony SWE II, Jobgether Boosters, Bree, MatchBox + repetidas de ayer |
| 2026-10-13 | RmfSrqOUR7ghoMtDh | mid level frontend developer next.js typescript | 19 | 6–7 | 16 repetidas con la núcleo |
| 2026-10-13 | RmfSrqOUR7ghoMtDh | next.js | 20 (tope) | 3 | Únicas: Luxury Presence, matcha.fm |
| 2026-10-14 (validación día 1/3) | run o4qLy58yqFoT8y8Vd / 4YhoO2YCymadGLZMR | mid level full stack developer typescript react | 38 (no llegó a 40) | 7 (18 %) | 6 únicas; 1 repetida con next.js (Cohere); 1 repetida de días anteriores (Chrome Technologies); 0 en tracker. Útiles: Voices (híbrido London ON), Cohere, Alpha Hub, SeventhHire FDE, Caddie, Xero (híbrido Vancouver), Braze. Mucho Java/.NET, Quebec francés y Senior/Lead: "mid level" no filtró nivel hoy |
| 2026-10-14 (validación día 1/3) | run o4qLy58yqFoT8y8Vd / 4YhoO2YCymadGLZMR | next.js | 39 (no llegó a 40) | 12 (31 %) | 11 únicas; 2 avisos repetidos con la núcleo (Cohere en otras ciudades); 2 repetidas de días anteriores (Alan, AppDirect); 3 en tracker (Alan, AppDirect, Super.com). Útiles: Cohere, Felix, Nango FDE (= Jobgether FDE), Grafana, Valence, SAP, Nex, Ema, McGraw Hill, Elastic Path, EZRA, Jonas Club / Shortcuts Interactive Web Designer. Run total 77 ofertas, costo estimado $0.08–0.15 |
| 2026-10-15 (validación día 2/3) | run H71EOygQtpZZSPmKu / o1bxGrYppgQkroYip | mid level full stack developer typescript react | 40 (tope) | 9 (23 %) | 9 únicas; 0 repetidas con next.js; 1 repetida de días anteriores (Braze); 1 en tracker (Braze, descartada). Útiles: Canada Life AI Developer (oficina London ON), OPENLANE (remoto), Jobgether FDE Agile, contrato TS de agencias (Techedin / NearSource / Applicantz, el mismo puesto), Unity Sr Full Stack (NestJS), MaintainX Integrations, Stay22, Faire Ads (Toronto 3 días), Accenture AI-Native (Mississauga 3 días). Clasificado con la rúbrica nueva (híbrido fuera de Ontario = descartada; 5+ años ya no pone tope) |
| 2026-10-15 (validación día 2/3) | run H71EOygQtpZZSPmKu / o1bxGrYppgQkroYip | next.js | 40 (tope) | 12 (30 %) | 12 únicas; 0 repetidas con la núcleo; 10 repetidas de días anteriores (9 del 14); 5 en tracker (Alan, Felix, Grafana, McGraw Hill, Super.com). Útiles: Fellow, Jobgether Frontend React, Salt UI (contrato Shopify/Liquid), Kake Node/React, Render Growth, PostGrid (SWE y Senior), OpenTable Blog (Toronto 2 días), Stripe Data Viz, Homebase, Ascend, Operatic (Hamilton 2 días), Amii. Las dos URLs llegaron al tope: run total 80 ofertas, costo estimado $0.08–0.16 |
| 2026-10-16 (validación día 3/3) | run IBGBkBDaCPilAeRNc / QWBxkmwaEfsJmzKuV | mid level full stack developer typescript react | 40 (tope) | 14 (35 %) | 14 únicas; 0 repetidas con next.js; 4 repetidas de días anteriores (Vention, Alan, Autodesk ×2); 3 en tracker (Alan, Docebo FDE, JD Power). Útiles: Race Roster Senior (remoto u oficina London ON), Vanta GRC, DualEntry, Uride, matcha.fm, honeycomb (Sr II y SWE I), Mission.dev, Invert, Docebo SPE (Toronto 3 días), BuildOps (Toronto 3 días), Mural, Genius AI (remoto GTA), Jobgether fintech Go/TS |
| 2026-10-16 (validación día 3/3) | run IBGBkBDaCPilAeRNc / QWBxkmwaEfsJmzKuV | next.js | 40 (tope) | 3 (8 %) | 3 únicas; 2 repetidas de días anteriores (Faire Staff, Intuit); 0 en tracker. Útiles: Affirm SWE I Fullstack (remoto), Grafana Session Replay (remoto, backend Go), Docebo SPE II (Toronto 3 días). El resto fue marketing, diseño, producto y Staff/Principal. Run total 80 ofertas, costo estimado $0.08–0.16 |
| 2026-10-16 (exploración fuera de Canadá) | run 9A1aFFpBEHmrEqJM5 / eiIrcrm5Ter9jdOU0 | A: full stack developer typescript react bilingual spanish · United States · 7 días | 20 (tope) | 0 | Todas presenciales o híbridas en oficinas de EE.UU. (Humana, Mastercard, Ford, Pacific Life, H-E-B…); ninguna menciona español; las que se revisaron exigen autorización de EE.UU. |
| 2026-10-16 (exploración fuera de Canadá) | run 9A1aFFpBEHmrEqJM5 / eiIrcrm5Ter9jdOU0 | B: full stack developer typescript react · Latin America · 7 días | 20 (tope) | 1 + 1 en Evaluar | Útil: BairesDev Senior Fullstack React & Node ("100% remote, from anywhere", 2 avisos). Evaluar: EPAM Colombia (no dice si exige vivir en Colombia). El resto exige residencia (Brasil, Colombia, LATAM) u oficina (Chile, Puerto Rico) |
| 2026-10-16 (exploración fuera de Canadá) | run 9A1aFFpBEHmrEqJM5 / eiIrcrm5Ter9jdOU0 | C: desarrollador full stack react typescript · Latin America · 7 días | 20 (tope) | 0 nuevas | Solo BairesDev (el mismo puesto que en B) y Mural Growth Argentina (la misma oferta que salió en Canadá). Muchas en Brasil y portugués; Kleva/Sidetool (TS/Next/Postgres) es híbrida en Buenos Aires. Arcadia Chile valora inglés + español, pero es híbrida en Santiago |
| 2026-10-16 (exploración fuera de Canadá) | run 9A1aFFpBEHmrEqJM5 / eiIrcrm5Ter9jdOU0 | D: full stack developer typescript react remote americas · Worldwide · 7 días | 0 | 0 | LinkedIn no resolvió "Worldwide" como texto. Run total 60 ofertas, costo estimado $0.06–0.12 |
| 2026-10-16 (exploración fuera de Canadá) | run DBE57DH7Bt0DGQeXj / yIfHjihGa6RcwUG2X | D bis: mismas keywords que D · `geoId=92000000` · 7 días | 0 | 0 | Worldwide no funciona ni como texto ni como geoId. Punto cerrado |
| 2026-10-16 (sondeo de empresas) | run MWosd1KasMccpdAGs / ZIO4SJ9nEZprBKjMs | nombre de empresa como keyword (BairesDev, Kake, Toptal, Andela, Lemon.io, X-Team, Turing), 2 por búsqueda, `scrapeCompany` true | 14 | — | Solo para buscar IDs: el actor no los devuelve. BairesDev y X-Team traen puestos de desarrollo; Toptal y Andela solo internos; Kake, Lemon.io y Turing no aparecieron por nombre |
| 2026-10-16 (exploración backend) | run Xa9pagDIf8X35zlkh / qOoWFqdWZkREFQjqd | A: nestjs · Canada · 7 días | 20 (tope) | 2 nuevas (10 %) | 0 repetidas con B; 8 repetidas con las URLs validadas; 2 en tracker (Unity aplicada, Kake por aplicar). Nuevas: MLSE [C] Software Engineer (React/TS + Node + Postgres, Toronto, contrato) y Punt Senior Backend (Laravel/PHP, Vancouver, débil). Resto: Staff/Principal, .NET, puestos de producto, onsite |
| 2026-10-16 (exploración backend) | run Xa9pagDIf8X35zlkh / qOoWFqdWZkREFQjqd | B: mid level backend developer node.js typescript · Canada · 7 días | 20 (tope) | 7 nuevas (35 %) | 0 repetidas con A; 4 repetidas con las URLs validadas; 5 en tracker (CARFAX y PostGrid ×2 aplicadas; MaintainX y Cover Genius descartadas). Nuevas: HRXconnect Senior Backend (Node/TS, híbrido Toronto), Uride Senior Backend (remoto), Deel Backend AI (remoto), Autodesk Access (Node/AWS, Toronto), TCS (Node/NestJS o Java), RemitBee (Mississauga), Liberty Mutual (Node + Python). 6 de 7 sin Python obligatorio. Run total 40, costo estimado $0.04–0.08 |
| 2026-10-17 (validación backend día 1/3) | run q5moh4xbeCNEEJRzV / MWYd1mLHcQ5qVESLO | mid level full stack developer typescript react | 60 (tope) | 6 (10 %) | 6 únicas; 5 avisos repetidos con backend (Proof, misma oferta); 4 repetidas de días anteriores (Guidewire, Applicantz, MEDFAR RN, Proof); 2 en tracker (Proof, Applicantz). Útiles: Encore FS contrato (React/NestJS/TanStack, Markham 4 días), MaintainX IAM (Montreal, 200+ con excepción), Solace contrato (Ottawa), Autodesk Viewer Platform (Montreal), Grantek (Burlington), Orbis (Burnaby, núcleo C#). Mucho Java, .NET, Liferay, Quebec francés y Senior 8+: día flojo |
| 2026-10-17 (validación backend día 1/3) | run q5moh4xbeCNEEJRzV / MWYd1mLHcQ5qVESLO | next.js | 60 (tope) | 9 (15 %) | 8 únicas; 1 repetida con backend (EA, dos IDs); 10 repetidas de días anteriores (MEDFAR Sr FS, Astek, Wealthsimple, Sony Staff, Grafana, JD Power, Docebo FDE, STACK, Clio, Info-Tech); 4 en tracker (Grafana, JD Power, Docebo FDE, Info-Tech). Útiles: Knotch Sr FE (remoto), Okta Sr FS (Toronto, Go), EA FS (Next/NestJS, Vancouver sin modalidad), Relay Sr Web Dev, D. E. Systems (Vue, remoto), Thumbtack Design Systems, ClickUp (Angular), Tekgence y Kake (encaje Bajo). El resto fue marketing, producto, Staff/Principal y Quebec |
| 2026-10-17 (validación backend día 1/3) | run q5moh4xbeCNEEJRzV / MWYd1mLHcQ5qVESLO | mid level backend developer node.js typescript · sin `f_WT` | 60 (tope) | 19 (32 %) | 18 únicas; 1 repetida con next.js (EA); repetición con la núcleo: 2 avisos de 60 (3 %), la misma oferta (Proof); 15 repetidas de días anteriores (Workday Evisort, Engineered Intelligence, Okta Staff, DualEntry, Mural, Treasure AI, Humankind, Docebo SPE II, Genius AI, Air Canada, Deel, MaintainX Integration, MEDFAR, Kruger, Proof); 8 en tracker. 17 de 19 útiles sin Python obligatorio (lo exigen Manulife y Schneider). Primeras 40: 10 útiles únicas (orden del dataset). Útiles: HelloFresh Sr FE, Braze SE II, Faire Sr (200+ con excepción), Lyft GovTech, Velora/Aplos (remoto), Senpilot, xMentium (remoto), TD SE II, Manulife, Questrade API, Bayview (remoto, USD), quotaflow, OpenText, SearchLabs, Schneider/AiDASH, Sensor Tower, AssemblyAI, PolicyAdvisor, EA. Run total 180 ofertas, costo estimado $0.18–0.36 |
| 2026-10-19 (validación backend día 2/3) | run 7BvbUkMhfcj0cGAYy / CBCUzXDX97fHV60r6 | mid level full stack developer typescript react | 6 (no llegó a 60) | 1 (17 %) | 0 únicas: la útil (Jobgether Python/Vue/GCP) es el mismo contrato que Aequilibrium en backend; Affirm Staff Mobile repetida con backend; 0 repetidas de días anteriores; 0 en tracker. Resto: Staff, Java VP, Montreal híbrido (Hunter Bond), 8+ años (BusPlanner). Lunes: la ventana de 24 h cubre el domingo |
| 2026-10-19 (validación backend día 2/3) | run 7BvbUkMhfcj0cGAYy / CBCUzXDX97fHV60r6 | next.js | 30 (no llegó a 60) | 0 (0 %) | Todo marketing, producto, diseño, research de Cohere y Hunter Bond Junior React (Montreal híbrido); 0 repetidas de días anteriores; 0 en tracker |
| 2026-10-19 (validación backend día 2/3) | run 7BvbUkMhfcj0cGAYy / CBCUzXDX97fHV60r6 | mid level backend developer node.js typescript · sin `f_WT` | 58 (no llegó a 60) | 11 (19 %) | 10 únicas; repetición con la núcleo: 4 avisos de 58 (7 %), 2 ofertas (Affirm Staff Mobile ×3 ciudades, Aequilibrium = Jobgether); 3 repetidas de días anteriores (MaintainX IAM, Affirm Consumer, Autodesk Data Delivery); 1 en tracker (MaintainX IAM, descartada). 9 de 11 útiles sin Python obligatorio (lo exigen Aequilibrium y Dunsky). Primeras 40: 3 útiles únicas (Dunsky, Beacon, Deel FDE; orden del dataset). Útiles: Jobgether Builder Studio, Deel FDE Akai (= Jobgether), Thomson Reuters Noetica (200+ con excepción), PointClickCare Platform, Aequilibrium (contrato Python/Vue), Dunsky Data & AI, Pantheon SE II (200+ con excepción), Beacon, Vretta, AutoTrader (200+ con excepción), Autodesk Data Delivery (Vancouver sin modalidad). Primer día clasificado con la rúbrica leída en el run. Run total 94 ofertas, costo estimado $0.09–0.19 |
| 2026-10-20 (validación backend día 3/3) | run zqWYnCCa1GgZ2s1dR / iAhk8NeedpFLTyjkM | mid level full stack developer typescript react | 22 (no llegó a 60) | 3 (14 %); 2 con el filtro de Python | 2 únicas (1 con el filtro); Coveo Launch (versión en francés) repetida con next.js; 1 aviso repetido con backend (Affirm Consumer); 9 avisos repetidos de días anteriores; 1 en tracker (Applicantz). Útiles: Swoon React (banco Big 5, remoto), Coveo; Zodiac Python FS (Toronto híbrido) queda descartada con el filtro nuevo. Resto: Java, .NET, Montreal híbrido, Lead |
| 2026-10-20 (validación backend día 3/3) | run zqWYnCCa1GgZ2s1dR / iAhk8NeedpFLTyjkM | next.js | 60 (tope) | 13 (22 %); 12 con el filtro de Python | 12 únicas (11 con el filtro); 15 avisos repetidos de días anteriores (MEDFAR ×2, Docebo FDE ×2, Affirm ×2, Faire, ODAIA, Miovision, Vention, matcha.fm, Mastercard, TELUS, MoversSuite, Apptoza); 4 en tracker (Faire, ODAIA, Docebo FDE, BrightOrder = Jobgether app-090). Útiles: Jobgether Growth (remoto), Big Wave TS/Node (remoto), Grafana Analytics (remoto), LEAP Web Dev (Toronto 3 días), Harvey FE (200+ con excepción), Ashby Design Engineer (200+ con excepción), Autodesk SDET (remoto), Coveo Launch, AutoScout24 CMS, Objectway, Atlassian Loom (exige vivir en BC), Teladoc; Descartes (Python) queda descartada con el filtro nuevo. Mejor día de next.js en la validación |
| 2026-10-20 (validación backend día 3/3) | run zqWYnCCa1GgZ2s1dR / iAhk8NeedpFLTyjkM | mid level backend developer node.js typescript · sin `f_WT` | 59 (no llegó a 60) | 9 (15 %); 6 con el filtro de Python | 9 únicas (6 con el filtro); repetición con la núcleo: 1 aviso de 59 (2 %); 10 avisos repetidos de días anteriores; 5 en tracker (Autodesk Viewer y Data Delivery, RemitBee, Beacon, Stelvio). 5 de 9 útiles sin Python obligatorio. Primeras 40: 5 útiles únicas (4 con el filtro). Útiles: Indigo Stride (remoto, por proyecto), Caylent FDE (200+ con excepción), V-Soft Agentic, Four Seasons Platform, Scotiabank FS, Amazon Ordering (Vancouver); UniSysTech, MNP y Tekgence/Vedan (mismo contrato) quedan descartadas con el filtro nuevo. Validación cerrada: útiles únicas 18 / 10 / 9 (promedio 12,3) y repetición con la núcleo 3 % / 7 % / 2 %; pasa a validada. Run total 140 ofertas, costo estimado $0.14–0.28 |
| 2026-10-26 (exploración product engineer) | run MRtN4VMUT0jp3ZCJX / yiNg4L3PHr7mmgd7W | A: product engineer · Canada · `f_WT=2` · 7 días | 21 | 3 nuevas (14 %) | 4 en tracker o el mismo puesto en otra ciudad (Jobgether Growth, Motion, Intuitive.ai, StackAdapt ×2, Docebo FDE). Nuevas útiles: JD Power Applied AI (200+ con excepción), HouseSigma Product Builder (Medio, el único rol "product" de nivel alcanzable), Mercury Cards (Evaluar, Haskell). Descartadas: Cohere North Admin (Python), Affirm Sr Consumer ×2 (móvil nativo) y 9 Staff/Principal/Tech Lead (Ashby, Magnet, PCMI, Blackpoint, Fathom, GitLab, Auxo) más Hays (hardware) |
| 2026-10-26 (exploración product engineer) | run MRtN4VMUT0jp3ZCJX / yiNg4L3PHr7mmgd7W | B: product engineer typescript react · Canada · 7 días | 19 | 7 nuevas (37 %) | 2 en tracker o repetidas (ODAIA aplicada, Affirm SWE II App Experience). Nuevas útiles: Tubi Sr Growth (Toronto 2 días, 34 solicitantes), BioRender Sr (remoto), Seeq Sr Frontend Infra (remoto), Pinterest SWE II FS y Sr FS (Ontario, 200+ con excepción), Bree Frontend & Mobile (200+ con excepción), GC AI Office Integrations (Medio). Descartadas: Fullsteam (200+, 6 días) y 9 Staff/Principal (Capital One, Questrade, Solink, Harvey ×2, Mozilla, PolarGrid, Ashby ×2, eBay). Run total 40 ofertas, costo estimado $0.04–0.08. Agregadas al tracker como app-301 a app-312 |
| 2026-10-31 (prueba de hipótesis) | run 49cfSAi0ZXL7dndae / uz0pmUa7ziLN8z7eP | contract full stack developer typescript react · Canada · 7 días | 20 (tope) | 2 nuevas (10 %) + 4 ya en tracker | 17 de 20 contrato o plazo fijo; solicitantes casi todos 25–60. Nuevas: Techedin TS/Python/AI (remoto, T4 $45–50/h, 2–3 años, Muy alto; posible republicación del 15 oct) y Kongsberg Geospatial Web Dev React/TS (Ottawa híbrido, 6 meses, 0–3 años, 200+ con excepción, Evaluar por modalidad y habilitación de seguridad). Ya en tracker: Apex React (aplicada hoy), Lazer Agentic AI (aplicada), MethodHub y Russell Tobin (descartadas). Descartadas: Pacer (Java/Angular 8+), Kelly/Citi (8+, 3 días), Apex Designer (Java 7+), Direct IT (Python/Vue lead), Digitalogia (Java/Python), Iris (.NET), Deloitte y Mitchell Martin (Java), Rival (C#, Montreal), Baker Tilly (Vancouver híbrido), Xideral (Python, francés), Flexstaf (FHIR, mismo proyecto que Russell Tobin), StafinGo (arquitecto). Great Value Hiring es un gig de benchmarks de IA (ruido) |
| 2026-10-31 (prueba de hipótesis) | run 49cfSAi0ZXL7dndae / uz0pmUa7ziLN8z7eP | software engineer II typescript react · Canada · 7 días | 20 (tope) | 1 nueva (5 %) | 12 en tracker o la misma oferta (Affirm SWE II ×2, Athennian ×2, Xanadu, Baseten, 11x ×2, Manulife, Huron, Wawanesa, Sony). Nueva: Jobgether Full Stack (remoto, 2–4 años, CA$65–85K, Muy alto). Descartadas: Badge (North Vancouver 1 día), Coalition (200+), Cohere Web Developer ×2, Questrade Senior ×2, adidas Senior |
| 2026-10-31 (prueba de hipótesis) | run 49cfSAi0ZXL7dndae / uz0pmUa7ziLN8z7eP | bilingual spanish software developer · Canada · 7 días | 20 | 0 | Ninguna pide español: Java de bancos (TD, Citi, CIBC, Scotiabank), Quebec en francés, Senior Java. Run total 60 ofertas |
| 2026-10-31 (prueba de hipótesis) | run nxMyJafoKUwvspfhu / tSZyfAyiN1pMPDxqc | mid level full stack developer typescript react · `under10Applicants: true` · 7 días | 20 (tope) | 0 nuevas | El filtro no se aplicó: 18 de 20 con 25 a 200+ solicitantes. Casi lo mismo que la URL SWE II. Onni Capital Intermediate SE (Vancouver, no remoto) queda descartada |
| 2026-10-31 (prueba de hipótesis) | run UzELl159dCOF058vm / QYJClDFNxeNDVY4ws | full stack developer typescript react · `f_JT=C` · `autoConvertToAiSearch: false` · 7 días | 20 (tope) | 0 | Solo 2 de 20 contratos (Kake ×2): los filtros clásicos no funcionan. Resto Staff/Senior/Lead ya vistos. Las tres corridas sumaron ~119 ofertas, costo estimado $0.12–0.24. Agregadas al tracker como app-440 a app-442 |
| 2026-10-31 (prueba product engineer) | run PtyUV5WCCJFXI3Vpw / U3Rcuh3aLf9dMHn6K | mid level product engineer typescript react · Canada · 7 días | 18 | 0 | Casi todo repetido con núcleo y SWE II o ya en el tracker (Affirm, Xanadu, Baseten ×2, Manulife, EA, Athennian ×2, 11x ×2, Cohere ×2, Questrade ×2, Badge, adidas). Sin útiles: Thumbtack AI Platform (Victoria, 200+), Stripe Revenue y Elastic Senior (200+), Raydar (Solutions Engineer). Costo estimado $0.02–0.04 |
| 2026-10-31 (prueba contratos EE.UU.) | run GudVCqvUa8wzfl8Yl / qA7adVLvZJGf5P8Fq | A: remote contract full stack developer typescript react · United States · 7 días; B: la misma + `canada` | 38 (19 + 19) | 1 en Evaluar | Exigen W2, ciudadanía o autorización de EE.UU.: Anagh, Prominent, Signify, CSI, Oliver James ×2, Trispoke, TPI ×2, Central Point, Kellton, Akraya, Talenzaa, Red Cell, Global Alliant, Talent Groups, Torentify, Acumenz, TechStar. Stack o nivel: Brillio (Java), Tek Leaders (8+), Agile Tech Labs (Python 5+), Rise y O2 (.NET), Kforce (Vue/Java), Burtch Works (Python 7+), Twine AdTech (7+), Twine Cloud PBX (telefonía/React Native). Sin dato de autorización: ConsultNet ×2 (Senior 5+), CCS Global (GIS, 5+), Innovar (contract-to-hire, conversión en EE.UU.), Crossing Hurdles y Great Value Hiring (gigs). En Evaluar: DeWinter AI Product Engineer (3+ años, US$50–175/h, preguntar si acepta Canadá). Lazer ya aplicada. Costo estimado $0.04–0.08 |
| 2026-11-02 (validación contratos día 1/3) | hDdO7riTag7sHWVmI (mañana) y BBYfXWQFuf2t4PtDD (noche) | contract full stack developer typescript react · 24 h | 9 + 59 | 3 | Lunes: a la mañana solo 9 avisos (4 gigs); a la noche 59, con 19 contratos. Útiles: Google SWE II Early Career (no es contrato), IDENTOS (contrato 12 meses remoto) y PRI Engineering (permanente, Mississauga). Las 3 se aplicaron; PRI respondió al día siguiente |
| 2026-11-03 (validación contratos día 2/3) | XaTlKNmEYywhdvvWT | contract full stack developer typescript react · 24 h | 59 | 2 (1 única) | La mayoría ya había salido en el run de la noche anterior. 16 contratos. Útiles: Jobgether Intermediate SE (= AppDirect/Tackle) y SS&C AI Software Engineer (también en backend), ambas permanentes y aplicadas |
| 2026-11-04 (validación contratos día 3/3) | bawWfbEPAffZSgQc4 | contract full stack developer typescript react · 24 h | 60 (tope) | 2 | 21 contratos. Útiles: Twine Customer Portal y Gigafest, que David descartó. Repetición con núcleo y backend: 2 de 57 avisos. Validación cerrada: ~1,3 útiles únicas por día; pasa a validada (decisión de David) |

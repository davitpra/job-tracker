# Rúbrica de clasificación de ofertas

Regla fija para clasificar cada oferta en el tracker (https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5). Aplicarla siempre, en este orden.

## Paso 0. Qué se lee siempre
- La descripción completa de la oferta: responsabilidades, dominio, años, nivel, modalidad, idiomas, requisitos obligatorios y "nice to have".
- El CV maestro (`cv/master-cv.md`), leído en cada clasificación y no de memoria.
- Contexto fijo de David: vive en London ON; se mudará a BC; trabajo actual ~60 % frontend / 40 % backend; español nativo e inglés profesional.
- **Años que ve un reclutador** (agregado el 2026-10-27): unos 3 años y 10 meses en empresa (Idukay, Kruger y el contrato de Delphi). El trabajo independiente se cuenta como evidencia de habilidades, no como años de nivel.

## Paso 1. Filtros eliminatorios → Descartada
Si falla cualquiera, la oferta va directo a **Descartada**, sin puntuar:
- Presencial, o híbrido fuera de alcance. Sí son válidos:
  - remoto (en Canadá o en cualquier país);
  - híbrido en London ON y alrededores, y en Toronto/GTA (incluye Mississauga y North York) con cualquier frecuencia presencial (cambiado el 2026-10-16); en el resto de Ontario, según la frecuencia presencial.
- **Fuera de Ontario solo se acepta remoto.** El híbrido o presencial en BC u otra provincia se descarta por ahora (cambiado el 2026-10-14).
- Ofertas fuera de Canadá (p. ej. EE.UU.) que exigen autorización de trabajo en ese país y no aceptan trabajar desde Canadá → **Descartada** (agregado el 2026-10-16).
- Stack central ajeno al de David (Java, .NET, Python o móvil nativo como núcleo). Python se agregó el 2026-10-20: cuenta como núcleo cuando el backend principal es Python y es requisito obligatorio (p. ej. Python/Django, Flask, FastAPI o "deep Python"). No cuenta cuando Python es una opción entre varios lenguajes ("Node.js, Python o Go"), uno más de una lista de lenguajes exigidos junto con TS/Node, o un deseable.
- Nivel muy por encima: Staff/Principal, 8+ años o gestión de personas.
- Requisito duro que no cumple (p. ej. francés obligatorio o una certificación específica).

No hay salario mínimo: el salario nunca descarta una oferta. Se anota como dato.

**Filtro de competencia (se revisa después del paso 2, porque depende del encaje).** Agregado el 2026-10-15:
- Más de 200 solicitantes → **Descartada**, salvo que se cumplan las dos condiciones:
  - encaje **Alto o Muy alto**, y
  - publicada hace **menos de 5 días**, *o* hay un **contacto** (recruiter, hiring manager o referido) a quien escribir.
- Si pasa la excepción, se aplica y el próximo paso incluye un mensaje directo a alguien del equipo el mismo día.

Si un filtro es dudoso (modalidad poco clara, híbrido en Ontario lejos de London y fuera del GTA, o un remoto que podría exigir residir en un país o ciudad concretos), no se descarta: va a **Evaluar**, con la duda en Brechas.
- **Avisos de agencia sin modalidad ni ubicación** (agregado el 2026-11-04, a partir de BeachHead): van a **Evaluar** y se pregunta al reclutador en el primer contacto. Si David ya aplicó, queda en **Aplicado** con la duda en Brechas y en Próximo paso.

## Paso 2. Encaje: requisito por requisito contra el CV
Cada requisito **obligatorio** se puntúa con evidencia del CV:
- ✅ Cumple = 2
- 🟡 Parcial = 1 (lo ha tocado, pero no a fondo)
- ❌ No cumple = 0

**El requisito de años se puntúa contra los años en empresa del paso 0, no contra el total del CV** (cambiado el 2026-10-27): piden 3 o menos → ✅; piden 4 → 🟡; piden 5 o más → ❌.

Porcentaje = puntos / máximo posible.
- ≥ 90 % → **Muy alto** (agregado el 2026-10-27)
- 80–89 % → **Alto**
- 50–79 % → **Medio**
- < 50 % → **Bajo**

Ajustes:
- **Tope de nivel** (cambiado el 2026-10-27; antes solo topaba pedir 6+): si piden 5 años o más **como requisito**, o el título dice **Senior, Sr., Founding o Lead**, el encaje queda como máximo en **Medio**. Motivo: en 112 aplicaciones (al 2026-10-27), los puestos Senior dieron 1 señal positiva de 62; los demás, 3 de 50.
  - **Excepción (2026-11-04, a partir de BeachHead):** si los años son solo **preferidos** y el título es **Intermediate o Mid**, no hay tope. El requisito de años se puntúa ❌ igual, pero el encaje no se limita a Medio.
- **Stack:** si TS/React/Next.js/NestJS/PostgreSQL es el núcleo del rol, sube un nivel, como máximo hasta Alto. Muy alto solo se alcanza con 90 % o más real (2026-10-27). Nunca supera el tope de nivel.
- **Español** (agregado el 2026-10-27): si la oferta **exige** español (bilingüe inglés/español o trato con clientes o equipos hispanohablantes), cuenta como requisito cumplido (✅) y el encaje sube un nivel, hasta Alto como máximo. Es el único ajuste que puede pasar por encima del tope de nivel, porque el español achica mucho el grupo de candidatos. Si el español es solo deseable, no suma al porcentaje pero sube la prioridad (paso 3).
- **Rol muy backend** (> 70 %): se anota como brecha y cuenta en contra solo para desempatar.
- **"Nice to have":** no suman al porcentaje; solo desempatan y se usan en "Por qué encajas".

## Paso 3. Prioridad (1 = más alta, 4 = solo si sobra tiempo)
Base según el encaje: Muy alto = 1, Alto = 1, Medio = 2, Bajo = 3. Dentro de la prioridad 1, Muy alto va primero. Después se suman las reglas de abajo (cada una vale 1), con un ajuste total de como máximo ±2 y un resultado entre 1 y 4 (antes ±1; cambiado el 2026-10-27 para que el contrato y el español pesen junto con lo demás).

**Sube** un nivel por cada una que se cumpla:
- publicada hace menos de 3 días y con menos de 50 solicitantes;
- hay un contacto o referido;
- la empresa suma mucho al CV;
- **es un contrato** (por agencia o directo), agregado el 2026-10-27: los contratos dieron 3 señales positivas de 15, contra 1 de 97 en puestos permanentes;
- **pide o valora español** (obligatorio o deseable), agregado el 2026-10-27.

El sector financiero del cliente y pedir herramientas de IA en el desarrollo **no** suben la prioridad (decisión de David el 2026-11-04: la IA la usan todas las ofertas y el sector no cambia las posibilidades).

**Baja** un nivel por cada una que se cumpla:
- publicada hace más de 2 semanas;
- más de 200 solicitantes (solo afecta a las que pasaron la excepción del filtro de competencia);
- **título Senior, Sr., Founding o Lead, o piden 5+ años obligatorios** (agregado el 2026-10-27). Así, un Senior sin contacto queda en prioridad 3 y con contacto en 2: se aplica a Senior solo cuando hay alguien a quien escribir o la empresa es pequeña. Años solo preferidos con título Intermediate o Mid no bajan (2026-11-04).

El esfuerzo de aplicar (Workday/Taleo frente a Easy Apply) no cambia la prioridad; solo ordena qué se hace primero dentro del mismo nivel.

## Paso 4. Estado inicial
- **Descartada:** falló un filtro del paso 1, incluido el de competencia (200+ sin excepción).
- **Evaluar:** falta información clave, algún filtro es dudoso o el encaje es Bajo.
- **Por aplicar:** encaje Muy alto, Alto o Medio y ninguna duda.

## Paso 5. Qué se escribe en el tracker
- **Por qué encajas:** los 2–3 requisitos más fuertes que cumple, con la evidencia del CV. Si la oferta pide o valora español, va siempre aquí.
- **Brechas o riesgos:** cada 🟡 y ❌, más los ajustes aplicados (p. ej. "título Senior → tope Medio y prioridad −1", "piden 5 años; en empresa 3,8 → ❌").
- **Clasificación guardada** (`clasif`, agregado el 2026-10-28): toda oferta que se puntúa lleva este campo. El diálogo de la oferta lo muestra en "Cómo se clasificó" y Métricas lo usa en "¿La rúbrica acierta?":
  - `pts`, `max` y `pct` (número entero, sin "%");
  - `requisitos`: lista de `{ r: requisito obligatorio, n: 2 | 1 | 0, e: evidencia del CV o lo que falta }`, uno por requisito puntuado, incluido el de años;
  - `ajusteEncaje`: texto corto con lo que movió el nivel (p. ej. "Tope Medio por título Senior", "Sube a Alto por stack (TS/Node es el núcleo)"); se omite si no hubo ajuste;
  - `prioridad`: `{ base, ajustes: [{ t: "contacto", v: 1 }, { t: "Senior", v: -1 }], final }`;
  - `filtro`: solo si algún filtro fue dudoso (p. ej. "Dudoso: Waterloo, días de oficina no indicados");
  - `rubrica`: fecha de la versión de esta rúbrica que se usó (la `version` de `settings/rubrica`).
- **Notas:** lo que no cabe en otro campo (origen, dudas, lo que se hizo). El puntaje y los ajustes no se repiten aquí. Las entradas nuevas van con fecha (`AAAA-MM-DD: …`).
- **Salario normalizado** (agregado el 2026-10-28): además del texto en Salario, se llenan `salMin`, `salMax` (números), `moneda` (CAD, USD, GBP, EUR o vacío si el aviso no la dice) y `periodo` ("año", "hora" o "mes"). Reglas: "Hasta $X" → solo `salMax`; "Desde $X" → solo `salMin`; un monto único → los dos iguales; "$" sin moneda en un aviso de Canadá → CAD; si el aviso da un rango de EE.UU. y no el de Canadá, no se llena. La pestaña "Tecnologías y puestos" (sección Lo que pagan) usa estos campos.
- **Motivo de descarte** (agregado el 2026-10-28): toda oferta que queda en **Descartada** lleva `motivoDescarte`, una lista con uno o más de estos valores exactos: "Senior o 5+ años", "Híbrido o presencial", "Modalidad no indicada", "200+ solicitantes", "Python como núcleo", "Otro stack como núcleo", "Java/Kotlin, .NET o C#", "Móvil nativo", "Otra brecha técnica", "Rol distinto o por debajo del nivel", "Salario bajo", "Autorización o residencia", "Francés", "Duplicada o ya aplicaste en la empresa", "Falta información", "Oferta cerrada", "Otro". Se marcan todos los que pesaron, no solo el filtro que la eliminó. "Otro" solo si no aplica ninguno.
- **Pestaña Rúbrica** (agregado el 2026-10-28): se alimenta del documento `settings/rubrica` de la base del tracker (`texto`, `version`, `cambios`). Cada vez que cambie esta rúbrica, se actualiza también ese documento. Última versión: 2026-11-04.
- **Número de la oferta nueva:** varias sesiones agregan ofertas a la vez. Antes de escribir una `app-N`, consultar el `n` más alto (`orderBy: -n`) y no reutilizar uno ya ocupado (agregado el 2026-11-04).

## Paso 6. Aplicar también en la web de la empresa (encaje Alto y Muy alto)
Agregado el 2026-10-28. Rige de aquí en adelante; no se aplica a las que ya estaban en Aplicado ese día.
- **Cuándo:** una oferta con encaje **Alto o Muy alto** pasa de **Por aplicar** a **Aplicado** (normalmente por LinkedIn).
- **Qué se escribe:** el estado queda en **Aplicado**, como siempre (no hay estado nuevo). En **Próximo paso** se pone primero "Aplicar en la web de la empresa", con el link a la oferta en su página de empleos si se encuentra, y después cualquier otro paso que ya hubiera (p. ej. "Aplicar en la web de la empresa: <link>. Después: escribir a <contacto>").
- **No aplica** si la oferta ya se aplicó en la web de la empresa, o si es de una agencia o de un cliente no revelado (Jobgether, Swoon, Raydar, BeachHead…), porque no hay página de la empresa donde aplicar.
- **Recordatorio:** el tracker muestra arriba las aplicadas Alto/Muy alto cuyo Próximo paso todavía dice "Aplicar en la web de la empresa", y Claude las lista al empezar cada vez que David trabaje el tracker. No hay tarea programada ni aviso al celular (decisión de David).
- **Cierre:** cuando David confirma que aplicó en la web, Claude quita ese texto de Próximo paso y deja el resto, y agrega en Notas "Aplicado también en la web de la empresa el <fecha>".

## Paso 7. Contacto después de aplicar (agregado el 2026-10-28)
- Motivo: al 2026-10-28, las aplicaciones con alguien en Contacto dieron 3 señales positivas de 21 (14 %), incluidas las 2 entrevistas; sin contacto, 2 de 97 (2 %). El corte "Por contacto" de Métricas lo sigue midiendo.
- Cuando David consigue a alguien (recruiter, hiring manager o alguien del equipo), se anota en **Contacto** con su rol y, si hay, el link de LinkedIn.
- No hay aviso "sin contacto" en la lista: David lo pidió quitar el 2026-10-28.

## Tracker reconstruido (2026-11-18)
El tracker original (FsyQMtsZNsn3QTk84ypRpB) desapareció entre el 15 y el 16 de noviembre. Se rehízo en https://claude.ai/artifact/3HRNkCXVHakMDD47n3ekB5 con 104 ofertas recuperadas del Registro de empleos de LinkedIn, la memoria del proyecto y el historial de chats (campo `recuperada: true`). Las aplicadas recuperadas no tienen encaje, prioridad ni `clasif`, salvo las pocas que estaban anotadas. El botón "Exportar JSON" del tracker baja una copia completa de la base.

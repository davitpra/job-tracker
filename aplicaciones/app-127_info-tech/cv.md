# DAVID PRADO
Title: Intermediate Software Developer
Contact: London, ON | (phone, email and links come from templates/cv-template.docx)

## PROFESSIONAL SUMMARY
Software Developer with 6+ years of experience, almost 4 of them on company teams. For the last 2, I’ve worked independently: I talk to the users, make the technical decisions and ship to production myself. I build web software applications with JavaScript, TypeScript, React, Next.js, Node.js and relational databases (PostgreSQL, MySQL), and I turn conversations with users into functional requirements, then write specs and automated tests before the code. I use Claude Code and Codex daily, with specs and tests keeping the output reviewable. I’ve built generative AI pipelines with vision models, and I enjoy learning new technologies. Technical lead for the order module of a logistics platform processing 5,000+ shipments per day, where I guided the team through code reviews. I’ve mentored junior developers, and I’m bilingual in Spanish and English.

## TECHNICAL SKILLS
**Core stack:** JavaScript, TypeScript, HTML5, CSS3, React, Next.js (SSR/SSG), Node.js, NestJS, Express
**Databases & SQL:** Relational database design, SQL, PostgreSQL, MySQL/MariaDB, Prisma, Drizzle, Row-Level Security, full-text search, MongoDB, Redis
**AI:** Generative AI integration, vision models, dynamic prompting, async AI pipelines (BullMQ, pg-boss), fal.ai, Python (basic)
**AI-assisted development:** Claude Code, Codex, agentic coding workflows, spec-driven development
**APIs & integrations:** REST APIs, GraphQL, JSON:API, Socket.IO, Shopify (GraphQL APIs, headless, metaobjects and metafields)
**Frontend:** Vite, React Query / TanStack, Redux, PWA, Service Workers, IndexedDB (Dexie), Tailwind, Sass, Bootstrap, Material UI
**Source control & cloud:** Git, GitHub, Bitbucket, GitHub Actions, CI/CD, Docker, AWS (EC2, S3, CloudWatch, Lambda, API Gateway), Vercel, Linux VPS
**Testing & quality:** Jest, Cypress, Vitest, Playwright, integration testing, code reviews, SonarQube, ESLint
**Practices:** Agile/Scrum, Kanban, design patterns (Strategy, outbox), modular monolith, ADRs, requirements gathering, mentoring, WCAG, Jira

## PROFESSIONAL EXPERIENCE

### Full-Stack Developer (Independent) | Mar 2024 – Present
Self-employed | London, ON · Remote
Custom web software applications and AI-powered products for small businesses and my own ventures, mostly replacing paper-based or manual workflows. Spec-driven delivery with AI coding agents (Claude Code, Codex) used daily: architecture decisions recorded as ADRs, specs before code, and integration tests in CI.

#### Claw & Soul · AI Pet Art E-commerce · Technical Co-Founder | Apr 2025 – Present
- Selected for the Fanshawe College Entrepreneurship & Innovation Program. Built end to end an e-commerce platform that turns pet photos into AI art and paint-by-numbers kits, and shaped technical and product decisions with a business partner.
- Designed an asynchronous generative AI pipeline with BullMQ/Redis: photo analysis with vision models, dynamic prompting, and generation with fal.ai. Swappable art styles use the Strategy design pattern.
- Deployed AWS Lambda and API Gateway functions with AWS SAM for Shopify webhooks, image processing, AI calls and S3 presigned uploads.
- Integrated headless Shopify through its GraphQL APIs, modeling the product catalog, art styles and print formats with metaobjects and metafields, on a PostgreSQL data model with full-text search.
**Stack:** Next.js · React · TypeScript · NestJS · PostgreSQL · BullMQ/Redis · fal.ai · AWS · Shopify · GraphQL

#### Offline Inspection System · Ontario Greenhouses, London, ON | Aug 2026 – Oct 2026
- Gathered requirements with Health & Safety and Human Resources to digitize inspections across two sites, and turned them into functional requirements and specs. Identified the lack of connectivity in the greenhouse as the reason the previous tool was abandoned.
- Designed and built, as the sole developer, an offline-first PWA for health & safety, maintenance, and electrical inspections, piloted with **~30 users**. It organizes work areas, assigns owners, and tracks each finding through to corrective action.
- Designed the relational database in PostgreSQL with database-level immutability, per-site Row-Level Security, and hash-chained audit logs aligned with OHSA requirements. Solved offline sync with the outbox pattern on IndexedDB and Service Workers.
- Documented the architecture in **12 ADRs** to communicate technical details, and applied spec-driven development (OpenSpec) with integration tests in CI.
**Stack:** TypeScript · React · Vite · TanStack · NestJS · PostgreSQL · Drizzle · pg-boss · Dexie · Docker

#### ClawPuzzle · AI personalization platform for Puzzle Salvaje, Ecuador | Aug 2026 – Oct 2026
- Built the AI personalization flow for Puzzle Salvaje, a puzzle business with **5+ years** of operation and **thousands of units sold** in Ecuador: pet photo upload, style selection and AI-generated artwork, connected to Shopify through its GraphQL API.
- Improved an existing in-house generation engine: redesigned the data model, removed **90+ obsolete files**, and merged two repositories into a monorepo while preserving Git history.
**Stack:** Next.js · React · TypeScript · NestJS · PostgreSQL · Prisma · fal.ai · Shopify · GraphQL

#### Meal Ordering System · Horizon Place care residence, London, ON | Mar 2024 – Aug 2024
- Identified the need to digitize paper meal orders while working in the residence's dietary department, then designed and built a full-stack web application to replace them.
- Piloted the app with **60+ residents**, **14 tables**, and **two shifts**. Eliminated errors by displaying allergies, diets, and preferences in real time, saving **10–20 minutes per service**.
**Stack:** Next.js · React · Strapi · Socket.IO

### Frontend Software Engineer (Contract) | Nov 2024 – Feb 2025
Delphi (via Randstad) | Phoenix, AZ, USA · Remote from London, ON
- Migrated pages and components from WordPress to Next.js with SSR and SSG, as part of a migration that raised Lighthouse Performance from **45 to 90**, along with technical SEO and accessibility (WCAG) improvements in HTML5, CSS3 and JavaScript.
- Integrated REST APIs with Axios and React Query for the vehicle parts catalog and store locator, optimizing caching and reducing redundant requests.
- Wrote unit tests with Jest and E2E tests with Cypress, and took part in code reviews, GitHub Actions pipelines and SonarQube checks within a distributed Agile/Scrum team.

### Senior Software Developer | Jan 2022 – Aug 2023
Kruger Corp | Quito, Ecuador
- Technical lead for the order tracking module of Urbano, a logistics platform processing **5,000+ daily shipments** (high volumes): the full lifecycle from customer creation to routing, delivery, and payment collection, within a three-developer team.
- Developed order, payment collection, and cash-on-delivery reconciliation services with NestJS and PostgreSQL, writing the SQL behind them, plus React and Vite views for customers and internal operations: collections, delivery retries, and per-order success rate.
- Made architecture decisions and designed the relational data model for the order and payment flow. Provided technical guidance to peers through code reviews, and supported production deployments on AWS (EC2, S3, CloudWatch) with unit testing and CI.

### Software Developer | Jan 2020 – Oct 2021
Idukay | Quito, Ecuador
- Integrated a professional training platform (MERN) with the web services of the SRI, Ecuador's tax authority, for electronic invoicing: XML invoice generation, status and error handling, and automatic delivery to users, processing **60–70 invoices per month**.
- Built the reporting module end to end, with backend and React frontend, for **~50 students and 8 courses**: progress, grades, and pass rates per course for instructors and administrators. Tested critical logic with Jest and took part in code reviews.

## EDUCATION

### Entrepreneurship & Innovation Program and LeapIN Business Accelerator | Apr 2025 – Aug 2025
Fanshawe College | London, ON, Canada
- Developed a startup project from concept to prototype with mentorship from industry experts.

### Diploma, Internet Applications and Web Development | Sep 2023 – Apr 2025
Fanshawe College | London, ON, Canada

### Full Stack Developer with JavaScript · React Front-end Developer | 2019 – 2023
Platzi | Online

## LANGUAGES
**Spanish:** Native · **English:** Professional

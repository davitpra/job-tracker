# DAVID PRADO
Title: Senior Application Developer
Contact: London, ON | (phone, email and links come from templates/cv-template.docx)

## PROFESSIONAL SUMMARY
Senior Application Developer with 6+ years of experience, almost 4 of them on company teams. For the last 2, I’ve worked independently: I talk to the users, make the technical decisions and ship to production myself. My focus is customer-facing digital experiences built with TypeScript and React: responsive, accessible (WCAG) interfaces, reusable UI components, bilingual English/French front ends, and integration with backend services and APIs on AWS. I define specs before writing code and own code quality through peer reviews, automated testing and static analysis in CI/CD. I use Claude Code and Codex daily, with specs and tests keeping the output reviewable. I’ve mentored junior developers and led the order module of a logistics platform processing 5,000+ shipments per day.

## TECHNICAL SKILLS
**Front-end:** TypeScript, JavaScript, React, Next.js (SSR/SSG, App Router), Redux, React Query / TanStack, Vite, HTML5, CSS, Sass, Tailwind, styled-components, PWA, Angular
**Accessibility & UX:** WCAG, responsive design, multilingual / bilingual (English/French) internationalization (i18n), design system work and reusable UI components (Material UI, Bootstrap), Figma-to-code, front-end performance optimization (Lighthouse)
**AWS & cloud-native:** AWS (EC2, S3, Lambda, API Gateway, AWS SAM, CloudFront, CloudWatch), serverless, Docker, Vercel
**Backend & APIs:** Node.js, NestJS, REST APIs, GraphQL, Express, PostgreSQL, Prisma, Drizzle, Redis, BullMQ, Shopify APIs, Python (basic)
**AI-first development:** Claude Code, Codex, AI-assisted development tools, agentic coding workflows, spec-driven development, prompt engineering (dynamic prompting), generative AI integration (fal.ai, vision models)
**Testing & code quality:** automated testing, Jest, Vitest, Cypress, Playwright, integration testing, test coverage in CI, peer code reviews, static analysis (SonarQube, ESLint, Prettier), clean code
**CI/CD & source control:** Git, GitHub, GitHub Actions, GitHub workflows, CI/CD, Jenkins, semantic versioning, Dependabot, Sentry, Datadog
**Practices:** Agile/Scrum, Kanban, technical specifications, ADRs, documentation, Jira

## PROFESSIONAL EXPERIENCE

### Full-Stack Developer (Independent) | Mar 2024 – Present
Self-employed | London, ON · Remote
Custom web systems and AI-powered products for small businesses and my own ventures, mostly replacing paper-based or manual workflows. AI-first workflow with AI coding agents (Claude Code, Codex) used daily: specs before code, architecture decisions recorded as ADRs, and generated code reviewed and covered by integration tests in CI before it ships.

#### Claw & Soul · AI Pet Art E-commerce · Technical Co-Founder | Apr 2025 – Present
- Built end to end, with a business partner, a customer-facing e-commerce platform that turns pet photos into AI art and paint-by-numbers kits (Fanshawe College Entrepreneurship & Innovation Program).
- Built cloud-native pieces on AWS with AWS SAM: Lambda and API Gateway for Shopify webhooks, image processing and fal.ai calls, plus S3 presigned uploads served through CloudFront.
- Designed an asynchronous AI pipeline with BullMQ/Redis: photo analysis with vision models, dynamic prompting, and generation with fal.ai. Implemented swappable art styles using the Strategy pattern.
- Integrated headless Shopify through its GraphQL APIs, modeling the product catalog, art styles and print formats with metaobjects and metafields.
**Stack:** Next.js · React · TypeScript · NestJS · PostgreSQL · BullMQ/Redis · AWS Lambda · S3 · CloudFront · fal.ai · Shopify · GraphQL

#### Offline Inspection System · Ontario Greenhouses, London, ON | Aug 2026 – Oct 2026
- Gathered requirements with Health & Safety and Human Resources to digitize inspections across two sites. Identified the lack of connectivity in the greenhouse as the reason the previous tool was abandoned.
- Designed and built, as the sole developer, an offline-first PWA for health & safety, maintenance, and electrical inspections, piloted with **~30 users**. It organizes work areas, assigns owners, and tracks each finding through to corrective action.
- Solved offline sync with the outbox pattern on IndexedDB and Service Workers. Implemented database-level immutability, per-site Row-Level Security, and hash-chained audit logs aligned with OHSA.
- Documented the architecture in **12 ADRs**, applied spec-driven development (OpenSpec) with integration tests in CI, and set up Sentry error tracking with alerts.
**Stack:** TypeScript · React · Vite · TanStack · NestJS · PostgreSQL · Drizzle · pg-boss · Dexie · Serwist · Docker · Sentry

#### ClawPuzzle · AI personalization platform for Puzzle Salvaje, Ecuador | Aug 2026 – Oct 2026
- Built the technology for Puzzle Salvaje, a custom puzzle business with **5+ years** of operation and **thousands of units sold** in Ecuador, to launch a new line of AI-personalized wooden puzzles.
- Designed the customer-facing personalization flow: pet photo upload, style selection, and AI-generated artwork ready for production with themed pieces, connected to the Shopify store through its GraphQL API.
**Stack:** Next.js · React · TypeScript · NestJS · PostgreSQL · Prisma · fal.ai · Shopify · GraphQL

#### Meal Ordering System · Horizon Place care residence, London, ON | Mar 2024 – Aug 2024
- Designed and built a full-stack web application to replace paper meal orders, piloted with **60+ residents**, **14 tables**, and **two shifts**. Eliminated errors by displaying allergies, diets, and preferences in real time, saving **10–20 minutes per service**.
**Stack:** Next.js · React · Strapi · Socket.IO

### Frontend Software Engineer (Contract) | Nov 2024 – Feb 2025
Delphi (via Randstad) | Phoenix, AZ, USA · Remote from London, ON
- Migrated customer-facing pages and components from WordPress to Next.js with SSR and SSG, as part of a migration that raised Lighthouse Performance from **45 to 90**, through front-end performance optimization, CDN caching (Cache-Control), technical SEO and WCAG accessibility improvements.
- Integrated REST APIs with Axios, Redux and React Query for the vehicle parts catalog and store locator, optimizing caching and reducing redundant requests.
- Wrote unit tests with Jest and E2E tests with Cypress, took part in peer code reviews, and shipped through GitHub Actions CI/CD with SonarQube static analysis and semantic versioning, within a distributed Agile/Scrum team.

### Senior Software Developer | Jan 2022 – Aug 2023
Kruger Corp | Quito, Ecuador
- Technical lead for the order tracking module of Urbano, a logistics platform processing **5,000+ daily shipments**: the full lifecycle from customer creation to routing, delivery, and payment collection, within a three-developer team.
- Developed order, payment collection, and cash-on-delivery reconciliation services with NestJS and PostgreSQL, plus React and Vite views for customers and internal operations: collections, delivery retries, and per-order success rate.
- Supported a highly available production platform on AWS (EC2, S3, CloudWatch): deployment support, health checks and alerts, and monitoring with Datadog and Sentry.
- Made architecture decisions and designed the data model for the order and payment flow. Kept delivery quality through peer code reviews, unit testing, test coverage in CI (GitHub Actions, Jenkins) and SonarQube.

### Software Developer | Jan 2020 – Oct 2021
Idukay | Quito, Ecuador
- Integrated a professional training platform (MERN) with the web services of the SRI, Ecuador's tax authority, for electronic invoicing: XML invoice generation, status and error handling, and automatic delivery to users, processing **60–70 invoices per month**.
- Built the reporting module end to end, with backend and React frontend, for **~50 students and 8 courses**: progress, grades, and pass rates per course for instructors and administrators, plus a progress map for students. Tested critical logic with Jest and took part in code reviews.

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

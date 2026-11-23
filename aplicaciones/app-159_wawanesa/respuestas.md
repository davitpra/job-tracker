# Respuestas del formulario — Wawanesa (app-159)

Preparadas en chat el 2026-11-23.

## salary
Thanks for asking. Based on the posted range, I'm looking for a base salary of $105,000 to $115,000. That number isn't fixed. I'd weigh it together with the full package you describe, including the annual bonus, pension and benefits, and I'm open to talking it through once we know more about the role and the level.

## q-ai-short
For the last two years I've built my independent projects AI-first with Claude Code and Codex. I start with a spec, the agent implements against it, and tests in CI plus my review decide what's merged. And yes, Claw & Soul has AI in the product. It's a pet-art e-commerce platform I co-founded. You upload a pet photo and pick a style, then vision models analyze it, the prompt is built dynamically and fal.ai generates the art. Each portrait takes 20 to 30 seconds, so it runs as an async queue on BullMQ and Redis.

## q-testing
I start testing before the code exists. The spec defines what has to work, and that becomes the test cases. I put most of the effort where bugs actually cost something: integration tests around the critical flows, unit tests with Jest or Vitest for the business logic, and E2E tests with Cypress or Playwright for what users do. Everything runs in CI with coverage and static analysis, so nothing merges red. That matters more with AI-written code. If the tests don't pass, it doesn't ship.

## q-startup
Yes. It's how I've worked for the last two years, as an independent developer and as technical co-founder of Claw & Soul. A good example is a greenhouse operation that asked me to digitize their health and safety inspections. There was no spec and no team. I sat down with Health & Safety and HR and found out why their last tool failed: no signal in the greenhouses. So I built an offline-first PWA on my own and piloted it with about 30 users. Nobody told me what to build. I had to find it.

# CV structure and tailoring rules (David Prado)

How to produce a tailored CV for a job posting that keeps the exact format of David's master CV.

## Where things live
Changed 2026-11-02: the master CV now has a single copy, in GitHub.

| Where | What |
|---|---|
| GitHub `davitpra/cv-toolkit`, file `master-cv.md` | **The master CV: content source of truth and its only copy.** Read it from any chat in any project (public repo: `git clone --depth 1 https://github.com/davitpra/cv-toolkit`). To change the CV, edit this file and push to `main`; no other copy is kept or synced. The `Contact:` line deliberately has no phone or email: the build takes them from the template. |
| `cv/cv-structure.md` (this project) | This file: tailoring rules and steps. |
| `cv/master-cv.md` (this project) | Only a pointer to the GitHub file. |
| Tracker artifact, db doc `settings/cvMaestro` | Only a pointer to the GitHub file (the "CV maestro" button shows the link). No longer synced. |
| GitHub `davitpra/cv-toolkit` (rest of the repo) | Templates (.docx), build scripts, `make.sh` and `check_ats.py`. Its README has the markdown build format and visual spec. Clone it; never paste its files into a chat. **Never commit tailored CVs or letters** (`tailored-cvs/` is git-ignored; the repo is public). |

## Tailoring rules (David's decisions)
1. **Title under the name changes per posting.** Match the posting's role name when it's truthful (e.g. "Senior Frontend Developer", "Full-Stack Engineer"); otherwise the closest honest title. Keep the summary's first words consistent with it.
2. **Rewrite bullets for the posting.** Use the posting's keywords and reorder to lead with what they ask for. Rewording is allowed; inventing is not: no new facts, tools, metrics, team sizes or results that aren't in `master-cv.md` (or that David hasn't stated). Keep the bolded metrics as they are.
3. **Deliver only the PDF. Never send the .docx.** The .docx is just an intermediate build file: do not pass it to SendUserFile, do not attach it, do not offer it. One file per CV: `Resume - David Prado - <Company>.pdf`. (Restated 2026-10-15.) Exception to mention to David, not to do on my own: if the posting or portal explicitly asks for .docx (some older ATS such as Taleo), say so and ask.
4. **Page count depends on the years of experience the posting asks for.** Changed 2026-10-20. See "Page count".
5. **Never add the Civil Engineering degree.**
6. Language: English (the master is EN).
7. File name: `Resume - David Prado - <Company>.pdf`.
8. **Humanize pass (li-human skill), cleanup only.** Added 2026-10-15. See "Humanize pass" below.
9. **AI coding tools (Claude Code, Codex).** Added 2026-10-17. David uses them daily on his independent projects.
   - Always keep the mention in the Independent intro and the `**AI-assisted development:**` skills line (both already in `master-cv.md`). When cutting to one page, keep that skills line if the posting mentions AI, AI-native work or developer productivity.
   - Add this sentence to the summary only when the posting mentions AI tools, AI-native work or productivity, right after the specs-and-tests sentence: "I use Claude Code and Codex daily, with specs and tests keeping the output reviewable."
   - Never attach these tools to Delphi, Kruger, Idukay or the Meal Ordering System: that work predates them.
10. **Years of experience in the summary: always split them.** Added 2026-10-27 (wording chosen by David). The summary opens with these two sentences from `master-cv.md`: "<Title> with 6+ years of experience, almost 4 of them on company teams. For the last 2, I’ve worked independently: I talk to the users, make the technical decisions and ship to production myself."
   - Never write "6+ years" on its own. Recruiters count only the in-house dates (Idukay, Kruger, Delphi: about 3 years and 10 months), so a bare "6+" reads as inflated next to the dates.
   - When the title changes (rule 1), only `<Title>` changes (e.g. "Full-Stack Engineer with 6+ years of experience, almost 4 of them on company teams.").
   - When cutting the summary for one page, keep both sentences; shorten the others instead.
11. **Pass the ATS filter.** Added 2026-11-04 (decided by David). Every tailored CV has to read cleanly in an ATS and cover the posting's keywords. See "ATS pass" below. The check is part of delivery: the CV is not delivered without its ATS report.

## ATS pass
**Format (already guaranteed by the template; don't break it):** one column, no tables, text boxes, icons or skill bars; standard headings (PROFESSIONAL SUMMARY, TECHNICAL SKILLS, PROFESSIONAL EXPERIENCE, EDUCATION); contact line in the body, not in a header/footer; one date format; simple "●" bullets; PDF with a real text layer.

**Content:**
- From the posting, pull the required keywords (and the preferred ones) and spell them exactly as the posting does ("Node.js" or "NodeJS", "PostgreSQL" or "Postgres", "CI/CD", "REST APIs"). When a tool has an acronym and a full name, include both once.
- Place the important ones in the title, the summary and the Skills line, and put the top ones inside an experience bullet too, so they have context (the report lists keywords that live only in the Skills line).
- Only use keywords that `master-cv.md` supports. If the posting requires something David doesn't have, do **not** add it: list it as a gap and tell David. No hidden text, no keyword stuffing.
- Keep the posting's keywords verbatim even if the humanize lexicon flags one (rule 8).

**Check (`check_ats.py`, part of `make.sh`):**
1. Write `keywords.txt` next to `tailored.md` (outside the repo or in `tailored-cvs/`), one term per line, aliases separated by `|`, in three groups: `# required` (supported by the master CV), `# preferred`, `# gaps` (required by the posting, not supported; excluded from the percentage and reported separately).
2. Run `./make.sh cv tailored.md "<Company>" <pages> keywords.txt`.
3. The report checks the text layer (extractable text, headings, email and phone in the body, odd characters) and the coverage of `required`. **Minimum 80%.** Under 80% or any text-layer flag → fix and rerun.
4. In the reply to David, always show: the coverage %, the keywords NOT covered, the keywords found only in the Skills line, and the gaps. If a missing keyword is something David truthfully has but the CV doesn't say, edit the CV to include it; if not, leave it out and say so.

## Humanize pass (li-human skill)
Applies to every tailored CV, after editing `tailored.md` and before delivering.
- **What to apply:** remove invisible characters, replace em dashes (—), and swap AI slop words (leverage, robust, seamless, spearheaded, crucial, delve…) for plain words. Fix by hand only the lines that genuinely read as formula (rule-of-three, "not just X, it's Y", uniform bullets).
- **What NOT to apply to the CV:** do not chase a PASS score. VOICE and BURSTINESS clash with standard CV style.
- **Keep the CV's format characters:** en dashes in dates, "●" bullets, "·" and "|" separators, typographic apostrophes in the summary. Never write `humanize.py` output over `tailored.md`; apply only slop-word, em-dash and invisible-character changes by hand.
- **Keep the posting's keywords verbatim**, even if the lexicon flags one (ATS matching matters more).
- `make.sh` already prints SLOP DENSITY and FINGERPRINT for the CV (2 "curly quote" from the summary apostrophes are expected).

Cover letters and application-form answers get the full li-human process until PASS (show the final text with its score). `make.sh cl` prints every check and the verdict. In the cover letter, keep the template title "David Prado – <Role>" intact.

## Document structure (fixed order)
1. Name: `DAVID PRADO`
2. Title (tailored)
3. Contact line (fixed, copied from the template)
4. PROFESSIONAL SUMMARY: one paragraph
5. TECHNICAL SKILLS: `**Label:** items` lines (reorder lines and items so the posting's stack comes first; drop irrelevant lines or items if needed)
6. PROFESSIONAL EXPERIENCE, reverse-chronological:
   - Full-Stack Developer (Independent): meta line, intro paragraph, then projects (H4) each with bullets + `**Stack:**` line
   - Delphi (via Randstad), Kruger Corp, Idukay: meta line + bullets
7. EDUCATION: Fanshawe program, Fanshawe diploma, Platzi
8. LANGUAGES: `**Spanish:** Native · **English:** Professional`

## Build steps (token-light)
1. `git clone --depth 1 https://github.com/davitpra/cv-toolkit` (attach the repo to the session first if needed). Don't read the docx/pdf skills or any XML: the scripts handle the format.
2. Read `master-cv.md` from the clone and write `tailored.md` once (outside the repo or in the git-ignored `tailored-cvs/`), following the rules above. Write `keywords.txt` from the posting (see "ATS pass").
3. `./make.sh cv tailored.md "<Company>" <pages> keywords.txt`, with `1` or `2` according to "Page count". It builds, converts to PDF, checks the layout as text, runs the ATS check and runs the detector.
4. If it flags something (single word on its own line, too many pages, slop words, ATS coverage under 80% or a text-layer flag), edit only those lines with Edit and rerun. Render a page to PNG (`pdftoppm -r 60`) only if a flag can't be judged from the text.
5. Send only `out/Resume - David Prado - <Company>.pdf`, and in the reply give the ATS summary (coverage %, keywords not covered, gaps).

## Page count (by years asked in the posting)
Decided by David on 2026-10-20; replaces the old rule (one page for focused or mid-level postings).
- **Less than 4 years asked → 1 page.** Cut using the order below.
- **4 years or more asked → 2 pages, always.** Never 1, never more than 2. Fill the room with the posting's most relevant projects and bullets from `master-cv.md`; don't pad with content the posting doesn't care about.
- **Range (e.g. "3–5 years") →** use the higher number (so "3–5 years" → 2 pages).
- **No years in the posting →** go by the level in the title: Senior/Lead → 2 pages; otherwise 1 page.

Page 1 always carries what the posting asks for most, since many reviewers stop there.

### Getting to one page
Cut in this order until it fits:
1. Summary down to 3–4 lines, focused on the posting (keep the years split from rule 10).
2. Skills down to the 4–6 most relevant lines, trimming items within each line.
3. Independent: keep the 2–3 most relevant projects with 2 bullets each, and shorten the intro to 1 line.
4. Delphi and Kruger: 2 bullets each. Idukay: 1 bullet.
5. Education: drop the Platzi entry and the bullet under the Fanshawe program.
Never change fonts, sizes, margins or spacing to make it fit.

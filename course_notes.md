# Course notes and planned improvements

Running list of things to change in the course. Migrated here from GitHub issues
on the previous repository (`bmaitner/Statistical_ecology_course`), which is no
longer maintained. All of these came out of teaching the course in Fall 2025.

Original issues, for reference:

- [#1 Consider splitting into 2 or 3 courses?](https://github.com/bmaitner/Statistical_ecology_course/issues/1) — opened 2025-09-10
- [#2 Midterm feedback 2025](https://github.com/bmaitner/Statistical_ecology_course/issues/2) — opened 2025-10-14
- [#3 General notes](https://github.com/bmaitner/Statistical_ecology_course/issues/3) — opened 2025-12-13

---

## Course structure

### Consider splitting into 2 or 3 courses

This course might be more effective if split into multiple courses. For example:

1. **Intro to R** — using the command line, finding files, loading data, plotting data, data wrangling, etc.
2. **Stats in R** — essentially the *Ecological Models and Data in R* book
3. **Advanced R** — building packages, using docker, etc. Essentially things that aren't covered in 1 or 2.

## Course materials

From midterm feedback, Fall 2025:

- [ ] Add additional examples to course R scripts. Add more documentation, comments, and links to book or slides.
- [ ] Include additional R coding resources
- [ ] Link assignments explicitly to Pages/Chapters in the text book or to specific lectures/slides.

## Content gaps

- [ ] Add in more content about model interpretation
- [ ] Add in more content about visualizing model predictions for complicated models

## Logistics

- [ ] Split submission in Canvas for multi-part assignments. E.g., one for code and one for a Word document.

## Infrastructure

- [ ] **Convert the slides to Markdown, so the decks are fully reproducible.**
  Quarto's `revealjs` format is the obvious target: plain-text source, code
  chunks that actually execute, HTML for teaching and PDF for the repo from one
  file. It also dogfoods what the course teaches — hard to argue for
  reproducibility in Lecture 27 while the lectures themselves are binary blobs
  edited in a browser.

  What it would fix:

  - **Slides can't drift from the scripts.** Code on the slides would run at
    render time. The `%>%` → `|>` change in Fall 2026 had to be made twice, by
    hand, in two places, and the decks were missed for weeks.
  - **No more stale exports.** Right now the `.pptx`/`.pdf` in `lectures/` are
    downloads that go out of date silently. A `.qmd` renders to both.
  - **Figures get generated, not pasted.** The Holling curve, distribution plots,
    and so on would come from code, which also sidesteps reusing copyrighted
    figures.
  - **Real diffs.** Slide changes would show up in `git log` as readable text
    instead of a changed binary.

  What it would cost:

  - The visual polish of Google Slides — layouts, icons, image placement. Reveal
    themes can get close, but not for free.
  - No more editing from any browser, and no collaborative editing.
  - A one-time conversion of 26 decks. Speaker notes do survive (Quarto revealjs
    supports them), so that work isn't lost.
  - Quarto isn't in `renv.lock` yet.

  Sensible first step: pilot one code-heavy deck rather than converting
  everything. Lecture 07 (tidyverse) or 08 (ggplot) would benefit most, since
  they're almost entirely code and would gain the most from executable chunks. If
  the pilot feels good, the rest can follow a deck at a time.

  This also serves the "add more examples, link slides to scripts" item above —
  with Quarto, a deck and its example script could share source rather than being
  maintained in parallel.

---

## Noticed while teaching, Fall 2026

**Lecture 2 timing was right.** The expanded deck — roughly double the Fall 2025
version, adding the Sandin & Pacala opener, Table 1.1 in three groups, the
Holling curve activity, and the variability block — filled the session without
running over or short. No need to trim or pad it next time.

**Lecture 3 timing was right too, and the restructure worked.** Fall 2025 ran
about 25 minutes of lecture and then sent students to work through §1.7 on their
own, which wasn't very useful. Fall 2026 replaced that with alternating blocks —
three frameworks, code, the modelling process, code, wrap — and filled the
session. Keep the alternating structure; it is what the later lectures already
do well.

Two things that made it work and are worth preserving:

- The frogs/tadpoles session doubles as a walk through Figure 1.5. Students build
  a deterministic and a stochastic part by hand, then fit and test them.
- The confidence-interval demo. With `set.seed(101)` the 95% interval for the
  slope is (1.69, 1.98) and misses the true value of 2. Simulating 1000 datasets
  shows 95% coverage, so the miss is the lesson rather than a mistake.

- [ ] **The slides need more visuals — they're text-heavy and a bit dull.**
  Noticed across the rebuilt Lectures 2 and 3, where most of the new material is
  prose and code with very few figures.

  Generate figures in R rather than reusing the book's. It sidesteps the
  copyright question on a public repo, and the code becomes teaching material in
  its own right. Candidates that are cheap to make:

  - **Likelihood curve** for the seed predation data — `dbinom(51, 941, p)`
    across a range of `p`, with the maximum marked at 0.054. Would make the
    likelihood slide concrete instead of abstract.
  - **Posterior density** for the same data, for the Bayesian slide.
  - **Frogs vs tadpoles**, clean and noisy side by side. The script already draws
    these; they just aren't on the slides.
  - **Histogram of slope estimates**, clean vs noisy, with the true value marked.
    Already in `Chapter_1_examples.R`.
  - **Coverage** — a sample of confidence intervals as horizontal lines, with the
    ones that miss the true value picked out in a different colour.

  Worth noting that the Markdown/Quarto conversion below makes this much cheaper:
  figures would be generated at render time from the code already in the chapter
  scripts, rather than pasted in as images that then go stale.

- [ ] **Lecture 2's GitHub authentication slides are out of date.** Found this
  while teaching the lecture: in current versions of RStudio, clicking "push"
  handles authentication for you — it opens a browser sign-in rather than failing
  and demanding a Personal Access Token. The three slides covering this
  ("Cloning worked. Pushing won't", "Get a token", "Store your token") describe a
  workflow students no longer have to do by hand.

  Two things to weigh before cutting them outright:

  - Did it work for everyone, or just most of the room? RStudio bundles Git
    Credential Manager on Windows and Mac; Linux users may still need the manual
    flow.
  - It's still worth students knowing a token exists and that it should never go
    in a script — that point could survive on a single slide even if the
    step-by-step goes.

---

## Related work already in progress

Not a substitute for the items above, but worth knowing about when picking them up:

- **Data wrangling moved earlier (Fall 2026).** Tidyverse and ggplot2 moved from lectures 23/25 to lectures 07/08, so students get `filter`/`group_by`/`summarise` in week 4 rather than November. This was prompted by students struggling to rearrange data, and it partly overlaps with the "Intro to R" strand in the course-splitting idea above. See `syllabus/syllabus.md`.
- **Slide updates pending.** A checklist of deck-level changes for Fall 2026 is kept locally in `lectures/README.md` (not published). Some of it touches the "link assignments to chapters/slides" item.
- **Bolker chapter 3 materials.** Lectures 09 and 10 have no deck and there is no `Chapter_3_examples.R`; those slots were previously self-study. Building them is a chance to act on the "additional examples and documentation" item.

# Change log

Substantial changes to the course materials, newest first. Small fixes (typos,
re-renders, single slides) are left to the git history. Open items and plans for
the next offering are in `course_notes.md`.

## Fall 2026

### November 2026

- **2026-11-22.** Lecture 29 (open science) rebuilt in Quarto, the last of the
  Google Slides decks: every lecture now renders from a `.qmd`. Its click-through
  builds became fragment stacks, its undocumented photos were replaced with
  Wikimedia Commons ones, and it gained four short activities. The old
  `.pptx`/`.pdf` exports were removed from `lectures/`, along with a stray knitr
  `lectures/figure/` folder (now gitignored). The local `*_draft_additions.md`
  working notes were checked against the decks and deleted; the unused pieces
  moved into `course_notes.md`.
- **2026-11-21.** Lectures 06, 07, 08, 11 and 28 rebuilt in Quarto. Lecture 27,
  already Quarto, restyled to the current format and given a slide comparing AI
  coding tools (interfaces, whether they run code, cost to students, checked on
  the vendors' pages). Lectures 27 to 29 each open with a course evaluation
  reminder. Lecture 28 gained five activities and a Quarto comparison.
- **2026-11-21.** "Check:" answers now appear on click in every deck (97 of them),
  so students run the code and commit to an answer before seeing it.
- **2026-11-18 to 11-20.** Lectures 01 to 05 rebuilt in Quarto, in the
  later-deck format (no bullet lists, "story so far", "which tool, when", timed
  speaker notes), with US spelling and no em-dashes. Fixes made on the way:
  Lecture 2's Holling type II labels (both forms now shown), a "write code in a
  script" slide in Lectures 2 and 4, Lecture 2's GitHub sign-in slides updated
  for browser sign-in, and Lecture 3's figures drawn at render time.
- **2026-11-18.** Final project instructions moved to Markdown
  (`final/Final_Project.md`, rendered to `.docx` and `.html`).
- **2026-11-12.** Lecture 24 (GLMs): `glm()` shown to maximize a likelihood,
  checked against `mle2()`; prediction bands from `se.fit = TRUE` on the link
  scale, and the silent `interval =` trap.
- **2026-11-09.** Lecture 23 (linear models): `lm()` shown to maximize a
  likelihood; `predict()` intervals checked against Lecture 21's simulation
  recipe; the `geom_smooth()` ribbon identified as a confidence band.

### October 2026

- **2026-10-23.** Midterm files renamed by year (`Midterm_2025`, `Midterm_2026`,
  data files included) after students found `a`/`b` confusing.
- **2026-10-22.** Lecture 18 trimmed from 46 to 41 slides; recaps calibrated
  lighter (three-line "story so far", plain-words boxes on central ideas only).
- **2026-10-20.** After the mid-semester check-in, statistics lectures (from
  Lecture 18 on) gained a "story so far" slide, "In plain words" boxes and a
  closing "which tool, when" table.
- **2026-10-17.** Automated checks (`R_scripts/ci_checks.R`, run by GitHub
  Actions): stray control characters, and every "Type and run" block replayed in
  slide order in a fresh session. `renv` lockfile updated.
- **2026-10-16.** Optional supplements started (`supplements/`): self-contained
  decks for students who want to go beyond the course.
- **2026-10-13.** Redacted "Your turn" exercises (structure and data given, the
  key lines replaced by a prompt) adopted as the standard, after Lecture 15.
  Solutions decks added, posted after class.
- **2026-10-06.** Lectures 12 and 13 gained "Get set up" slides after Lecture 13's
  type-along code failed in class (its data were never loaded);
  `R_scripts/check_deck_student_code.R` added to catch this. Midterm converted
  to Markdown with `midterm/render_midterm.R`.

### September 2026

- **2026-09-22.** Lecture 09 built in Quarto, the pilot for converting the
  slides, along with `R_scripts/Chapter_3_examples.R` (chapter 3 previously had
  no lecture or script).
- **2026-09-10.** Lecture 06 rebuilt around Assignment 1 and guided work on
  students' own data. Assignments converted to Markdown.
- **2026-09-07.** Lecture 05 rebuilt: cloning the course repository, the data
  go-around, and exploratory graphics on AVONET.
- **2026-09-01.** Quizzes converted to Markdown, rendered to `.docx`.

### August 2026

- **2026-08-24.** Lectures renumbered so data wrangling (tidyverse) and ggplot2
  come at Lectures 7 and 8 rather than 23 and 25; `%>%` replaced by `|>`;
  syllabus moved to Markdown with USF branding; links repointed from the old
  `Statistical_ecology_course` repository.

## Fall 2025

First offering, in the predecessor repository `bmaitner/Statistical_ecology_course`
(archived as Zenodo DOI 10.5281/zenodo.17923198). Notes from it were migrated
into `course_notes.md`.

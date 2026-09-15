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

### Move the assignment and the data search earlier, and add at-home problems

Proposed after teaching Lecture 6 in Fall 2026. The problem it solves: students
arrive at the in-class exercises without enough independent R practice, so the
exercises run slowly, so the work block gets squeezed, so they get even less
practice. Adding more in-class time does not break that loop because there is no
more time to add.

The proposal is to shift practice out of class:

1. **Introduce Assignment 1 earlier**, at Lecture 4 rather than Lecture 6.
   Lecture 4's reading row already says "think about data of interest", so the
   nudge exists; this makes it a real deadline instead of a suggestion.
2. **Move the data go-around earlier too**, to Lecture 4. In Fall 2026 it was in
   Lecture 5, which left one class day to find datasets for the students who
   needed help. Lecture 4 gives a full week.
3. **Add a short problem set after each lecture from 4 onward**, worked on the
   student's own dataset rather than on AVONET.

The third is the substantive change. The natural content already exists: it is
the "Your turn" prompts from the Lecture 5 and 6 decks, moved out of class.
Roughly:

- After Lecture 4: read your dataset in, report its class, list the variables and
  their classes, find and fix one formatting problem.
- After Lecture 5: a histogram raw and logged, a scatterplot, a boxplot, a
  barplot, all on your own data.
- After Lecture 6: a correlation matrix, a pairs plot, two groups side by side
  with fixed axes, labeled and saved.

Worth noticing what that list is: it is Assignment 1, broken into three weekly
pieces. That may be the better structure outright. Smaller and more frequent
means problems surface while there is still time to fix them, students cannot
leave the whole thing to the last night, and the in-class time turns into
troubleshooting what they already attempted rather than first attempts.

The cost is more grading events, though not more work per event, and Canvas
setup for three submissions instead of one. If that is too much, the problem sets
could be participation-graded or self-checked, with Assignment 1 unchanged as the
graded deliverable.

Two things to keep if this happens:

- **The go-around still has to produce Brian's dataset-hunting list.** Whatever
  lecture it lands in, he needs lead time before the assignment to find data for
  students who do not have any.
- **Keep some guided work in class.** Lecture 6's four work pauses were the part
  that worked; the point is to have students arrive already having tried, not to
  remove the trying from the room.

Related: this overlaps with "Add additional examples to course R scripts" below,
and with the "Intro to R" strand of the course-splitting idea above.

## Course materials

From midterm feedback, Fall 2025:

- [ ] Add additional examples to course R scripts. Add more documentation, comments, and links to book or slides.
- [ ] Include additional R coding resources
- [ ] Link assignments explicitly to Pages/Chapters in the text book or to specific lectures/slides.
- [ ] Strip the em-dashes out of the course materials. They are in the syllabus
  (7), `data/short_links.md` (3), the Lecture 3 to 5 slide decks, and this file.
  Deliberately left alone during Fall 2026 because the materials had already gone
  out to students; fix them before the next offering. Restructure the sentences
  rather than swapping in a hyphen.

- [ ] Switch the course materials to US spelling. The course is taught in the US,
  and some materials use British forms. Left alone during Fall 2026 for the same
  reason as the em-dashes: they had already gone out to students. Fix both in the
  same pass.

  Where they are, as of September 2026:

  - **Decks:** "modelling" in Lectures 02 (3, plus "modelled"), 03 (12), 18 (4),
    22, 23 and 26; "analyse" and "optimisation" in Lecture 03; "labelled" in
    Lecture 06. Counts are from the PDF exports in `lectures/`.
  - **Syllabus:** the Lecture 2 row, "Frameworks for modelling".
  - **Quiz and assignments:** `Quiz_01_Chapter1.md` question 3, and the opening
    paragraphs of `Assignment_3.md` and `Assignment_4.md`. Re-render after editing.
  - **Scripts:** the section header "lecture 18 modelling fir data" in
    `R_scripts/Chapter_6_examples.R`.
  - **File name:** `Lecture_02_modelling_frameworks`. Renaming it means updating
    the Drive deck title too, and any links to it.

  Do not change code. `summarise()` is a dplyr function and `colour =` is a valid
  ggplot argument, so every `summarise` in the scripts and decks, and the `colour`
  arguments in `Chapter_5_examples.R` and `Chapter_6_examples.R`, stay as they
  are. "Analyses" as a plural noun is standard US English and is not on this list.

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

  **Piloted in Lecture 9 (Fall 2026).** Lecture 9 turned out to be the right
  first candidate rather than 07 or 08: it was being built from scratch, so
  there was no conversion cost at all. `lectures/lecture_09_deterministic_functions.qmd`
  renders to a self-contained revealjs deck with Quarto 1.9.37, which is already
  installed. Speaker notes live in `::: {.notes}` blocks and open with the `s`
  key. Every figure and every printed result is computed at render time, so the
  separate `Lecture_09_figures.R` became optional.

  If the pilot holds up in class, the rest can follow a deck at a time, and
  Lectures 07 and 08 remain the best conversion candidates because they are
  almost entirely code.

  Two things to sort out before converting more:

  - **`quarto` and `revealjs` are not in `renv.lock`.** Quarto's revealjs does
    not need the R package, but the lockfile should record the dependency.
  - **Rendering needs `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE` on this machine**,
    because the project renv library is not restored, so Quarto finds an empty
    library and reports knitr and rmarkdown missing. Running `renv::restore()`
    once would fix it properly.

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
three frameworks, code, the modeling process, code, wrap — and filled the
session. Keep the alternating structure; it is what the later lectures already
do well.

Two things that made it work and are worth preserving:

- The frogs/tadpoles session doubles as a walk through Figure 1.5. Students build
  a deterministic and a stochastic part by hand, then fit and test them.
- The confidence-interval demo. With `set.seed(101)` the 95% interval for the
  slope is (1.69, 1.98) and misses the true value of 2. Simulating 1000 datasets
  shows 95% coverage, so the miss is the lesson rather than a mistake.

**Lecture 4 timing was good, but has less slack than 2 and 3.** The expanded deck
(plain text, metadata, long/wide, the readxl block, and the −999 demo) fit the
session. The margin is thinner though: it depends on debugging going quickly, and
a larger class or a slower room could push it over. If it needs trimming, the
long/wide pair is the most cuttable — it previews Lecture 25 rather than covering
assigned reading.

**Lecture 5 ran tight but held.** The rebuilt deck (the git block, the moved-up
data go-around, and the 14-slide exploratory graphics block) got through all of
its content, but left only 10 to 15 minutes for students to start on 2.6 rather
than the 25 that was planned. So the front of the lecture runs about 10 to 15
minutes longer than estimated.

Nothing to cut: the content was worth the time and the session did not overrun.
The thing to change is the expectation, not the deck. 2.6 is effectively a
Lecture 6 activity, so plan it that way rather than treating it as carry-over,
and drop the "(if needed)" from the Lecture 6 agenda.

If a future offering does need the room, the cut list in the Lecture 5 draft
still holds: the overplotting slide first, then the boxplot and barplot slides,
demonstrated live from the script instead.

**Lecture 6 ran tight, and the work time lost again.** The rebuilt deck (the four
assignment-support slides, the moved-up data-source block, and the ten-slide
guided block on students' own data) fit, but left only a few minutes for 2.6.
That is the second lecture running where the planned work block got squeezed to
almost nothing: Lecture 5 planned 25 minutes and got 10 to 15, Lecture 6 planned
10 and got less.

The pattern is now clear enough to act on. The front of every rebuilt deck runs
10 to 15 minutes longer than estimated, and the in-class work is always what
absorbs it, because it sits at the end. See "Move the assignment and the data
search earlier" under Course structure for the fix Brian proposed.

**Lecture 7 ran out of time at slide 27 of 34.** Class ended on "What went
wrong?", the NA-in-summarise slide. Brian showed the closing slide (the R4DS
chapter 1 reading and the Assignment 1 reminder) and told the class Lecture 8
would pick up at slide 28 before moving on to ggplot2. So Lecture 8 starts with
six carried-over slides: the three-slide ungroup block, the grouping Your turn,
and both slice-function slides. That makes three lectures in a row where the deck
outran the class.

Knock-on effects:

- Lecture 8 was already the longest deck of the semester (41 slides), and now has
  those six slides in front of it.
- Quiz 4 had a question on ungroup(). The quiz is given before the carried-over
  slides, so that question was dropped, which also shortens the quiz.

Options for next offering, not yet decided: cut or consolidate examples in the
filter block (seven slides), move the ungroup block and grouping exercise into
at-home practice (see the at-home problems proposal under Course structure), or
shorten the opening quiz.

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
    ones that miss the true value picked out in a different color.

  Worth noting that the Markdown/Quarto conversion below makes this much cheaper:
  figures would be generated at render time from the code already in the chapter
  scripts, rather than pasted in as images that then go stale.

- [ ] **Consider moving `data/Deer_movement/MD_dataset.RDS` out of the repo.**
  At 92 MB it is more than half the 167 MB clone. Students now clone the repo in
  Lecture 5, so every one of them pays for it, on classroom wifi, simultaneously.
  The dataset library is deliberate and worth keeping, but this one file could
  live behind a download link in its README like the Bolker seed data does.

- [ ] **Lecture 2 should make "write code in a script, not the console" explicit.**
  Lecture 2 is where students first open RStudio, and by week four some are still
  typing code straight into the console. The exported Lecture 2 deck never
  mentions the console, the source pane, or creating a new R script, so this is a
  gap rather than a point that was made and missed.

  It matters more than it looks, because nearly everything later depends on it:

  - Console code is gone when the session ends, so there is nothing to rerun,
    fix, or hand in. Assignment 1 grades reproducibility and documentation at
    20% each, and neither is possible without a script.
  - Every "Your turn" pause from Lecture 5 onward assumes students are building up
    a file they can edit and rerun. Typos cost far more class time when the fix
    means retyping a whole block in the console.
  - Comments, section headers (`Ctrl/Cmd + Shift + R`) and the outline pane, all
    introduced in Lecture 6, only exist in the editor.

  One or two slides would cover it: the four RStudio panes with the source pane
  labeled, File > New File > R Script, and running a line or selection with
  `Ctrl/Cmd + Enter`. Framing to use: the console is a scratchpad for quick
  checks like `str()` or `?mean`, and the script is the record of your work.
  Worth repeating briefly in Lecture 4, when they first load real data.

- [ ] **Lecture 2 mislabels the Holling type II parameters. Show both forms.**
  The deck writes f(x) = ax/(b + x) and says "Here, a and b are attack rate and
  handling time". In that form a is the asymptote and b is the half-saturation
  constant (Bolker ch. 3). Attack rate and handling time are the parameters of the
  other way of writing the same curve, the Holling type II functional response
  f(x) = alpha x / (1 + alpha h x). They match when a = 1/h and b = 1/(alpha h),
  so the maximum is set by handling time and the attack rate is the initial slope
  a/b.

  Fixed in `R_scripts/Chapter_1_examples.R` in Fall 2026; the deck was left as is
  because it had already been taught. Lecture 9 now shows both forms side by side
  ("One curve, two ways to write it") and reconciles them in the speaker notes.

  For next year, put both forms in Lecture 2 itself. It is the best available
  example of the mechanistic versus phenomenological distinction that Lecture 2
  introduces: the curve is identical, and only the reason for using it decides
  which parameters you write down.

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

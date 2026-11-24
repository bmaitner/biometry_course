# Course notes

What to change before the next offering, and what teaching the course in Fall
2026 showed. Finished work is recorded in `CHANGELOG.md`; the full history of
these notes is in git.

The list started as GitHub issues on the previous repository
(`bmaitner/Statistical_ecology_course`, Fall 2025):
[#1 Consider splitting into 2 or 3 courses?](https://github.com/bmaitner/Statistical_ecology_course/issues/1),
[#2 Midterm feedback 2025](https://github.com/bmaitner/Statistical_ecology_course/issues/2),
[#3 General notes](https://github.com/bmaitner/Statistical_ecology_course/issues/3).

---

# Before the next offering

## Course structure

### Consider splitting into 2 or 3 courses

1. **Intro to R:** using the command line, finding files, loading data, plotting
   data, data wrangling, etc.
2. **Stats in R:** essentially the *Ecological Models and Data in R* book.
3. **Advanced R:** building packages, using docker, etc. Things that aren't
   covered in 1 or 2.

The optional supplements (below) are a cheap test of demand for the third.

### Move the assignment and the data search earlier, and add at-home problems

Proposed after teaching Lecture 6 in Fall 2026. Students arrive at the in-class
exercises without enough independent R practice, so the exercises run slowly, so
the work block gets squeezed, so they get even less practice. More in-class time
can't break that loop because there is none to add.

1. **Introduce Assignment 1 at Lecture 4** rather than Lecture 6, making
   "think about data of interest" a real deadline.
2. **Move the data go-around to Lecture 4 too.** In Lecture 5 it left one class
   day to find data for students who needed help; Lecture 4 gives a week.
3. **A short problem set after each lecture from 4 on**, on the student's own
   dataset. The content exists already, as the "Your turn" prompts from Lectures
   5 and 6:
   - after Lecture 4: read the data in, report its class, list the variables and
     their classes, find and fix one formatting problem;
   - after Lecture 5: a histogram raw and logged, a scatterplot, a boxplot, a
     barplot;
   - after Lecture 6: a correlation matrix, a pairs plot, two groups side by side
     with fixed axes, labeled and saved.

That list is Assignment 1 in three weekly pieces, which may be the better
structure outright: problems surface while there's time to fix them, and class
time becomes troubleshooting rather than first attempts. The cost is more
grading events and Canvas setup; the problem sets could be participation-graded
or self-checked, with Assignment 1 unchanged.

Keep two things: the go-around still has to produce Brian's dataset-hunting
list with lead time, and some guided work stays in class (Lecture 6's work
pauses were the part that worked).

### Move the R supplement out of class

Brian's proposal after teaching Lecture 10. Working through the book's R
supplement (e.g., 3.6) in the room is the most substitutable part of the period:
students can follow it alone, and the room goes quiet while everyone works at a
different pace. Candidates for the recovered time, roughly in order of how well
they use having Brian in the room:

- the same shape-finding work on students' own datasets;
- the at-home problem sets above, done in class with help available;
- choosing between two defensible shapes, argued out loud;
- starting the next chapter, to relieve schedule pressure later.

First, students need to be able to get through the supplement alone: list the
sections on the syllabus reading rows rather than on the slides, and find some
way to tell who did it.

### Introduce Assignment 2 in Lecture 11

The work block at the end of Lecture 11 (load a focal dataset, run the day's
functions on it) is Part 2 of Assignment 2 under another name, so one slide turns
it from an exercise into progress. Drafted for Fall 2026 and not used (update the
dates); it goes just before "Remainder of class":

> **Assignment 2: Distributions**
>
> Out Thursday, due Thursday Oct 8
>
> Part 1: 12 kinds of data. For each, say whether it is discrete or continuous,
> then name a distribution and why. (Table 4.1 and section 4.5)
>
> Part 2: your own dataset, at least 3 numeric variables. Histogram, discrete or
> continuous, mean and median, and an argument for a distribution.
>
> The rest of today is the start of Part 2.

Say that Part 1 needs the next reading and Part 2 doesn't, and show the shape of
a two-step answer (discrete or continuous first, then the distribution).

### Lecture 7 is too long

It ran out of time at slide 27 of 34 in Fall 2026, pushing six slides into
Lecture 8. Options, not yet decided: consolidate the filter block (seven
slides), move the ungroup block and grouping exercise to at-home practice (see
above), or shorten the opening quiz. The deck's agenda notes name the "& and |"
pair as the first cut.

### Optional supplements

Proposed 2026-10-16; plan and build order in `supplements/README.md`.
Self-contained decks for students who want more, that work with nobody in the
room, and double as first drafts of a possible "Biometry II". At the
mid-semester check-in students wanted all of them; ranked interest: geospatial,
writing an R package, getting messy data into shape, reproducible pipelines.
New requests: phylogenetics and genetics. Other candidates: visualization beyond
the basics (palettes, `ggridges`, `ggbump`, `patchwork`, `gt`), visualizing model
predictions, competition and other dynamic models, finding data and pulling it
with APIs.

## Course materials

- [ ] **Remaining em-dashes:** `syllabus/syllabus.md` (7) and
  `data/short_links.md` (3). Restructure the sentences rather than swapping in a
  hyphen. The decks are clean.
- [ ] **Remaining British spelling:** Lectures 14, 25 and 26; the syllabus (the
  Lecture 2 row, "Frameworks for modelling"); `Quiz_L03_2026_Chapter1.md`
  question 3; the section header "lecture 18 modelling fir data" in
  `R_scripts/Chapter_6_examples.R`. Re-render after editing. Don't change code:
  `summarise()` and `colour =` are valid function and argument names. The file
  name `Lecture_02_modelling_frameworks` is unchanged on purpose (renaming it
  breaks links).
- [ ] **Swap Bolker's own data and examples in the slides.** Students meet them
  in the reading, so reusing them in class repeats rather than reinforces (Brian,
  2026-11-18). Known spots: Lecture 2's Sandin and Pacala (2005) opener; Lecture
  3's Duncan and Duncan (2000) seed predation data in "One dataset, three
  answers", "Likelihood and Bayes, drawn" and "Same data, same conclusion"
  (compute the new numbers at render time); Lecture 4's long and wide tables.
  Keep his frameworks and figures (Table 1.1, the Figure 1.5 flowchart). Check
  later decks as they're revised.
- [ ] **Say why, not just what.** After Lecture 9 the reasons were thinner than
  the mechanics. Lines to add, in Lecture 9 and the chapter 3 material: why name
  a curve at all (parameters let you compare how fast, how big, where the peak
  is); why separate phenomenological and mechanistic forms (the form decides the
  questions you can ask); why a failing curve is useful (how it fails says what
  to try next); why sum of squares (it makes "better fit" a number). Bolker 3.1
  makes most of these. Reasons that live only in speaker notes get said only if
  remembered.
- [ ] **More visuals in Lecture 2**, which is still mostly text and screenshots.
  Generate figures in R rather than reusing the book's.
- [ ] **Add the `ungroup()` examples** from the Lecture 7 deck ("Still grouped",
  "group_by() is sticky", "The quiet version") to `R_scripts/Lecture_07_examples.R`.
- [ ] **More examples in the course R scripts**, with comments and links to the
  book or slides (Fall 2025 midterm feedback).
- [ ] **Additional R coding resources** (Fall 2025 midterm feedback).
- [ ] **Link assignments explicitly** to book chapters and to specific lectures
  (Fall 2025 midterm feedback). Lecture 6's "You already have the tools" slide
  does this for Assignment 1.

## Content gaps

- [ ] **Model interpretation.**
- [ ] **Visualizing predictions from more complicated models.** Lectures 21 to 24
  cover one continuous predictor plus a factor (mle2 fits via Lecture 21's
  simulation recipe; `lm()` with `predict(interval = )`; `glm()` with
  `se.fit = TRUE` on the link scale). Still missing: interactions, and more than
  two predictors.

## Logistics

- [ ] **Split Canvas submissions** for multi-part assignments, e.g. one for code
  and one for a Word document.

## Infrastructure

- [ ] **Cut a release and mint a Zenodo DOI for this repository at the end of
  the semester.** The DOI badge in `README.md` (10.5281/zenodo.17923198) archives
  the predecessor repository's v1.2025 release, not this one; `biometry_course`
  has no releases yet. Enable the Zenodo GitHub integration **first**, then
  publish the tag: Zenodo only archives releases made after it starts watching.
  Relabeling the badge in the meantime was considered and declined (2026-10-19).
- [ ] **Decide whether the course site replaces or supplements the Canvas
  links**, at the start of the next offering rather than mid-semester. The site
  (<https://bmaitner.github.io/biometry_course/>) went up 2026-11-24; see
  `CHANGELOG.md`. Its syllabus, assignments and data links still point at
  GitHub; the syllabus could become a page on the site.
- [ ] **Set the repository homepage** once the site exists.
- [ ] **Record Quarto in `renv.lock`**, and run `renv::restore()` once on the
  teaching machine. Until then, rendering needs
  `RENV_CONFIG_AUTOLOADER_ENABLED=FALSE`, because the project library is empty.
- [ ] **Consider moving `data/Deer_movement/MD_dataset.RDS` out of the
  repository.** At 92 MB it is more than half the clone, and every student clones
  it in Lecture 5, on classroom wifi, at the same time. It could live behind a
  download link in its README.

## Conventions to keep

- **Midterms are named by year** (`Midterm_2025`, `Midterm_2026`, data files
  included). Add `Midterm_2027` next year rather than editing this year's.
  `midterm/README.md` lists what belongs to which year.
- **Run `Rscript R_scripts/ci_checks.R` before teaching from a changed deck.** It
  replays every "Type and run" block in slide order in a fresh session, the
  failure that broke Lecture 13 in class.

---

# Teaching notes, Fall 2026

## What worked, and should carry forward

- **Redacted exercises (Lecture 15).** Give the structure, the data and the
  comments, and replace the substantive lines with a prompt ("your negative
  log-likelihood goes here; hint: you wrote one a few slides ago"), rather than
  `____` gaps. Retrieval made it feel like solving, and students were visibly
  excited when it worked. Pair each one with a checkable answer (the decline came
  out at 2.9% against the 3% assumed in Lecture 14).
- **Scaffolded code (Lecture 9).** A worked example next to a skeleton with the
  body removed, so nobody spends the pause stuck on syntax they already know.
- **Labeled type-along code.** The "Type and run" badge, added after a Lecture 9
  slide asked students to use a function they'd never been told to type.
- **Worked examples on real data are the fix for a short deck.** Lectures 10, 11
  and 12 finished 30, 40 and 50 minutes early; adding ten slides of worked
  examples on course data (Lecture 12) fixed it, and Lecture 13 then filled the
  period. Add practice before adding explanation.
- **Open-ended exercises can stay unfinished.** Lecture 14's reef exercise was
  hard and students didn't finish it; the struggle was productive. A solutions
  deck posted after class removes the "did I get it right" anxiety without
  removing the struggle.
- **Alternating blocks (Lecture 3).** Lecture and code in turns filled the
  session; a lecture followed by self-study (Fall 2025) didn't.
- **Demonstrations that fail on purpose.** Lecture 3's 95% interval that misses
  the true slope (with 95% coverage over 1000 simulations), and Lecture 11's
  `var(x) == sd(x)^2` coming back FALSE on the Macs before the floating-point
  slide explains it (demo with `0.1 + 0.2`, which fails on every machine).

## Mid-semester check-in (Lecture 17, 2026-10-20)

Asked out loud rather than on cards. The coding was going well; the statistics
needed simplifying, with recaps throughout. That produced the "story so far",
"In plain words" and "which tool, when" slides, then calibrated after Lecture 18
ran long: three-line recaps, plain-words boxes only on central ideas, quizzes of
about four quick questions.

## Timing, lecture by lecture

| Lecture | Fall 2026 |
|---|---|
| 2 | Right. The expanded deck filled the session. |
| 3 | Right, with the alternating structure. |
| 4 | Fit, with less slack than 2 and 3. If it needs trimming, cut the long/wide pair (it previews Lecture 26). |
| 5 | Tight: the front ran 10 to 15 minutes long, leaving 10 to 15 for 2.6 instead of 25. Treat 2.6 as a Lecture 6 activity. Cut list in the deck's agenda notes. |
| 6 | Tight; the work time lost again. |
| 7 | Ran out at slide 27 of 34 (see "Lecture 7 is too long"). |
| 8 | Worked, even with six slides carried over. Its candidate cuts (categorical by categorical, the `geom_line()` pair, "Soooo many more options") stayed in. |
| 9 | The first deck to fit comfortably. |
| 10 | About 30 minutes early, not counting the R supplement. A 32-slide deck with four work pauses runs about an hour. |
| 11 | About 40 minutes early, before the frog practice block was added. |
| 12 | About 50 minutes early; fixed with worked examples. |
| 13 | Full period, once its setup slide was in. |
| 18 | A bit long at 46 slides plus a quiz, an assignment introduction and a package install; trimmed to 41 afterwards. |
| 23 | About 20 minutes early. |

Across Lectures 5 to 7 the front of each rebuilt deck ran 10 to 15 minutes over
estimate, and the in-class work at the end absorbed it every time.

## Still to record

- **Lecture 24's backup activity** ("Your call: which model?", two optional
  slides after "Which tool, when"): whether it was used and how it went. If it
  worked, make it a standing slide.

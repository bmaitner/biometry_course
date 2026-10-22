# Supplements: optional material beyond the course

Plan written 2026-10-16. Two supplements are built, **01 Figures worth showing**
and **02 Structural equation models**; everything else here is still a proposal.

Supplements are numbered **in the order they get built**, not in the order this
file plans them, so a number is never reassigned once it is on a deck. That is
why the second one built is 02 even though it sits below the ranked queue.

## Who these are for

Three audiences, which is what makes the design different from a lecture deck:

1. **Students in the course now** who want more than the schedule allows.
2. **Students after the course has ended**, who come back for a technique when
   their own work needs it.
3. **A future "Biometry II" or "Advanced Biometry"**, for which these are the
   first drafts of lectures.

The third audience is the reason these are **slide decks**, in the same revealjs
template as the rest of the course, not a different format. They should be able
to walk straight into a schedule if that course ever runs.

## The rule that makes a supplement different from a lecture

**They have to work without you in the room.**

A lecture deck is half the lecture. The other half is you filling gaps, reading
the room, and saying the thing that is in the speaker notes. The Fall 2026 decks
lean on that heavily and should: the notes in Lecture 16 carry the arithmetic of
the odds interpretation, the reason bounds are not enough, and what to do when a
student swaps two arguments.

A supplement gets none of that. Someone is reading it alone, possibly a year
after the course. So:

- **Reasoning goes where the reader will see it.** Anything that would have been
  "say this out loud" becomes visible text.
- **Speaker notes get written for a student, not for you.** See the next section
  for why this works better than it sounds.
- **No "as we did on Tuesday."** Cite the lecture by number and name, because the
  reader may be eighteen months out and may never have taken the course.
- **Every object a code block uses is created by an earlier code block**, with no
  exceptions. The existing rule matters more here, because nobody can rescue them
  when it breaks.

## Render twice, from one source

Quarto will produce both a deck and a scrolling reading version from the same
`.qmd`, which serves the "reading it alone at 11pm" case without any extra
authoring:

```yaml
format:
  revealjs:
    output-file: NN_topic-slides.html
  html:
    output-file: NN_topic.html
    toc: true
```

**Render each format in its own pass**, or `embed-resources` silently fails for
the deck and you get a file that only works next to its `_files` directory:

```bash
quarto render NN_topic.qmd --to revealjs   # 3.4 MB, self-contained
quarto render NN_topic.qmd --to html       # 1.2 MB, self-contained
```

Tested 2026-10-16. Rendering both in one pass produced a 98 KB deck with
external references to `_files/libs/`, and warnings that are easy to miss.

Useful side effect: **`::: {.notes}` content becomes visible prose in the reading
version.** So notes written for a student are not wasted, they become the
explanation in the long-form version while staying hidden on the slides. That is
the mechanism that makes "write the notes for the reader" pay off twice.

## The topics, on two axes

They are not one list. Some are useful to a student this semester; others have
enough depth to anchor weeks of a future course. A few are both.

| Topic | Students' rank (Oct 20) | Useful this semester | Spine of a Biometry II |
|---|---|---|---|
| Figures worth showing: palettes, `ggridges`, `ggbump`, `patchwork`, model predictions | built | **High** | Medium |
| Geospatial: `sf`, rasters, making a decent map | **1** | Low | **High** |
| Package development: `devtools`, docs, tests | **2** | Low | **High** |
| Getting messy data into shape | **3** | **High** | Medium |
| Reproducible pipelines | **4** | Low | Medium |
| Where distributions come from: simulating the generating process | wanted, unranked | **High** | Medium |
| Finding data, and pulling it with APIs | wanted, unranked | Medium, mistimed this year | Medium |
| Competition and other dynamic models | wanted, unranked | Low | **High** |
| **Phylogenetics** (new request) | requested | Medium | **High** |
| **Genetics** (new request) | requested | Medium | **High** |
| **Structural equation models**: path analysis, piecewise SEM | built, not requested | Medium | **High** |

"Wanted, unranked" means the students said they wanted all of the topics, and
these were not among the four they put first. "Not requested" means nobody asked
for it; it is on the list because the material argues for it.

Read the right-hand column as a draft syllabus. Geospatial, dynamic models and
package development are each worth several weeks, and the last of those is
exactly the "Advanced R" strand of the course-splitting idea in
`course_notes.md`. That is the real argument for building these: the time is not
spent on a side project, it is spent drafting a course you have already
considered teaching.

## Build order

**First, for Fall 2026: "Figures worth showing."** Built 2026-10-16, 47 slides.
Palettes, installing packages from GitHub, ridgelines, patchwork, bump charts,
and plotting model predictions with an uncertainty band.

- It closes an open item under "Content gaps" in `course_notes.md`
- Final project presentations are seven weeks out and are graded partly on
  communication
- It is the cheapest to write and the hardest to get wrong
- There is demonstrated appetite, which is where the palette question came from

**Second: "Where distributions come from."** Specified 2026-10-19, not built.
Agent-based simulations of the processes that generate each distribution, run in
the browser through NetLogo Web with no install, each paired with the same
process in six lines of R. Fills a gap in Lecture 12, which teaches which
distribution to use but never the mechanism that produces it. Specs and the
verified embedding mechanics are in `models/README.md`.

**Third: "Getting messy data into shape."** Newly obvious: the Lecture 16 setup
took ten lines of `tapply()` and a `data.frame()` build, and that was with clean
data and a worked example on the screen. On their own data, with no example, this
is the step that stalls people.

**Then, in the order the students asked for them (2026-10-20):** geospatial,
package development, reproducible pipelines, then the rest, with phylogenetics
and genetics added to the list. "Getting messy data into shape" was their third
choice, so it keeps its place above. "Where distributions come from" was not in
their top four; Model 3 is built, and whether to finish the module before
starting geospatial is a judgment call: it serves this semester's material,
geospatial serves what they asked for.

**Below the ranked queue, and built anyway: "Structural equation models."**
Proposed and built 2026-10-22, as `02_structural_equation_models.qmd`: 46
content slides in nine parts, 23 type-and-run blocks. Nobody asked for it, so it
sits under the four the students ranked, but it is the only candidate that extends the course's own spine instead
of opening a new domain. The course builds deterministic function (Lectures 9 and
10), stochastic distribution (11 and 12), likelihood (15 to 17), model comparison
(18), fitting (19 to 22), then GLMs (23 and 24). An SEM is that same machinery
with more than one response variable, and a piecewise SEM is a set of GLMs plus a
test of the independence claims the diagram implies, so by Lecture 24 students
have everything it needs. It also answers the question ecology students actually
arrive with: does rainfall affect biomass directly, or through soil moisture?
Multiple regression cannot separate those, and the course hands them nothing that
can.

Two design decisions, both carried into the built deck:

- **Piecewise only.** `piecewiseSEM`, component models, d-separation and
  Fisher's C stay inside the likelihood and AIC framework the course already
  teaches. Covariance-based SEM (`lavaan`, latent variables, chi-square, CFI,
  RMSEA) is a different statistical culture, and teaching both in one module
  would run against the Lecture 17 request to simplify the statistics. Latent
  variables get one "where this goes next" slide and nothing more. They are also
  where the partial and global distinction actually bites, and they need sample
  sizes and measurement-model thinking that the datasets in this class rarely
  support.
- **Real time on what the arrows are not.** This is the most misusable tool on
  the list, because it invites causal language from observational data and can
  easily produce someone who draws arrows and then believes them. Equivalent
  diagrams fit identically, unmeasured confounders are invisible, and good fit
  does not validate the structure. The supplement form helps, since that
  reasoning has to be visible text rather than something said out loud.

The deck follows the sketch: the question multiple regression cannot answer; the
diagram as a model, and what a **missing** arrow claims, which is the stronger
claim and the testable one; path analysis by hand with two `lm()` calls, with the
indirect effect as a product of path coefficients; standardized against
unstandardized coefficients; the basis set and the d-sep table; an exercise in
the Lecture 15 style; Shipley's AIC across competing diagrams, which lands back
on Lecture 18; what it does not tell you; where it goes next, not taught.

**One thing the build changed: it does the whole method by hand.** The plan
assumed `piecewiseSEM`. As of October 2026 the CRAN version declares
**R (>= 4.5.0)**, and this course is on 4.4.1, so `install.packages()` reports
it as unavailable. The archived versions are reachable but want their
dependencies built from source, `performance` included, which is a long compile
for a convenience function. So the deck
builds the basis set, runs the claims and computes Fisher's C in about forty
lines of base R and `MASS`, and shows `psem()` once, in a block flagged as not
runnable here, as the shortcut to use when your R is new enough.

That is now the better version regardless of the R constraint. Doing it by hand
is the same "by hand, then with the function" move Lecture 18 makes with
`anova()`, the basis set stops being a black box, and a supplement nobody is
supervising cannot open with an install that fails. It is also the only piece of
the course with no CRAN dependency beyond `MASS`, which is worth something for a
deck meant to still work in a few years.

**The numbers it lands on**, all verified against the data on 2026-10-22: the
path decomposition sums to the simple regression coefficient exactly (0.26389),
which gives the exercise the recognizable right answer the Lecture 15 note asks
for; richness is overdispersed at 9.49 and the negative binomial takes it to
1.17; the hypothesized diagram survives at Fisher's C = 9.50, df = 6, p = 0.147;
and both the strict mediation diagram and the temperature chain are rejected.
The AIC comparison between the two surviving diagrams comes out 1.27 apart,
inside Lecture 18's own "within 2 is a tie", so the deck reports a tie rather
than a winner.

**The dataset question is settled: `Deep_sea_megabenthos`.** Checked 2026-10-22
against the three candidates in `data/`, which came out clearly separated.

`Mangroves` is out. `Cannicci_et_al_Final_dataset_4.0.csv` is 587 rows of species
by site with binary functional traits (burrowing, leaf storing, woodboring, and
so on) and no continuous environmental variable anywhere in it, so there is no
mediator to measure.

`Deep_sea_megabenthos` is the one. `TOSCA_ROV.csv` is already one row per
subtransect, 749 of them, so no aggregation stands between the student and the
model, and it carries depth, temperature, salinity, slope and substrate as
predictors with richness, Shannon and evenness as responses. It yields two chains,
and the pair is what makes it worth using:

- **A chain that holds:** slope to hard substrate to richness. Steeper ground
  exposes bedrock and boulders rather than sand, and hard substrate is where
  sessile animals can attach. The substrate link is a binomial GLM (slope
  p = 5e-11), and hard-substrate subtransects average 22.5 morphospecies against
  12.4 on soft (on the 739 rows with every variable present, which is what the
  deck uses). Slope keeps a direct path as well, so this is partial mediation
  and the student needs both arrows, which is the point.
- **A chain the data reject:** depth to temperature to richness. Depth predicts
  temperature about as hard as anything in ecology does (r = -0.64), and then the
  temperature path to richness dies once depth is in the model (p = 0.23). That
  is exactly what a d-separation test is for, and a rejected chain sitting next
  to a surviving one teaches better than either alone.

Three things to write into the module rather than discover in the room. Richness
is overdispersed, with residual deviance over df of 9.5, so the component model
is negative binomial rather than Poisson, which puts the Lecture 12 bestiary to
live use. The 749 subtransects come from only five dives, so the
pseudoreplication has to be named even though five levels is too few for a
comfortable random effect. And Shannon and richness correlate at 0.83 because one
is computed from the other, so a chain through both is tautological and belongs
in the "what the arrows are not" section as a worked trap.

`Coral` is the backup, at a price. Its best chain is depth to rugosity to coral
richness, and it is nearly complete mediation: rugosity to richness p = 8e-18,
with the direct depth path down to p = 0.054. Richness is a count there too, so
the component model is a GLM and it ties to Lecture 24 directly. The three costs
are that `WTD_RUG` is missing at 669 of the 1281 stations, so half the data
leaves; that reaching station level means aggregating 13,601 rows of long-format
cover records, which is the `tapply()` problem the messy-data supplement exists
to solve and not something to do twice; and that the ecology arguably runs
backwards, since reef rugosity is largely built by the coral, which is a
liability in a first example even though it is the lesson later. If it is used at
all, pre-aggregate it into `data/class_examples/` the way `reef_surveys.csv` was
done, and make it the exercise rather than the worked example.

It is scored Medium for this semester rather than Low only because of the final
project: a student with a multi-variable observational dataset could use it
there, and that is the one place in the course where they would be allowed to. In
a Biometry II it is two or three weeks rather than one: path analysis, piecewise
SEM, then latent variables and the covariance-based tradition.

## Anatomy of a supplement

Three pieces, so that "tutorial examples and tools" means something runnable:

1. `supplements/NN_topic.qmd`, rendered both ways, using the same **Type and
   run** convention the decks use.
2. A script in `R_scripts/`, the same code without the prose, ready to be copied
   and bent to their own data.
3. Any data it needs, from `data/class_examples/`, so a supplement never depends
   on a download being fast or a service being up. This matters more here, since
   someone may open it years from now.

A supplement may depend on packages the course does not otherwise use, including
ones from GitHub. That is a feature rather than a cost: supplement 01 installs
`glyospalettes` and `transformerpalettes` with `remotes::install_github()`, which
teaches a skill students need and the lectures never have room for. Note the
dependency on the title slide, and remember that the deck then needs those
packages to render.

Each ends with the same three things: **what this buys you**, in one sentence;
**where it fits**, pointing at the lecture or the project stage it serves; and
**going further**, a short reading list. Supplements 01 and 02 already do this.

Rules for the reading list, since a reader alone cannot ask which source to trust:

- **Five or six items, not twenty.** Lead with the single best place to start,
  and say why it is first.
- **Free and online first.** Most of the best R material is a free book. A
  student a year out of the course may no longer have library access.
- **One line each on what it is for**, not only the title.
- **Every DOI checked against Crossref and every URL opened before it goes in.**
  A plausible-looking DOI that resolves to the wrong paper has already happened
  once in this folder.

## Suggested reading for the planned topics

Drafted 2026-10-22, so a reading list exists before the deck does. Each DOI was
checked against Crossref and each URL returned a page on that date. Students can
use these now, and the lists become each supplement's "Going further" slide.

**Geospatial**

- *Geocomputation with R*, Lovelace, Nowosad and Muenchow. Free, and the place to
  start: <https://r.geocompx.org>
- *Spatial Data Science*, Pebesma and Bivand. The deeper treatment, by the
  authors of `sf`: <https://r-spatial.org/book/>
- Pebesma (2018), the `sf` paper: <https://doi.org/10.32614/RJ-2018-009>

**Writing an R package**

- *R Packages* (2nd edition), Wickham and Bryan. Free, and the standard
  reference: <https://r-pkgs.org>
- *rOpenSci Packages: Development, Maintenance, and Peer Review*, for the habits
  that make a package usable by someone else: <https://devguide.ropensci.org>
- The course's own `biometrydata/` folder: a complete, small, data-only package
  to read alongside the book.

**Getting messy data into shape**

- *R for Data Science* (2nd edition), the data import and tidying chapters. The
  course's own text, so already familiar: <https://r4ds.hadley.nz>
- Wickham (2014), "Tidy Data", the idea behind the tidyverse:
  <https://doi.org/10.18637/jss.v059.i10>
- Broman and Woo (2018), "Data Organization in Spreadsheets". The single most
  useful paper to read before collecting data:
  <https://doi.org/10.1080/00031305.2017.1375989>

**Reproducible pipelines**

- Wilson et al. (2017), "Good enough practices in scientific computing". Start
  here: <https://doi.org/10.1371/journal.pcbi.1005510>
- *The targets R Package User Manual*: <https://books.ropensci.org/targets/>
- Landau (2021), the `targets` paper: <https://doi.org/10.21105/joss.02959>
- *Happy Git and GitHub for the useR*, Bryan: <https://happygitwithr.com>

**Where distributions come from**

- Bolker, chapter 4, the course text, which this supplement extends.
- Lindén and Mäntyniemi (2011), on the negative binomial for overdispersed
  ecological counts: <https://doi.org/10.1890/10-1831.1>

**Finding data, and APIs**

- `httr2` documentation, for talking to any web API from R:
  <https://httr2.r-lib.org>
- `rgbif` documentation, the worked case most ecologists want first, species
  occurrences from GBIF: <https://docs.ropensci.org/rgbif/>

**Competition and other dynamic models**

- Bolker, chapter 11, "Dynamic models": fitting them, which is the part the other
  books leave out.
- Otto and Day (2007), *A Biologist's Guide to Mathematical Modeling in Ecology
  and Evolution*, Princeton University Press. Building them.

**Phylogenetics**

- Harmon, *Phylogenetic Comparative Methods*. Free online, and the place to
  start: <https://lukejharmon.github.io/pcm/>
- Revell and Harmon (2022), *Phylogenetic Comparative Methods in R*, Princeton
  University Press. The hands-on companion.
- Paradis and Schliep (2019), `ape` 5.0:
  <https://doi.org/10.1093/bioinformatics/bty633>
- Revell (2012), `phytools`: <https://doi.org/10.1111/j.2041-210X.2011.00169.x>

**Genetics** (population genetics, pending the question of which genetics the
students meant)

- *Population Genetics in R*, Grünwald lab. Free, worked, and aimed at
  biologists rather than programmers:
  <https://grunwaldlab.github.io/Population_Genetics_in_R/>
- Nielsen and Slatkin (2013), *An Introduction to Population Genetics: Theory and
  Applications*, Sinauer. The theory, at the level this course works at.
- Jombart (2008), `adegenet`: <https://doi.org/10.1093/bioinformatics/btn129>

## Keeping them working

Unsupervised code that has quietly stopped working is worse than no supplement.

- **Done, 2026-10-22:** `check_deck_student_code.R` sweeps `supplements/` as
  well as `lectures/`. `deck_dirs()` holds the list and `all_decks()` expands
  it, so `check_all_decks()`, `check_all_characters()` and `deck_packages()` all
  pick up a new supplement with no further edit. `ci_checks.R` runs them, so CI
  covers supplements too; keep the package list in `check.yaml` in step with
  `deck_packages()`.
- Put a **last checked** date on the title slide. `ggbump` and friends move.
- Pin examples to course data, as above.
- **Prefer base R and the packages the course already uses.** Supplement 02 was
  going to depend on `piecewiseSEM` until that package moved to R 4.5.0 and
  stopped installing here. A supplement nobody is supervising should not open
  with an install that fails, so a dependency is worth paying for only when it
  teaches something the hand-written version cannot.

## Getting them found

- An index page on the course site, which gives the github.io plan a second
  reason to exist
- A pointer on the "Before next class" slide of whichever lecture leads into one
- A line in the final project instructions for the ones that serve it
- In office hours, when someone asks: "that is Supplement 2"

## What the students said

Asked at the mid-semester check-in, Lecture 17, 2026-10-20, out loud: "which (if
any) are most useful?", "which would make you sign up for a second biometry
course?", and "any other requests?".

- **They want all of them.** Ranked: geospatial, package development, messy
  data, reproducible pipelines, then the rest.
- **Two new topics:** phylogenetics and genetics.

Notes on the two new ones, for when they are specified:

- **Phylogenetics** has a hook already in the course. Assignment 3's hawk model
  (Part 1b) treats 249 species as independent data points, and the starter script
  says outright that related species are not. A module on phylogenetic
  comparative methods, reading a tree into R and refitting that model with the
  non-independence accounted for, answers a caveat students have already met.
  It is also a natural partner to the geospatial module: both are about data
  points that are not independent.
- **Genetics** fits the likelihood half of the course unusually well: allele
  frequencies and Hardy-Weinberg are binomial and multinomial likelihoods, the
  same machinery as Lectures 15 to 18 with a different biology. Which part of
  genetics the students mean (population genetics, sequence data, quantitative
  genetics) is worth asking before building; the answer changes the module
  completely.

The ranking reorders the build order above: the Biometry II spine is no longer
"whatever order, no deadline", it has a queue.

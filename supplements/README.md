# Supplements: optional material beyond the course

Plan written 2026-10-16. The first supplement, **01 Figures worth showing**, is
built; everything below it is still a proposal.

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

| Topic | Useful this semester | Spine of a Biometry II |
|---|---|---|
| Figures worth showing: palettes, `ggridges`, `ggbump`, `patchwork`, model predictions | **High** | Medium |
| Where distributions come from: simulating the generating process | **High** | Medium |
| Getting messy data into shape | **High** | Medium |
| Finding data, and pulling it with APIs | Medium, mistimed this year | Medium |
| Geospatial: `sf`, rasters, making a decent map | Low | **High** |
| Competition and other dynamic models | Low | **High** |
| Package development: `devtools`, docs, tests | Low | **High** |
| Reproducible pipelines | Low | Medium |

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

**Then the Biometry II spine**, one at a time, in whatever order the students'
answers suggest. There is no deadline on those, which is the point.

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

Each ends with the same two things: **what this buys you**, in one sentence, and
**where it fits**, pointing at the lecture or the project stage it serves.

## Keeping them working

Unsupervised code that has quietly stopped working is worse than no supplement.

- Add `supplements/` to `check_deck_student_code.R`. The type-and-run extraction
  already works on any Quarto file; it only needs the directory.
- Put a **last checked** date on the title slide. `ggbump` and friends move.
- Pin examples to course data, as above.

## Getting them found

- An index page on the course site, which gives the github.io plan a second
  reason to exist
- A pointer on the "Before next class" slide of whichever lecture leads into one
- A line in the final project instructions for the ones that serve it
- In office hours, when someone asks: "that is Supplement 2"

## Before building past the first two: ask them

**Lecture 17, Tuesday October 20, is the mid-semester check-in**, already on the
syllabus. One slide with the topic list, have them pick two. Three minutes, in a
class that already has the slot, and it replaces a guess with a ranked list.

Worth asking in a way that separates the two audiences: "which would help you
this semester" and "which would make you sign up for a second course" are
different questions, and the second one is the more valuable answer.

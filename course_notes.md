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

---

## Related work already in progress

Not a substitute for the items above, but worth knowing about when picking them up:

- **Data wrangling moved earlier (Fall 2026).** Tidyverse and ggplot2 moved from lectures 23/25 to lectures 07/08, so students get `filter`/`group_by`/`summarise` in week 4 rather than November. This was prompted by students struggling to rearrange data, and it partly overlaps with the "Intro to R" strand in the course-splitting idea above. See `syllabus/syllabus.md`.
- **Slide updates pending.** A separate checklist of deck-level changes for Fall 2026 lives in [lectures/README.md](lectures/README.md). Some of it touches the "link assignments to chapters/slides" item.
- **Bolker chapter 3 materials.** Lectures 09 and 10 have no deck and there is no `Chapter_3_examples.R`; those slots were previously self-study. Building them is a chance to act on the "additional examples and documentation" item.

---
title: "Final Project"
subtitle: "PCB 6455 / BSC 4933: Biometry"
output:
  html_document:
    toc: true
    toc_depth: 2
  word_document:
    toc: false
---

# Overview

In place of a final exam, you will do a final project that builds on everything
you have done this semester. It has three parts, all about the research
question you have been investigating with your focal dataset (the one from
Assignments 1 to 4 and the midterm):

1. **Code.** A full, reproducible analysis of your data.
2. **Writing.** An updated draft of your midterm paper, now with the results of
   a statistical model.
3. **Presentation.** A short talk to the class on what you did and what you
   found.

**Due at your presentation, during the scheduled final exam block** (finals week
is December 5 to 10; the exact day and time will be posted on Canvas and in the
syllabus).

As on the midterm, you can use any real-world tools you like for the code: the
book, your notes, classmates, AI, online resources. **The exception is the
writing in Part 2, which must be your own.**

## Rationale

This project shows both your coding ability and your ability to interpret
results in a biological context. The three parts are modeled on three central
skills for scientists: analyzing data, writing about it, and presenting it.

None of it starts from scratch. The code extends your assignments, the writing
is a second draft of your midterm Part 1, and the presentation summarizes both.

## Assignment Format

You will submit three things:

1. **Your code**, as an R script, an R Markdown file, or a Quarto file.
   Graduate students submit it as a link to their own GitHub repository
   (mandatory); undergraduates can do the same for extra credit, or upload the
   file to Canvas.

   Example .Rmd file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_markdown/Example.Rmd>

   Example .R file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_commented/Example.R>

2. **Your writing**, as a Word document on Canvas (or the rendered output of
   your .Rmd or .qmd file, if you write it there).

3. **Your presentation slides**, added to a single Google Slides file shared
   by the whole class, so every talk runs from one computer and no time is lost
   connecting laptops. I will post the link on Canvas; it is not in this
   document because this page is public.

## Grading

- **Part 1 (code):** reproducibility, documentation, the suitability of your
  modeling decisions, and the accuracy of your conclusions.
- **Part 2 (writing):** writing quality. Expectations are higher for graduate
  students.
- **Part 3 (presentation):** presentation quality. Points are deducted for going
  over 5 minutes.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Part 1: code | 60% |
| Part 2: writing | 30% |
| Part 3: presentation | 10% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

### What reproducible means here

The same standard as Assignment 2 and the midterm:

- It runs **top to bottom in a fresh R session**, with no steps done by hand.
  Restart R and run the whole thing before you submit.
- The **data are loaded by the script**, either from a URL or from a path
  relative to the project folder, not from your Desktop.
- Every package is loaded with `library()` **at the top**.

# Part 1: Code

Use your dataset and R to answer one or more biologically interesting
questions. Your analysis should improve on your earlier work, and it should be a
full analysis, not a fragment. It should include:

- **Loading the data**, and any cleaning or reshaping.
- **Any transformations**, and the reason for each.
- **Your candidate models**, and why you built each one as you did: its
  functional form, its distribution, and its predictors. Use the tools from the
  second half of the course: `lm()`, `glm()`, `mle2()`, and, if your rows come
  in groups (site, plot, individual, year), `lmer()` or `glmer()`.
- **Model comparison** with AIC, following the rule from Assignment 4: the
  models must use the same response, on the same scale, fitted to the same
  rows of data.
- **The model you keep**, with its estimates and confidence intervals. For a
  `glm()` or `glmer()`, undo the link and report effects as multipliers, odds
  ratios or predicted values (Lecture 24).
- **At least one check** that the model describes your data, such as residual
  plots, its predictions with a confidence band over the data, or, for counts,
  the share of observations inside the model's 95% range.
- **Your figures**, made with ggplot2.

**Document it well** (Lecture 26): a comment at the top saying what the script
does and what data it needs, sections for each stage, clear object names, and
comments that say **why** you made each decision, not just what the code does.
Good "why" comments are most of your Methods section.

If your rows are not independent and you have not modeled that (for example,
sites close together in space, repeated years, or related species), say so in
your comments and in Part 2, and say which way it is likely to bias your
results (Lecture 25).

# Part 2: Writing

Write a short, partial draft of a paper. Think of it as the second draft of your
midterm Part 1: revise it using the feedback you received, and add the results
of your models. If you are new to scientific writing, the ESA has a useful guide
(<https://doi.org/10.1002/bes2.1258>).

Write all of the text yourself: no AI, no plagiarism. AI and online resources are
fine for the code.

Your draft should contain the following sections (aim for about 300 words each;
going over is fine):

- **Introduction.** The question you hope to answer and why it matters, closing
  with a brief statement of what you did in your analyses. Include citations to
  support your claims.

- **Materials and methods.** Where the data came from, what they contain, and
  briefly how they were collected. Then the analyses: your candidate models, why
  you chose them, and how you compared them. Cite R and any R packages you used;
  `citation()` and `citation("packagename")` will give you these.

- **Results.** What you found, including the results of **at least one
  statistical model**, not just plots: which model was best supported, its
  estimates with confidence intervals, and what they mean biologically.
  Figures should be readable on their own: axis labels with units, and a
  caption. They should be better than your midterm figures.

# Part 3: Presentation

Present your findings to the class in the style of a short scientific talk,
during the scheduled final exam block. Talks should be **about 5 minutes**, and
going over costs points, because it takes time from the next speaker.

All talks run from **one shared Google Slides file**, using the link I post on
Canvas. Add your slides to it, in your own section, before the session starts,
and check that they look right there: fonts, figures and anything copied from
PowerPoint can shift. Do not edit anyone else's slides.

A format that works:

1. **Title slide**, with an informative title and your name.
2. **Background** (1 to 2 slides): what is your question, and why does it
   matter?
3. **Methods** (1 to 2 slides): how did you investigate it? Mention your
   modeling decisions.
4. **Results** (1 to 2 slides): at least one figure and the results of at least
   one statistical model, interpreted in terms of your question.
5. **What you would do next.**

Keep text to a minimum: roughly seven lines of about seven words each is an
upper limit, not a target. Your figures are the presentation; if a figure needs
a paragraph of explanation, fix the figure. Practice out loud, with a clock.

# Before you submit

- [ ] The code runs top to bottom in a fresh session
- [ ] Data are loaded from a URL or a relative path, not from your Desktop
- [ ] Every modeling decision has a comment saying why
- [ ] Models compared with AIC use the same response and the same rows
- [ ] The kept model has estimates with confidence intervals, on the original scale
- [ ] Every figure has axis labels with units and a caption
- [ ] R and any packages are cited in Part 2
- [ ] Your slides are in the shared file, and your talk fits in 5 minutes

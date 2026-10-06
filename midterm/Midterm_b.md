---
title: "Midterm"
subtitle: "PCB 6455 / BSC 4933: Biometry"
output:
  html_document:
    toc: true
    toc_depth: 2
  word_document:
    toc: false
---

# Overview

The midterm has three parts.

1. **Writing about data.** A short partial draft of a paper, using the dataset
   you have been working with all semester.
2. **Functions and distributions.** Three datasets I give you. For each, decide
   which function (Chapter 3) and which distribution (Chapter 4) fit, and say
   why.
3. **Power analysis.** Use simulation to work out how sample size and
   measurement noise together determine your chance of detecting a
   relationship.

**Due Tuesday Oct 13, 11:59 pm.**

Since this work is meant to demonstrate your real-world coding ability, you can
use any real-world tools you like for the code: the book, your notes, classmates,
AI, online resources. **The exception is the writing in Part 1, which must be
your own.**

## Rationale

Each part tests a skill you will need for the final, and for your own research.
Part 1 is the writing and figures, Part 2 is choosing a model, Part 3 is deciding
whether a study can answer the question before you run it.

This is also designed to compound rather than be thrown away: Part 1 reuses your
Assignment 1 and 2 work, and the draft you produce here becomes the starting
point for the final.

## Assignment Format

As before, this can be submitted in one of two formats:

1. **The output of an .Rmd file.**
   Example .Rmd file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_markdown/Example.Rmd>

   Example output:

   - <https://github.com/bmaitner/biometry_course/blob/main/example_R_markdown/Example.pdf>
   - <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/example_R_markdown/Example.docx>
   - <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/example_R_markdown/Example.html>

2. **A fully-reproducible R script that can be run on any computer.**
   Example .R file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_commented/Example.R>

Submit in one of two ways:

1. Provide the file on Canvas (e.g., .R or .html; undergrads only).
2. Upload the file to your own Github repository and provide a link via Canvas
   (mandatory for graduate students, undergrads get extra credit).

Parts can be combined in one file or submitted as separate files, whichever you
prefer. If you would rather write Part 1 in Word, submit the document along with
the code that made the figures.

## Grading

- **Part 1:** writing quality, analysis and visualization quality, and
  reproducibility.
- **Part 2:** the accuracy of your answers and the quality of your
  justifications.
- **Part 3:** the quality of your figure, the reproducibility of your code, and
  the accuracy of your conclusion.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Part 1 | 60% |
| Part 2 | 30% |
| Part 3 | 10% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

### What reproducible means here

The same standard as Assignment 2:

- It runs **top to bottom in a fresh R session**, with no steps done by hand.
- The **data are loaded by the script**, either from a URL or from a path
  relative to the project folder.
- Every package is loaded with `library()` **at the top**.

# Part 1: Writing about data

Write a short, partial draft of a paper using your focal dataset. If you are new
to scientific writing, the ESA has a useful guide
(<https://doi.org/10.1002/bes2.1258>).

Write all of the text yourself: no AI, no plagiarism. AI and online resources are
fine for the code.

Your draft should contain:

- **Introduction** (about 300 words). The question you hope to answer and why it
  matters, closing with a brief statement of what you will do in your analyses.
  Include citations to support your claims.

- **Materials and methods** (300 words or less). Where the data came from, what
  they contain, and briefly how they were collected, plus the analyses you are
  doing (at this point, plotting and description). Cite R and any R packages you
  used. `citation()` and `citation("packagename")` will give you these.

- **Results** (300 words or less). What you found, with figures that support it.
  Figures should be readable on their own: axis labels with units, and a caption.

# Part 2: Functions and distributions

You are given three datasets. For each one, answer in three steps:

- **A. What shape is the relationship?** Name a function from Chapter 3 and say
  what in the plot led you there.
- **B. What distribution describes the scatter around it?** Name a distribution
  from Chapter 4 and Table 4.1.
- **C. Why?** One short paragraph per dataset is plenty.

Load the data straight from the course repository:

```r
library(readr)

twoa <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2a.RDS")
twob <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2b.RDS")
twoc <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2c.RDS")
```

Example code is at
<https://github.com/bmaitner/biometry_course/blob/main/midterm/midterm_b_example.R>.

The datasets:

- **2a.** Adult body mass and egg mass, for 250 bird species, from the Amniote
  Life History Database. Treat adult body mass (g) as the predictor (x) and egg
  mass (g) as the response (y).

- **2b.** Reef fish surveys from the Florida Keys, 250 surveys, from NOAA's
  National Coral Reef Monitoring Program. Treat the total abundance of fish
  recorded on a survey as the predictor (x) and the number of species recorded
  as the response (y).

- **2c.** Benthic surveys of 150 reef stations in the Florida Keys. Rugosity is
  a measure of how structurally complex the sea floor is, measured from 0 to
  about 2. Treat rugosity as the predictor (x) and the percentage of the station
  covered by hard bottom as the response (y).

**Show your evidence.** A plot of the data, and whatever you used to decide:
a histogram of the response, a mean against a variance for counts, a mean
against a median for skew. More than one answer can be defensible for some of
these, and the reasoning is what is being graded.

Two things worth checking, both of which came up in class:

- **Does a transformation change your answer?** Several of these are easier to
  read on log axes.
- **Is the variable one thing?** If a dataset contains more than one group, a
  pooled plot can look like nothing in the bestiary while each group is
  perfectly ordinary. Say so if you find it.

# Part 3: Power analysis

Use simulation to work out how **sample size** and **noise** together determine
statistical power.

Assume a linear relationship between y and x, with:

- intercept = 2
- slope = 1
- standard deviation ranging from 1 to 20

This is the model from class. For each combination of standard deviation and
sample size, simulate many datasets, fit `lm()` to each, and record how often
the slope comes out significant (p < 0.05). That proportion is the power.

You will need to produce:

- **One or more figures** showing how power changes with the standard deviation,
  for at least three different sample sizes.
- **A short written answer**, in your own words, on how noise and sample size
  affect power. Include something practical: if you could either double your
  sample size or halve your measurement error, which would help more here?

A skeleton for this is in
<https://github.com/bmaitner/biometry_course/blob/main/midterm/midterm_b_example.R>,
which loops over standard deviations at a single sample size. Your job is to
extend it.

This part can be a separate file or combined with Parts 1 and 2.

# Before you submit

- [ ] The code runs top to bottom in a fresh session
- [ ] Data are loaded from a URL or a relative path, not from your Desktop
- [ ] Every figure has axis labels and a caption
- [ ] R and any packages are cited in Part 1
- [ ] Part 2 gives a function, a distribution, and a reason for each dataset
- [ ] Part 3 has a figure with more than one sample size, plus your conclusion

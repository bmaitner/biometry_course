---
title: "Assignment 2: Distributions"
subtitle: "PCB 6455 / BSC 4933: Biometry"
output:
  html_document:
    toc: true
    toc_depth: 2
  word_document:
    toc: false
---

# Overview

This assignment has two parts (full detail at the bottom). In the first part, I'll give you a list of different types of data and you'll have to decide what type of probability distribution they correspond to using the Bestiary of Distributions in your book (section 4.5). For the second part, you'll use the same dataset from Assignment 1 and will decide which types of distributions your focal variables correspond to.

## Rationale

Understanding data distributions is important for data visualization and statistical analyses, as well as providing information on important biological processes. This assignment is designed to familiarize you with some of the more common types of statistical distributions in biology as well as getting you used to the process of trying to decide which is most appropriate for a given variable.

## Assignment Format

As before, this assignment can be submitted in one of two formats:

1. **The output of an .Rmd file.**
   Example .Rmd file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_markdown/Example.Rmd>

   Example output:

   - <https://github.com/bmaitner/biometry_course/blob/main/example_R_markdown/Example.pdf>
   - <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/example_R_markdown/Example.docx>
   - <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/example_R_markdown/Example.html>

2. **A fully-reproducible R script that can be run on any computer.**
   Example .R file: <https://github.com/bmaitner/biometry_course/blob/main/example_R_commented/Example.R>

Assignments can be submitted in 2 ways:

1. Provide the file on Canvas (e.g., .R or .html; undergrads only).
2. Upload the file to your own Github repository and then provide a link via Canvas (mandatory for graduate students, undergrads get extra credit).

## Grading

Students will be graded on both meeting the criteria outlined in the overview as well as the quality of their work.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Part 1 answers | 40% |
| Part 2 accuracy and reasoning | 40% |
| Reproducibility | 20% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

### What reproducible means here

The reproducibility portion of the grade is for work that runs on a computer
that is not yours:

- It runs **top to bottom in a fresh R session**, with no steps done by hand.
- The **data are loaded by the script**, either from a URL or from a path
  relative to the project folder. An absolute path such as
  `C:/Users/yourname/Desktop/data.csv` will not run on my computer.
- Every package the script uses is loaded with `library()` **at the top**.

# Part 1: Hypothetical Distributions

For each of the following types of data, answer in two steps:

- **A. Is the variable discrete or continuous?**
- **B. Which distribution is most appropriate?** Choose from the options in
  Table 4.1 and Section 4.5 of your book.

Then briefly (one or two short sentences MAX) explain how you came to that
conclusion. You can include these as either text in a .Rmd file output, or else
just include them as comments in a .R file.

Several of these have more than one defensible answer, and more than one will be
accepted. **The reasoning is what is being graded**, so a well argued second
choice is worth more than a bare right answer.

1. **Number of surviving individuals within a forest plot**, out of a known
   starting number
2. **Species abundance (counts of individuals in a plot)**
3. **Pollinator visitation rate (visits per flower per unit time)**
4. **Ages (in years) of surviving individuals within a reserve**
5. **Body size (e.g., body mass, length)**
6. **Biomass per unit area**
7. **Time to germination**
8. **Proportion of habitat covered by vegetation**
9. **Larval settlement success (number settled out of larvae released)**
10. **Proportion of infected fish in a population (parasite prevalence)**
11. **Daily temperature at a field site**
12. **Population growth rate**, meaning next year's population size divided by
    this year's

# Part 2: Focal Dataset Distributions

For your focal dataset (the one you used in Assignment 1), choose **at least
three numeric variables** you are interested in and explain which distribution
you think is most appropriate for each.

For each variable, provide:

- A **histogram**. If the raw histogram is strongly skewed, show a logged version
  as well and say which one you are reading.
- Whether the variable is **discrete or continuous**, as it was measured. Note
  that this is not always how R stores it: counts are often read in as numeric.
- The **mean and the median**. How far apart they are is evidence about skew,
  and therefore about which distributions are plausible.
- A short written argument, as comments if you are using a .R file, naming the
  distribution and tying it to what you just showed.

If a variable does not look like anything in the bestiary, say so and explain
why. That is a real answer and will be graded as one.

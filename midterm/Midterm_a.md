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

Your midterm will be composed of three parts. In the first part, you'll practice your data, visualization, and writing skills. In the second, you'll be given data and have to decide what models and distributions seem appropriate. In the third, you'll have to complete a power analysis. Since this work is designed to demonstrate your real-world coding abilities, you can use any real-world tools you'd like (book, notes, friends and classmates, AI, online resources, etc.).

## Rationale

Each portion of this midterm is designed to test your progress on key skills needed for data analysis, as well as giving you an opportunity to practice what you've learned in class (which will help you remember it).

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

- Part 1 will be graded on writing quality, analysis and visualization quality, and reproducibility.
- Part 2 will be graded based on both the accuracy of your answer as well as your justifications.
- Part 3 will be graded on the quality of your figure, reproducibility of your code, and the accuracy of your conclusion.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Part 1 | 60% |
| Part 2 | 30% |
| Part 3 | 10% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

# Part 1: Writing about data

This portion of the midterm is designed to help you practice writing for scientific papers and publications. This is designed so you can re-use code and writing from previous assignments for this assignment, which can in turn be re-used in future assignments. Your job in this section is to write a short, partial draft of a paper. If you're new to scientific writing, the ESA has a useful guide (<https://doi.org/10.1002/bes2.1258>). You should write all the text in Part 1 yourself (i.e., no AI, no plagiarism), but AI and online resources can be used in coding if you like. If you prefer, you can submit part 1 as a word document along with the code (.R or .Rmd) used to generate the figures.

Your draft paper should contain the following sections:

- **Introduction** (300 words or so): Explain the question you hope to answer and why it is important. Close with a brief section that explains what you'll be doing in your analyses. Include citations to support your claims.

- **Materials and methods** (300 words or less): Since you're using previously-published data, this section should contain information on the data you're using (where it came from, what it contains, brief overview of how it was collected, etc.) and the analyses you're doing (at this point, this will just be plotting). Remember to cite R and any R packages you use.

- **Results** (300 words or less): This section should detail what you found, and should include figures to support those findings.

# Part 2: Distributions and Functions

In this portion of the midterm, you'll be provided with three datasets which you'll use to answer questions about which functions (Chapter 3) and distributions (Chapter 4) are most appropriate. The data for 2a, 2b, and 2c are stored in the folder midterm (<https://github.com/bmaitner/biometry_course/tree/main/midterm>). Example code showing how to load these data is available via Github (<https://github.com/bmaitner/biometry_course/blob/main/midterm/midterm_example.R>). For each of the three datasets, explain which function (see chapter 3) and distribution (see Chapter 4) are most appropriate to model the data and why you think so. Brief explanations of the variables follow.

- **2.a)** This dataset shows bird mass and wing length. You should consider mass as the predictor (x) variable and wing length as the response (y) variable.

- **2.b)** This dataset shows bird beak length and beak width. You should consider beak length as the predictor (x) variable and beak width length as the response (y) variable.

- **2.c)** This dataset shows the functional richness (amount of functional diversity) and functional evenness (how evenly spread the functional diversity is) of marine microorganism communities. You should consider functional richness as the predictor (x) variable and functional evenness as the response (y) variable.

# Part 3: Power analysis

In this portion of the midterm, your task is to use simulations and power analysis to identify how sample size and slope interact to impact statistical power. Assume a linear relationship between y and x, where x has a slope ranging between -2 and 2, the intercept is 2, and the standard deviation is 8. Note that this is essentially the equation we were working with in class. As a base for your code, you can use the code on the course Github (<https://github.com/bmaitner/biometry_course/blob/main/midterm/midterm_example.R>). You'll need to create one or more figures that show how changing sample size changes the relationship between power and slope, and provide a brief answer in your own words about how slope and sample size impact power. This should be turned in as an .R or .Rmd file, but it can be a separate file or can be combined with the answers to parts 1 and/or 2.

---
title: "Assignment 3: Model Selection"
subtitle: "PCB 6455 / BSC 4933: Biometry"
output:
  html_document:
    toc: true
    toc_depth: 2
  word_document:
    toc: false
---

# Overview

This assignment has two parts (full detail at the bottom). In the first part, I'll give you data and full models and you'll have to decide whether all parameters should be retained or whether a simpler model is preferred by modifying the full model into simpler models and then comparing the AICs. For the second part, you'll use the dataset you've chosen for this class (e.g., from Assignment 1, 2, the midterm) and will fit alternative models and decide which are best.

## Rationale

Model fitting and comparison is central to hypothesis testing as well as modelling biological processes. Part one is designed to let you practice your model fitting and comparison skills while part two is meant to let you put those skills to work in a more realistic context.

## Assignment Format

Part 1 will be easiest if submitted as an .R file (since it requires modification of an existing .R file). Part 2 can be submitted as either .R or .Rmd.

Assignments can be submitted in 2 ways:

1. Provide the file on Canvas (e.g., .R or .html; undergrads only).
2. Upload the file to your own Github repository and then provide a link via Canvas (mandatory for graduate students, undergrads get extra credit).

## Grading

Students will be graded on both meeting the criteria outlined in the overview as well as the quality of their work. Remember, assignments should be fully reproducible, so any data you use in part 2 should either be loaded directly from an online source or else should provide details on where the data can be found and downloaded.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Part 1 | 40% |
| Part 2 | 40% |
| Reproducibility | 20% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

# Part 1: Model modification and selection

I've prepared three different models (1a, 1b, 1c) using different data and distribution types. The starting script is here:

<https://github.com/bmaitner/biometry_course/blob/main/assignments/assignment_3/assignment_3.R>

Your job is to create alternate versions of each model, compare their AICs using the function `AICtab()`, and select which model (or models) you think are best for each of the three. For each, you should start with the code I provided, add multiple alternate models, compare their AICs, and explain which model(s) you think is best and why. The starting models I have are deliberately over-fit, so you can create alternate models simply by removing different parameters if you like. You're also free to add parameters.

# Part 2: Focal dataset model selection

For your focal dataset (the one you used in Assignment 1, 2, and the midterm), create alternate models and compare them using their AIC score. In previous assignments, you've plotted your variables (Assignment 1), identified the distributions they follow (Assignment 2), and written about analyses and questions you'd like to ask with them (midterm). Your goal here is to select one or more response variables you'd like to investigate. For each response variable, you should make two or more models and compare them via their AIC values. Code from the book, the lectures, and from Part 1 can be modified to help you construct your models so you don't have to start from scratch. Make sure to clearly identify the different variables you're trying to predict, note the different candidate models, and explain which model(s) you think are the best and why.

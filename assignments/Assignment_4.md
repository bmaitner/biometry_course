---
title: "Assignment 4: General and Generalized Linear Models"
subtitle: "PCB 6455 / BSC 4933: Biometry"
output:
  html_document:
    toc: true
    toc_depth: 2
  word_document:
    toc: false
---

# Overview

The goal of this assignment is to apply the modelling techniques discussed in chapter 9 (LMs, GLMs, etc.) to your system of interest. You should identify one or more ecologically or biologically interesting questions that can be asked with your data, fit several candidate models, and identify which model(s) you think are best.

For each model, you should provide documentation as to why you constructed the model as you did (e.g., why did you pick a given functional form and distribution, why did you include those variables, etc.), and what the biological or ecological interpretation of that model would be (e.g., this model assumes that *some variable* is a function of *some other variable*, and that intercepts vary by *some other variable*).

You are free to convert models from previous assignments into the `lm()` / `glm()` formatting, but you should also test a few new models as part of this exercise.

## Rationale

General linear models and generalized linear models are the workhorses of biology and are among the most important statistical skills you can have. This assignment is designed to give you practice in both thinking about what would constitute a reasonable model and how to fit a model using `lm()`, `glm()`, and related functions (those in chapter 9).

## Assignment Format

Assignments can be submitted in 2 ways:

1. Provide the file on Canvas (e.g., .R or .html; undergrads only).
2. Upload the file to your own Github repository and then provide a link via Canvas (mandatory for graduate students, undergrads get extra credit).

## Grading

Students will be graded on the model documentation, rationale for model structures, biological interpretations, and reproducibility. Remember, assignments should be fully reproducible, so any data you use should either be loaded directly from an online source or else should provide details on where the data can be found and downloaded.

*Grade Breakdown:*

| Item | Percent |
|----|----|
| Model documentation and rationale | 40% |
| Biological interpretation of models | 40% |
| Reproducibility | 20% |
| Uploaded to Github (Undergrads) | +10% |
| Not uploaded to Github (Grads) | -10% |

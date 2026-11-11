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

**Due Friday, November 20, 11:59 pm.**

The goal of this assignment is to apply the modeling techniques discussed in chapter 9 (LMs, GLMs, etc.) to your focal dataset (the one you used in Assignments 1 to 3 and the midterm). You should identify one or more ecologically or biologically interesting questions that can be asked with your data, fit at least three candidate models for each question, and identify which model(s) you think are best.

For each model, you should provide documentation as to why you constructed the model as you did (e.g., why did you pick a given functional form and distribution, why did you include those variables, etc.), and what the biological or ecological interpretation of that model would be (e.g., this model assumes that *some variable* is a function of *some other variable*, and that intercepts vary by *some other variable*). For a `glm()`, interpret effects on the original scale, not the link scale: undo the link (`exp()` for a log link, `plogis()` for a logit) and report effects as multipliers, odds ratios, or predicted values, as in Lecture 24.

When you compare models with AIC, they must use the same response, on the same scale, fitted to the same rows of data. AIC cannot compare `log(y)` with `y`, an `lm()` with a binomial `glm()` on 0/1 data, or a quasi-Poisson model with anything (it has no AIC). If adding a predictor drops rows because of missing values, remove those rows before fitting any of the models.

For the model (or models) you keep, show at least one check that it describes your data: residual plots for an `lm()`, the dispersion check for counts, or a figure of its predictions with a confidence band over the data. Say what the check shows.

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

---
title: "PCB 6455 / BSC 4933: Biometry"
subtitle: "Course Syllabus"
author: "Dr. Brian Maitner"
date: "Fall 2026"
output:
  html_document:
    toc: true
    toc_depth: 2
    toc_float: true
  word_document:
    toc: true
    toc_depth: 2
  pdf_document:
    toc: true
---

![](images/usf_signature.png){width="2.5in"}

**PCB 6455 / BSC 4933: Biometry**

CRN 92379/89986, Section #601, Credit Hours: 4

|  |  |
|----|----|
| Semester | Fall 2026 |
| Class Meeting Days | T, Th |
| Class Meeting Time | 2:00 – 3:50 pm |
| Class Meeting Location | DAV 265 |
| Instructor | Dr. Brian Maitner |
| Office Location | DAV 226 |
| Office Hours | Tues 3:15 – 4:15 (or by appointment) |
| Email | [bmaitner\@usf.edu](mailto:bmaitner@usf.edu){.email} |

# University Course Description

Introduction to exploratory data analysis in ecology. Techniques for dealing with encountered data are emphasized.

# Course Prerequisites

None.

# Course Purpose

The biological sciences, including ecology, evolution, and conservation biology are all about understanding complex natural systems — from tracking endangered species to modeling climate impacts on habitats. Statistics help us make sense of the data we collect, separating real patterns from random noise. Data science goes a step further, giving us tools to handle large, messy, and dynamic datasets, visualize results clearly, and build models to predict future scenarios. This course introduces coding in R (a common coding language and the most popular in ecology, evolutionary biology, and conservation biology) and provides students with skills needed for data analysis, wrangling, and visualization. Upon completion, students will be able to conduct their own publication-quality analyses and visualizations and will know where to look to expand their skills further.

# Course Format

The course will be taught in a "flipped" format: students will be expected to do readings in preparation for class, and the majority of class time will be spent working on coding exercises that help students understand and apply the contents of the readings. Where possible, assignments will encourage students to use data from their own study system (or a system of their choice), allowing students to focus their learning where it is most relevant. Students should plan on bringing laptops to class.

# Student Learning Outcomes

Upon completing this course, students will:

1.  develop an understanding of the fundamental concepts underlying statistical analyses
2.  identify proper approaches in collecting and analyzing data, and interpreting and presenting the results of biological investigations using R scripts
3.  become familiar with how to design successful biological experiments
4.  learn to think critically about the world, in general, and science specifically
5.  lay the foundation for future statistical development and learning

# Course Objectives

By the end of this course, students will be able to:

- **Import** datasets into R and **execute** core data-wrangling operations.
- **Generate** clear data visualizations using both base R graphics and the ggplot2 package.
- **Classify** common statistical distributions and **determine** their appropriate ecological applications.
- **Select** and **justify** specific statistical analyses tailored to unique ecological questions and data structures.
- **Diagnose** and **resolve** errors in R code using standard troubleshooting and debugging techniques.
- **Formulate** a structured, logical workflow to solve novel coding problems.
- **Integrate** acquired R programming skills into independent ecological research projects.

# Required Texts and/or Readings and Course Materials

**Textbooks:**

- *Ecological Models and Data in R* by Benjamin M. Bolker (ISBN: 978-0691125220)
- *R for Data Science* (<https://r4ds.hadley.nz/>)

**Papers:**

- Merow, C., Serra-Diaz, J.M., Enquist, B.J. et al. AI chatbots can boost scientific coding. *Nat Ecol Evol* 7, 960–962 (2023). <https://doi.org/10.1038/s41559-023-02063-3>
- Maitner, B., Santos Andrade, P. E., Lei, L., Kass, J., Owens, H. L., Barbosa, G. C. G., Boyle, B., Castorena, M., Enquist, B. J., Feng, X., Park, D. S., Paz, A., Pinilla-Buitrago, G., Merow, C., & Wilson, A. (2024). Code sharing in ecology and evolution increases citation rates but remains uncommon. *Ecology and Evolution*, 14, e70030. <https://doi.org/10.1002/ece3.70030>

**Software:**

- R (available for free at <https://www.r-project.org/>)
- RStudio (available for free at <https://posit.co/download/rstudio-desktop/>)
- Git (optional for undergrads. Available for free at <https://git-scm.com/downloads>)
- Github account (optional for undergrads. Sign up for free at <https://github.com/>)

In addition to this text and these software applications, students will select readings from the scientific literature of their choosing and will make use of freely available online resources (e.g., StackOverflow).

# Grading Scale

| Percent | Grade |
|---------|-------|
| 90–100  | A     |
| 80–89   | B     |
| 70–79   | C     |
| 60–69   | D     |
| 0–59    | F     |

# Grade Categories and Weights

| Graded Item                      | Percent of Final Grade |
|----------------------------------|------------------------|
| In-class participation           | 20%                    |
| In-class quizzes                 | 20%                    |
| Assignments (4x)                 | 20%                    |
| Midterm (take-home)              | 20%                    |
| Final (presentation + take-home) | 20%                    |

## In-class Participation

Students will be rewarded for attending class and actively participating. Participation includes actively working on in-class exercises, helping others debug their code, participating in discussions, and generally engaging with the class and with your peers. Up to 2 classes can be missed without impacting your participation grade.

## In-class Quizzes

Short (only a few questions) in-class quizzes will sometimes be given at the start of class. These quizzes will not be announced beforehand. The goal of these quizzes is to both ensure that students are doing the readings before class, as well as assessing how well students are understanding the material.

## Assignments

There will be four total assignments, each accounting for 5% of your total grade. These assignments will focus on key elements of data analysis and will make use of both your own data (or data relevant to your interests) and publicly available data. Assignments can be submitted as either an R, R markdown, or Quarto file format. Assignments can be submitted via Canvas or alternatively can be posted to Github (required for grads, extra credit for undergrads).

## Midterm

The midterm will be take-home, and will focus on data of relevance to the student. Students will load data, visualize it in different ways, and conduct relevant exploratory analyses.

## Final

The final will build on the midterm, and should ideally utilize the same dataset. Students will conduct statistical analyses on their focal dataset, as well as creating relevant visualizations. The entire workflow should be reproducible and should include detailed comments to make clear what is being done at each step and why. Graduate students will be expected to upload their final assignment to Github (as an .Rmd or .Qmd file) and undergraduate students can optionally submit in this format for extra credit. In addition to the assignment, you'll also be expected to give a short presentation of what you did and what you found during class.

# Instructor Feedback Policy & Grade Dissemination

I'll aim to have work graded within two weeks of the assignment closing date. In the spirit of fairness, if I fail to meet this deadline, I'll allow students to submit an assignment of their choosing equivalently late. For example, if it takes me three weeks to grade one of your assignments, I won't take off points for your next project being up to one week late.

# Course Schedule

| Lecture | Date | Subject | Due |
|----------------|----------------|-----------------------|----------------|
| 1 | Aug 25 T | Syllabus; Why we need statistics; Reproducibility and Openness |  |
| 2 | Aug 27 Th | Frameworks for modelling; Installing R and RStudio (and Github) | Read 1.1 – 1.3 |
| 3 | Sep 1 T | Statistical Frameworks; Work through 1.7 | Read 1.4 – 1.6 |
| 4 | Sep 3 Th | Intro to Data in R; Work on loading and viewing data | Read 2.1 – 2.3; Think about data of interest |
| 5 | Sep 8 T | Exploratory analyses and graphics; Work on exploratory analyses (2.6) | Read 2.4 – 2.5 |
| 6 | Sep 10 Th | **Assignment 1: Data exploration.** Exploratory analyses and graphics; Work on exploratory analyses | Review 2.5 – 2.6 |
| 7 | Sep 15 T | Tidyverse: rearranging data to ask questions (filter, mutate, group_by, summarise) | *R for Data Science*: Chapter 3 |
| 8 | Sep 17 Th | ggplot2 | *R for Data Science*: Chapter 1; **Assignment 1 Due** |
| 9 | Sep 22 T | Deterministic functions | Read 3.1 – 3.3 |
| 10 | Sep 24 Th | Deterministic functions; Working with functions | Read 3.4 – 3.5; Complete 3.6 |
| 11 | Sep 29 T | Probability and Stochastic distributions; R functions for probability, distribution, and summary statistics | Read 4.1 – 4.2, 4.4 |
| 12 | Oct 1 Th | **Assignment 2: Distributions.** Probability and Stochastic distributions; Working with the bestiary of distributions | Skim 4.5 – 4.6 |
| 13 | Oct 6 T | Stochastic simulation; Midterm explained | Read 5.1 – 5.2 |
| 14 | Oct 8 Th | Power analysis | Read 5.3; **Assignment 2 Due** |
| 15 | Oct 13 T | Likelihood: Parameter estimation | Read 6.1 – 6.2 (6.2.2 is optional); **Midterm due** |
| 16 | Oct 15 Th | Estimating complex functions | 6.3 (6.3.2 optional) |
| 17 | Oct 20 T | Confidence intervals; Mid-semester check-in | 6.4 (6.4.2 optional); Skim 6.5 |
| 18 | Oct 22 Th | **Assignment 3: Model selection.** Model comparisons | 6.6 (6.6.3 optional) |
| 19 | Oct 27 T | Model fitting | 7.1 – 7.2 |
| 20 | Oct 29 Th | Issues with model fitting | 7.4 |
| 21 | Nov 3 T | Confidence limits | 7.5 |
| 22 | Nov 5 Th | Likelihood Examples; Work through examples in class | Skim chapter 8; **Assignment 3 Due** |
| 23 | Nov 10 T | General Linear Models | 9.1 – 9.2 |
| 24 | Nov 12 Th | **Assignment 4: GLMs.** Generalized Linear Models | 9.3 – 9.4 |
| 25 | Nov 17 T | Data tidying, making code readable, pseudocode, annotation, etc. | *R for Data Science*: Chapters 4, 5 |
| 26 | Nov 19 Th | Final project explained; Debugging and where to go for help; Debugging practice | *R for Data Science*: Chapter 8; <https://doi.org/10.1038/s41559-023-02063-3>; **Assignment 4 Due** |
| 27 | Nov 24 T | Reproducibility; Work on making .rmd files | *R for Data Science*: Chapter 6 |
| — | Nov 26 Th | *Thanksgiving — No classes* |  |
| 28 | Dec 1 T | Code and Data sharing; Work on projects in class | Test free week; <https://doi.org/10.1126/science.aab2374>; <https://doi.org/10.1002/ece3.70030> |
| 29 | Dec 3 Th | Catch-up; Work on final projects in class | Test free week; last T/Th class meeting |
| — | Dec 8 T | **Presentations of Final Project** (final exam block, 12:30 – 2:30 pm) | **Final Project Due** |

\* Note: The Schedule is subject to revision.

**Fall 2026 University dates used above** (USF Office of the Registrar): classes begin Aug 24; Labor Day Sep 7 (a Monday, so it does not affect this course); Veterans Day Nov 11 (a Wednesday, so it does not affect this course); Thanksgiving Nov 26–27; Test Free Week Nov 28 – Dec 4; classes end Dec 4; final exams Dec 5–10. Per the USF Standard Final Exam Matrix, a TR 2:00 – 3:15 pm course takes its final exam block on Tuesday, Dec 8, 12:30 – 2:30 pm.

# USF Core Syllabus Policies

USF has a set of central policies related to student recording class sessions, academic integrity and grievances, student accessibility services, academic disruption, religious observances, academic continuity, food insecurity, and sexual harassment that **apply to all courses at USF**. Be sure to review these online: <https://www.usf.edu/provost/faculty-success/resources-policies-forms/core-syllabus-policy-statements.aspx>

# Course Policies: Grades

**Late Work Policy:**

Students should aim to have assignments in on time. Late assignments may receive a penalty of up to 5% of the maximum score per day (but see "Instructor Feedback Policy & Grade Dissemination"). Any in-person assignments (*e.g.*, quizzes, presentations, Midterm, Final) cannot be made up without prior approval except in exceptional circumstances (*e.g.*, car crash on your way to class, Hurricane) or for medical reasons.

**Medical Excuses:**

Students should not attend class if they are ill, particularly if they have fever and/or gastrointestinal symptoms and/or respiratory symptoms such as a sneezing, runny nose, sore throat or coughing. Students experiencing any of these symptoms should contact immediately the Student Health Services (813-974-2331) on the Sarasota-Manatee and Tampa campus or the Wellness Center (727-873-4422) on the St. Petersburg campus for appropriate medical guidance and to obtain a verification of care letter. Students may turn to other health providers as well. **To be approved for missed classes, late assignments or missed examinations a verification of care letter must be presented by the student to the faculty member upon return to class.**

**Grades of "Incomplete":**

The current university policy concerning incomplete grades will be followed in this course.

*For undergraduate students:* An "I" grade may be awarded to a student only when a small portion of the student's work is incomplete and only when the student is otherwise earning a passing grade. The time limit for removing the "I" is to be set by the instructor of the course. For undergraduate students, this time limit may not exceed two academic semesters, whether or not the student is in residence, and/or graduation, whichever comes first. For graduate students, this time limit may not exceed one academic semester. "I" grades not removed by the end of the time limit will be changed to "IF" or "IU," whichever is appropriate.

*For graduate students:* An Incomplete grade ("I") is exceptional and granted at the instructor's discretion only when students are unable to complete course requirements due to illness or other circumstances beyond their control. The course instructor and student must complete and sign the "I" Grade Contract Form that describes the work to be completed, the date it is due, and the grade the student would earn factoring in a zero for all incomplete assignments. The due date can be negotiated and extended by student/instructor as long as it does not exceed two semesters for undergraduate courses and one semester for graduate courses from the original date grades were due for that course. An "I" grade not cleared within the two semesters for undergraduate courses and one semester for graduate courses (including summer semester) will revert to the grade noted on the contract.

# Course Policies: Technology and Media

**Canvas:** Most assignments will be submitted via Canvas (with a few exceptions).

**Laptop Usage:** Make sure to bring them! However, I recommend taking notes in a physical notebook or making notes in your copy of the textbook, as research has shown that taking notes in a notebook is more effective for multiple reasons (*e.g.*, fewer distractions in a notebook, writing things down aids in memory). However, it will also be useful to make notes in your code using commenting (we'll cover this in class).

**Phone Usage:** Keep phones silenced during class. If you need to take a call or do a lot of texting during class, please step outside of the classroom while you do so to avoid distracting others.

# Course Policies: Student Expectations

**Title IX Policy:**

Title IX provides federal protections for discrimination based on sex, which includes discrimination based on pregnancy, sexual harassment, and interpersonal violence. In an effort to provide support and equal access, **USF has designated all faculty (TA, Adjunct, etc.) as Responsible Employees, who are required to report any disclosures of sexual harassment, sexual violence, relationship violence or stalking.** The Title IX Office makes every effort, when safe to do so, to reach out and provide resources and accommodations, and to discuss possible options for resolution. Anyone wishing to make a Title IX report or seeking accommodations may do so online, in person, via phone, or email to the Title IX Office. For information about Title IX or for a full list of resources please visit: <https://www.usf.edu/title-ix/gethelp/resources.aspx>. If you are unsure what to do, please contact Victim Advocacy — a confidential resource that can review all your options — at 813-974-5756 or [va\@admin.usf.edu](mailto:va@admin.usf.edu){.email}.

**Generative AI:**

Use AI sensibly, if at all. The goal of this course is to teach you, and using AI to do your assignments negates that learning. It's also still pretty bad at a lot of coding stuff (but very good at others). In class we'll go over some recommendations on when using AI might be helpful, and when you might want to avoid it. In all cases, any use of AI must be cited. If you have questions about permissible use of AI, just ask.

# Learning Support and Campus Offices

## Academic Accommodations

Students with disabilities are responsible for registering with Student Accessibility Services (SAS) in order to receive academic accommodations. For additional information about academic accommodations and resources, you can visit the SAS website.

[SAS website for the St. Pete campus.](https://www.stpetersburg.usf.edu/student-life/resources/student-accessibility-services/)

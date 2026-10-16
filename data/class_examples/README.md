# Class examples: analysis-ready tables

Small, tidy tables used in lecture, so that class time goes on the statistics
rather than on wrangling. In a deck, setting up should be one line:

```r
occ <- read.csv("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bobwhite_occupancy.csv")
```

Everything here is derived from the raw datasets one directory up. Nothing here
is a new source of data.

## The files

| File | Rows | What it is |
|---|---|---|
| `bobwhite_occupancy.csv` | 23 | One row per year, 1997 to 2019: Florida BBS routes surveyed (`n_routes`) and how many held Northern Bobwhite (`n_occupied`). The binomial response used in Lecture 16. |
| `bobwhite_counts.csv` | 1,360 | One row per route-year where bobwhite were detected: the `count`, plus `frac_built`, temperature and precipitation for the route. Used in Lectures 15 and 16. |
| `reef_surveys.csv` | 8,560 | NCRMP reef fish surveys, trimmed to the columns the exercises use: `depth`, `richness`, `abundance`, `visibility`, `habitat`, `protection`. |

`elapsed` in the bobwhite files is years since the first year in that file, which
is what the models actually use as a covariate. Fitting on `elapsed` rather than
on the calendar year keeps the intercept interpretable and the parameters from
becoming strongly correlated.

## How they are made

`make_class_examples.R`, run from the project root:

```r
source("data/class_examples/make_class_examples.R")
```

The script is the only way files in this folder are created. If something here
cannot be rebuilt by running it, it does not belong here. It ends with checks on
the numbers the lectures quote, so a change in the raw data that would silently
break a slide fails loudly instead.

The script is written in **dplyr**, deliberately. Aggregating and reshaping is
what the tidyverse is best at, and it is what Lecture 7 covered. The modeling
code in the decks stays base R, to match Bolker. Two tools, each doing the job it
is good at.

## A caveat worth keeping in mind

These tables exist to buy time in a 110 minute class, not because data
preparation is unimportant. It is the step that most often blocks people on
their own projects, and reading a clean file teaches none of it.

So treat this folder as a lecture convenience only. Assignments and the final
project should still start from raw data, and `make_class_examples.R` is worth
reading as a worked example of the step it is saving you.

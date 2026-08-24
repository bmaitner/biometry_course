---

editor_options: 
  markdown: 
    wrap: 72
---

# Short links used in course materials

Several scripts load data over the network through `tinyurl.com` short links, so that students can type a short URL in class rather than a long one. The short links are managed in a TinyURL account and are **not** part of this repository, so changing where they point has to be done by signing in to TinyURL.

This file records what each short link should point to, and which scripts use it, so the mapping is documented in one place.

## Current short links

The original short links could not be repointed, so new ones were created against
`biometry_course` instead. **Use the new links** in anything going forward.

| Short link (use this) | Points to | Replaces |
|---|---|---|
| `https://tinyurl.com/avonetbirddata` | `.../biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds` | ~~`tinyurl.com/avonetdata`~~ |
| `https://tinyurl.com/amniotetraits` | `.../biometry_course/raw/refs/heads/main/data/Amniote_traits/Amniote_Database_Aug_2015.rds` | ~~`tinyurl.com/amniotes`~~ |
| `https://tinyurl.com/codesharingdataset` | `.../biometry_course/raw/refs/heads/main/data/Code_sharing/code_data.RDS` | ~~`tinyurl.com/codesharingdata`~~ |

All three were resolved and confirmed to land on `biometry_course`.

The old links still work. They serve the same static datasets from the old
repository, so a stale reference in an old file or a student's saved script is
harmless — these files do not change. Updating references is about keeping
everything pointed at one maintained repo, not about fixing broken behaviour.

## Where each short link is used

Scripts — **updated**, all 10 call sites now use the new links:

| Short link | Used in |
|---|---|
| `tinyurl.com/avonetbirddata` | `R_scripts/Lecture_07_examples.R:7`, `R_scripts/Lecture_08_examples.R:12`, `R_scripts/Lecture_25_examples.R:10`, `R_scripts/Chapter_7_examples.R:445`, `R_scripts/Chapter_9_examples.R:15` |
| `tinyurl.com/amniotetraits` | `R_scripts/Lecture_26_examples.R:6`, `:103`, `:120`, `:142` |
| `tinyurl.com/codesharingdataset` | `R_scripts/Chapter_9_examples.R:368` |

Slides — **still to do**. Because new links were created rather than the old ones
repointed, the decks need editing too. See
[../lectures/README.md](../lectures/README.md) for the affected slides.

Lecture 07 (tidyverse) opens by loading the Avonet data, so that deck matters first.

## Full data URLs already pointing here

These are written out in full in the scripts and were repointed from `Statistical_ecology_course` to `biometry_course` directly. No action needed; listed so the whole set of remote data references is documented together.

| File loaded | Used in |
|------------------------------------|------------------------------------|
| `data/Avonet/AVONET1_BirdLife.csv` | `R_scripts/Chapter_2_examples.R`, `R_scripts/Chapter_4_examples.R`, `assignments/assignment_3/assignment_3.R`, `example_R_commented/Example.R`, `example_R_markdown/Example.Rmd` |
| `data/Avonet/AVONET1_BirdLife.rds` | `R_scripts/Chapter_7_examples.R`, `assignments/assignment_3/assignment_3.R` |
| `data/Code_sharing/code_data.RDS` | `R_scripts/Chapter_9_examples.R` |
| `midterm/2a.RDS`, `2b.RDS`, `2c.RDS` | `midterm/midterm_example.R` |

All are of the form:

```         
https://github.com/bmaitner/biometry_course/raw/refs/heads/main/<path>
```

## Checking the links

To confirm every remote reference still resolves, from the project root:

``` sh
grep -rhoE 'https://(github\.com/bmaitner/biometry_course|tinyurl\.com)[^"]*' \
  --include=*.R --include=*.Rmd . | grep -v renv/ | sort -u | \
  while read u; do echo "$(curl -sL -o /dev/null -w '%{http_code}' "$u")  $u"; done
```

Anything other than `200` means a link needs attention.

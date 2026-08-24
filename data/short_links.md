# Short links used in course materials

Several scripts load data over the network through `tinyurl.com` short links, so
that students can type a short URL in class rather than a long one. The short
links are managed in a TinyURL account and are **not** part of this repository,
so changing where they point has to be done by signing in to TinyURL.

This file records what each short link should point to, and which scripts use
it, so the mapping is documented in one place.

## Short links to update

All three short links still resolve to the old `Statistical_ecology_course`
repository, which is a separate live repo rather than a redirect. They need to
be repointed at `biometry_course`.

Paste the **New target** value into TinyURL, then tick the box.

| Done | Short link | New target | Old target (current) |
|---|---|---|---|
| [ ] | `https://tinyurl.com/avonetdata` | `https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds` | `.../Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds` |
| [ ] | `https://tinyurl.com/amniotes` | `https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Amniote_traits/Amniote_Database_Aug_2015.rds` | `.../Statistical_ecology_course/raw/refs/heads/main/data/Amniote_traits/Amniote_Database_Aug_2015.rds` |
| [ ] | `https://tinyurl.com/codesharingdata` | `https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Code_sharing/code_data.RDS` | `.../Statistical_ecology_course/raw/refs/heads/main/data/Code_sharing/code_data.RDS` |

Each **New target** was checked and returns HTTP 200.

## Where each short link is used

| Short link | Used in |
|---|---|
| `tinyurl.com/avonetdata` | `R_scripts/Lecture_07_examples.R:7`, `R_scripts/Lecture_08_examples.R:12`, `R_scripts/Lecture_25_examples.R:10`, `R_scripts/Chapter_7_examples.R:445`, `R_scripts/Chapter_9_examples.R:15` |
| `tinyurl.com/amniotes` | `R_scripts/Lecture_26_examples.R:6`, `:103`, `:120`, `:142` |
| `tinyurl.com/codesharingdata` | `R_scripts/Chapter_9_examples.R:368` |

Lecture 07 (tidyverse) opens by loading `tinyurl.com/avonetdata`, so that one
matters first.

## Full data URLs already pointing here

These are written out in full in the scripts and were repointed from
`Statistical_ecology_course` to `biometry_course` directly. No action needed;
listed so the whole set of remote data references is documented together.

| File loaded | Used in |
|---|---|
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

```sh
grep -rhoE 'https://(github\.com/bmaitner/biometry_course|tinyurl\.com)[^"]*' \
  --include=*.R --include=*.Rmd . | grep -v renv/ | sort -u | \
  while read u; do echo "$(curl -sL -o /dev/null -w '%{http_code}' "$u")  $u"; done
```

Anything other than `200` means a link needs attention.

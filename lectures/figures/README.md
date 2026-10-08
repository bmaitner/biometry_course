# Figures used in the lecture decks

Two kinds of file live here: figures generated from course code, and
photographs obtained from outside the course. The difference matters for
licensing, so they are listed separately.

## Generated figures

These are produced by scripts in `R_scripts/` and can be rebuilt at any time.
They are our own work and carry no license restrictions beyond the repository's
own license.

| Files | Made by |
|---|---|
| `05_*.png` | `R_scripts/Lecture_05_figures.R` |
| `06_*.png` | `R_scripts/Lecture_06_figures.R` |
| `09_*.png` | `R_scripts/Lecture_09_figures.R` |

Regenerate by sourcing the script from the project root, for example
`source("R_scripts/Lecture_09_figures.R")`.

Figures inside the Quarto decks (`Lecture_*.qmd`) are not stored here at all.
They are drawn by code chunks at render time and embedded in the HTML, which is
why those decks have no image files to track.

## Photographs

Everything in this section was obtained from outside the course. **Record the
source and license here whenever a new one is added.**

| File | Subject | Source | Author | License | Retrieved |
|---|---|---|---|---|---|
| `northern_cardinal.jpg` | Male Northern Cardinal (*Cardinalis cardinalis*), used in Lecture 13 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Male_Northern_Cardinal_(41590411245).jpg) | U.S. Fish and Wildlife Service, Midwest Region | Public domain | 2026-10-06 |
| `northern_bobwhite.jpg` | Northern Bobwhite pair (*Colinus virginianus*), used in Lecture 14 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Colinus_virginianus_USFWS.jpg) | U.S. Fish and Wildlife Service Headquarters | Public domain | 2026-10-06 |

### Rules for adding images

1. **Prefer public domain or CC0.** US federal agency photographs, such as
   USFWS, NPS and NOAA, are usually public domain, and those agencies cover most
   organisms and habitats this course talks about. That avoids attribution and
   share-alike obligations entirely on a repository that is public.
2. **If a CC BY or CC BY-SA image is the only option**, credit the author and
   name the license on the slide itself, not only in this file. Note that
   share-alike terms can extend to the material the image is placed in, which is
   a reason to avoid it for teaching materials that are reused.
3. **Download the file into this folder, do not hot-link.** The decks are
   rendered with `embed-resources: true`, so a local file is baked into the HTML
   and the deck works with no network in the classroom. A remote link breaks
   when the host moves the file.
4. **Keep them small.** A width of about 960 pixels is plenty for a slide. The
   decks are already around 4 MB each.
5. **Add a row to the table above**, with the page the file came from rather
   than the direct image URL, so the license can be checked later.

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
| `06_01_*.png` to `06_06_*.png` | `R_scripts/Lecture_06_figures.R` (the Quarto deck now draws these itself; kept for the script) |
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
| `22_sponge_aggregation.jpg` | Dense sponge aggregation, Dive 9, Charlie-Gibbs Fracture Zone (Fig. 3g), used in Lecture 22 | [Keogh et al. 2022, *Marine Biodiversity* 52:55](https://doi.org/10.1007/s12526-022-01285-1) | Keogh, Command, Edinger, Georgiopoulou and Robert | CC BY 4.0 | 2026-11-04 |
| `22_substrates.jpg` | The five substrate types of the TOSCA ROV dives (Fig. 5a to e), used in Lecture 22 | as above | as above | CC BY 4.0 | 2026-11-04 |
| `22_glass_sponge.jpg` | Hexactinellida sp. (Fig. 3i), used in Lecture 22 | as above | as above | CC BY 4.0 | 2026-11-04 |
| `22_paragorgia.jpg` | *Paragorgia* sp. apparently attached to *Solenosmilia variabilis* (Fig. 3d), used in Lecture 22 | as above | as above | CC BY 4.0 | 2026-11-04 |
| `23_tree_swallow_flight.jpg` | Tree Swallow (*Tachycineta bicolor*) in flight, Oregon, used in Lecture 23 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Tree_Swallows,_Oregon_(204489371).jpg) | Derald Grimwood | CC0 | 2026-11-09 |
| `23_blue_jay_flight.jpg` | Blue Jay (*Cyanocitta cristata*) in flight, Stirling, Ontario, used in Lecture 23 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Blue_Jay_in_Flight_0566_(4511292119).jpg) | Robert Taylor | CC BY 2.0 | 2026-11-09 |
| `24_sctld_treatment.jpg` | A diver applying antibiotic paste to a coral with stony coral tissue loss disease, location not recorded, used in Lecture 24 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Scuba_diver_SCTLD_antibiotic_paste.png) | Joe Snyder/NOAA | Public domain | 2026-11-11 |
| `01_bolker_book_cover.jpg` | Cover of Bolker, *Ecological Models and Data in R* (Princeton University Press, 2008), the course text, used in Lecture 1 | Original Google Slides deck | Princeton University Press | Publisher's copyright; used as a book cover to identify the course text | 2026-11-18 |
| `01_r_popularity_ecology.png`, `01_lai_2019_title.png` | Percent of ecology articles reporting use of R, 2008 to 2017, and the article's title block, used in Lecture 1 | [Lai et al. 2019, *Ecosphere* 10: e02567](https://doi.org/10.1002/ecs2.2567) | Lai, Lortie, Muenchen, Yang and Ma | CC BY 4.0 | 2026-11-18 |
| `01_r_in_job_ads.png` | Percentage of PhD student and postdoc job ads mentioning R, 2006 to 2018, used in Lecture 1 | *Frontiers in Ecology and the Environment* 2020, 18(3): 123 to 124, as cited on the slide | as cited | Journal copyright; the author is a colleague | 2026-11-18 |
| `01_code_sharing_title.png`, `01_code_sharing_methods.png`, `01_code_sharing_table.png` | Title block and two page crops of the code-sharing paper, used in Lecture 1 | [Maitner et al. 2024, *Ecology and Evolution* 14: e70030](https://doi.org/10.1002/ece3.70030) | Maitner et al. | CC BY 4.0 | 2026-11-18 |
| `01_course_github_page.png`, `01_r_citations_repo.png` | Screenshots of this course's GitHub repository and of the `R_citations` repository, used in Lecture 1 | github.com/bmaitner | Brian Maitner | Our own repositories | 2026-11-18 |
| `02_holling_curve.png` | A Holling type II curve (prey eaten per predator against prey density), drawn in R, used in Lecture 2 | Original Google Slides deck | Brian Maitner | Our own work | 2026-11-18 |
| `02_r_console.png`, `02_rstudio*.png`, `02_github_*.png` | Screenshots of R, RStudio and GitHub, some with the slide's arrows and labels baked in, used in Lecture 2 | Original Google Slides deck | Brian Maitner | Our own screenshots | 2026-11-18 |
| `03_flowchart_1.png` to `03_flowchart_9.png`, `03_flowchart_walk.png` | The modeling process flowchart (after Bolker Figure 1.5), in the nine build stages of the original slides, used in Lecture 3 | Original Google Slides deck | Brian Maitner | Our own drawing | 2026-11-18 |
| `04_amphibians_xlsx.png` | Screenshot of the top of `data/European_amphibians/oo_32985.xlsx` open in Excel, showing the title rows above the real column names, used in Lecture 4 | Original Google Slides deck | Brian Maitner | Our own screenshot; the data are CC0 (Trochet et al. 2014) | 2026-11-18 |
| `05_rstudio_project_corner.png` | Screenshot of the top right of RStudio showing the open project (biometry_course), used in Lecture 5 | Original Google Slides deck | Brian Maitner | Our own screenshot | 2026-11-20 |
| `05_kerkhoff_enquist_2009.png` | Title block of Kerkhoff and Enquist (2009), "Multiplicative by nature", *Journal of Theoretical Biology* 257: 519 to 521, used in Lecture 5 | Original Google Slides deck | Elsevier | Journal copyright; cited on the slide | 2026-11-20 |
| `05_kiwi.jpg` | Te Tuatahi a nui, a male North Island brown kiwi (*Apteryx mantelli*) on Maungatautari, used in Lecture 5 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:TeTuatahianui.jpg) | Maungatautari Ecological Island Trust | Public domain (released by the author) | 2026-11-20 |
| `05_cassowary.jpg` | Southern cassowary (*Casuarius casuarius*) at Kyiv Zoo, used in Lecture 5 | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Casuarius_casuarius_2.jpg) | DoroshenkoE | Public domain (released by the author) | 2026-11-20 |
| `06_data_sources.png` | Six screenshots of the sources behind the `data/` folders, arranged in one image: Cannicci et al. 2021 (*PNAS*, mangrove invertebrates), Pesant et al. 2015 (*Scientific Data*, Tara Oceans), Keogh 2022 (PANGAEA, Charlie-Gibbs megabenthos), Sauer et al. 2020 (USGS, North American Breeding Bird Survey), NOAA's National Coral Reef Monitoring Program, and Abernathy et al. (Dryad, deer movement), used in Lecture 6 | Original Google Slides deck | the publishers and agencies named | Screenshots of title blocks and landing pages; each shows its own citation | 2026-11-21 |
| `06_great_egret.jpg` | Great egret (*Ardea alba*) in flight at Federsee, Germany, for the herons (Ardeidae), used in Lecture 6 (Comparing groups) | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Great_egret_(great_egret_(Ardea_alba)_at_Federsee,_Germany)_at_Federsee.jpg) | Hobbyfotowiki | CC0 | 2026-11-21 |
| `06_shoebill.jpg` | Shoebill (*Balaeniceps rex*), for Balaenicipitidae, used in Lecture 6 (Comparing groups) | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Schuhschnabel_(Balaeniceps_rex).jpg) | Bildflut | CC0 | 2026-11-21 |
| `06_brown_pelican.jpg` | Juvenile brown pelican (*Pelecanus occidentalis*) in flight, Costa Rica, for Pelecanidae, used in Lecture 6 (Comparing groups) | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Brown_pelican_(Pelecanus_occidentalis),_Costa_Rica.jpg) | Hobbyfotowiki | CC0 | 2026-11-21 |
| `06_hamerkop.jpg` | Two hamerkops (*Scopus umbretta*), Lake Baringo, Kenya, for Scopidae, used in Lecture 6 (Comparing groups) | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Hamerkop_(Scopus_umbretta),_Kenya.jpg) | Hobbyfotowiki | CC0 | 2026-11-21 |
| `06_roseate_spoonbill.jpg` | Roseate spoonbill (*Platalea ajaja*), San Blas, Nayarit, Mexico, for the ibises and spoonbills (Threskiornithidae), used in Lecture 6 (Comparing groups) | [Wikimedia Commons](https://commons.wikimedia.org/wiki/File:Roseate_Spoonbill_(Platalea_ajaja)_(8079374345).jpg) | Ron Knight | CC BY 2.0 | 2026-11-21 |

The Lecture 1 images were taken from the 2025 Google Slides deck when it was
converted to Quarto (2026-11-18), with the crops it used. The job-ads figure is
from a journal that is not open access; its author is a colleague.

The two Lecture 23 photos are cropped to matching frames around the spread
wings. The Blue Jay is CC BY, so the slide credits the photographer and names
the license; no public domain photo of a rounded-winged songbird in flight was
found on Commons.

The Lecture 24 photo is resized from a 1153-pixel PNG and saved as JPEG. Commons
does not record where it was taken, so the slide describes the treatment and
does not claim it shows the Dry Tortugas.

The four Lecture 22 images are cropped from the paper's figures, with the panel
letters removed and the authors' identifications added as labels. They are the
same ROV dives as the `tosca_rov` dataset, which is why they were used over
public domain alternatives: no public domain imagery exists from this site. The
slides credit them, and the substrates slide carries the full citation and
license link.

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

# Bean beetle (Bruchinae, formerly Bruchidae) competition experiments

Single-generation competition experiments among eight species of seed beetle,
run by Brian Maitner between 2011 and 2013. Each replicate is one petri dish
holding a known number of beetles of one or two species on a fixed amount of
food, scored by counting the next generation of adults as they emerged. Every
row is therefore an N(t) to N(t+1) transition at a known starting density,
which is what makes the data useful for fitting discrete-time competition
models.

The data have not been published or analyzed.

**License:** CC-BY 4.0. Please credit Brian Maitner.

## Files

The main experiment:

| File | Rows | What it holds |
| :--- | ---: | :--- |
| `competition_interspecific.csv` | 1361 | Two-species replicates, 22 species pairs |
| `competition_monoculture.csv`   |  264 | Single-species replicates, all 8 species |
| `species.csv`                   |    8 | Species codes and scientific names |

Four smaller side experiments from the same period, each sparse:

| File | Rows | What it holds |
| :--- | ---: | :--- |
| `emergence_times.csv`           |   50 | Egg-to-emergence time, 6 species |
| `host_suitability.csv`          |   61 | One species on each of 7 bean types (58 scored) |
| `mung_bean_monoculture.csv`     |   11 | Monoculture on mung beans instead of cowpea |
| `bean_beetle_ratio.csv`         |   10 | Monoculture at 1 g of beans instead of 2 g |
| `hybridization_screening.csv`   |   27 | Single-pair mating crosses (7 scored) |

Plus `build_beetle_competition.R`, which rebuilds all eight tables, and `raw/`,
holding the original spreadsheets unmodified.

Rebuild from the project root with:

```bash
Rscript data/Beetle_competition/build_beetle_competition.R
```

## The one thing to know before fitting anything

The density columns in the original datasheets count **males plus females**, at
a 50:50 sex ratio, in the dish where the beetles were left to mate for two
days. Only the **females** were then moved into the dish with the beans. So a
treatment labeled 20 is ten ovipositing females, not twenty beetles.

Both numbers are kept. `start_nominal_*` is the treatment label as written on
the datasheet; `start_females_*` is half of it, and is the density that
actually experienced competition. Use `start_females_*` as the initial
population size. The same rule holds for the monocultures, whose master
workbook records it as "put males and females at exp. Densities for 2 days /
after 2 days put females into ovip. Chamber".

## Methods

From `raw/Beetle_Protocols.docx`, written by Brian Maitner for the
undergraduates who ran the experiment.

Stock populations were kept on black-eyed peas (cowpea, *Vigna unguiculata*).
Rearing dishes were started from stock populations every day or two, checked
for eggs, and set aside so that emergence date, and therefore adult age, was
known. Emerged adults were cooled in a refrigerator before handling, sorted by
sex under a dissecting scope, and held in single-sex dishes.

Each replicate was set up in two stages. First, the full treatment number of
beetles of each species, at a 50:50 sex ratio, went into its own bean-free
petri dish and was left for two days, so that every female mated with a
conspecific male. Hybridization between several of these species was a real
concern, which is why mating was kept separate from competition. Second, the
mated females of both species, and only the females, were transferred together
into a square petri dish containing **2 g of black-eyed peas**, which was taped
shut and held in a growth chamber. No more than one replicate of the same
treatment was set up on a given day.

Parental adults were removed once they had died or once the beans began to show
"windows" where larvae had thinned the seed coat, which happens shortly before
emergence. Replicates were ended once the emerged progeny had died, frozen for
at least two days, and counted later. Most species emerge in three to four
weeks; *C. analis* and *A. obtectus* take longer, so for replicates involving
them the faster species was sometimes removed and frozen at six weeks and the
slower one given until two months, after which a non-emergence was recorded as
a zero.

Counts are of **emerged** adults only. Beetles still inside beans were not
counted, which is what the two `_Stuck` columns in the raw sheets were meant to
capture; the metadata marks those columns "ignore this" and they are empty
throughout. Both sexes were counted separately, so each species has a total and
a female count.

Temperature and humidity were not recorded in any of these files.

## Design

Per species pair: 23 density combinations, 3 replicates each, 69 replicates.
The grid is a fan rather than a full factorial. With species 1 and species 2 in
the order given by the file name, the combinations are

- species 2 held at 4, species 1 at 4, 8, 12, 20, 30, 40
- species 1 held at 4, species 2 at 4, 8, 12, 20, 30, 40
- the interior block, species 1 and species 2 each at 8, 12, 20
- three corners: (40, 20), (20, 40), (40, 40)

all in nominal units, so halve them for females. A few pairs carry extra
replicates beyond the third, which is why counts per pair run from 1 to 90.

Monocultures were run separately, at nominal densities 2, 4, 8, 12, 16, 20, 30,
40 and 60. Replication is uneven: three replicates for most species-by-density
combinations, four to eight for about a fifth of them. They cover
a wider density range than the interspecific grid, which makes them the better
data for estimating each species' intraspecific competition and density-
dependent fecundity.

## Coverage

22 of the 28 pairs that were laid out have at least some data. All eight
species appear.

| Pair | n | Pair | n | Pair | n |
| :--- | ---: | :--- | ---: | :--- | ---: |
| Cmac_Csub | 90 | Cchi_Aobt | 69 | Crho_Cpha | 69 |
| Cmac_Crho | 82 | Cchi_Cpha | 69 | Csub_Cpha | 69 |
| Cmac_Zsub | 74 | Cmac_Aobt | 69 | Zsub_Cpha | 69 |
| Cchi_Zsub | 72 | Cmac_Cpha | 69 | Csub_Zsub | 68 |
| Cchi_Crho | 71 | Crho_Aobt | 69 | Crho_Csub | 67 |
| Cchi_Csub | 70 | Aobt_Csub | 38 | Aobt_Zsub | 31 |
| Cmac_Cchi | 70 | Zsub_Cana | 5  | Cana_Cpha | 1  |
| Crho_Zsub | 70 |           |    |           |    |

Six datasheets are empty templates, so those pairs were planned and never run:
`Aobt_Cana`, `Aobt_Cpha`, `Cchi_Cana`, `Cmac_Cana`, `Crho_Cana`, `Csub_Cana`.
*C. analis* was almost entirely dropped: it has 6 interspecific replicates in
total, though its monocultures were completed.

Monoculture replicates per species: Aobt 35, Cana 30, Cchi 30, Cmac 30,
Cpha 30, Crho 36, Csub 41, Zsub 32.

## Columns

### `competition_interspecific.csv`

| Column | Description |
| :--- | :--- |
| `pair` | Pair identifier, `<species_1>_<species_2>`, from the datasheet file name |
| `species_1`, `species_2` | Four-letter codes; join to `species.csv` |
| `start_nominal_1`, `start_nominal_2` | Treatment label: males plus females put together to mate |
| `start_females_1`, `start_females_2` | Females actually placed on the beans; half the nominal value. **Use these as the initial density.** |
| `replicate` | Replicate number within pair and treatment, 1-based |
| `replicate_recorded` | The Rep value written on the datasheet; blank on 5 rows and repeated on some others, which is why `replicate` exists |
| `progeny_1`, `progeny_2` | Emerged adult progeny of each species |
| `progeny_females_1`, `progeny_females_2` | Female progeny of each species |
| `source_row` | Row number in the original sheet, for tracing a value back |

### `competition_monoculture.csv`

| Column | Description |
| :--- | :--- |
| `species_code` | Four-letter code |
| `start_nominal`, `start_females` | As above |
| `replicate`, `replicate_recorded` | As above |
| `progeny`, `progeny_females` | Emerged adult progeny, and the female subset |
| `date_start` | Date the females went onto the beans, where recorded (89 of 264 rows) |
| `date_adults_removed` | Date the parental females were removed, where recorded |
| `source_sheet`, `source_row` | Location in the master workbook |

### `species.csv`

`species_code`, `genus`, `epithet`, `scientific_name`, `authority`, `family`,
`subfamily`. Join on `species_code` from any of the other tables.

These beetles are called bruchids throughout the original paperwork and sat in
their own family, Bruchidae, when the experiment was run. Bruchidae is now
treated as the subfamily **Bruchinae** within **Chrysomelidae**, so all eight
species are Chrysomelidae today. A student looking one of them up will find the
newer placement, which is why both names are in the table and in the title of
this file.

Authorities were checked against the GBIF backbone in October 2026. Two are not
simply what GBIF returned:

- *Zabrotes subfasciatus* is recorded here as **(Boheman, 1833)**. The GBIF
  backbone prints "Bohemann" with a double n, but the entomologist is Carl
  Henrik Boheman and GBIF's own source checklists use the single-n spelling.
- *Callosobruchus subinnotatus* is recorded as **(Pic)** with no year. GBIF
  carries no authority at all for this species, and no year was found in
  Catalogue of Life or the other checklists reachable from it. The literature
  cites it as "(Pic)", so that is what is given rather than a guessed year.

The parentheses on all eight mean the species was first described in a
different genus. *Acanthoscelides obtectus*, for instance, is Say's *Bruchus
obtectus* of 1831.

## The side experiments

All four are pilots: they were run to settle a methods question or to scope out
the host range, and most of the planned replicates were never set up. Treat
them as small, uneven and useful for their own questions rather than as part of
the competition data set.

### `emergence_times.csv`

Egg-to-emergence time, from the date eggs were laid to the date the first adult
emerged. `species_code`, `date_oviposited`, `date_first_emergence`,
`days_to_emergence`. 50 observations between 2012-01-09 and 2012-09-06. The
build script checks that the recorded day count equals the difference between
the two dates for every row, which is the only internal consistency check
available anywhere in these data.

| Species | n | Days (min-median-max) |
| :--- | ---: | :--- |
| Aobt | 13 | 37 - 39 - 42 |
| Cchi | 17 | 22 - 23 - 28 |
| Cmac | 15 | 21 - 22 - 24 |
| Crho |  3 | 21 - 23 - 26 |
| Cana |  1 | 31 |
| Csub |  1 | 31 |

This confirms the protocol's warning that *A. obtectus* and *C. analis* take
substantially longer than the rest, which matters for any pair involving them:
the slower species had up to two months to emerge while the faster one was
scored and removed at six weeks. *C. analis* and *C. subinnotatus* rest on a
single observation each, and *C. phaseoli* and *Z. subfasciatus* were never
measured.

### `host_suitability.csv`

Two beetles of one species on 2 g of a single bean type, scored for emerged
progeny. Eight bean types were laid out; seven were started. Columns:
`species_code`, `bean`, `bean_mass_g`, `replicate`, `start_beetles`,
`date_start`, `date_adults_removed`, `adults_removed_marked_x`, `progeny`,
`progeny_stuck_in_bean`, `progeny_females`, `notes`.

`start_beetles` is 2 in every row. The sheet heads that column "# sp (t)" and,
unlike the main experiment, says nothing about sex ratio, so it is **not**
halved here and it is not safe to assume it means two females.

`adults_removed_marked_x` is `TRUE` where that cell held an "x" rather than a
date (24 rows). The sheets do not make clear whether that meant removed on an
unrecorded date or never removed.

Highest progeny count per species and bean, with blank meaning the combination
was started but never scored, or never started:

| | adzuki | cowpea | garbanzo | great northern | mung | pinto | soy |
| :--- | ---: | ---: | ---: | ---: | ---: | ---: | ---: |
| Aobt | 0  | 4  | 4 | 5 | 0  | 5 | 0 |
| Cchi | 13 | 61 | 8 | 0 |    | 0 | 0 |
| Cmac | 25 |    | 2 | 0 | 31 | 0 | 0 |
| Crho |    |    | 0 | 0 |    | 0 | 0 |
| Csub |    | 35 |   |   | 8  |   | 0 |

44 of the 58 scored replicates produced zero adults, so most of the signal is
in whether anything emerged at all. The pattern splits along host genus: the
*Callosobruchus* species do well on the small *Vigna* seeds (cowpea, mung,
adzuki) and produce nothing on soy, pinto or great northern, while
*A. obtectus*, a *Phaseolus* specialist, does the reverse. Seven replicates
carry notes, several recording that eggs were laid and larvae entered the seed
but failed to develop, which is a different kind of zero from no oviposition at
all.

Pigeon pea was laid out for every species and never started. 30 further
*C. maculatus* cells in the earlier January 2012 version of this workbook read
"see Nicole's data": those results were held by a collaborator and are not in
this Drive account.

### `mung_bean_monoculture.csv`

Monoculture on mung beans rather than black-eyed peas, same layout and density
ladder as the monoculture master. 11 replicates, 10 of them *C. subinnotatus*
and 1 *C. maculatus*; the *A. obtectus* sheet was laid out and never run. Two
replicates have female counts but no total. Columns as in
`competition_monoculture.csv`, plus `progeny_stuck_in_bean`.

Because the layout and densities match the master exactly, `start_females` is
derived the same way, but note this workbook has no notes sheet of its own
stating the convention.

### `bean_beetle_ratio.csv`

The same kind of monoculture run on **1 g** of beans instead of 2 g, with
density written per gram. `beetles_per_g_beans` runs 2, 4, 6, 10, 20, which is
the same per-gram range the main experiment covers with 4 to 40 beetles in 2 g.
10 replicates, 7 *C. maculatus* and 3 *C. subinnotatus*. Column A is headed
"Beetles/g beans", so this is a count of beetles and is not halved. Useful for
asking whether competition scales with beetles per gram of resource or with
absolute numbers, though with 10 replicates the answer will be weak.

### `hybridization_screening.csv`

One virgin female with one male, in a small dish with 3 black-eyed peas, to
test whether a pair of species could produce offspring. `female_species`,
`male_species`, `cross_type` (`conspecific` or `interspecific`), `replicate`,
`offspring`. Only 3 of the 9 crosses were ever scored, 7 cells in all. Note
that one *C. subinnotatus* female with a *C. maculatus* male produced 17
offspring, and a replicate of the same cross produced 0. That is the concern
the two-day conspecific mating step in the main protocol was designed around.

## Known problems

Real features of the data, not artifacts of processing. Nothing here has been
silently corrected.

1. **No dates for the interspecific replicates.** The datasheets have columns
   for start date, end date and the date parental adults were removed, and all
   three are empty in all 28 files. The protocol says they were written in a
   paper log book. So generation length cannot be recovered for these rows, and
   there is no way to order replicates in time. The monocultures do have some
   dates (89 of 264, between 2011-09-15 and 2012-07-12).

2. **34 replicates have female counts but no totals.** In `Cmac_Crho` (10),
   `Cmac_Csub` (20) and `Crho_Csub` (4), both species' female counts were
   entered and neither total was. `progeny_1` and `progeny_2` are `NA` there,
   and the female count is a lower bound on the total. 12 monoculture
   replicates, all *C. subinnotatus*, have the same gap.

3. **One replicate is missing a single count.** In `Cmac_Aobt`, the
   *A. obtectus* total at nominal 20 x 8 is blank. This is the gap the original
   `versions_notes.xlsx` flagged as "check physical data for cmac_v_aobt". It is
   the only row where exactly one species' total is missing.

4. **One internal contradiction.** In `Cmac_Cchi` at nominal 30 x 4, replicate
   1, the *C. chinensis* total is 0 but its female count is 1. One of the two
   cells is wrong and there is no way to tell which. Both are left as recorded.

5. **Zeros are real.** A 0 means the species produced no emerged adults, which
   happens often at high competitor density and is the biologically interesting
   outcome. Missing values are blank, never 0. Do not fill blanks with zeros.

6. **Unequal replication.** Pairs range from 1 to 90 replicates, and the
   `Aobt_Zsub`, `Aobt_Csub`, `Zsub_Cana` and `Cana_Cpha` sheets are partly
   filled, with gaps scattered through the grid rather than at one end of it.

## Using these data

Each dish is a single transition, not a time series: one parental generation in,
one filial generation out. That suits the discrete-time competition models,
where the progeny of species 1 are written as a declining function of both
species' starting densities, for example the Leslie-Gower / Beverton-Holt form

```
N1(t+1) = lambda1 * N1(t) / (1 + alpha11 * N1(t) + alpha12 * N2(t))
```

with `N` in females. Fitting this per pair gives intraspecific and
interspecific competition coefficients, and the ratios among them predict which
species should exclude which. Counts with many zeros and variance that grows
with the mean also make this a natural setting for Poisson and negative
binomial likelihoods, and for comparing them.

Two cautions:

- **Do not pool the two tables naively.** The monoculture replicates are a
  separate experiment, held in `competition_monoculture.csv` precisely so they
  are counted once. The 2013 merge in `raw/competition_dataset_8_7.csv` copied
  each species' monoculture block into every pair file that used that species,
  so in that file *C. chinensis*' 30 monoculture rows appear five times over.
  Fitting from it weights those rows five-fold.
- **The data are wide by position within a pair, not by species.** `species_1`
  is whichever species came first in the file name, so the same species is
  sometimes in position 1 and sometimes in position 2. To fit one model across
  all species, reshape to one row per species per dish, with a focal density
  and a competitor density.

## Provenance

The interspecific replicates come from 28 per-pair datasheets, which are the
authoritative record and are reproduced in `raw/datasheets/`. The monoculture
replicates come from the eight single-species sheets in
`raw/Beetle_competition_discrete_mating.xlsx`.

`raw/competition_dataset_8_7.csv` is a merge made in August 2013 covering 13 of
the pairs. It is kept for reference but is not used, because it dropped the
replicate numbers and all female counts, and because it duplicated the
monoculture rows as described above. Where the two overlap they agree exactly:
the build script checks all 193 comparable monoculture values and stops if any
differ. The merge omitted *C. subinnotatus* entirely, even though five of its
six pairs were finished, and omitted the partly filled `Aobt_Zsub`. Rebuilding
from the datasheets recovers 1361 interspecific replicates against the merge's
912, and 8 species against 6.

`raw/Bruchid_competition_data.xlsx` and
`raw/Bruchid_competition_data_2011-09-18.xlsx` are 2011-2012 pilot and
methods-development workbooks. Only their hybridization screening is extracted
here; the rest is kept for reference. `raw/blank_template.xlsx` is the empty
datasheet, and `raw/versions_notes.xlsx` is the change log for the 2013 merge.

The species codes, the column meanings and the 50:50 sex ratio come from
`raw/Datasheet_Metadata.docx`, and the husbandry and experimental procedure from
`raw/Beetle_Protocols.docx`. Both sat outside the data folder, alongside a copy
of the datasheets, and together are the only written documentation of the
experiment.

The four side experiments come from `raw/beetle_emergence_times.xlsx`,
`raw/bruchids_on_alternate_beans.xlsx`, `raw/bruchids_mung_beans_discrete.xlsx`
and `raw/bruchid_bean_beetle_ratio.xlsx`.
`raw/bruchids_on_alternate_beans_discrete.xlsx` is the January 2012 version of
the host suitability workbook, kept for reference but not used: every number in
it also appears in the May 2012 version, and its only extra content is the 30
"see Nicole's data" placeholders.

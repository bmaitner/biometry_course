# Build the tidy bean beetle competition data sets from the original datasheets.
#
# Run from the project root:
#
#   Rscript data/Beetle_competition/build_beetle_competition.R
#
# Requires readxl, dplyr and tidyr (all in renv.lock).
#
# Inputs, all under raw/ -- see README.md for where each one came from:
#
#   raw/datasheets/<Sp1>_<Sp2>.xlsx            28 interspecific datasheets
#   raw/Beetle_competition_discrete_mating.xlsx  monoculture master (8 species)
#   raw/Bruchid_competition_data.xlsx            2012 pilot, hybridization sheet
#
# Outputs, written next to this script:
#
#   competition_interspecific.csv
#   competition_monoculture.csv
#   species.csv
#   hybridization_screening.csv
#
# Two things about the raw sheets drive most of the code below.
#
# First, the datasheets share a 14-column template but not its header text:
# some say "C. chin" where others say "Cchi", and two say "F(mac)" instead of
# "F(Cmac)". Columns are therefore read by position for the pair sheets, with
# the species taken from the file name, and by matching the header text for the
# monoculture sheets, whose layout does shift between species.
#
# Second, the monoculture rows in the pair datasheets are always blank -- the
# metadata says those replicates were "recorded elsewhere". They live in the
# monoculture master instead, which is why there are two output tables rather
# than one.

suppressMessages({
  library(readxl)
  library(dplyr)
  library(tidyr)
})

here <- function(...) file.path("data", "Beetle_competition", ...)
if (!dir.exists(here("raw"))) {
  stop("run this from the project root, so that data/Beetle_competition/raw exists")
}

num <- function(x) suppressWarnings(as.numeric(x))

xldate <- function(x) {
  v <- num(x)
  as.Date(ifelse(!is.na(v) & v > 20000 & v < 60000, v, NA), origin = "1899-12-30")
}

# ---- species -----------------------------------------------------------------
# Codes and names are from Datasheet_Metadata.docx, and all eight are current.
# Acanthoscelides obtectus (Say, 1831) is the accepted name; Bruchus obtectus
# Say is the original combination, and Mylabris obtectus another synonym.
#
# These beetles are called bruchids throughout the protocol doc and sat in
# their own family, Bruchidae, when the experiment was run. Bruchidae is now
# treated as the subfamily Bruchinae within Chrysomelidae, so all eight species
# are Chrysomelidae today.

# Authorities were checked against the GBIF backbone in October 2026, with two
# departures from what it returned:
#
#   Zabrotes subfasciatus -- the GBIF backbone prints "(Bohemann, 1833)", but
#     the name is Carl Henrik Boheman and GBIF's own source checklists give
#     "(Boheman, 1833)", so the single-n spelling is used here.
#   Callosobruchus subinnotatus -- GBIF carries no authority for this species,
#     and neither Catalogue of Life nor the other checklists reachable from it
#     supply a year. The literature cites it as "(Pic)", so that is recorded
#     without a year rather than guessing one.
#
# Parentheses mean the species was first described in a different genus, which
# is true of all eight.

species <- tibble::tribble(
  ~species_code, ~genus,            ~epithet,       ~scientific_name,              ~authority,            ~family,         ~subfamily,
  "Aobt",        "Acanthoscelides", "obtectus",     "Acanthoscelides obtectus",    "(Say, 1831)",         "Chrysomelidae", "Bruchinae",
  "Cana",        "Callosobruchus",  "analis",       "Callosobruchus analis",       "(Fabricius, 1781)",   "Chrysomelidae", "Bruchinae",
  "Cchi",        "Callosobruchus",  "chinensis",    "Callosobruchus chinensis",    "(Linnaeus, 1758)",    "Chrysomelidae", "Bruchinae",
  "Cmac",        "Callosobruchus",  "maculatus",    "Callosobruchus maculatus",    "(Fabricius, 1775)",   "Chrysomelidae", "Bruchinae",
  "Cpha",        "Callosobruchus",  "phaseoli",     "Callosobruchus phaseoli",     "(Gyllenhal, 1833)",   "Chrysomelidae", "Bruchinae",
  "Crho",        "Callosobruchus",  "rhodesianus",  "Callosobruchus rhodesianus",  "(Pic, 1902)",         "Chrysomelidae", "Bruchinae",
  "Csub",        "Callosobruchus",  "subinnotatus", "Callosobruchus subinnotatus", "(Pic)",               "Chrysomelidae", "Bruchinae",
  "Zsub",        "Zabrotes",        "subfasciatus", "Zabrotes subfasciatus",       "(Boheman, 1833)",     "Chrysomelidae", "Bruchinae"
)

# ---- interspecific replicates ------------------------------------------------

read_pair <- function(path) {
  pair  <- tools::file_path_sans_ext(basename(path))
  codes <- strsplit(pair, "_", fixed = TRUE)[[1]]

  raw <- suppressMessages(
    read_excel(path, sheet = 1, col_names = FALSE, col_types = "text")
  )[-1, ]

  tibble::tibble(
    pair               = pair,
    species_1          = codes[1],
    species_2          = codes[2],
    start_nominal_1    = num(raw[[1]]),
    start_nominal_2    = num(raw[[2]]),
    replicate_recorded = num(raw[[3]]),
    progeny_1          = num(raw[[7]]),
    progeny_2          = num(raw[[8]]),
    progeny_females_1  = num(raw[[13]]),
    progeny_females_2  = num(raw[[14]]),
    source_row         = seq_len(nrow(raw)) + 1L
  )
}

interspecific <-
  list.files(here("raw", "datasheets"), pattern = "[.]xlsx$", full.names = TRUE) |>
  lapply(read_pair) |>
  bind_rows() |>
  # Both species must have been stocked, and at least one count recorded. Rows
  # that fail the second test are treatments that were laid out but never run.
  filter(
    !is.na(start_nominal_1), !is.na(start_nominal_2),
    start_nominal_1 > 0, start_nominal_2 > 0,
    !is.na(progeny_1) | !is.na(progeny_2) |
      !is.na(progeny_females_1) | !is.na(progeny_females_2)
  ) |>
  arrange(pair, start_nominal_1, start_nominal_2, source_row) |>
  # The recorded Rep is kept, but it is blank on five rows and repeats an
  # earlier value on others, so the key is renumbered within treatment.
  group_by(pair, start_nominal_1, start_nominal_2) |>
  mutate(replicate = row_number()) |>
  ungroup() |>
  mutate(
    start_females_1 = start_nominal_1 / 2,
    start_females_2 = start_nominal_2 / 2
  ) |>
  select(
    pair, species_1, species_2,
    start_nominal_1, start_nominal_2,
    start_females_1, start_females_2,
    replicate, replicate_recorded,
    progeny_1, progeny_2,
    progeny_females_1, progeny_females_2,
    source_row
  )

stopifnot(all(c(interspecific$species_1, interspecific$species_2) %in%
                species$species_code))

# ---- monoculture replicates --------------------------------------------------

mono_master  <- here("raw", "Beetle_competition_discrete_mating.xlsx")
sheet_to_code <- c(
  "A. obt"  = "Aobt", "C. ana"  = "Cana", "C. chin" = "Cchi", "C.mac"  = "Cmac",
  "C.phas"  = "Cpha", "C. rhod" = "Crho", "C.sub"   = "Csub", "Z. sub" = "Zsub"
)

find_col <- function(header, pattern) {
  hit <- grep(pattern, header, ignore.case = TRUE, perl = TRUE)
  if (length(hit) == 0) NA_integer_ else hit[1]
}

read_mono <- function(sheet) {
  x      <- suppressMessages(
    read_excel(mono_master, sheet = sheet, col_names = FALSE, col_types = "text")
  )
  header <- ifelse(is.na(unlist(x[1, ])), "", unlist(x[1, ]))
  body   <- x[-1, ]

  i_prog  <- find_col(header, "^Sp\\s*1\\s*\\(t\\+1\\)")
  i_fem   <- find_col(header, "^Females$")
  i_rep   <- find_col(header, "^Rep$")
  i_start <- find_col(header, "^Starting date")
  i_rm    <- find_col(header, "^Adults removed")
  stopifnot(!is.na(i_prog), !is.na(i_fem), !is.na(i_rep))

  tibble::tibble(
    species_code        = unname(sheet_to_code[[sheet]]),
    start_nominal       = num(body[[1]]),
    replicate_recorded  = num(body[[i_rep]]),
    progeny             = num(body[[i_prog]]),
    progeny_females     = num(body[[i_fem]]),
    date_start          = if (is.na(i_start)) as.Date(NA) else xldate(body[[i_start]]),
    date_adults_removed = if (is.na(i_rm))    as.Date(NA) else xldate(body[[i_rm]]),
    source_sheet        = sheet,
    source_row          = seq_len(nrow(body)) + 1L
  )
}

monoculture <- lapply(names(sheet_to_code), read_mono) |>
  bind_rows() |>
  filter(
    !is.na(start_nominal), start_nominal > 0,
    !is.na(progeny) | !is.na(progeny_females)
  ) |>
  arrange(species_code, start_nominal, source_row) |>
  group_by(species_code, start_nominal) |>
  mutate(replicate = row_number()) |>
  ungroup() |>
  mutate(start_females = start_nominal / 2) |>
  select(
    species_code, start_nominal, start_females,
    replicate, replicate_recorded,
    progeny, progeny_females,
    date_start, date_adults_removed,
    source_sheet, source_row
  )

# The 2013 merge copied one monoculture block per species into every pair file
# that used that species. Those copies are the only published version of these
# numbers, so they are checked against the master here rather than being used.
merge_mono <- read.csv(here("raw", "competition_dataset_8_7.csv")) |>
  mutate(r = row_number()) |>
  filter((sp1t > 0 & sp2t == 0) | (sp1t == 0 & sp2t > 0)) |>
  mutate(
    species_code  = toupper(substr(ifelse(sp1t > 0, sp1, sp2), 1, 1)),
    species_code  = paste0(species_code,
                           substr(ifelse(sp1t > 0, sp1, sp2), 2, 4)),
    start_nominal = ifelse(sp1t > 0, sp1t, sp2t),
    progeny_merge = ifelse(sp1t > 0, sp1_t1, sp2_t1),
    pair          = paste(sp1, sp2, sep = "_")
  ) |>
  group_by(species_code) |>
  filter(pair == min(pair)) |>
  arrange(species_code, start_nominal, r) |>
  group_by(species_code, start_nominal) |>
  mutate(replicate = row_number()) |>
  ungroup() |>
  select(species_code, start_nominal, replicate, progeny_merge)

check <- inner_join(merge_mono, monoculture,
                    by = c("species_code", "start_nominal", "replicate"))
stopifnot(nrow(check) == nrow(merge_mono))
stopifnot(all(check$progeny_merge == check$progeny, na.rm = TRUE))

# ---- hybridization screening -------------------------------------------------

pilot <- here("raw", "Bruchid_competition_data.xlsx")
hx    <- suppressMessages(
  read_excel(pilot, sheet = "Hybridization screenings",
             col_names = FALSE, col_types = "text")
)
hx_code <- c("C. maculatus" = "Cmac", "C. subinnotatus" = "Csub",
             "A. obtectus"  = "Aobt")
hx_body <- hx[(which(!is.na(hx[[1]]) & hx[[1]] == "Female") + 1):nrow(hx), ]

hybridization <- tibble::tibble(
  female_species = unname(hx_code[trimws(hx_body[[1]])]),
  male_species   = unname(hx_code[trimws(hx_body[[2]])]),
  rep_1 = num(hx_body[[3]]),
  rep_2 = num(hx_body[[4]]),
  rep_3 = num(hx_body[[5]])
) |>
  filter(!is.na(female_species), !is.na(male_species)) |>
  pivot_longer(starts_with("rep_"), names_to = "replicate",
               names_prefix = "rep_", values_to = "offspring") |>
  mutate(
    replicate  = as.integer(replicate),
    cross_type = ifelse(female_species == male_species,
                        "conspecific", "interspecific")
  ) |>
  select(female_species, male_species, cross_type, replicate, offspring)

# ---- side experiments --------------------------------------------------------
# Four smaller experiments from the same period. All are sparse: they were run
# to settle methods questions or to scope out the host range, and most of the
# planned replicates were never set up. Zeros in them are real and informative,
# especially in the host suitability trial.

norm_sp <- function(x) {
  key <- gsub("[^a-z]", "", tolower(trimws(x)))
  map <- c(aobt = "Aobt", cana = "Cana", cchin = "Cchi", cchi = "Cchi",
           cmac = "Cmac", cphas = "Cpha", crhod = "Crho", csub = "Csub",
           zsub = "Zsub")
  unname(map[key])
}

# Egg-to-emergence time by species. The sheet records the date eggs were laid,
# the date the first adult emerged, and the difference in days.
em_raw <- suppressMessages(
  read_excel(here("raw", "beetle_emergence_times.xlsx"), sheet = 1,
             col_names = FALSE, col_types = "text")
)[-1, ]

emergence_times <- tibble::tibble(
  species_code         = norm_sp(em_raw[[1]]),
  date_oviposited      = xldate(em_raw[[2]]),
  date_first_emergence = xldate(em_raw[[3]]),
  days_to_emergence    = num(em_raw[[4]])
) |>
  filter(!is.na(species_code), !is.na(days_to_emergence))

# The recorded day count should be the difference between the two dates; this
# is the one internal consistency check available anywhere in these data.
stopifnot(all(
  as.integer(emergence_times$date_first_emergence -
               emergence_times$date_oviposited) ==
    emergence_times$days_to_emergence
))

# Host suitability: two beetles of one species on 2 g of each of eight bean
# types. The column is headed "# sp (t)" and reads 2 in every row; unlike the
# main experiment, nothing in this workbook says whether that is two females or
# one pair, so it is left as start_beetles rather than being halved.
#
# The May 2012 workbook supersedes the January one, whose only extra content is
# 30 cells reading "see Nicole's data" -- C. maculatus results held by a
# collaborator and not present in this account.
hs_raw <- suppressMessages(
  read_excel(here("raw", "bruchids_on_alternate_beans.xlsx"), sheet = 1,
             col_names = FALSE, col_types = "text")
)[-1, ]

host_suitability <- tibble::tibble(
  species_code            = norm_sp(hs_raw[[1]]),
  bean                    = trimws(hs_raw[[2]]),
  bean_mass_g             = num(hs_raw[[3]]),
  replicate               = num(hs_raw[[4]]),
  start_beetles           = num(hs_raw[[5]]),
  date_start              = xldate(hs_raw[[6]]),
  date_adults_removed     = xldate(hs_raw[[7]]),
  adults_removed_marked_x = trimws(hs_raw[[7]]) == "x" &
                              !is.na(trimws(hs_raw[[7]])),
  progeny                 = num(hs_raw[[9]]),
  progeny_stuck_in_bean   = num(hs_raw[[10]]),
  progeny_females         = num(hs_raw[[11]]),
  notes                   = trimws(hs_raw[[12]])
) |>
  # keep replicates that were actually started or scored
  filter(!is.na(species_code), !is.na(date_start) | !is.na(progeny)) |>
  select(species_code, bean, bean_mass_g, replicate, start_beetles,
         date_start, date_adults_removed, adults_removed_marked_x,
         progeny, progeny_stuck_in_bean, progeny_females, notes)

# Monoculture on mung beans rather than black-eyed peas, same layout as the
# monoculture master. The A.obt sheet was laid out but never run.
read_mung <- function(sheet) {
  x <- suppressMessages(
    read_excel(here("raw", "bruchids_mung_beans_discrete.xlsx"), sheet = sheet,
               col_names = FALSE, col_types = "text")
  )[-1, ]
  tibble::tibble(
    species_code        = norm_sp(sheet),
    start_nominal       = num(x[[1]]),
    replicate_recorded  = num(x[[3]]),
    date_start          = xldate(x[[5]]),
    progeny             = num(x[[7]]),
    progeny_stuck_in_bean = num(x[[9]]),
    date_adults_removed = xldate(x[[11]]),
    progeny_females     = num(x[[13]])
  )
}

mung_bean_monoculture <- lapply(c("C.mac", "C. sub", "A.obt"), read_mung) |>
  bind_rows() |>
  filter(!is.na(start_nominal), start_nominal > 0,
         !is.na(progeny) | !is.na(progeny_females)) |>
  arrange(species_code, start_nominal) |>
  group_by(species_code, start_nominal) |>
  mutate(replicate = row_number()) |>
  ungroup() |>
  mutate(start_females = start_nominal / 2) |>
  select(species_code, start_nominal, start_females, replicate,
         replicate_recorded, progeny, progeny_females,
         progeny_stuck_in_bean, date_start, date_adults_removed)

# Beetle-to-bean ratio trial, run on 1 g of beans instead of 2 g, with density
# expressed per gram. Sheet1 is just the conversion table for the main
# experiment and holds no observations.
read_ratio <- function(sheet) {
  x <- suppressMessages(
    read_excel(here("raw", "bruchid_bean_beetle_ratio.xlsx"), sheet = sheet,
               col_names = FALSE, col_types = "text")
  )[-1, ]
  tibble::tibble(
    species_code          = norm_sp(sub(" 1 g$", "", sheet)),
    beetles_per_g_beans   = num(x[[1]]),
    bean_mass_g           = 1,
    replicate_recorded    = num(x[[3]]),
    date_start            = xldate(x[[4]]),
    progeny               = num(x[[6]]),
    progeny_stuck_in_bean = num(x[[8]]),
    date_adults_removed   = xldate(x[[10]]),
    progeny_females       = num(x[[12]])
  )
}

bean_beetle_ratio <- lapply(c("C.mac 1 g", "C.sub 1 g"), read_ratio) |>
  bind_rows() |>
  filter(!is.na(beetles_per_g_beans), !is.na(progeny)) |>
  arrange(species_code, beetles_per_g_beans) |>
  group_by(species_code, beetles_per_g_beans) |>
  mutate(replicate = row_number()) |>
  ungroup() |>
  select(species_code, beetles_per_g_beans, bean_mass_g, replicate,
         replicate_recorded, progeny, progeny_females,
         progeny_stuck_in_bean, date_start, date_adults_removed)

stopifnot(all(c(emergence_times$species_code, host_suitability$species_code,
                mung_bean_monoculture$species_code,
                bean_beetle_ratio$species_code) %in% species$species_code))

# ---- write and report --------------------------------------------------------

write.csv(interspecific, here("competition_interspecific.csv"),
          row.names = FALSE, na = "")
write.csv(monoculture,   here("competition_monoculture.csv"),
          row.names = FALSE, na = "")
write.csv(species,       here("species.csv"),
          row.names = FALSE, na = "")
write.csv(hybridization, here("hybridization_screening.csv"),
          row.names = FALSE, na = "")
write.csv(emergence_times, here("emergence_times.csv"),
          row.names = FALSE, na = "")
write.csv(host_suitability, here("host_suitability.csv"),
          row.names = FALSE, na = "")
write.csv(mung_bean_monoculture, here("mung_bean_monoculture.csv"),
          row.names = FALSE, na = "")
write.csv(bean_beetle_ratio, here("bean_beetle_ratio.csv"),
          row.names = FALSE, na = "")

cat("competition_interspecific.csv  ", nrow(interspecific), "replicates,",
    n_distinct(interspecific$pair), "pairs\n")
cat("competition_monoculture.csv    ", nrow(monoculture), "replicates,",
    n_distinct(monoculture$species_code), "species\n")
cat("species.csv                    ", nrow(species), "species\n")
cat("hybridization_screening.csv    ", nrow(hybridization), "cells,",
    sum(!is.na(hybridization$offspring)), "scored\n")
cat("emergence_times.csv            ", nrow(emergence_times), "observations,",
    n_distinct(emergence_times$species_code), "species\n")
cat("host_suitability.csv           ", nrow(host_suitability), "replicates,",
    sum(!is.na(host_suitability$progeny)), "scored,",
    n_distinct(host_suitability$bean), "bean types\n")
cat("mung_bean_monoculture.csv      ", nrow(mung_bean_monoculture), "replicates,",
    n_distinct(mung_bean_monoculture$species_code), "species\n")
cat("bean_beetle_ratio.csv          ", nrow(bean_beetle_ratio), "replicates,",
    n_distinct(bean_beetle_ratio$species_code), "species\n")
cat("\nmonoculture cross-check against the 2013 merge: ",
    nrow(check), " rows compared, all equal\n", sep = "")
cat("emergence-time date arithmetic: all ", nrow(emergence_times),
    " rows consistent\n", sep = "")

# Build the analysis-ready tables used in lecture.
#
# Why this folder exists: in-class time kept going on data wrangling rather than
# on the statistics the lecture was about. Lecture 16 opened with ten lines of
# tapply() and data.frame() before anyone fit anything, and the class ran out of
# time. The tables those ten lines produced now live here, already built, so the
# setup slide is a single read.csv().
#
# The prep is not hidden, it is just not typed in class: this script is the
# record of how every file in this folder was made, and it is deliberately
# written in dplyr, which is the right tool for the job and which students met
# in Lecture 7. The modeling code in the decks stays base R, like the book.
#
# Run from the project root:  source("data/class_examples/make_class_examples.R")
#
# Add a new table by writing a section here, not by saving something from a
# console session. If a file in this folder cannot be rebuilt by running this
# script, it does not belong here.

library(dplyr)

bbs <- read.csv("data/BBS/FL_BBS.csv")

out_dir <- "data/class_examples"

# ---------------------------------------------------------------------------
# 1. Northern Bobwhite occupancy, one row per year
#
# How many BBS routes were surveyed in Florida each year, and how many of them
# had bobwhite on them. This is the binomial response used in Lecture 16:
# n_occupied successes out of n_routes trials.
#
# 1996 is dropped because exactly one route was run that year, so its
# proportion is 1 out of 1 and carries almost no information.
# ---------------------------------------------------------------------------

routes_per_year <- bbs |>
  group_by(year = Year) |>
  summarise(n_routes = n_distinct(Route), .groups = "drop")

bobwhite_per_year <- bbs |>
  filter(Scientific_Name == "Colinus virginianus") |>
  group_by(year = Year) |>
  summarise(n_occupied = n_distinct(Route), .groups = "drop")

bobwhite_occupancy <- routes_per_year |>
  left_join(bobwhite_per_year, by = "year") |>
  mutate(n_occupied = coalesce(n_occupied, 0L)) |>
  filter(n_routes > 10) |>
  mutate(elapsed = year - min(year))

write.csv(bobwhite_occupancy,
          file.path(out_dir, "bobwhite_occupancy.csv"),
          row.names = FALSE)

# ---------------------------------------------------------------------------
# 2. Northern Bobwhite counts, one row per route-year
#
# The counts themselves, with the two covariates the lectures use: the year of
# the survey and the fraction of the route's surroundings that is developed.
#
# Note for anyone building on this: these are counts given presence. A row
# exists only where bobwhite were detected, so there are no zeros. See
# ../BBS/README.
# ---------------------------------------------------------------------------

bobwhite_counts <- bbs |>
  filter(Scientific_Name == "Colinus virginianus") |>
  select(route = Route, year = Year, count = total_sightings,
         frac_built, mean_annual_temp, mean_annual_precip) |>
  mutate(elapsed = year - min(year)) |>
  arrange(year, route)

write.csv(bobwhite_counts,
          file.path(out_dir, "bobwhite_counts.csv"),
          row.names = FALSE)

# ---------------------------------------------------------------------------
# 3. Reef fish surveys, trimmed
#
# The NCRMP survey table with just the columns the exercises use, so students
# download a tenth of the file. Depth and richness are the pair used in the
# Lecture 16 practice exercise.
#
# The eight surveys with zero total abundance are kept here rather than
# dropped: they are real, and deciding what to do about them is part of the
# exercise. See ../Reef_fish/README.
# ---------------------------------------------------------------------------

reef <- read.csv("data/Reef_fish/NCRMP_reef_fish_surveys.csv")

reef_surveys <- reef |>
  select(survey_id, year = YEAR, depth = DEPTH,
         visibility = UNDERWATER_VISIBILITY, habitat = HABITAT_TYPE,
         protection = PROT, abundance = total_abundance,
         richness = species_richness) |>
  filter(!is.na(depth), !is.na(richness))

write.csv(reef_surveys,
          file.path(out_dir, "reef_surveys.csv"),
          row.names = FALSE)

# ---------------------------------------------------------------------------
# 4. Commonest Florida birds, ranked within each year
#
# Total individuals counted across all routes, per species per year, kept to
# the six commonest in any given year. Built for the rank-over-time figure in
# the figures supplement, and useful anywhere a worked example needs a small
# tidy table with a group, a time axis and an order.
#
# Common names are added by hand because BBS ships scientific names only.
# ---------------------------------------------------------------------------

common_names <- tibble::tribble(
  ~species,                    ~common_name,
  "Agelaius phoeniceus",       "Red-winged Blackbird",
  "Bubulcus ibis",             "Cattle Egret",
  "Cardinalis cardinalis",     "Northern Cardinal",
  "Chaetura pelagica",         "Chimney Swift",
  "Corvus brachyrhynchos",     "American Crow",
  "Melanerpes carolinus",      "Red-bellied Woodpecker",
  "Mimus polyglottos",         "Northern Mockingbird",
  "Pipilo erythrophthalmus",   "Eastern Towhee",
  "Thryothorus ludovicianus",  "Carolina Wren",
  "Zenaida macroura",          "Mourning Dove"
)

species_ranks <- bbs |>
  filter(Year > 1996) |>
  group_by(year = Year, species = Scientific_Name) |>
  summarise(total = sum(total_sightings), .groups = "drop") |>
  group_by(year) |>
  mutate(rank = rank(-total, ties.method = "first")) |>
  ungroup() |>
  filter(rank <= 6) |>
  left_join(common_names, by = "species") |>
  select(year, species, common_name, total, rank) |>
  arrange(year, rank)

write.csv(species_ranks,
          file.path(out_dir, "bbs_species_ranks.csv"),
          row.names = FALSE)

# ---------------------------------------------------------------------------
# 5. Cardinal and bobwhite on every 2019 route, zeros included
#
# Two species on the same development gradient, for the "do two groups
# differ?" example in Lecture 18: does development affect a backyard bird and a
# grassland bird differently?
#
# Unlike bobwhite_counts, this table HAS the zeros. The BBS file only records a
# species where it was seen, so the zeros are rebuilt here: every route surveyed
# in 2019 gets a row for each species, and a route missing from a species' rows
# held none of it. That is the fix described in ../BBS/README.
# ---------------------------------------------------------------------------

routes_2019 <- bbs |>
  filter(Year == 2019) |>
  distinct(route = Route, frac_built)

two_species <- tibble::tribble(
  ~Scientific_Name,        ~species,
  "Cardinalis cardinalis", "cardinal",
  "Colinus virginianus",   "bobwhite"
)

bbs_two_species <- routes_2019 |>
  tidyr::crossing(two_species) |>
  left_join(bbs |>
              filter(Year == 2019) |>
              select(route = Route, Scientific_Name, count = total_sightings),
            by = c("route", "Scientific_Name")) |>
  mutate(count = coalesce(count, 0L)) |>
  select(species, route, count, frac_built) |>
  arrange(species, route)

write.csv(bbs_two_species,
          file.path(out_dir, "bbs_two_species.csv"),
          row.names = FALSE)

# ---------------------------------------------------------------------------
# Report what was written, and check the numbers the lectures quote
# ---------------------------------------------------------------------------

for (f in c("bobwhite_occupancy.csv", "bobwhite_counts.csv", "reef_surveys.csv",
            "bbs_species_ranks.csv", "bbs_two_species.csv")) {
  p <- file.path(out_dir, f)
  message(sprintf("%-26s %5d rows  %6.1f KB", f,
                  nrow(read.csv(p)), file.size(p) / 1024))
}

stopifnot(
  nrow(bobwhite_occupancy) == 23,
  bobwhite_occupancy$n_routes[bobwhite_occupancy$year == 2019] == 71,
  bobwhite_occupancy$n_occupied[bobwhite_occupancy$year == 2019] == 52,
  nrow(bobwhite_counts) == 1360,
  all(bobwhite_counts$count > 0),
  nrow(reef_surveys) == 8560,
  !any(is.na(species_ranks$common_name)),
  max(species_ranks$rank) == 6,
  nrow(bbs_two_species) == 142,
  sum(bbs_two_species$species == "bobwhite" & bbs_two_species$count == 0) == 19,
  sum(bbs_two_species$species == "cardinal" & bbs_two_species$count == 0) == 0
)

message("checks passed: 52 of 71 routes in 2019, 1360 counts, 8560 surveys, 142 two-species rows")

# Help pages for every dataset in the package.
#
# Each object is identical to reading the matching file in data/ of the course
# repository, as built by data-raw/build_package_data.R. The \source of each
# page gives that download, so the same data can be had either way.

# ---------------------------------------------------------------------------
# Class examples
# ---------------------------------------------------------------------------

#' Northern Bobwhite occupancy on Florida BBS routes, by year
#'
#' How many Florida Breeding Bird Survey routes were surveyed each year, and on
#' how many of them Northern Bobwhite (*Colinus virginianus*) were detected. The
#' binomial response used in Lectures 16 and 17. Built from [fl_bbs]; 1996 is
#' dropped because a single route was run that year.
#'
#' @format A data frame with 23 rows, one per year from 1997 to 2019:
#' \describe{
#'   \item{year}{survey year}
#'   \item{n_routes}{routes surveyed that year}
#'   \item{n_occupied}{routes on which bobwhite were detected}
#'   \item{elapsed}{years since 1997, the covariate used in the models}
#' }
#' @source Built by `data/class_examples/make_class_examples.R`. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bobwhite_occupancy.csv>
#' @seealso [bobwhite_counts], [fl_bbs]
"bobwhite_occupancy"

#' Northern Bobwhite counts on Florida BBS routes
#'
#' One row per route and year on which bobwhite were detected. Built from
#' [fl_bbs]. There are **no zeros**: routes where bobwhite were not seen have no
#' row, so these are counts given presence.
#'
#' @format A data frame with 1,360 rows:
#' \describe{
#'   \item{route}{BBS route number}
#'   \item{year}{survey year}
#'   \item{count}{bobwhite counted on the route that year}
#'   \item{frac_built}{fraction of the route's surroundings that is developed;
#'     constant within a route}
#'   \item{mean_annual_temp}{mean annual temperature at the route, degrees C}
#'   \item{mean_annual_precip}{mean annual precipitation at the route, mm}
#'   \item{elapsed}{years since 1996, the first year in the file}
#' }
#' @source Built by `data/class_examples/make_class_examples.R`. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bobwhite_counts.csv>
#' @seealso [bobwhite_occupancy], [fl_bbs]
"bobwhite_counts"

#' Reef fish surveys, trimmed for class
#'
#' The columns of [reef_fish_surveys] used in the lecture exercises, renamed to
#' short lower-case names.
#'
#' @format A data frame with 8,560 rows, one per survey:
#' \describe{
#'   \item{survey_id}{sample unit, station and year joined by "_"}
#'   \item{year}{survey year}
#'   \item{depth}{metres}
#'   \item{visibility}{underwater visibility, metres}
#'   \item{habitat}{reef structure and vertical relief}
#'   \item{protection}{the `PROT` code, 0, 1 or 2. A code, not a quantity:
#'     do not average it. See [reef_fish_surveys]}
#'   \item{abundance}{all fish recorded; **not** a whole number, see
#'     [reef_fish_surveys]}
#'   \item{richness}{number of species recorded}
#' }
#' @source Built by `data/class_examples/make_class_examples.R`. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/reef_surveys.csv>
#' @seealso [reef_fish_surveys]
"reef_surveys"

#' Yearly ranks of the most-counted Florida BBS species
#'
#' The six most-counted species on Florida BBS routes in each year from 1997
#' to 2019, ranked within the year. Ten species make the top six at some point.
#' Built from [fl_bbs] for the bump chart in Supplement 01.
#'
#' @format A data frame with 138 rows, six per year:
#' \describe{
#'   \item{year}{survey year}
#'   \item{species}{scientific name}
#'   \item{common_name}{English name}
#'   \item{total}{birds counted across all routes that year}
#'   \item{rank}{rank among the six that year, 1 = most counted}
#' }
#' @source Built by `data/class_examples/make_class_examples.R`. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bbs_species_ranks.csv>
#' @seealso [fl_bbs]
"bbs_species_ranks"

#' Cardinal and bobwhite on every 2019 Florida BBS route, zeros included
#'
#' Counts of Northern Cardinal (*Cardinalis cardinalis*) and Northern Bobwhite
#' (*Colinus virginianus*) on each of the 71 Florida Breeding Bird Survey routes
#' run in 2019. Built from [fl_bbs] for the two-species comparison in Lecture 18.
#'
#' Unlike [fl_bbs] and [bobwhite_counts], this table **includes the zeros**:
#' every route has a row for each species, and a count of 0 means the species
#' was not recorded on a route that was surveyed.
#'
#' @format A data frame with 142 rows, one per species per route:
#' \describe{
#'   \item{species}{"bobwhite" or "cardinal"}
#'   \item{route}{BBS route number}
#'   \item{count}{birds counted on the route in 2019; 0 if none}
#'   \item{frac_built}{fraction of the route's surroundings that is developed}
#' }
#' @source Built by `data/class_examples/make_class_examples.R`. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bbs_two_species.csv>
#' @seealso [fl_bbs], [bobwhite_counts]
"bbs_two_species"

# ---------------------------------------------------------------------------
# Birds
# ---------------------------------------------------------------------------

#' Breeding Bird Survey, Florida
#'
#' North American Breeding Bird Survey counts for Florida, 112 routes from 1996
#' to 2019, with temperature, precipitation, development and human footprint
#' added for each route.
#'
#' Two things to know before modeling with it:
#'
#' * **There are no zeros.** A row exists only where a species was detected, so
#'   `total_sightings` starts at 1. To get absences, build the full route by
#'   year grid: the routes surveyed in a year are `unique(Route[Year == y])`.
#' * **The spatial columns do not change over time.** `frac_built`,
#'   `footprint`, `mean_annual_temp`, `mean_annual_precip`, `Latitude` and
#'   `Longitude` are constant within a route, so they can explain differences
#'   among routes but not a trend through time.
#'
#' @format A data frame with 79,991 rows and 24 columns. The ones used most:
#'
#' * `Route`, `Year`: BBS route number and survey year
#' * `Scientific_Name`, `Genus`, `Family`, `ORDER`: the species counted
#' * `total_sightings`: birds of that species counted on the route
#' * `TotalSpp`: species recorded on the route that year
#' * `mean_annual_temp`, `mean_annual_precip`: route climate
#' * `frac_built`: fraction of the surroundings that is developed
#' * `footprint`: human footprint index
#' * `Latitude`, `Longitude`: route location
#'
#' The rest record the survey itself: date, start and end times, temperature
#' and wind.
#' @source U.S. Geological Survey, North American Breeding Bird Survey,
#'   <https://doi.org/10.5066/P97WAZE5>, retrieved with the bbsAssistant
#'   package. Public domain. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/BBS/FL_BBS.csv>
#' @seealso [bobwhite_counts], [bobwhite_occupancy], [bbs_species_ranks]
"fl_bbs"

#' AVONET: morphological traits of the world's birds
#'
#' Beak, wing, tail and leg measurements, body mass, and ecological traits for
#' 11,009 bird species, in BirdLife taxonomy.
#'
#' @format A data frame with 11,009 rows and 37 columns, one row per species.
#'   See the source for full column definitions.
#' @source Tobias et al. (2022) AVONET: morphological, ecological and
#'   geographical data for all birds. *Ecology Letters* 25: 581-597.
#'   <https://doi.org/10.1111/ele.13898>. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds>
"avonet"

#' Amniote life-history traits
#'
#' Life-history traits for birds, mammals and reptiles: body mass, clutch size,
#' longevity, age at maturity and more.
#'
#' The original file codes missing values as -999. Here they are already `NA`,
#' as in the course's `.rds` copy; the `.csv` in the repository still has -999.
#'
#' @format A data frame with 21,322 rows and 36 columns, one row per species.
#' @source Myhrvold et al. (2015) An amniote life-history database to perform
#'   comparative analyses with birds, mammals, and reptiles. *Ecology* 96: 3109.
#'   <https://doi.org/10.1890/15-0846R.1>. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Amniote_traits/Amniote_Database_Aug_2015.rds>
"amniotes"

# ---------------------------------------------------------------------------
# Reef fish and coral
# ---------------------------------------------------------------------------

#' Reef fish surveys, Florida Reef Tract
#'
#' National Coral Reef Monitoring Program fish surveys, one row per survey, in
#' 2014, 2016, 2018, 2021, 2022 and 2024.
#'
#' * `total_abundance` is **not** a whole number. The values are densities
#'   rather than head counts, so a count distribution is the wrong choice.
#' * `PROT` is a code (0, 1, 2), not a quantity. Use `MPA_NAME` for protection.
#'
#' @format A data frame with 8,560 rows and 16 columns, including `survey_id`,
#'   `YEAR`, `latitude`, `longitude`, `DEPTH` (metres), `UNDERWATER_VISIBILITY`
#'   (metres), `HABITAT_TYPE`, `ZONE_NAME`, `SUB_REGION_NAME`,
#'   `REGION_DESCRIPTION`, `PROT`, `MPA_NAME`, `total_abundance` and
#'   `species_richness`.
#' @source NOAA Southeast Fisheries Science Center and NOAA National Centers for
#'   Coastal Ocean Science (2018). <https://doi.org/10.7289/v52n50ks>. CC0.
#'   `data/Reef_fish/get_reef_fish_data.R` in the course repository documents
#'   how this subset was made. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Reef_fish/NCRMP_reef_fish_surveys.csv>
#' @seealso [reef_fish_species], [reef_fish_species_list], [reef_surveys]
"reef_fish_surveys"

#' Reef fish abundance by survey and species
#'
#' The 20 most frequently recorded species, one row per survey per species, with
#' zeros kept. Join to [reef_fish_surveys] by `survey_id` for depth, habitat and
#' the rest, and to [reef_fish_species_list] by `SPECIES_CD` for names.
#'
#' @format A data frame with 171,200 rows: `survey_id`, `SPECIES_CD`, and
#'   `abundance`, which like `total_abundance` is not a whole number.
#' @source As for [reef_fish_surveys]. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Reef_fish/NCRMP_reef_fish_species.csv>
"reef_fish_species"

#' Reef fish species codes
#'
#' @format A data frame with 20 rows: `SPECIES_CD`, `SCIENTIFIC_NAME` and
#'   `COMMON_NAME`.
#' @source As for [reef_fish_surveys]. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Reef_fish/NCRMP_reef_fish_species_list.csv>
"reef_fish_species_list"

#' Benthic cover on Florida coral reefs
#'
#' National Coral Reef Monitoring Program benthic cover, Florida: percent cover
#' of hard bottom, soft bottom and rubble, with the cover category recorded at
#' each station. Units are in the column names, as exported from ERDDAP.
#'
#' The repository holds this export twice. The other copy puts the units in a
#' second row instead, which makes every column read as text; this is the one
#' that reads cleanly.
#'
#' @format A data frame with 13,601 rows and 35 columns.
#' @source NOAA National Coral Reef Monitoring Program.
#'   <https://www.ncei.noaa.gov/erddap/info/CRCP_Benthic_Cover_Florida/index.html>.
#'   CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Coral/CRCP_Benthic_Cover_Florida_b0ba_bcb9_5f6a.csv>
"coral_cover"

# ---------------------------------------------------------------------------
# Bean beetle competition experiments
# ---------------------------------------------------------------------------

#' Bean beetle competition: two-species replicates
#'
#' Single-generation competition experiments among eight species of seed beetle
#' (Chrysomelidae: Bruchinae), run by Brian Maitner in 2011 to 2013. Each row is
#' one petri dish: known numbers of two species on 2 g of black-eyed peas,
#' scored by counting the emerged progeny. Unpublished.
#'
#' **Use `start_females_*` as the starting density.** The `start_nominal_*`
#' columns count males plus females put together to mate; only the females went
#' onto the beans, so a treatment labeled 20 is ten females.
#'
#' @format A data frame with 1,361 rows:
#' \describe{
#'   \item{pair}{species pair, `<species_1>_<species_2>`}
#'   \item{species_1, species_2}{four-letter codes; see [beetle_species]}
#'   \item{start_nominal_1, start_nominal_2}{treatment label, males plus females}
#'   \item{start_females_1, start_females_2}{females placed on the beans}
#'   \item{replicate}{replicate within pair and treatment}
#'   \item{replicate_recorded}{replicate as written on the datasheet}
#'   \item{progeny_1, progeny_2}{emerged adult progeny of each species}
#'   \item{progeny_females_1, progeny_females_2}{female progeny of each species}
#'   \item{source_row}{row in the original datasheet}
#' }
#' @source Brian Maitner. CC-BY 4.0. The original spreadsheets are in
#'   `system.file("extdata", "Beetle_competition", "raw", package = "biometrydata")`.
#'   Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/competition_interspecific.csv>
#' @seealso [beetle_competition_monoculture], [beetle_species]
"beetle_competition_interspecific"

#' Bean beetle competition: single-species replicates
#'
#' Monocultures of all eight species at nominal densities from 2 to 60. A wider
#' density range than [beetle_competition_interspecific], so the better data for
#' estimating each species' intraspecific competition.
#'
#' @format A data frame with 264 rows: `species_code`, `start_nominal`,
#'   `start_females` (use this), `replicate`, `replicate_recorded`, `progeny`,
#'   `progeny_females`, `date_start`, `date_adults_removed`, `source_sheet` and
#'   `source_row`.
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/competition_monoculture.csv>
#' @seealso [beetle_competition_interspecific], [beetle_species]
"beetle_competition_monoculture"

#' Bean beetle species
#'
#' The eight species in the competition experiments. Join on `species_code`.
#'
#' @format A data frame with 8 rows: `species_code`, `genus`, `epithet`,
#'   `scientific_name`, `authority`, `family` and `subfamily`.
#' @source Brian Maitner. Authorities checked against the GBIF backbone,
#'   October 2026. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/species.csv>
"beetle_species"

#' Bean beetle egg-to-emergence times
#'
#' A side experiment: days from oviposition to the first emerged adult.
#'
#' @format A data frame with 50 rows: `species_code`, `date_oviposited`,
#'   `date_first_emergence` and `days_to_emergence`.
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/emergence_times.csv>
"beetle_emergence_times"

#' Bean beetle host suitability
#'
#' A pilot: two beetles of one species on 2 g of one of seven bean types. Unlike
#' the main experiment, `start_beetles` is **not** known to be females, and is
#' not halved.
#'
#' @format A data frame with 61 rows and 12 columns, including `species_code`,
#'   `bean`, `start_beetles`, `progeny` and `progeny_females`.
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/host_suitability.csv>
"beetle_host_suitability"

#' Bean beetle monocultures on mung beans
#'
#' A pilot: monocultures on mung beans instead of black-eyed peas.
#'
#' @format A data frame with 11 rows and 10 columns, laid out like
#'   [beetle_competition_monoculture].
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/mung_bean_monoculture.csv>
"beetle_mung_bean_monoculture"

#' Bean beetle monocultures at a lower bean mass
#'
#' A pilot: monocultures on 1 g of beans instead of 2 g.
#'
#' @format A data frame with 10 rows and 10 columns, including `species_code`,
#'   `beetles_per_g_beans`, `bean_mass_g`, `progeny` and `progeny_females`.
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/bean_beetle_ratio.csv>
"beetle_bean_ratio"

#' Bean beetle hybridization screening
#'
#' A pilot: single-pair mating crosses between species, scored for offspring.
#'
#' @format A data frame with 27 rows: `female_species`, `male_species`,
#'   `cross_type`, `replicate` and `offspring`.
#' @source Brian Maitner. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/hybridization_screening.csv>
"beetle_hybridization_screening"

# ---------------------------------------------------------------------------
# Other datasets
# ---------------------------------------------------------------------------

#' Code and data sharing in ecology papers
#'
#' 1,001 papers from ecology and environmental science journals, 2010 to 2022,
#' scored for whether their R code and data were made available, with citation
#' counts and article metadata. Used in the Chapter 9 (GLM) examples and in
#' Assignment 3.
#'
#' Stored as a grouped tibble, as in the course's `.rds` file. Load dplyr to
#' print it as one, or use `as.data.frame()`.
#'
#' @format A data frame with 1,001 rows and 25 columns, including
#'   `r_scripts_available` and `data_available` (1 = yes, 0 = no), `citations`,
#'   `open_access`, `year` and `age_y` (years since 2010).
#' @source Compiled by Brian Maitner,
#'   <https://github.com/bmaitner/R_citations>. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Code_sharing/code_data.RDS>
"code_sharing"

#' Mule deer movement and risk
#'
#' GPS steps of collared female mule deer (*Odocoileus hemionus*) in Colorado
#' and Utah, 2015 to 2022, laid out for step selection analysis: each used step
#' (`case_ = TRUE`) is matched with available steps, with vegetation, terrain,
#' land cover, and modeled cougar and human encounter risk at the end of each.
#' Raw coordinates were removed by the data providers.
#'
#' Stored as a data.table, as in the course's `.rds` file. It behaves as an
#' ordinary data frame unless data.table is loaded.
#'
#' @format A data frame with 1,854,448 rows and 23 columns. See the source for
#'   the full variable key; `case_`, `step_id_`, `sl_` (step length, m), `ta_`
#'   (turn angle, radians), `NDVI`, `lionRSF_s2`, `hmd_prob_use_season`, `site`
#'   and `animalID` are the ones most analyses start from.
#' @source Dynamic riskscapes for prey: disentangling the impact of human and
#'   cougar presence on deer behavior using GPS smartphone locations.
#'   <https://doi.org/10.5061/dryad.51c59zwkg>. CC0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Deer_movement/MD_dataset.RDS>
"deer_movement"

#' Deep-sea megabenthos from ROV transects
#'
#' Counts of seafloor animals by phylum along ROV video subtransects, with depth,
#' temperature, salinity, substrate and diversity indices.
#'
#' Read from the PANGAEA export, so column names carry PANGAEA's units in
#' mangled form (`Depth.water..m.`). The first column, `X`, is a row number.
#' The original `.tab` file is at
#' `system.file("extdata", "Deep_sea_megabenthos", "TOSCA_ROV.tab", package = "biometrydata")`.
#'
#' @format A data frame with 749 rows and 26 columns.
#' @source <https://doi.org/10.1594/PANGAEA.946727>. CC-BY 4.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Deep_sea_megabenthos/TOSCA_ROV.csv>
"tosca_rov"

#' Mangrove fauna and their functional traits
#'
#' Invertebrate species recorded at mangrove sites worldwide, with region, tidal
#' regime, habitat, and functional traits such as feeding mode and burrowing.
#' Column names are as in the original file, spelling included. The first
#' column, `X`, is a row number.
#'
#' @format A data frame with 587 rows and 33 columns.
#' @source Cannicci et al. (2021) A functional analysis reveals extremely low
#'   redundancy in global mangrove invertebrate fauna. *PNAS* 118: e2016913118.
#'   <https://doi.org/10.1073/pnas.2016913118>. Data:
#'   <https://doi.org/10.25442/hku.12830951.v2>. **CC-BY-NC 4.0: not for
#'   commercial use.** Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Mangroves/Cannicci_et_al_Final_dataset_4.0.csv>
"mangroves"

#' Tara Oceans samples, events and biodiversity
#'
#' The Tara Oceans biodiversity, event and sample registries, combined. Column
#' names are cut off; full names are in the PANGAEA records below.
#'
#' @format A data frame with 51,501 rows and 207 columns.
#' @source Pesant et al. (2015) Open science resources for the discovery and
#'   analysis of Tara Oceans data. *Scientific Data* 2: 150023.
#'   <https://doi.org/10.1038/sdata.2015.23>. Combined from
#'   <https://doi.org/10.1594/PANGAEA.853809>,
#'   <https://doi.org/10.1594/PANGAEA.842227> and
#'   <https://doi.org/10.1594/PANGAEA.875582>. CC-BY 3.0. Download:
#'   <https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Marine_microorganisms/TARA_data_combined.RDS>
"tara"

# Build the package's copies of the course data
#
# Run from the project root:
#
#   source("biometrydata/data-raw/build_package_data.R")
#
# The files in data/ are the originals, and they stay where they are, so every
# read.csv() and readRDS() URL in the course materials keeps working. This
# script reads each of them exactly the way the course materials do and saves
# the result into biometrydata/data/ as .rda files. A dataset in the package is
# therefore identical to what a student gets by downloading the file:
#
#   identical(biometrydata::fl_bbs, read.csv(".../data/BBS/FL_BBS.csv"))
#
# Files R cannot read directly as a table (spreadsheets, PANGAEA .tab exports,
# protocols) are copied unchanged into inst/extdata/, mirroring their folders in
# data/, and are reached with system.file().
#
# Rerun after anything in data/ changes, including after
# make_class_examples.R rebuilds the class example tables.

pkg_data <- "biometrydata/data"
pkg_extdata <- "biometrydata/inst/extdata"

if (!dir.exists("data") || !dir.exists("biometrydata")) {
  stop("Run this from the project root, the folder holding data/ and biometrydata/.")
}

dir.create(pkg_data, showWarnings = FALSE, recursive = TRUE)
dir.create(pkg_extdata, showWarnings = FALSE, recursive = TRUE)

# package object name = how it is read from data/
tables <- list(
  # class examples: small, analysis-ready
  bobwhite_occupancy = function(){ read.csv("data/class_examples/bobwhite_occupancy.csv") },
  bobwhite_counts    = function(){ read.csv("data/class_examples/bobwhite_counts.csv") },
  reef_surveys       = function(){ read.csv("data/class_examples/reef_surveys.csv") },
  bbs_species_ranks  = function(){ read.csv("data/class_examples/bbs_species_ranks.csv") },

  # the course datasets
  amniotes = function(){ readRDS("data/Amniote_traits/Amniote_Database_Aug_2015.rds") },
  avonet   = function(){ readRDS("data/Avonet/AVONET1_BirdLife.rds") },
  fl_bbs   = function(){ read.csv("data/BBS/FL_BBS.csv") },

  beetle_competition_interspecific = function(){ read.csv("data/Beetle_competition/competition_interspecific.csv") },
  beetle_competition_monoculture   = function(){ read.csv("data/Beetle_competition/competition_monoculture.csv") },
  beetle_species                   = function(){ read.csv("data/Beetle_competition/species.csv") },
  beetle_emergence_times           = function(){ read.csv("data/Beetle_competition/emergence_times.csv") },
  beetle_host_suitability          = function(){ read.csv("data/Beetle_competition/host_suitability.csv") },
  beetle_mung_bean_monoculture     = function(){ read.csv("data/Beetle_competition/mung_bean_monoculture.csv") },
  beetle_bean_ratio                = function(){ read.csv("data/Beetle_competition/bean_beetle_ratio.csv") },
  beetle_hybridization_screening   = function(){ read.csv("data/Beetle_competition/hybridization_screening.csv") },

  code_sharing = function(){ readRDS("data/Code_sharing/code_data.RDS") },

  # the same ERDDAP export is in data/Coral twice; this is the version with the
  # units in the column names, which reads with the right column types
  coral_cover = function(){ read.csv("data/Coral/CRCP_Benthic_Cover_Florida_b0ba_bcb9_5f6a.csv") },

  tosca_rov     = function(){ read.csv("data/Deep_sea_megabenthos/TOSCA_ROV.csv") },
  deer_movement = function(){ readRDS("data/Deer_movement/MD_dataset.RDS") },

  # the file is Latin-1; read it as such so place names survive
  mangroves = function(){ read.csv("data/Mangroves/Cannicci_et_al_Final_dataset_4.0.csv",
                                   fileEncoding = "latin1") },

  tara = function(){ readRDS("data/Marine_microorganisms/TARA_data_combined.RDS") },

  reef_fish_surveys      = function(){ read.csv("data/Reef_fish/NCRMP_reef_fish_surveys.csv") },
  reef_fish_species      = function(){ read.csv("data/Reef_fish/NCRMP_reef_fish_species.csv") },
  reef_fish_species_list = function(){ read.csv("data/Reef_fish/NCRMP_reef_fish_species_list.csv") }
)

for (nm in names(tables)) {
  obj <- tables[[nm]]()
  assign(nm, obj)
  save(list = nm, file = file.path(pkg_data, paste0(nm, ".rda")),
       compress = "xz", version = 3)
  message(sprintf("%-34s %8d rows  %4d columns", nm, nrow(obj), ncol(obj)))
}

# files that are not tables R reads directly
raw_files <- c(
  "European_amphibians/oo_32985.xlsx",
  "Deep_sea_megabenthos/TOSCA_ROV.tab",
  list.files("data/Beetle_competition/raw", recursive = TRUE,
             full.names = FALSE) |>
    (function(x){ file.path("Beetle_competition/raw", x) })()
)

for (f in raw_files) {
  to <- file.path(pkg_extdata, f)
  dir.create(dirname(to), showWarnings = FALSE, recursive = TRUE)
  file.copy(file.path("data", f), to, overwrite = TRUE, copy.date = TRUE)
}
message(length(raw_files), " files copied to inst/extdata")

# a dataset in data/ that the package does not know about is a mistake
known <- c(
  sub("^data/", "", unlist(lapply(tables, function(f){
    regmatches(deparse(body(f)), regexpr("data/[^\"]+", deparse(body(f))))
  }))),
  raw_files,
  "Coral/CRCP_Benthic_Cover_Florida_7018_0ee5_9488.csv",   # duplicate export of coral_cover
  "Amniote_traits/Amniote_Database_Aug_2015.csv",          # same as the .rds, with -999 for NA
  "Avonet/AVONET1_BirdLife.csv",                           # same as the .rds
  "Mangroves/Cannicci_et_al_Final_dataset_4.0.xlsx"        # same as the .csv
)
data_files <- list.files("data", pattern = "\\.(csv|rds|RDS|xlsx|tab)$",
                         recursive = TRUE)
missing <- setdiff(data_files, known)
if (length(missing) > 0) {
  stop("In data/ but not in the package: ", paste(missing, collapse = ", "))
}

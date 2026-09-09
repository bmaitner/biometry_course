# How the reef fish files in this folder were made
##################################################
#
# You do not need to run this. The output files are already in this folder.
# It is here so the provenance of those files is documented and reproducible.
#
# Heads up: the download is about 770 MB and takes a few minutes.
#
# Source: NOAA National Coral Reef Monitoring Program, reef fish surveys of the
# Florida Reef Tract, served from the NCEI ERDDAP server.
# https://www.ncei.noaa.gov/erddap/info/CRCP_Reef_Fish_Surveys_Florida/index.html
#
# Licence is CC0-1.0, so redistribution here is fine. See the README.


# Download ----------------------------------------------------------------

  # The full table records every species at every survey in every length bin,
  # including absences, which is why it is so large. We ask ERDDAP for only the
  # columns we need rather than all 36 of them.

    variables <- c("PRIMARY_SAMPLE_UNIT", "STATION_NR", "YEAR",
                   "latitude", "longitude", "DEPTH", "UNDERWATER_VISIBILITY",
                   "HABITAT_TYPE", "ZONE_NAME", "SUB_REGION_NAME",
                   "REGION_DESCRIPTION", "PROT", "MPA_NAME",
                   "SPECIES_CD", "SCIENTIFIC_NAME", "COMMON_NAME", "NUM")

    erddap <- paste0(
      "https://www.ncei.noaa.gov/erddap/tabledap/CRCP_Reef_Fish_Surveys_Florida.csv?",
      paste(variables, collapse = ","))

    raw_file <- tempfile(fileext = ".csv")

    download.file(erddap, destfile = raw_file, mode = "wb")

  # ERDDAP writes a units row underneath the header, so skip it and supply the
  # column names by hand.

    header <- strsplit(readLines(raw_file, n = 1), ",")[[1]]

    fish <- read.csv(raw_file,
                     skip = 2,
                     header = FALSE,
                     col.names = header,
                     stringsAsFactors = FALSE)


# Define a survey ---------------------------------------------------------

  # A primary sample unit usually holds two stations, which are separate surveys.
  # Sample unit alone is therefore not a unique key; sample unit plus station
  # plus year is.

    fish$survey_id <- paste(fish$PRIMARY_SAMPLE_UNIT,
                            fish$STATION_NR,
                            fish$YEAR,
                            sep = "_")


# Sum over length bins ----------------------------------------------------

  # One row per survey per species, adding up the length bins.

    abundance <- aggregate(NUM ~ survey_id + SPECIES_CD + SCIENTIFIC_NAME + COMMON_NAME,
                           data = fish,
                           FUN  = sum,
                           na.rm = TRUE)


# Build the survey-level file ---------------------------------------------

  survey_columns <- c("survey_id", "PRIMARY_SAMPLE_UNIT", "STATION_NR", "YEAR",
                      "latitude", "longitude", "DEPTH", "UNDERWATER_VISIBILITY",
                      "HABITAT_TYPE", "ZONE_NAME", "SUB_REGION_NAME",
                      "REGION_DESCRIPTION", "PROT", "MPA_NAME")

  surveys <- unique(fish[survey_columns])

    # Should be one row per survey. Stop here if not.

      stopifnot(nrow(surveys) == length(unique(surveys$survey_id)))

  total <- aggregate(NUM ~ survey_id, data = abundance, FUN = sum)

    names(total)[2] <- "total_abundance"

  richness <- aggregate(NUM ~ survey_id,
                        data = abundance[abundance$NUM > 0, ],
                        FUN  = length)

    names(richness)[2] <- "species_richness"

  surveys <- merge(surveys, total,    by = "survey_id", all.x = TRUE)
  surveys <- merge(surveys, richness, by = "survey_id", all.x = TRUE)

    # A survey where nothing was recorded is a real zero, not a missing value.

      surveys$species_richness[is.na(surveys$species_richness)] <- 0
      surveys$total_abundance[is.na(surveys$total_abundance)]   <- 0

  surveys <- surveys[order(surveys$YEAR,
                           surveys$PRIMARY_SAMPLE_UNIT,
                           surveys$STATION_NR), ]

  write.csv(surveys,
            "data/Reef_fish/NCRMP_reef_fish_surveys.csv",
            row.names = FALSE)


# Build the species-level file --------------------------------------------

  # Keeping all 481 species would be mostly zeros and far too big for the repo,
  # so keep the 20 recorded at the most surveys. Zeros are retained for those,
  # because an absence is data.

    recorded <- abundance[abundance$NUM > 0, ]

    commonest <- names(sort(table(recorded$SPECIES_CD), decreasing = TRUE))[1:20]

    species <- abundance[abundance$SPECIES_CD %in% commonest, ]

      names(species)[names(species) == "NUM"] <- "abundance"

  # Species names go in their own lookup rather than repeating on all 171,200
  # rows, which cuts the file from 29 MB to 5 MB.

    species_list <- unique(species[c("SPECIES_CD", "SCIENTIFIC_NAME", "COMMON_NAME")])
    species_list <- species_list[order(species_list$SPECIES_CD), ]

    write.csv(species_list,
              "data/Reef_fish/NCRMP_reef_fish_species_list.csv",
              row.names = FALSE)

    species <- species[c("survey_id", "SPECIES_CD", "abundance")]
    species <- species[order(species$survey_id, species$SPECIES_CD), ]

    write.csv(species,
              "data/Reef_fish/NCRMP_reef_fish_species.csv",
              row.names = FALSE)

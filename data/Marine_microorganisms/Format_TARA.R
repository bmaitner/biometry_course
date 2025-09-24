# Note: column names are cut off, see full names on Pangea

# Tara Oceans Consortium, Coordinators; Tara Oceans Expedition, Participants (2015): Biodiversity context of all samples from the Tara Oceans Expedition (2009-2013) [dataset]. PANGAEA, https://doi.org/10.1594/PANGAEA.853809
# Tara Oceans Consortium, Coordinators; Tara Oceans Expedition, Participants (2015): Registry of all events from the Tara Oceans Expedition (2009-2013) [dataset]. PANGAEA, https://doi.org/10.1594/PANGAEA.842227
# Tara Oceans Consortium, Coordinators; Tara Oceans Expedition, Participants (2017): Registry of all samples from the Tara Oceans Expedition (2009-2013) [dataset publication series]. PANGAEA, https://doi.org/10.1594/PANGAEA.875582

# Function to read in poorly formatted data

  read_pangaea_tab <- function(file){
    
    # find end of comments
    
    end_of_comment_block <- grep(pattern = "*/",
                                 x = readLines(file, warn = FALSE),
                                 fixed = TRUE)
    
    # read in file
    
    read.delim(file = file,
               sep = "\t",
               skip = end_of_comment_block)
    
    
  }

# Read in datasets

  biodiv <- read_pangaea_tab("data/Marine_microorganisms/TARA_sample_biodiv.tab")
  events <- read_pangaea_tab("data/Marine_microorganisms/TARA_reg_events.tab")
  samples <- read_pangaea_tab("data/Marine_microorganisms/TARA_SAMPLES_CONTEXT_ENV-WATERCOLUMN.tab")
  samples2 <- read_pangaea_tab("data/Marine_microorganisms/TARA_SAMPLES_CONTEXT_ENV-WATERCOLUMN_2.tab")

# Join datasets together
  
  library(tidyverse)
  
  combined_data <- left_join(biodiv,events)
  combined_data <- left_join(combined_data,samples)
  combined_data <- left_join(combined_data,samples2)

# Save combined dataset

  write.csv(x = combined_data, file = "data/Marine_microorganisms/TARA_data_combined.csv",
            row.names = FALSE)

  saveRDS(combined_data, file = "data/Marine_microorganisms/TARA_data_combined.RDS")
  
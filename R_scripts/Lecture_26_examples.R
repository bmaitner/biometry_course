# Lecture 26: Getting help

library(tidyverse)
library(reprex)

  traits <- read_rds("https://tinyurl.com/amniotes")

# basic issues ------------------------------------------------------------

  
# Calculate mean mass
  
  traits |>
    group_by(class) |>
    summarise(mean_mass = mean(adult_body_mass_g))
  
# Make a new data frame containing scientific name in "Genus species" format
  # (note: what this calls "species" is actually the specific epithet)
  
  data.frame(scientific_name = paste(traits[4,],traits[5,]))
  
# Calculate SD in length 
  
  traits |>
    group_by(class) |>
    summarise(SD_svl = sd(adult_svl))

# Calculate svl/mass ratio
  
  traits >
    mutate(svl_mass_ratio = adult_svl_cm/adult_body_mass_g)
  

# more advanced issues ----------------------------------------------------


  # Calculate offspring per year, skipping those with NA data
  
  annual_fecundity <- NULL
  
  for(i in 1:length(unique(traits$species))){
    
    
    species_i <- paste(traits$genus[i]," ",traits$species[i],sep = "")
    
    offspring_per_clutch <- traits$litter_or_clutch_size_n[i]
    
    clutches_per_year <- traits$litters_or_clutches_per_y[i]
    
    # Don't include values with NAs
    
    if(is.na(offspring_per_clutch) &
       is.na(clutches_per_year)){
      next
    }
      
    offspring_per_clutch*clutches_per_year
    
    out <- data.frame(species = species_i,
                      annual_offspring = offspring_per_clutch*clutches_per_year)
    
    annual_fecundity <- bind_rows(annual_fecundity,out)
    
  }# end i loop
  
  
# Break data into family-sized batches and save them
  
  # make a temp folder
  family_folder <- tempdir()
  
  # Get data for each family and save as an RDS file
  
  for(i in 1:length(unique(traits[,4]))){
    
    group_i <-   unique(traits[,4])[i]
    
    data_i <- traits[which(traits[,4] == group_i),]
    
    data_i |>
    saveRDS(file.path(genus_folder,
                      paste(unique(data_i[,3]),
                      ".rds",sep = "")))
    
  }
  
  # Look at output files
  
    family_files <- list.files(family_folder,pattern = ".rds",full.names = TRUE)

  # Load an example
    
    test <- readRDS(family_files[i])
    

# reproducible examples ---------------------------------------------------

  ?reprex
    
    
reprex({
  
  traits <- read_rds("https://tinyurl.com/amniotes")
  
  traits |>
  ggplot(mapping = aes(x=adult_body_mass_g,
                       y=adult_svl_cm))+
    geom_point()+
    scale_y_log10()+
    scale_x_log10()+
    geom_smooth(method = "lm")
  
  
  })    
    
# dput(data_i)

reprex({
  
  traits <- read_rds("https://tinyurl.com/amniotes")
  
  traits |>
    ggplot(mapping = aes(x=adult_body_mass_g,
                         y=adult_svl_cm))+
    geom_point()+
    scale_y_log10()+
    scale_x_log10()+
    geom_smooth(method = "lm")
  
  

  })    


# Below is ChatGPT's suggested fix, which seems to work:

reprex({
  
  library(ggplot2)
  
  # Load the dataset correctly from URL
  traits <- readRDS(url("https://tinyurl.com/amniotes"))
  
  # Quick look
  dplyr::glimpse(traits)
  
  # Plot: body mass vs SVL with log scales + linear smooth
  traits |>
    ggplot(aes(x = adult_body_mass_g,
               y = adult_svl_cm)) +
    geom_point(alpha = 0.3) +
    scale_x_log10() +
    scale_y_log10() +
    geom_smooth(method = "lm") +
    labs(
      x = "Adult body mass (g, log10 scale)",
      y = "Adult snout–vent length (cm, log10 scale)",
      title = "Body size relationships in amniotes"
    ) +
    theme_minimal()
  
})

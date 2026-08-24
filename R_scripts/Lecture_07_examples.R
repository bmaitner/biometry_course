# Code for lecture 7 (tidyverse)

  library(tidyverse)

#let's get some data

  avo <- read_rds("https://tinyurl.com/avonetbirddata")


# filter ------------------------------------------------------------------

  #Limit to only the Parrot family
  
    # base R
  
      parrot_fam1 <- avo[which(avo$Family1 == "Psittacidae"),]
  
    # dplyr

      parrot_fam2 <- avo |>
                      filter(Family1 == "Psittacidae")

  # Limit to forest parrots
      
      forest_parrots1 <- avo[which(avo$Family1 == "Psittacidae" &
                                   avo$Habitat == "Forest"),]
      
      forest_parrots2 <- avo |>
                        filter(Family1 == "Psittacidae" &
                                 Habitat == "Forest")
      
      forest_parrots3 <- avo |>
        filter(Family1 == "Psittacidae") |>
        filter(Habitat == "Forest")
      
  # Try subsetting to a single Order and trophic level   
      
      unique(avo$Order1)
      unique(avo$Trophic.Level)
      
      
  # Subset to parrots or cockatoos
      
      parrots_or_cockatoos <- avo |>
        filter(Family1 == "Psittacidae" |
                 Family1 == "Cacatuidae")
      
      parrots_or_cockatoos2 <- avo |>
        filter(Family1 %in% c("Psittacidae","Cacatuidae")
               )

  # Combining &|
      
      #Let's only take forest parrots and woodland cockatoos
      
      fp_or_wc <- avo |>
        filter((Family1 == "Psittacidae" &
                 Habitat == "Forest")|
                 (Family1 == "Cacatuidae" &
                    Habitat == "Woodland"))
      
      
      
      fp_or_wc2 <- avo[which((avo$Family1 == "Psittacidae" &
                                     avo$Habitat == "Forest")|
                                     (avo$Family1 == "Cacatuidae" &
                                        avo$Habitat == "Woodland")),]
      
  # Try limiting the dataset to only
      
      #Forest Carnivores in either the family "Accipitridae" or "Falconidae"
      

# Arrange -----------------------------------------------------------------

      
      #Arrange by size
      
      avo_by_mass <- avo |>
        arrange(Mass)
      
      # base R
        avo_by_mass2 <- avo[order(avo$Mass),]
      
      avo_by_mass_dec <- avo |>
        arrange(-Mass)
      
      avo_by_mass_dec2 <- avo |>
        arrange(desc(Mass))
      
      # base R
        avo_by_mass_dec3 <- avo[order(avo$Mass,decreasing = TRUE),]



# Distinct ----------------------------------------------------------------


    # Remove duplicates
        
        avo_no_dupes <- avo |>
          distinct()
        
    # How many families are there?
        
      avo_famy <- avo |>
        distinct(Family1)
      
    # Which trophic levels occur in each family?
      
      family_trohich_levels <- avo |>
        distinct(Family1,Trophic.Level)
        
    # How many species in each family?
      
      avo |>
        count(Family1,sort = TRUE)


# mutate ------------------------------------------------------------------


      # Let's say we wanted to know how similar the two beak length measurements are
      
      avo_w_beak_diff <- avo |>
        mutate(beak_length_difference = Beak.Length_Culmen - Beak.Length_Nares)
      
      hist(avo_w_beak_diff$beak_length_difference)
      
      avo_w_beak_diff |>
        arrange(-beak_length_difference)
                    
    # What if we wanted to scale that by body size?  
      
      avo_w_beak_diff2 <- avo |>
        mutate(relative_beak_length_difference = (Beak.Length_Culmen - Beak.Length_Nares)/Mass)

      avo_w_beak_diff2 |>
        arrange(-relative_beak_length_difference)

# select ------------------------------------------------------------------

      # Let's only take family, species, and mass
      
      fsm <- avo |>
        select(Family1,Species1,Mass)
      
      # Let's say we want everything EXCEPT range size
      
      no_rangesize <- 
        avo |> select(!Range.Size)
      
      no_rangesize2 <- 
        avo |> select(-Range.Size)
      
      # Keep only the taxonomic fields:
      
      avo_tax <- avo |>
        select(Species1:Order1)
      
      
      # ignore the last few fields (lifestyle to range size)
      
        avo_less_fields <-
          avo |> select(!Primary.Lifestyle:Range.Size)
      
      
        avo_less_fields2 <-
          avo |> select(-Primary.Lifestyle:-Range.Size)
        
      # Check that the two give you the same results
        all(colnames(avo_less_fields)==colnames(avo_less_fields2))
        

# rename ------------------------------------------------------------------


  #Let's say we wanted to rename some of the fields
        
        avo |>
          rename(Species = Species1,
                 Family = Family1,
                 Order = Order1)
        
  # You can also do this when selecting:
        
        avo_tax2 <- 
          avo |>
          select(Species = Species1,
                 Family = Family1,
                 Order = Order1,
                 Mass)
        


# relocate ----------------------------------------------------------------


  avo_relocated <- avo |>
          relocate(Order1,Family1,Species1,Mass,Wing.Length)
          
        

# group_by ----------------------------------------------------------------

        avo_w_family_mass <- avo  |> 
          group_by(Family1) |> 
          mutate(fam_mean_mass = mean(Mass))
        
      # Check that it did what we expect  
        avo_w_family_mass |>
          select(Family1,fam_mean_mass) |>
          distinct()
        
  # Summarise 
        
    family_mass <- avo  |> 
            group_by(Family1) |> 
            summarise(Mean_Mass = mean(Mass))
          
    family_mass <- avo  |> 
            group_by(Family1) |> 
            summarise(Mean_Mass = mean(Mass),
                      SD_Mass = sd(Mass),
                      Total_Mass = sum(Mass),
                      n_species = n())      

  # Slice

    biggest_in_fams <- avo |>
      group_by(Family1) |> 
      slice_max(Mass,n = 1) |> 
      select(Family1,Species1,Mass)
    
        
    biggest_in_fams2 <- avo |>
      group_by(Family1) |> 
      arrange(-Mass) |>
      slice_head(n = 1) |>
      select(Family1,Species1,Mass)
    
    smallest_in_fams <- avo |>
      group_by(Family1) |> 
      slice_min(Mass,n = 1) |>
      select(Family1,Species1,Mass)
    
    smallest_in_fams2 <- avo |>
      group_by(Family1) |> 
      arrange(-Mass) |>
      slice_tail(n = 1) |>
      select(Family1,Species1,Mass)
    

    
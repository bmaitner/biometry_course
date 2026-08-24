# Code for lecture 25

  library(tidyverse)
  library(styler) # style package
  library(lintr) # style package
  

#let's get some data

  avo <- read_rds("https://tinyurl.com/avonetdata")


# naming ------------------------------------------------------------------

  # Which is best?
  
    parrot_data <- avo |> filter(Family1 == "Psittacidae")

    parrot-data <- avo |> filter(Family1 == "Psittacidae")
    
    parrot data <- avo |> filter(Family1 == "Psittacidae")
    

# spacing -----------------------------------------------------------------

  a <- 1 + 2 #space between these
  b <- 2^3 # no space with ^
  
  avo$Beak.Length_Culmen >= avo$Beak.Length_Nares # use space with logical operators (==, &, |)
  
  mean(x = avo$Mass, na.rm =  TRUE) # space after comma, but not next to parentheses

  
  # Both of the following are fine: 
  
    avo |>
      group_by(Family1) |>
      summarise(mean_mass        = mean(Mass),
                sd_mass          = sd(Mass),
                mean_wing_length = mean(Wing.Length),
                sd_wing_length   = sd(Wing.Length))
    
    
    avo |>
      group_by(Family1) |>
      summarise(mean_mass = mean(Mass),
                sd_mass = sd(Mass),
                mean_wing_length = mean(Wing.Length),
                sd_wing_length = sd(Wing.Length))
    

# pipes and arguments -----------------------------------------------------

  # see previous example
    

# code chunks -------------------------------------------------------------

  # ctrl+shift+R (or cmd+shift+R on Mac) inserts a section divider
    
  # you can also make your own using comments
    
###########################################################################    
    

# automated style guides --------------------------------------------------

    
  lint("R_scripts/Chapter_2_examples.R") # checks your style
    
  lint("R_scripts/Lecture_25_examples.R") # checks your style  

  style_file("R_scripts/Chapter_2_examples.R") # automatically restyles

  

# Data style --------------------------------------------------------------

avo_wide <- 
  avo |>
      select(Species1, Mass, Wing.Length) |>
      slice_head(n = 3)
  
avo_long <-  
  avo |>
  select(Species1, Mass, Wing.Length) |>
  slice_head(n = 3) |>
  pivot_longer(cols = c(Mass, Wing.Length),
               names_to = "trait",
               values_to = "trait_value")


avo_wide <- 
  avo |>
  select(Species1, Mass, Wing.Length, Beak.Width, Beak.Length_Culmen)

avo_long <-  
  avo_wide |>
  pivot_longer(cols = Mass:Beak.Length_Culmen,
               names_to = "trait",
               values_to = "trait_value")

# If you want to compare sizes of the two formats
  object.size(avo_wide)
  object.size(avo_long)

# make the data wide again
  
  avo_wide2 <-
    avo_long |>
    pivot_wider(id_cols = Species1,
                names_from = trait,
                values_from = trait_value)
  

# pseudocode --------------------------------------------------------------

  # Say we wanted to identify largest, mass-corrected, difference in beak lengths
  # Our pseudocode might be:
  
# Calculate difference in beak lengths (culmen vs nares)
# Divide difference by body mass
# Identify largest mass-corrected difference in beak lengths
    
  # We can then start to fill in the steps:
  
avo |>
# Calculate difference in beak lengths (culmen vs nares)
  mutate(delta_beak_length = Beak.Length_Culmen - Beak.Length_Nares) |>
# Divide difference by body mass
  mutate(mass_corrected_delta_beak_length = delta_beak_length / Mass) |>
# Identify largest mass-corrected difference in beak lengths
  slice_max(order_by = mass_corrected_delta_beak_length,
            n = 1) |>
    select(Species1, mass_corrected_delta_beak_length)
    
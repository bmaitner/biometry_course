# Code for chapter 2 examples
#############################

# Load libraries

library(readxl)

# Reading in data locally (relative paths)

  # Avonet data (Bird morphology and ecology)
  
    avonet <- read.csv("data/Avonet/AVONET1_BirdLife.csv")
    
  # Amniote traits
    
    amniotes <- read.csv("data/Amniote_traits/Amniote_Database_Aug_2015.csv")
    
    amniotes_v2 <- read.csv("data/Amniote_traits/Amniote_Database_Aug_2015.csv",
                         na.strings = -999)

  # European amphibians
    
    
    european_amphibs <- read_xlsx("data/European_amphibians/oo_32985.xlsx")
    
    european_amphibs_v2 <- read_xlsx("data/European_amphibians/oo_32985.xlsx",
                                skip = 3,
                                sheet = 1,
                                na = "DD")
    
# Reading in data locally (absolute paths) Note: this example won't work for you
    
    avonet <- read.csv("C:/Users/Brian Maitner/Desktop/current_projects/Statistical_ecology_course/data/Avonet/AVONET1_BirdLife.csv")
    
    
    
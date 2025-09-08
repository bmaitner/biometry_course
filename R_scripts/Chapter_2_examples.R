# Code for chapter 2 examples
#############################

# Load libraries ----------------------------------------------------------


library(readxl)
library(BIEN)
library(emdbook)

# Reading in data locally (relative paths) --------------------------------


  # Avonet data (Bird morphology and ecology)
  
    avonet <- read.csv("data/Avonet/AVONET1_BirdLife.csv")
    
  # Amniote traits
    
    amniotes <- read.csv("data/Amniote_traits/Amniote_Database_Aug_2015.csv")
    
    amniotes_v2 <- read.csv("data/Amniote_traits/Amniote_Database_Aug_2015.csv",
                         na.strings = -999)

  # European amphibians
    
    
    european_amphibs <- read_xlsx("data/European_amphibians/oo_32985.xlsx")
    
    
      # Remember, you can use ?read_xslx to check the function arguments and what they do
    
        ?read_xlsx
    
    european_amphibs_v2 <- read_xlsx("data/European_amphibians/oo_32985.xlsx",
                                skip = 3,
                                sheet = 1,
                                na = "DD")

# Reading in data locally (absolute paths) --------------------------------
    
    
    #avonet_v2 <- read.csv("C:/Users/Brian Maitner/Desktop/current_projects/Statistical_ecology_course/data/Avonet/AVONET1_BirdLife.csv")
    

# Reading in remotely -----------------------------------------------------

    
    avonet_v3 <- read.csv("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv")

    
# Getting data from an API online -----------------------------------------

    
    # sabal_palmetto_occurrences <- BIEN_occurrence_species(species = "Sabal palmetto")

    
# R data types ------------------------------------------------------------

  # Numeric    
    class(0)
    
  # Integer  
    class(1L) # The L tells R to treat it as an integer rather than numeric
  
  # Date
    class(as.Date("2025-01-01"))
    
  # POSIXt (dates and times)
    
    class(Sys.time())
    
  # Character  
    class("Optimus Prime")

  # Logical
    class(TRUE)
    
  # Factor
    factor_example <- as.factor(c("A","B","C"))
    class(factor_example)

    
# Accessing elements of an object -----------------------------------------

    
    # List
      test_list <- as.list(c("A"="Optimus Prime","B"="Megatron"))
      
        class(test_list)
      
        test_list$A
        test_list[[1]]
        test_list[1]
        test_list[["A"]]
        test_list["A"]
      
      
  # Named Vector
        
    test_named_vector <- c("A"="Optimus Prime","B"="Megatron")
    
      class(test_named_vector) #Note that it tells you "character", the class of the elements of the vector
      
      test_named_vector[[1]]
      test_named_vector[1]
      test_named_vector[["A"]]
      test_named_vector["A"]
      
  # Unnamed vector    
      
      test_vector <- c("Optimus Prime","Megatron")
      
      class(test_vector) #Note that it tells you "character", the class of the elements of the vector
      
      test_vector[[1]]
      test_vector[1]

  # Data.frame
      
    test_dataframe <- data.frame(character = c("Optimus Prime","Megatron"),
                                    faction = c("Autobot","Decepticon"))
    
    rownames(test_dataframe) <- c("A","B")
    
    class(test_dataframe)
    
    # Select a column
      test_dataframe$character
      test_dataframe[,1]
      test_dataframe["character"]
      test_dataframe[,"character"]
      
    # select a row
      test_dataframe[1,]
      test_dataframe["A",]
      
    # Select the first cell
      test_dataframe[1,1]
      test_dataframe["A","character"]

            
# Figuring out what's in an object ----------------------------------------

  # Get the class of a particular column
      class(test_dataframe$faction)
      class(test_dataframe[,2])

      
  # Summary functions
      str(test_dataframe) #shows structure
      summary(test_dataframe) #provides a summary
      table(test_dataframe) # provides a table showing counts of combinations
      head(test_dataframe) # shows the first few rows of data
      

# Converting between types ------------------------------------------------

    test_dataframe$faction <- as.factor(test_dataframe$faction)
    str(test_dataframe)    
    
    str(avonet_v3)
            

# Dealing with NAs --------------------------------------------------------

      incomplete_dataframe <- data.frame(character = c("Optimus Prime","Megatron","Unicron"),
                                   faction = c("Autobot","Decepticon",NA))
      
  # Toss all rows with missing data with na.omit()
      
      na.omit(incomplete_dataframe)
      
  # Re-assign NA values (use with caution and document this well!)
      
      incomplete_dataframe[is.na(incomplete_dataframe)] <- "Other"
    
  # Use a function that handles NA values    
      
      #The function cor checks for correlations between variables
      
        ?cor 
      
        # By default, cor uses all data, so NA's prevent you from calculation correlations
        
          cor(x = amniotes_v2$adult_body_mass_g,
              amniotes_v2$adult_svl_cm)
        
        # But, you can set the "use" argument to "complete.obs" to use only observations don't have NAs in them  
          
          cor(x = amniotes_v2$adult_body_mass_g,
              amniotes_v2$adult_svl_cm,use = "complete.obs")
          

# example in 2.6 ----------------------------------------------------------

  # The datasets in section 2.6.1 can be found at:

          # https://www.math.mcmaster.ca/~bolker/emdbook/duncan_10m.csv
          # https://www.math.mcmaster.ca/~bolker/emdbook/duncan_25m.csv
          
  # You can either download them and then load the local copy, 
  # or else you can use the URL to load them directly.        
      

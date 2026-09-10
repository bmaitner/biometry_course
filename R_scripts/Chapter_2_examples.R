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

    
    avonet_v3 <- read.csv("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv")

    
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
          

# Exploratory graphics --------------------------------------------------

  # Everything below uses avonet, which we read in at the top of this script.
  # These are the figures from the Lecture 5 slides; the code that produces
  # the slide versions is in R_scripts/Lecture_05_figures.R.


  # One variable, continuous: histogram

    hist(avonet$Mass)

      # That is one bar. It isn't broken -- it's telling you the truth badly.
      # The range runs from a 1.9 g hummingbird to a 111,000 g ostrich, so
      # 99.9% of the 11,009 species land in the first bin:

        range(avonet$Mass)
        max(avonet$Mass) / min(avonet$Mass)

      # Take logs and the shape appears

        hist(log10(avonet$Mass), breaks = 40)


  # Two variables, both continuous: scatterplot

    plot(x = avonet$Mass,
         y = avonet$Wing.Length)

      # Same problem: everything is crushed against the y axis.
      # log = "xy" puts both axes on a log scale.

        plot(x = avonet$Mass,
             y = avonet$Wing.Length,
             log = "xy")

      # This matters for more than looks. The correlation is weak on the raw
      # scale and strong on the log scale -- same data, same species:

        cor(avonet$Mass, avonet$Wing.Length, use = "complete.obs")
        cor(log10(avonet$Mass), log10(avonet$Wing.Length), use = "complete.obs")


  # The log-log plot also shows two odd things at once.

    # A row of points along the bottom, at exactly 0.1 mm:

      avonet[which(avonet$Wing.Length < 1),
             c("Species1", "Family1", "Mass", "Wing.Length")]

      # All five are kiwi (Apterygidae), which are flightless and have tiny
      # vestigial wings. A 2 kg bird does not have a 0.1 mm wing; 0.1 is a
      # placeholder standing in for "too small to measure", the same idea as
      # the -999 in the amniote data. Nothing errored. The plot found it.

    # And a handful of very heavy birds at the top right:

      avonet[which(avonet$Mass > 20000),
             c("Species1", "Mass", "Wing.Length")]

      # Ostrich, emu, cassowary, rhea. Extreme, but real measurements.
      # Outlier and error are not the same thing, and only you can tell
      # which is which -- that takes knowing the organisms.


  # Overplotting: 11,009 points is a lot of ink

    # Smaller points and partial transparency let you see where the density is

      plot(x = avonet$Mass,
           y = avonet$Wing.Length,
           log = "xy",
           pch = 16,
           cex = 0.4,
           col = rgb(red = 0, green = 0, blue = 0, alpha = 0.3))


  # One continuous variable split by a categorical one: boxplot

    boxplot(log10(Mass) ~ Trophic.Level, data = avonet)

      # The ~ means "as a function of". You'll see this formula notation
      # again for the rest of the course, in lm() and everywhere else.


  # One categorical variable: table, then barplot

    table(avonet$Habitat)

    barplot(sort(table(avonet$Habitat), decreasing = TRUE), las = 2)

      # las = 2 turns the labels sideways so they fit.


  # Two categorical variables: a table of counts

    table(avonet$Trophic.Level, avonet$Migration)


  # A caution about that last one -----------------------------------------

    # Migration is coded 1, 2, 3 (sedentary / partially migratory / migratory).
    # R stored it as an integer, so R will happily average it:

      class(avonet$Migration)

      mean(avonet$Migration)              # NA -- there are 23 missing values

      mean(avonet$Migration, na.rm = TRUE) # 1.288

    # 1.288 is a perfectly good number and a completely meaningless one.
    # There is no bird that is 1.288 migratory. The class was right, the
    # calculation ran, and the answer is nonsense. Plot it instead:

      barplot(table(avonet$Migration))


# Applying it to your own data (Lecture 6) --------------------------------

  # Lecture 5 looked at one or two variables at a time. Real datasets have
  # dozens of columns, so the next question is how to look at many at once,
  # how to compare groups, and how to make a figure someone else can read.


  # Many variables at once: the correlation matrix

    beak <- avonet[c("Beak.Length_Culmen", "Beak.Length_Nares",
                     "Beak.Width", "Beak.Depth")]

    round(cor(beak), 2)

      # Culmen length and Nares length correlate at 0.97. They are two ways of
      # measuring the same beak: from the feathers, and from the nostril. If
      # you put both in an analysis you are counting the same measurement
      # twice. This is the "identify variables to drop" bullet, made concrete.

      # cor() needs complete data. If your columns have NAs:

        round(cor(beak, use = "complete.obs"), 2)


  # The same thing as a picture

    pairs(beak, pch = 16, cex = 0.3, col = rgb(0, 0, 0, 0.15))

      # Every pair of columns, plotted against every other. The Culmen/Nares
      # panel is nearly a straight line. A number tells you there is a problem;
      # the picture tells you what kind.

    # Worth doing on a handful of columns, not fifty: the panels get too small
    # to read. Pick the variables you actually care about.

      traits <- avonet[c("Beak.Length_Culmen", "Tarsus.Length",
                         "Wing.Length", "Tail.Length", "Mass")]

      pairs(log10(traits), pch = 16, cex = 0.3, col = rgb(0, 0, 0, 0.15))


  # Comparing groups: pull out a subset

    pelicans <- avonet[which(avonet$Order1 == "Pelecaniformes"), ]

      nrow(pelicans)

      boxplot(log10(Mass) ~ Family1, data = pelicans)

    # We will do this far more comfortably with filter() next lecture.


  # Two plots side by side

    # par(mfrow) splits the plotting window into a grid: c(rows, columns).
    # Filled row by row.

      carnivores <- avonet[which(avonet$Trophic.Level == "Carnivore"), ]
      scavengers <- avonet[which(avonet$Trophic.Level == "Scavenger"), ]

      par(mfrow = c(1, 2))

        hist(log10(carnivores$Mass),
             main   = "Carnivore",
             xlab   = "log10 mass (g)",
             breaks = seq(0, 5.2, 0.2),
             xlim   = c(0, 5.2))

        hist(log10(scavengers$Mass),
             main   = "Scavenger",
             xlab   = "log10 mass (g)",
             breaks = seq(0, 5.2, 0.2),
             xlim   = c(0, 5.2))

      par(mfrow = c(1, 1))   # put it back, or every later plot stays in a grid


    # Look carefully before believing it. Each panel picked its own y axis, so
    # 20 scavengers look as numerous as 6115 carnivores. Read the axes.

      nrow(carnivores)
      nrow(scavengers)

    # Fixing ylim makes the panels comparable, and putting n in the title means
    # nobody has to guess.

      par(mfrow = c(1, 2))

        hist(log10(carnivores$Mass),
             main   = paste0("Carnivore (n = ", nrow(carnivores), ")"),
             xlab   = "log10 mass (g)",
             breaks = seq(0, 5.2, 0.2),
             xlim   = c(0, 5.2),
             ylim   = c(0, 1000))

        hist(log10(scavengers$Mass),
             main   = paste0("Scavenger (n = ", nrow(scavengers), ")"),
             xlab   = "log10 mass (g)",
             breaks = seq(0, 5.2, 0.2),
             xlim   = c(0, 5.2),
             ylim   = c(0, 1000))

      par(mfrow = c(1, 1))


  # Four groups means four blocks of nearly identical code

    # You could keep going by hand:

      herbivores <- avonet[which(avonet$Trophic.Level == "Herbivore"), ]
      omnivores  <- avonet[which(avonet$Trophic.Level == "Omnivore"), ]

      # ...and then four hist() calls, differing by one word each, with ylim
      # written out four times. Tedious, easy to mistype, and if you change your
      # mind about the axis you have to change it in four places.


  # A for loop does the same thing once

    # for (name in vector) { commands } runs the commands once for each element
    # of the vector, setting name to that element each time. Bolker introduces
    # these in section 2.6.1, in the paragraph beginning "for loops are a
    # general way of executing similar commands many times".

    # Start by watching what the loop variable does:

      for (level in c("Carnivore", "Herbivore", "Omnivore", "Scavenger")) {

        print(level)

      }

    # Now put the plotting code inside it:

      par(mfrow = c(2, 2))

        for (level in c("Carnivore", "Herbivore", "Omnivore", "Scavenger")) {

          group <- avonet[which(avonet$Trophic.Level == level), ]

          hist(log10(group$Mass),
               main   = paste0(level, " (n = ", nrow(group), ")"),
               xlab   = "log10 mass (g)",
               breaks = seq(0, 5.2, 0.2),
               xlim   = c(0, 5.2),
               ylim   = c(0, 1000))

        }

      par(mfrow = c(1, 1))

    # Four panels, one copy of the code, and ylim appears once. That last part
    # matters more than the typing you saved.

    # You will meet a loop again today: section 2.6.2.3 of the R supplement uses
    # one to make small multiples of the seed data. It also shows a one-line
    # lattice alternative, histogram(~ x | species).

    # Lecture 8 does the same job in ggplot2 with facet_wrap(~ Trophic.Level).


  # Making a figure someone else can read

    # Default labels are variable names. Yours should be words, with units.

      plot(x    = log10(avonet$Mass),
           y    = log10(avonet$Wing.Length),
           xlab = "Body mass (log10 g)",
           ylab = "Wing length (log10 mm)",
           main = "Wing length scales with body mass in 11,009 bird species",
           pch  = 16,
           cex  = 0.3,
           col  = rgb(0, 0, 0, 0.2))

    # A trend line, using lm() from Lecture 3

      fit <- lm(log10(Wing.Length) ~ log10(Mass), data = avonet)

      abline(fit, col = "red", lwd = 3)

      coef(fit)   # slope is 0.339


  # Saving a figure

    # If you submit a .R script, the grader runs your code and the plots appear.
    # If you want the image file itself, wrap the plot in png() and dev.off():

      png("my_figure.png", width = 900, height = 650)

        plot(log10(avonet$Mass), log10(avonet$Wing.Length),
             xlab = "Body mass (log10 g)",
             ylab = "Wing length (log10 mm)")

      dev.off()   # nothing is written to the file until you run this

    # Everything between png() and dev.off() goes into the file instead of the
    # plot pane, so you will not see it appear on screen. That is normal.
    # RStudio's Export button in the Plots pane does the same thing by hand.


# example in 2.6 (the R supplement) ---------------------------------------

  # The R supplement rebuilds Bolker's seed predation dataset from the two
  # raw Excel exports, which live at:

          # https://www.math.mcmaster.ca/~bolker/emdbook/duncan_10m.csv
          # https://www.math.mcmaster.ca/~bolker/emdbook/duncan_25m.csv

  # You do not need to do that reconstruction to do the plotting sections.
  # The finished dataset ships with the emdbook package:

    library(emdbook)

    data(SeedPred)

      str(SeedPred)      # 11803 observations of 9 variables

    # Every plotting section of the supplement assumes SeedPred already
    # exists, so this one line gets you to the part that matches the reading.

  # The other datasets used in chapter 2 are in there too:

    data(ReedfrogPred)      # tadpole predation, factorial experiment
    data(ReedfrogFuncresp)  # functional response
    data(DamselRecruitment)
    data(GobySurvival)

  # If you do want to read section 2.6.1: it uses melt() from the reshape
  # package, which is retired and is not in this project's renv.lock. Read it
  # for the ideas, not to run it. We will do exactly this reshaping in
  # Lecture 7 with pivot_longer(), which is the current way to do it.

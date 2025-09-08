#' @description
#' This code provides an example of how you might document your code using commenting.
#' @author Brian Maitner


# What are comments? ------------------------------------------------------

# This is a typical R file. You can add comments (bits of text that aren't run) using the pound sign

# R ignores everything to the right of a comment,
# so you can use it to keep track of what you did and why, e.g.,

  summary(cars) # This provides a summary of the cars dataset
  ?cars # This provides information on the cars dataset

# You can also use comments to ignore certain lines of code temporarily

 #cor(cars) # This line wont run unless you delete the pound sign or select only the text to the right of the pound sign.

# Making code reproducible ------------------------------------------------


# In an R file, you can't save plots the way you can in a .Rmd output, so its more critical the data they use be available easily.
# If you want to submit your work in .R format, make sure it will work on anyone's computer.
# One easy way to do this is to use URLs to load data, rather than local copies.

# For example this won't work for you:

  #avonet <- read.csv("C:/Users/Brian Maitner/Desktop/current_projects/Statistical_ecology_course/data/Avonet/AVONET1_BirdLife.csv")

# This will work if you clone this Github repository

  #avonet <- read.csv("data/Avonet/AVONET1_BirdLife.csv")

# But this should work for anyone:

  avonet <- read.csv("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv")



# Data in R packages ------------------------------------------------------

  # Some R packages, and base R itself, have small sets of data included for examples.
  # In these cases, you can just use the name of the dataset.
  # This is why we could use the cars dataset earlier.
  # Another example is the pressure dataset:

  plot(pressure)


# Digging into data -------------------------------------------------------


  
## Documenting object structure

avonet <- read.csv("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv")

str(avonet)

## Example Figure 1


plot(x = avonet$Centroid.Latitude,
     y = log10(avonet$Range.Size),
     xlab = "Centroid Latitude",
     ylab = "Range Size")
trend_line <- lm(log10(avonet$Range.Size)~avonet$Centroid.Latitude)
abline(trend_line,col="blue",lwd=3)



# Example Figure 2: The importance of proper scale

  # In biology, some patterns are often more easily seen when transformed in some way.  The log transformation is a common transformation that has strong biological justifications. We'll see why this is so later, but for now just take my word for it.

  plot(x = avonet$Mass,
       y = avonet$Wing.Length,
       xlab = "Mass",
       ylab = "Wing Length")

  # The pattern doesn't appear very obvious here.  There might be a relationship, but it's a bit hard to tell. Let's do a log10 transformation instead.


  plot(x = log10(avonet$Mass),
       y = log10(avonet$Wing.Length),
       xlab = "log10(Mass)",
       ylab = "log10(Wing Length)")
  
  # Much more clear now!
  
# Example Figure 3
  

Pelecaniformes <- subset(x = avonet,
                         subset = Order1 == "Pelecaniformes")

names(Pelecaniformes)[4] <- "Order" #Rename Order1 to Order
names(Pelecaniformes)[3] <- "Family" #Rename Order1 to Order

boxplot(data=Pelecaniformes,log10(Mass) ~ Family)


# Example table


avonet_continuous_traits <-
  avonet[c("Beak.Length_Culmen",
           "Beak.Length_Nares",
           "Beak.Width",
           "Beak.Depth",
           "Tarsus.Length",
           "Wing.Length",
           "Kipps.Distance",
           "Secondary1",
           "Hand.Wing.Index",
           "Tail.Length",
           "Mass")]

avonet_beak <- avonet[c("Beak.Length_Culmen",
                        "Beak.Length_Nares",
                        "Beak.Width",
                        "Beak.Depth")]

round(cor(avonet_beak),2)


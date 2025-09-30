# Chapter 5: Simulations and Power Analysis


# Basic example -----------------------------------------------------------

x <- 1:20
a <- 2
b <- 1

y_det <- a + b * x

plot(x = x,y = y_det)

# Add stochasiticty 

  y_stoch <- rnorm(n = 20, mean = y_det, sd = 2)
  
  plot(x=x, y=y_stoch)
  
  points(x,y_det,col="blue")
  abline(a = 2, b = 1,col="darkblue")

# Sample a few times to see stochasticity
  
  y_stoch <- rnorm(n = 20, mean = y_det, sd = 2)
  plot(x=x, y=y_stoch)
  
  y_stoch <- rnorm(n = 20, mean = y_det, sd = 2)
  plot(x=x, y=y_stoch)


# variance increases with mean --------------------------------------------

  x <- 1:20
  a <- 2
  b <- 1
  sd_multiplier = 0.3
  
  y_det <- a + b * x
  y_stoch <- rnorm(n = 20, mean = y_det, sd = y_det*sd_multiplier)
  
  plot(x=x, y=y_stoch)
  points(x,y_det,col="blue")
  

# negative binomial -------------------------------------------------------

  ?rnbinom
  # mu = mean
  # size = dispersion parameter
  
  
  a <- 20
  b <- 1
  k <- 5
  x <- runif(50, min=0, max=5)
  
  y_det <- a/(b+x)
  
  plot(x = x,y=y_det)
  
  y <- rnbinom(n = 50,mu = y_det,size = k)
  
  plot(x = x,y=y)  
  

# 2 categorical groups ------------------------------------------------------

g <- factor(rep(1:2,each=25))
  
  # alternatively, it may be easier to remember  
  g <- factor(rep(c(1,2),25))
  
a <- c(20,10)
b <- c(1,2)
k <- 5
x <- runif(50,min=0,max=5)

y_det <- a[g]/(b[g]+x)

plot(x = x,y=y_det)

y <- rnbinom(n = 50,size = k,mu = y_det)

plot(x = x, y = y)
plot(x = x, y = y, col = g)
plot(x = x, y = y, pch = as.numeric(g))

plot(x = x, y = y, col = g, pch=as.numeric(g))
points(x = x, y = y_det, col =g, pch = as.numeric(g)+15) #note the +15 bit only works in this specific case and isn't general to fill in the points

library(ggplot2)
ggplot(mapping = aes(x=x,y=y,colour = g))+
  geom_point()+
  geom_line(mapping = aes(x=x,y=y_det,colour = g))


# alternative approach to categorical groups ------------------------------

# Alterantively, it may be easier to keep all of the information in a single data frame

library(tidyverse)
library(ggplot2)

# Make a data.frame containing the chosen parameters

  species_parms <- 
    data.frame(species = c(1,2),
             a = c(20,10),
             b = c(1,2),
             k = 5)

# Make a data.frame containing random x draws for each species

  x_values_per_species <- 
    data.frame(species = rep(c(1,2),25),
               x = runif(50,min=0,max=5))

# Combine the two

  combined_data <-  x_values_per_species %>%
    left_join(species_parms)
  
# Make species a factor
  
  combined_data <- 
  combined_data %>%
    mutate(species = as.factor(species))

# Use mutate to calculate y_det
  
  combined_data <-
    combined_data %>%
      mutate(y_det = a/(b+x))
  
# Plot determinate bit
  
  ggplot(data = combined_data,
         mapping = aes(x=x,y=y_det,colour = species))+
    geom_point()
  
  
# Add stochastic bit:
  
  combined_data <-
  combined_data %>%
    rowwise() %>% # note this bit!
    mutate(y = rnbinom(n = 1,size = k,mu = y_det))

  
# Plot 

  ggplot(data = combined_data ,
         mapping = aes(x=x,y=y,colour = species))+
    geom_point()+ #these first three lines plot the points for the elements with stochasticity
    geom_line(mapping = aes(x=x,y=y_det,color=species)) #this adds a line for the determinate estimates
  







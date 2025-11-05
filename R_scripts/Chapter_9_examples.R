# Code corresponding to ideas in chapter 9


# begin lecture 21 --------------------------------------------------------


# Load packages

library(readr)
library(bbmle)

# Load data

  avo <- read_rds("https://tinyurl.com/avonetdata") %>%
    filter(Family1 == "Psittacidae")


# Plot of Beak Depth vs Beak Width
  
  plot(avo$Beak.Depth, avo$Beak.Width)
  
  library(ggplot2)

  ggplot(data = avo,mapping = aes(x=Beak.Width,y=Beak.Depth))+
    geom_point()+geom_smooth(method = "lm")

  

# simple linear regression ------------------------------------------------

    
# Fit with MLE
  
  avo.mle <- mle2(data = avo,
       minuslogl = Beak.Width ~ dnorm(mean = int + a*Beak.Depth,
                                      sd = sd),
       start = list(int = 0,
                    a = 1,
                    sd = 1))

  summary(avo.mle)
  
# Fit with lm
  
  avo.lm <- lm(data = avo,
               formula = Beak.Width ~ Beak.Depth)
    
  summary(avo.lm)  
  
# Get lm coefficients, etc
  
  avo.lm$coefficients
  avo.lm.summary <- summary(avo.lm)  
  avo.lm.summary$r.squared
  avo.lm.summary$sigma
  avo.lm.summary$coefficients
  

# Compare fits    

  AICtab(avo.lm,avo.mle)  
  

# multiple linear regression ----------------------------------------------


# polynomials -------------------------------------------------------------

  
  avo.mle.poly <- mle2(data = avo,
                       minuslogl = Beak.Width ~ dnorm(mean = int + a*Beak.Depth + b*Beak.Depth^2,
                                                      sd = sd),
                       start = list(int = 0,
                                    a = 1,
                                    b = 0,
                                    sd = 1))
  
  avo.lm.poly.1 <- lm(data = avo,
               formula = Beak.Width ~ poly(Beak.Depth,2))
  
  avo.lm.poly.2 <- lm(data = avo,
                      formula = Beak.Width ~ poly(Beak.Depth,2,raw = TRUE))
  
  
  avo.lm.poly.3 <- lm(data = avo,
                      formula = Beak.Width ~ Beak.Depth + I(Beak.Depth^2))


  AICtab(avo.lm.poly.1,
         avo.lm.poly.2,
         avo.lm.poly.3,
         avo.mle.poly)  
  
  avo.lm.poly.1
  avo.lm.poly.2
  
  plot(predict(avo.lm.poly.1),predict(avo.lm.poly.2))
  plot(predict(avo.lm.poly.2),predict(avo.lm.poly.3))
      
  # Why do we need poly or I?
  
    avo.lm.poly.4 <- lm(data = avo,
                        formula = Beak.Width ~ Beak.Depth + Beak.Depth + Beak.Depth^2)
    
    summary(avo.lm.poly.4)  # A term for beak depth squared isn't fitted!


# multiple predictors -----------------------------------------------------


    avo.mle.mr <- mle2(data = avo,
                         minuslogl = Beak.Width ~ dnorm(mean = int + a*Beak.Depth + b*Beak.Depth^2 +
                                                                 c*Beak.Length_Nares,
                                                        sd = sd),
                         start = list(int = 0,
                                      a = 1,
                                      b = 0,
                                      c = 0,
                                      sd = 1))
    
    
    avo.lm.mr <- lm(data = avo,
                        formula = Beak.Width ~ poly(Beak.Depth,2) + Beak.Length_Nares)

    
    # Again, the two models give comparable fits
    
      AICtab(avo.mle.mr,
             avo.lm.mr)
      

# the best models so far --------------------------------------------------


  AICtab(avo.lm,
         avo.lm.mr,
         avo.lm.poly.1,
         avo.lm.poly.2,
         avo.lm.poly.3,
         avo.mle.poly,
         avo.mle,
         avo.mle.mr)      
  
  # If you want to test them (keeping in mind this only work with nested models)    
    anova(avo.lm, avo.lm.mr)    
            
    

# categorical predictors --------------------------------------------------


    # Do beaks differ with habitat type?
    
    avo.mle.anova <- mle2(data = avo,
                       minuslogl = Beak.Width ~ dnorm(mean = a,
                                                      sd = sd),
                       start = list( a = 1,
                                    sd = 5),
                       parameters = list(a ~ Habitat - 1))
    
    
    avo.lm.anova.1 <- lm(data = avo,
       formula = Beak.Width ~ Habitat)
    
    avo.lm.anova.2 <- lm(data = avo,
                         formula = Beak.Width ~ Habitat-1)
    

    AICtab(avo.mle.anova,
           avo.lm.anova.1,
           avo.lm.anova.2)        
    
    
    avo.lm.anova.1
    avo.lm.anova.2
    

# A note on factors -------------------------------------------------------

 # By default, factor levels are alphabetized.  If we want to change that, we can use order()
    
# let's set Human Modified as the default
    
    unique(avo$Habitat)
    
    avo$Habitat <- factor(x = avo$Habitat,
                          levels = c("Human Modified",
                                     "Desert",
                                     "Grassland",
                                     "Shrubland",
                                     "Woodland",
                                     "Forest"))
    
    lm(data = avo,
       formula = Beak.Width ~ Habitat) |> summary()
    
    # we can see that although the estimates for habitats differ from human dominated, those differences aren't significant 
    

# multi-way anova ---------------------------------------------------------

    avo.lm.multianova.1 <- lm(data = avo,
                         formula = Beak.Width ~ Habitat + Trophic.Niche -1 )
    
    avo.lm.multianova.2 <- lm(data = avo,
                              formula = Beak.Width ~ Habitat * Trophic.Niche -1)

    AICtab(avo.lm.multianova.1,
           avo.lm.multianova.2)    

    summary(avo.lm.multianova.2)
    
    anova(avo.lm.multianova.2)
    anova(avo.lm.multianova.1)
    
    
    # Note that you can also use aov() instead of lm() |> anova()
    
      aov(data = avo,
          formula = Beak.Width ~ Habitat * Trophic.Niche -1) |> summary()
    
    
    # To test for differences among groups, use TukeyTest
      
      
      avo.lm.multianova.2 |> aov() |> TukeyHSD()
      
      
    # lets see if we're justified in omitting the habitat in favor of trophic niche
      # The previous fits suggest that Trophic niche might not be very powerful
    
      avo.lm.tn <- lm(data = avo,
                                formula = Beak.Width ~ Trophic.Niche -1 )
    
    # So even though the model with trophic niche does better than the model with habitat,
      # the combination of the two is still preferred    
      
      AICtab(avo.lm.tn,
             avo.lm.multianova.1,
             avo.lm.multianova.2,
             avo.lm.anova)
      

# ancova ------------------------------------------------------------------


      # For an example we'll use a simpler model
      
      avo.ancova.1 <- lm(data = avo,
                        formula = Beak.Width ~ Beak.Depth + Trophic.Niche -1 )
      
      avo.ancova.2 <- lm(data = avo,
                       formula = Beak.Width ~ Beak.Depth * Trophic.Niche -1 )
      
      
      AICtab(avo.lm,avo.ancova.1,avo.ancova.2)    
      summary(avo.ancova.2)
      

# End: lecture 21 ---------------------------------------------------------

      
      
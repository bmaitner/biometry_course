# Code corresponding to ideas in chapter 9


# begin lecture 23 --------------------------------------------------------


# Load packages

library(readr)
library(bbmle)
library(tidyverse)

# Load data

  avo <- read_rds("https://tinyurl.com/avonetdata") |>
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
      

# End: lecture 23 ---------------------------------------------------------


# Begin lecture 24 --------------------------------------------------------

      
      library(readr)
      library(bbmle)
      library(tidyverse)
      
      

# NLS ---------------------------------------------------------------------


      
      library(emdbook)
      
      # Frogs
      
        data(ReedfrogFuncresp)      
        
        plot(ReedfrogFuncresp$Killed~ReedfrogFuncresp$Initial)
        
        frog.lm <- lm(Initial ~ Killed,
                      data = ReedfrogFuncresp)
        
        frog.nls.0 <- nls(Initial ~ int+ a*Killed,
                          data = ReedfrogFuncresp)
        
        frog.nls.1 <- nls(Initial ~ int+ a*Killed^b,
                          data = ReedfrogFuncresp)
        
  
        summary(frog.lm)
        summary(frog.nls.0)
        summary(frog.nls.2)
        
        AICtab(frog.nls.1,frog.nls.2,frog.lm,frog.nls.0)
      
      # Fir
        
        data(FirDBHFec_sum)
        
        FirDBHFec_sum <- na.omit(FirDBHFec_sum)
        
        plot(FirDBHFec_sum$fecundity ~ FirDBHFec_sum$DBH)
        
        lm(fecundity ~ DBH, data=FirDBHFec_sum)
        
        fir.nls.0 <- nls(fecundity ~ int+ a*DBH,
                          data = FirDBHFec_sum)
        
        fir.nls.1 <- nls(fecundity ~ int+ a*DBH^b,
                          data = FirDBHFec_sum)
        
        AICtab(fir.nls.0,fir.nls.1)        
        
        

# gnls and nlsList --------------------------------------------------------

  library(nlme)
        
        
        fir.nlslist <- nlsList(model = fecundity ~ int + a*DBH^b | pop,
                data = FirDBHFec_sum,
                start = coef(fir.nls.1))
        
        summary(fir.nlslist)
        
        #AIC(fir.nlslist[) # doesn't work
        AICtab(fir.nlslist,base=TRUE)
        
        fir.gnls.0 <- gnls(fecundity ~ int+a*DBH^b,
                         data = FirDBHFec_sum,
                         params = list(int ~ 1, a ~ 1, b ~ 1),
                         start= list(int = 0.58, a = 0.5, b = 2),
                         control=list(tolerance=10)) #tolerance needed for fitting
        
        fir.gnls.1 <- gnls(fecundity ~ int+a*DBH^b,
             data = FirDBHFec_sum |> na.omit(),
             params = list(int ~ 1, a ~ 1, b ~ pop),
             start= list(int = 0.58, a = 0.5, b = c(2,2)),
             control=list(tolerance=10))
        
        fir.gnls.2 <- gnls(fecundity ~ int+a*DBH^b,
                         data = FirDBHFec_sum |> na.omit(),
                         params = list(int ~ pop, a ~ pop, b ~ pop),
                         start= list(int = c(0.58,0.58), a = c(0.5,0.5), b = c(2,2)),
                         control=list(tolerance=10))

        
        AICtab(fir.nls.1,fir.gnls.0,fir.gnls.1,fir.gnls.2)        
        
        summary(fir.gnls.1)
        summary(fir.nls.1)


# glms --------------------------------------------------------------------

        # Load data
        
        library(readr)
        
        code_data <- readr::read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Code_sharing/code_data.RDS")
        
        code_data <- readr::read_rds("https://tinyurl.com/codesharingdata")

        
        
        
    # Binomial data ( code included or not?)    
                
      code.glm  <- glm(formula = cbind(r_scripts_available, 1-r_scripts_available) ~ year + data_available + open_access,
            family = binomial(link = "log"),
            data = code_data)
      
      code.lm  <- lm(formula = r_scripts_available ~ year + data_available + open_access,
                        data = code_data)
      
      code.glm1  <- glm(formula = r_scripts_available ~ year + data_available + open_access,
                                 family = binomial,
                                 data = code_data)
      
      AICtab(code.lm,code.glm, code.glm1)

      summary(code.lm)
      summary(code.glm)
      summary(code.glm1)
      
    # Plot predictions
      
      plot(predict(code.lm) ~ code_data$year)
      abline(h = 0)

      plot(plogis(predict(code.glm)) ~ code_data$year)
      abline(h = 0)

      
    # Plot confidence intervals
      
      predict(code.lm,interval = "confidence")
      
      predict(code.lm,interval = "prediction")
      

      

    # Poisson data (number of citations over time)
      
      citations.glm0 <- glm(data = code_data,
                            family = "poisson",
                            formula = citations ~ 
                              age_y)
      
      
      citations.glm1 <- glm(data = code_data,
                family = "poisson",
                formula = citations ~ 
                  r_scripts_available*age_y+
                  open_access*age_y +
                  data_available*age_y +
                  data_available*r_scripts_available+
                  r_scripts_available*open_access+
                  open_access*data_available)
      
    AICtab(citations.glm0,
           citations.glm1)
        
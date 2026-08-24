

# Chapter 8.3 seed removal examples ---------------------------------------

library(emdbook)
library(bbmle)
library(tidyverse)

# load data

  data("SeedPred")
  
# What do these data contain?
  
  ?SeedPred

# subset to only records with seeds available

  SeedPred <- SeedPred[which(SeedPred$available > 0),]

# toss NAs
  
  SeedPred <- na.omit(SeedPred)
  
# make a subset where the number of seeds taken is not zero (nz)
  
  nz <- SeedPred |> filter(taken > 0)


# visualizing data --------------------------------------------------------

# We need to figure out which distribution to use
  
  # what might we use to do that?
    
  hist(SeedPred$taken)
  
  library(lattice)

  barchart(table(SeedPred$taken),
           stack = FALSE)
  
  barchart(table(SeedPred$taken,
                 SeedPred$available),
           stack=FALSE)
  
    
  barchart(table(nz$taken, nz$available, nz$dist, nz$species),
           stack = FALSE)
  
  barchart(table(nz$taken, nz$species, nz$dist, nz$available),
           stack = FALSE)
  
  barchart(table(nz$species, nz$available, nz$dist,
                 nz$taken), stack = FALSE)
  
  barchart(table(nz$available, nz$dist, nz$taken),
           stack = FALSE)
  
  barchart(table(nz$available, nz$species, nz$taken),
           stack = FALSE)
  
  # What distributions make sense?  What factors should we think about?
  
      # since its binary (taken/not-taken) binomial and beta-binomial are sensible
  
      # since there are a lot of zeroes, we might need a zero-inflated distribution
  
  #zero-inflated binomial
  
    dzibinom <- function(x, prob, size, zprob, log = FALSE){
      
      logv <- log(1 - zprob) + dbinom(x, prob = prob, size = size, log = TRUE)
      logv <- ifelse(x == 0, log(zprob + exp(logv)), logv)
      
       if (log){logv}else{ exp(logv)}
      
    }
  
  # zero-inflated beta binomial
    
    dzibb <- function(x, size, prob, theta, zprob, log = FALSE) {
      logv <- ifelse(x > size, NA, log(1 - zprob) +
                        dbetabinom(x, prob = prob,
                                   size = size,
                                   theta = theta,
                                   log = TRUE))
      logv <- ifelse(x == 0, log(zprob + exp(logv)),logv)
      
      if(log){logv}else{exp(logv)}
      
      
      }
  
  # fit the distributions
    
    
    SP.bb <- mle2(taken ~ dbetabinom( size = available,
                                      prob = prob,
                                      theta = theta),
                  start = list(prob = 0.5,
                               theta = 1),
                  data = SeedPred)
    
    SP.bb
    
    SP.b <- mle2(taken ~ dbinom(size = available,
                                prob = prob),
                  start = list(prob = 0.5),
                  data = SeedPred)
    
    
    SP.zibb <- mle2(taken ~ dzibb(size = available,
                                  prob = prob,
                                  theta = theta,
                                  zprob = plogis(logitzprob)),
                    start = list(prob = 0.5,
                                 theta = 1,
                                 logitzprob = 0),
                    data = SeedPred)
    
    SP.zib <- mle2(taken ~ dzibinom(size = available,
                                    prob = p,
                                    zprob = plogis(logitzprob)),
                   start = list(p = 0.2,
                                logitzprob = 0),
                   data = SeedPred)

    SP.zib  

    
    # Which model fits best?
    
    AICtab(SP.bb,SP.b,SP.zib,SP.zibb)
    


# DIfferences due to distance from forest ---------------------------------


  # Now that we've identified the correct distribution, we can start asking interesting questions
    
    # Does the seed predation function differ as a function of distance?
    
    SP.bb.dist <- mle2(taken ~ dbetabinom(prob,
                                         size = available,
                                         theta),
                      parameters = list(prob ~ dist - 1,
                                        theta ~ dist - 1),
                      start = as.list(coef(SP.bb)),
                      data = SeedPred)
    
    # Check out the model parms
    
   summary(SP.bb.dist) #all significant, but theta estimates are nearly identical
   # since the theta estimates are so similar, we might try a simpler model (a single theta)
   # for funsies, we can also try a model with a single prob, which should fit worse
   
    
      # We can also try the component models
    
    SP.bb.dist.prob <- mle2(taken ~ dbetabinom(prob,
                                          size = available,
                                          theta),
                       parameters = list(prob ~ dist - 1),
                       start = as.list(coef(SP.bb)),
                       data = SeedPred)
    
    SP.bb.dist.theta <- mle2(taken ~ dbetabinom(prob,
                                          size = available,
                                          theta),
                       parameters = list(theta ~ dist - 1),
                       start = as.list(coef(SP.bb)),
                       data = SeedPred)
    
    
  # How do we compare this model with the previous, simpler one?
    
    # Can use AIC.  Also, since the two are nested, we can use LRT
    
      AICtab(SP.bb.dist,
             SP.bb,
             SP.bb.dist.prob,
             SP.bb.dist.theta)

    # Can also to an LRT using anova for nested subsets
      
      anova(SP.bb.dist, SP.bb)
      anova(SP.bb.dist, SP.bb.dist.prob)
      
    # AIC says Sp.bb.dist.prob (model where distance influences prob) is best
    # anova says it isn't significantly better than Sp.bb.dist
      
      SP.bb.dist@coef
      SP.bb.dist.prob@coef
      
      #The two theta parameters are nearly identical identical
      

# Differences due to species ----------------------------------------------

      

      SP.bb.sp <- mle2(taken ~ dbetabinom(prob = prob,
                                           theta = theta,
                                           size = available),
                        parameters = list(prob ~ species,  
                                          theta ~ species),
                        start = c(prob = -2,
                                  theta = -1),
                        data = SeedPred)
      
      # Transformation to keep values where we need them
    
      
      SP.bb.sp <- mle2(taken ~ dbetabinom(prob = plogis(lprob), #keeps b/t -1 and 1
                                          theta = exp(ltheta),  #keeps b/t 0 and Infinite
                                          size = available),
                       parameters = list(lprob ~ species,  
                                         ltheta ~ species),
                       start = c(lprob = -1,
                                 ltheta = -1),
                       data = SeedPred)
      
    
      # What now?
      
      # Check the parameters!
      
      summary(SP.bb.sp)
      
        # most of the probability values are significant, but not the thetas
        # How might we adjust our model?
      
      
      
      SP.bb.sp.prob <- mle2(taken ~ dbetabinom(prob = plogis(lprob), # logis keeps b/t -1 and 1
                                          theta = exp(ltheta), # exp keeps b/t 0 and +Inf
                                          size = available),
                       parameters = list(lprob ~ species),
                       start = list(lprob = -1,
                                 ltheta = -1),
                       data = SeedPred)
      
      # Note: could also take start values from previous model, i.e.:
      
      startvals <- list(lprob = qlogis(coef(SP.bb.dist)["prob.dist10"]),
                        ltheta = log(coef(SP.bb.dist)["theta.dist10"]))
      
      
      summary(SP.bb.sp.prob) #most things are significant
      
      
      # Compare fits
        
        AICtab(SP.bb.sp,
               SP.bb.sp.prob)
        
        anova(SP.bb.sp,
              SP.bb.sp.prob)


# Does probability of removal depend on seed mass?
        
        #this formulation omits the intercept, making plotting easier
        
        SP.bb.sp.prob.v2  <- mle2(taken ~ dbetabinom(prob = plogis(lprob),
                                theta = exp(ltheta),
                                size = available),
             parameters = list(lprob ~ species-1),
             start = startvals,
             data=SeedPred)
        
        # Note that the two models are identical:
        
          AICtab(SP.bb.sp.prob,
                 SP.bb.sp.prob.v2)
        
        # Plot the predicted values:
          
          sp_preds <- coef(SP.bb.sp.prob.v2)[1:8] #get parms other than theta
          sp_preds <- plogis(sp_preds) #convert back to OG scale
              
          sp_ci <- confint(object = SP.bb.sp.prob.v2,method = "quad") #quadratic approximation for speed          
          sp_ci <- plogis(sp_ci) #transform to og scale          
            
          plot(x = SeedPred_mass,
               y = sp_preds,
               ylim=c(min(sp_ci[,1]),
                      max(sp_ci[,2])))
          
          arrows(x0 = SeedPred_mass,
                 y0 = sp_ci[1:8,1],
                 y1 = sp_ci[1:8,2],
                 code=3,
                 angle=90)
          
      # There MAY be some relationship (decrease with mass?)
          

# removed as a function of date -------------------------------------------


  library(tidyverse)
  library(ggplot2)
          
  SeedPred |>
    mutate(prop_taken = taken/available)|>
    group_by(date)|>
    summarise(mean_taken = mean(prop_taken))|>
    ggplot(mapping = aes(x=date,y=mean_taken))+
    geom_point()
    


          

# notes -------------------------------------------------------------------

      
      
        # Note in the inverses of these functions:
          log(exp(-11))
          exp(log(10))
        
          qlogis(plogis(-1))
          plogis(qlogis(.1))

          plogis(-10000000000000)
          
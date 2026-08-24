# Examples from chapter 7


# tadpole predation redux -------------------------------------------------

library(emdbook)
library(bbmle)
library(tidyverse)

data("ReedfrogFuncresp")

plot(x = ReedfrogFuncresp$Initial,
     y = ReedfrogFuncresp$Killed,
     xlab = "Initial",
     ylab = "Killed")



binomNLL2 <- function(params, N, k){
  a = params[1]
  h = params[2]
  pred_prob = a/ (1+a*h*N)
  
  -sum(dbinom(x = k,size = N, prob = pred_prob,log = TRUE))
  
}  


# optimize with mle2

parnames(binomNLL2) <- c("a","h") # quirk of mle2: need to set the parm names

m1 <- mle2(minuslogl = binomNLL2,
           start = c(a=.5,h=2),
           data = list(k = ReedfrogFuncresp$Killed,
                       N = ReedfrogFuncresp$Initial))
m1@method

# Here's how we'd do that with the formula format:

m1.a <- mle2(
  Killed ~ dbinom(size = Initial,
                  prob = a / (1 + a * h * Initial)),
  start = list(a = 0.5, h = 2),
  data = ReedfrogFuncresp
)


# tadpole predation brute force -------------------------------------------

# we need to select the data we wish to test in our brute force optimization

  a_vec = seq(from=0.1, to=0.9, by=.01)
  h_vec = seq(from=0.005, to=0.9, by=.001)
  
  likelihood_surface <- expand.grid(a_vec,h_vec) |> as.data.frame()
  colnames(likelihood_surface) <- c("a","h")
  likelihood_surface$nll <- NA

  for(i in 1:nrow(likelihood_surface)){
    
    likelihood_surface$nll[i] <- binomNLL2(params = c(a=likelihood_surface$a[i],
                                                      h=likelihood_surface$h[i]),
                                           N = ReedfrogFuncresp$Initial,
                                           k = ReedfrogFuncresp$Killed)
    
    
  }

  # selecting the best value
  
  best_brute_force <- likelihood_surface[which.min(likelihood_surface$nll),]

  #Compare with m1
  best_brute_force
  m1


# timing the functions ----------------------------------------------------

  mle2_time <- system.time(  m1 <- mle2(minuslogl = binomNLL2,
                           start = c(a=.5,h=2),
                           data = list(k = ReedfrogFuncresp$Killed,
                                       N = ReedfrogFuncresp$Initial))
  )
  
  
  brute_force_time <- system.time(
    
    for(i in 1:nrow(likelihood_surface)){
      
      likelihood_surface$nll[i] <- binomNLL2(params = c(a=likelihood_surface$a[i],
                                                        h=likelihood_surface$h[i]),
                                             N = ReedfrogFuncresp$Initial,
                                             k = ReedfrogFuncresp$Killed)
      
      
    }
    
    
    
    
  )

  # compare times
  
  brute_force_time["elapsed"]/mle2_time["elapsed"]
  
  

# crude estimate of time vs parameters ------------------------------------

time_per_nll <- brute_force_time["elapsed"]/nrow(likelihood_surface)

 #assume 100 values per parameter
  
  n_parameters <- 1:6
  time_for_brute_force <- (100^n_parameters) *time_per_nll
  
  time_table <- 
  data.frame(n_parms = n_parameters,
             time_s = time_for_brute_force)|>
    mutate(time_h = time_s/3600) |>
    mutate(time_d = time_h/24) |>
    mutate(time_y = time_d/365.25)
  
  time_table

# optimization algorithms -------------------------------------------------

  # BFGS  
  
  m1.bfgs <- mle2(minuslogl = binomNLL2,
             start = c(a=.5,h=2),
             data = list(k = ReedfrogFuncresp$Killed,
                         N = ReedfrogFuncresp$Initial),
             method = "BFGS")
  
  m1.bfgs.bad_start <- mle2(minuslogl = binomNLL2,
                  start = c(a=.01,h=10),
                  data = list(k = ReedfrogFuncresp$Killed,
                              N = ReedfrogFuncresp$Initial),
                  method = "BFGS")

  # Nelder-Mead
  
  m1.nm <- mle2(minuslogl = binomNLL2,
                  start = c(a=.5,h=2),
                  data = list(k = ReedfrogFuncresp$Killed,
                              N = ReedfrogFuncresp$Initial),
                  method = "Nelder-Mead")
  
  m1.nm.bad_start <- mle2(minuslogl = binomNLL2,
                            start = c(a=.01,h=10),
                            data = list(k = ReedfrogFuncresp$Killed,
                                        N = ReedfrogFuncresp$Initial),
                            method = "Nelder-Mead")
  
  # Simulated Annealing

  m1.sa <- mle2(minuslogl = binomNLL2,
                     start = c(a=.5,h=2),
                     data = list(k = ReedfrogFuncresp$Killed,
                                 N = ReedfrogFuncresp$Initial),
                     method = "SANN")
  
  m1.sa.bad_start <- mle2(minuslogl = binomNLL2,
                          start = c(a=.01,h=10),
                          data = list(k = ReedfrogFuncresp$Killed,
                                      N = ReedfrogFuncresp$Initial),
                          method = "SANN")

  
  set.seed(1)
  m1.sa.1 <- mle2(minuslogl = binomNLL2,
                  start = c(a=.5,h=2),
                  data = list(k = ReedfrogFuncresp$Killed,
                              N = ReedfrogFuncresp$Initial),
                  method = "SANN")
  
    
  set.seed(2005)
  m1.sa.2005 <- mle2(minuslogl = binomNLL2,
                start = c(a=.5,h=2),
                data = list(k = ReedfrogFuncresp$Killed,
                            N = ReedfrogFuncresp$Initial),
                method = "SANN")
  
  
  
  
  AICtab(m1.sa,m1.bfgs,m1.nm,m1.bfgs.bad_start,m1.nm.bad_start,m1.sa.bad_start,m1.sa.1,m1.sa.2005)
  

# lecture 20 --------------------------------------------------------------

  
  #pairwise combo scaling with n parameters

  x_vec <- 1:20
  y_vec <- (x_vec*(x_vec-1))/2
  
    
  plot(x = x_vec,y = y_vec,
       xlab="N parameters",
       ylab = "N slices/profiles needed")
    
  

# identifying bad fits ----------------------------------------------------

  library(emdbook)
  library(bbmle)
  
  data("ReedfrogFuncresp")
  
  plot(x = ReedfrogFuncresp$Initial,
       y = ReedfrogFuncresp$Killed,
       xlab = "Initial",
       ylab = "Killed")
  
  
  m2.bad_start <- mle2(
    Killed ~ dbinom(size = Initial,
                    prob = a / (1 + a * h * Initial)),
    start = list(a = 0.01, h = 10),
    data = ReedfrogFuncresp
  )


  # Plot predictions on top of actual
  
  plot(x = ReedfrogFuncresp$Initial,
       y = ReedfrogFuncresp$Killed,
       ylab = "Killed",
       xlab = "Initial")
  
  points(x = ReedfrogFuncresp$Initial,
         y = predict(m2.bad_start),
         col = "red")

  
  # Plot killed vs predicted killed
  
  
  plot(x = predict(m2.bad_start),
       y = ReedfrogFuncresp$Killed,
       xlab = "Predicted Killed",
       ylab = "Actually Killed")
  

  m2.bad_start

# trying a likelihood profile ---------------------------------------------

    a_profile_seq <- seq(from = 0.1,to = 40,by=0.1)  
    a_profile_nll <- numeric(length(a_profile_seq))
    
    
    for(i in 1:length(a_profile_seq)){
      
        out_i <- mle2(
          Killed ~ dbinom(size = Initial,
                          prob = a / (1 + a * h * Initial)),
          start = list(a = 0.01, h = 10),
          data = ReedfrogFuncresp,
          fixed =  c(a = a_profile_seq[i])
        )
      

        a_profile_nll[i]  <- out_i@min
        
    } #end for loop   
    
      
    for(i in 1:length(a_profile_seq)){
      
    
      out_i<- tryCatch(
        
      mle2(
        Killed ~ dbinom(size = Initial,
                        prob = a / (1 + a * h * Initial)),
        start = list(a = 0.01, h = 10),
        data = ReedfrogFuncresp,
        fixed =  c(a = a_profile_seq[i])
      ),error=function(e){e})
      
      
      if(inherits(x = out_i,
                  what = "error")){
        
        a_profile_nll[i]  <- NA
        
      }else{
        
        a_profile_nll[i]  <- out_i@min
        
      }
      
    }    
      


plot(x = a_profile_seq,
     y = a_profile_nll,
     xlab = "a",
     ylab = "NLL")

abline(v = m2.bad_start@coef["a"]) # add a line for our model fit estimate


# trying a better model ---------------------------------------------------

# get the best NLL from our profile

best_guess_a <- a_profile_seq[which.min(a_profile_nll)]


m2.good_start <- mle2(
  Killed ~ dbinom(size = Initial,
                  prob = a / (1 + a * h * Initial)),
  start = list(a = best_guess_a, h = 10),
  data = ReedfrogFuncresp
)


# check out the parameters
m2.bad_start
m2.good_start

# compare using aic
AICtab(m2.bad_start,m2.good_start)

# Plot predictions


# Plot predictions on top of actual

plot(x = ReedfrogFuncresp$Initial,
     y = ReedfrogFuncresp$Killed,
     ylab = "Killed",
     xlab = "Initial")

points(x = ReedfrogFuncresp$Initial,
       y = predict(m2.good_start),
       col = "red")


# Plot killed vs predicted killed


plot(x = predict(m2.good_start),
     y = ReedfrogFuncresp$Killed,
     xlab = "Predicted Killed",
     ylab = "Actually Killed")


# trycatch example --------------------------------------------------------


tryCatch(expr = 1/"a",
         error = function(e){e})


# 7.5 confidence limits ---------------------------------------------------

library(emdbook)
library(bbmle)
data(GobySurvival)
?GobySurvival

#subset data to a single density treatment and single experiment

  dat <- subset(GobySurvival,
               exper == 1 &
                 density == 9 &
                 qual > median(qual))

#estimate survival time based on the last time it was observed and the last time it wasn't observed
  
  time <- (dat$d1 + dat$d2)/2
  
# Set up nll function
  
  weiblikfun <- function(shape, scale) {
    -sum(dweibull(time,
                  shape = shape,
                  scale = scale,
                  log = TRUE)
         )
  }
  
# Fit mle2
  
  w1 <- mle2(weiblikfun, start = list(shape = 1, scale = mean(time)))

# How do we get confidence intervals for the parameters?
  
  summary(w1)
  confint(w1)
  plot(profile(w1))
  

  w1@vcov

  

# confidence interval for function ----------------------------------------

  library(MASS)
  
  # Draw from the parameter distribution
  
  vmat <- mvrnorm(1000,
                  mu = coef(w1),
                  Sigma = vcov(w1))
  
  survival_time_estimates <- numeric(nrow(vmat))

  # Function to calculate the mean
  
    meanfun <- function(shape, scale) { scale * gamma(1 + 1/shape)}


    
  for (i in 1:length(survival_time_estimates)) {
    survival_time_estimates[i] <- meanfun(vmat[i, 1], vmat[i, 2])
  }
  
  
  survival_CI  <- quantile(survival_time_estimates, c(0.025, 0.975))

  

# confidence interval alternative methods ---------------------------------

  library(readr)
  library(tidyverse)
  
  avo <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds") |>
    filter(Family1 == "Momotidae") |>
    arrange(Beak.Length_Nares)
  
  avo <- read_rds("https://tinyurl.com/avonetdata") |>
    filter(Family1 == "Momotidae") |>
    arrange(Beak.Length_Nares)
  
  avo_model <- mle2(Beak.Length_Culmen ~ dnorm(mean = int + Beak.Length_Nares*b,
                                               sd = sd),
                    start = list(int=1,b=1,sd=2),data=avo)
  
  
  # as above
  

    avo_vmat <- mvrnorm(1000,
                        mu = coef(avo_model),
                        Sigma = vcov(avo_model))
    
  
  #need a matrix since we'll have multiple estimates here
  
    avo_estimates <- matrix(nrow = 1000,
                            ncol = nrow(avo))
  
  for(i in 1:nrow(avo_estimates)){
    
    parms_i <- avo_vmat[i,]    
    
    estimates_i <- parms_i[1] + parms_i[2]*avo$Beak.Length_Nares  
    
    avo_estimates[i,] <- estimates_i
    
  }
    
  avo_estimates_ci <- NULL  
  for(i in 1:ncol(avo_estimates)){
    
    out_i <- data.frame(mean = mean(avo_estimates[,i]),
               low = quantile(avo_estimates[,i], 0.025),
               high = quantile(avo_estimates[,i], 0.975))
    
    avo_estimates_ci <- rbind(avo_estimates_ci,out_i)
    
  }  
    
  
  
plot(x = avo$Beak.Length_Nares,
     y=avo$Beak.Length_Culmen)  

lines(x = avo$Beak.Length_Nares,
       y = avo_estimates_ci$mean,col="blue")  


lines(x = avo$Beak.Length_Nares,
      y = avo_estimates_ci$low,
      col="blue",lty=2)

lines(x = avo$Beak.Length_Nares,
      y = avo_estimates_ci$high,
      col="blue",lty=2)



# the easy way to CIs -----------------------------------------------------

  avo_lm <- lm(formula = Beak.Length_Culmen ~ Beak.Length_Nares,
               data = avo)


  summary(avo_lm)
  summary(avo_model)

# compare intercepts
  avo_model@coef["int"]
  avo_lm$coefficients["(Intercept)"]
  
# compare slopes
  avo_model@coef["b"]
  avo_lm$coefficients["Beak.Length_Nares"]

# compare sd
  sigma(avo_lm)
  avo_model@coef["sd"]
  
# model coefficients are all pretty similar  

  
# get the ci  
  
  avo_ci <- predict(avo_lm,
                    interval = "confidence",
                    level = 0.95)

plot(x = avo$Beak.Length_Nares,
     y=avo$Beak.Length_Culmen)  

lines(x = avo$Beak.Length_Nares,
       y = avo_ci[,1],col="red")  

lines(x = avo$Beak.Length_Nares,
      y =avo_ci[,2],
      col="red",lty=2)

lines(x = avo$Beak.Length_Nares,
      y =avo_ci[,3],
      col="red",lty=2)


# ci vs pi ----------------------------------------------------------------


# Using the fitting data

avo_ci <- predict(avo_lm,
                  interval = "confidence",
                  level = 0.95)


avo_pi <- predict(avo_lm,
                  interval = "prediction",
                  level = 0.95)


plot(x = avo$Beak.Length_Nares,
     y=avo$Beak.Length_Culmen)  

lines(x = avo$Beak.Length_Nares,
      y = avo_pi[,1],col="purple")  

lines(x = avo$Beak.Length_Nares,
      y =avo_pi[,2],
      col="purple",lty=2)

lines(x = avo$Beak.Length_Nares,
      y =avo_pi[,3],
      col="purple",lty=2)

lines(x = avo$Beak.Length_Nares,
      y = avo_ci[,1],col="red")  

lines(x = avo$Beak.Length_Nares,
      y =avo_ci[,2],
      col="red",lty=2)

lines(x = avo$Beak.Length_Nares,
      y =avo_ci[,3],
      col="red",lty=2)


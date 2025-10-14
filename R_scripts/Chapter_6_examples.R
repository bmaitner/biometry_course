# Chapter 6: Likelihood

library(tidyverse)      

citation()


# example figure ----------------------------------------------------------

x <- 1:20
a <- 2
b <- 1


y_det <- a + b * x

plot(x = x,y = y_det,pch=16)

# Add stochasiticty 

y_stoch <- rnorm(n = 20, mean = y_det, sd = 2)

hist(rnorm(n = 2000,mean = 0,sd = 2),xlab = "",main = "")


plot(x=x, y=y_stoch,pch=16)


points(x,y_det,col="blue")
abline(a = 2, b = 1,col="darkblue")


# illustrative likelihood example -----------------------------------------

 # Our model is a simply distribution with mean of 1 and variance of 2

  # random draw of "observed" data

  hist(rnorm(n = 10,mean = 1,sd = 2),main = "",xlab="")

  # model 1
  
  x_vec <- seq(from = -5, to =5,by=.1)
  y_vec <- dnorm(x = x_vec,mean = 1,sd = 2)

  plot(y_vec ~ x_vec)

  # model 2
  
  y_vec2 <- dnorm(x = x_vec,mean = 2,sd = 1)
  
  plot(y_vec2 ~ x_vec)


# example functions -------------------------------------------------------

  calculate_mean <- function(x){
    out <- sum(x)/length(x)	
    return(out)
  }
  

  calculate_mean(x = c(1,2,3))
  mean(c(1,2,3))    

# frog predation ----------------------------------------------------------

library(emdbook)
data("ReedfrogPred")

# Get data

  x <- subset(x = ReedfrogPred,
              subset = density == 10 &
                pred == "pred" &
                size=="small")  
  
  k <- x$surv
  
# Write function to optimize
  
  binomNLL1 <- function(p,k,N){
    
    -sum(dbinom(x = k,
                prob = p,
                size = N,
                log = TRUE)
         )
    } #end fx
  
# Optimize using optim
  
  opt1 <- optim(fn = binomNLL1,
                par = c(p = 0.5), #starting parameter
                N = x$density, #10 individuals in each trial
                k = x$surv, # survival rate
                method = "BFGS")
  
  opt1$par
  exp(-opt1$value)
  
  # or optionally
  
  opt1 <- optim(fn = binomNLL1,
                par = c(p = 0.5), #starting parameter
                N = 10, #10 individuals in each trial
                k = k, # survival rate
                method = "BFGS")
  
  opt1$par # the estimated predation rate (p)
  
  opt1$value #this is the negative log likelihood
  
  # to get the maximum likelihood (rather than log likelihood):
  
  exp(-opt1$value)
  
# Optimize using mle2
  
  library(bbmle)  
  
  m1 <- mle2(minuslogl = binomNLL1,
             start = c(p=0.5), #starting parameters
             method = "BFGS",
             data = list(N= 10, k = k) #individuals in each trial (N) and survival rate (k).
             )
  
  
  m1@coef # estimated paramters (p)
  
  exp(-m1@min) # maximum likelihood
  

# visualizing what optimization does --------------------------------------


  
  binomNLL1 <- function(p,k,N){
    
    -sum(dbinom(x = k,
                prob = p,
                size = N,
                log = TRUE)
    )
  } #end fx
  
  
p_vector <- seq(from=.05,to=1,by=0.05)  

  p_likelihood_vec <- numeric(length(p_vector))
  
  for(i in 1:length(p_vector)){
    
    p_likelihood_vec[i] <- binomNLL1(p = p_vector[i],k = x$surv,N = x$density)
    
  }

  
  plot(x = p_vector,
       y = p_likelihood_vec,
       xlab="p",
       ylab="negative log likelihood")
  
  plot(x = p_vector,
       y = exp(-p_likelihood_vec),
       xlab="p",
       ylab="likelihood")
  
  max(exp(-p_likelihood_vec))
  
  p_vector[which.min(p_likelihood_vec)] 
  p_vector[which.max(exp(-p_likelihood_vec))] 
  
  exp(-opt1$value)


# visualizing pred vs density ---------------------------------------------

library(emdbook)
  library(bbmle)
  
data("ReedfrogFuncresp")
  
plot(ReedfrogFuncresp$Killed ~ ReedfrogFuncresp$Initial)
plot((ReedfrogFuncresp$Killed/ReedfrogFuncresp$Initial) ~ ReedfrogFuncresp$Initial)
    

# estimating complex functions --------------------------------------------

  
  # plot of a type two functional response
  
  
  # p = a/ (1+a*h*N)
  # p = per capita predation rate
  # a = attack rate
  # h = handling time
  # N = prey density
  
  a <- .5
  h <- .8
  N_vec <- 0:20

  plot(x = N_vec,y= a/(1+a*h*N_vec),
       ylab = "Per capita pred. rate",
       xlab = "Number total")
  
  

# tadpole predation -------------------------------------------------------

  # Need a new equation to optimize
  
    binomNLL2 <- function(params, N, k){
      a = params[1]
      h = params[2]
      pred_prob = a/ (1+a*h*N)
      
      -sum(dbinom(x = k,size = N, prob = pred_prob,log = TRUE))

    }  
  
  # load data and optimize
  
    data("ReedfrogFuncresp")
    
    opt2 <- optim(fn = binomNLL2,
          par = c(a=.5,h=.2),
          N = ReedfrogFuncresp$Initial,
          k = ReedfrogFuncresp$Killed
          ) 
  
  # optimize with mle2
  
    parnames(binomNLL2) <- c("a","h") # quirk of mle2: need to set the parm names
    
    m2 <- mle2(minuslogl = binomNLL2,
         start = c(a=.5,h=2),
         data = list(k = ReedfrogFuncresp$Killed,
                     N = ReedfrogFuncresp$Initial))
    
    

# plotting our estimates --------------------------------------------------

  plot((ReedfrogFuncresp$Killed/ReedfrogFuncresp$Initial) ~ ReedfrogFuncresp$Initial,
       xlab = "Initial Density",
       ylab = "Per capita predation rate")
  
          
  x_vec <- min(ReedfrogFuncresp$Initial):max(ReedfrogFuncresp)
  
  y_vec_optim <-  opt2$par["a"]/ (1 + opt2$par["a"] * opt2$par["h"] * x_vec)
  
  y_vec_mle2 <-  m2@coef["a"]/ (1 + m2@coef["a"] * m2@coef["h"] * x_vec)
  
  
  
  lines(x = x_vec,y=y_vec_optim,col="orange")
  lines(x = x_vec,y=y_vec_mle2,col="maroon")


# linear example

    
  normNLL1 <- function(params, x, y){
    
    a = params[1]
    b = params[2]
    c = exp(params[3])
    
    mu= a + b*x
    
    -sum(dnorm(x = y, mean = mu, sd = c, log = TRUE))
    

  }  
  
  linear_optim <- optim(fn = normNLL1,
                        par = c(a=.5,b=.2,c=.2),
                        x = ReedfrogFuncresp$Initial,
                        y = (ReedfrogFuncresp$Killed/ReedfrogFuncresp$Initial)
                        )  
  
  plot((ReedfrogFuncresp$Killed/ReedfrogFuncresp$Initial) ~ ReedfrogFuncresp$Initial,
       xlab = "Initial Density",
       ylab = "Per capita predation rate")
  
  y_vec_linear <-  linear_optim$par["a"] + linear_optim$par["b"]*x_vec
  
  lines(x = x_vec,y=y_vec_linear)
  
  # Check out the different likelihoods
  
    exp(-linear_optim$value)
    exp(m2@min)
    exp(-opt2$value)
  


# likelihood surface ------------------------------------------------------

    library(tidyverse)
    binomNLL1 <- function(p,k,N){
      
      -sum(dbinom(x = k,
                  prob = p,
                  size = N,
                  log = TRUE)
      )
    } #end fx
    
    

    for(i in 1:length(p_vector)){
      
      p_likelihood_vec[i] <- binomNLL1(p = p_vector[i],k = x$surv,N = x$density)
      
    }
    
    
    a_vec = seq(from=0.1,to=0.9,by=.01)
    h_vec = seq(from=0.005,to=.04,by=.001)

    likelihood_surface <- expand.grid(a_vec,h_vec) %>% as.data.frame()
    colnames(likelihood_surface) <- c("a","h")
    likelihood_surface$nll <- NA
    
    
    binomNLL2 <- function(params, N, k){
      a = params[1]
      h = params[2]
      pred_prob = a/ (1+a*h*N)
      
      -sum(dbinom(x = k,size = N, prob = pred_prob,log = TRUE))
      
    }  
    
    
    for(i in 1:nrow(likelihood_surface)){
      
      likelihood_surface$nll[i] <- binomNLL2(params = c(a=likelihood_surface$a[i],
                                                    h=likelihood_surface$h[i]),
                                         N = ReedfrogFuncresp$Initial,
                                         k = ReedfrogFuncresp$Killed)
      

    }
    
    
    likelihood_surface %>%
    ggplot(mapping = aes(x=a,y=h,fill=nll))+
      geom_raster()+
      geom_contour(mapping = aes(x=a,y=h,z=nll),bins = 5,color="white",inherit.aes = FALSE)+
      scale_fill_viridis_c()
    
    

# slices ------------------------------------------------------------------

    
    # load data and optimize
    
    data("ReedfrogFuncresp")

    # Need a new equation to optimize
    
    binomNLL2 <- function(params, N, k){
      a = params[1]
      h = params[2]
      pred_prob = a/ (1+a*h*N)
      
      -sum(dbinom(x = k,size = N, prob = pred_prob,log = TRUE))
      
    }  
    
    parnames(binomNLL2) <- c("a","h") # quirk of mle2: need to set the parm names
    
    m2 <- mle2(minuslogl = binomNLL2,
               start = c(a=.5,h=2),
               data = list(k = ReedfrogFuncresp$Killed,
                           N = ReedfrogFuncresp$Initial))
    
    # get the optimal parameter value for a then do a slice for h
    
    opt_a <- opt2$par["a"]
    
    # pick a sequence to optimize over
    
    h_vec <- seq(from = 0.001,to=0.04,by=0.005)
    
    # we're going to use mle2 because it makes it easy to fix certain parameters
    
    h_nll <- numeric(length(h_vec)) # this will hold our output
    
    for(i in 1:length(h_vec)){
      
      m2 <- mle2(minuslogl = binomNLL2,
                 start = c(a=.5,h=2),
                 data = list(k = ReedfrogFuncresp$Killed,
                             N = ReedfrogFuncresp$Initial),
                 fixed = list(a = as.numeric(opt_a),
                              h = h_vec[i]))
      
      h_nll[i] <- m2@min

      
    }

    
    plot(x=h_vec,y=h_nll)
        
    

# profiles ----------------------------------------------------------------

    h_vec <- seq(from = 0.001,to=0.04,by=0.005)
    
    # we're going to use mle2 because it makes it easy to fix certain parameters
    
    h_nll2 <- numeric(length(h_vec)) # this will hold our output
    a_value_picked <- numeric(length(h_vec)) #we'll use this to track the selected a values
    
    
    for(i in 1:length(h_vec)){
      
      m2 <- mle2(minuslogl = binomNLL2,
                 start = c(a=.5,h=2),
                 data = list(k = ReedfrogFuncresp$Killed,
                             N = ReedfrogFuncresp$Initial),
                 fixed = list(h = h_vec[i]))
      
      h_nll2[i] <- m2@min
      a_value_picked[i] <- m2@coef["a"]
      
      
    }
    
    
    plot(x=h_vec,y=h_nll2,ylab= "NLL",xlab="h")
    points(x=h_vec,y=h_nll,col="blue")
    
    plot(h_vec,a_value_picked)


# confidence intervals ----------------------------------------------------

    m5 <- mle2(minuslogl = binomNLL2,
               start = c(a=.5,h=2),
               data = list(k = ReedfrogFuncresp$Killed,
                           N = ReedfrogFuncresp$Initial))
    
  profile(m5)
  
  confint(m5,level = 0.95)   
  confint(profile(m5),level = 0.95)
    
  plot(profile(m5))

  # plotting on the profile
  
  ci_m5 <-   confint(m5,level = 0.95)
    
  plot(x=h_vec,y=h_nll2,ylab= "NLL",xlab="h")
  abline(v = ci_m5["h",]["2.5 %"])
  abline(v = ci_m5["h",]["97.5 %"])
  

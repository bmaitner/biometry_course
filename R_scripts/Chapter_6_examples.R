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


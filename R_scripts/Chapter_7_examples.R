# Examples from chapter 7


# tadpole predation redux -------------------------------------------------

library(emdbook)
library(bbmle)

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
  
  likelihood_surface <- expand.grid(a_vec,h_vec) %>% as.data.frame()
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
             time_s = time_for_brute_force)%>%
    mutate(time_h = time_s/3600) %>%
    mutate(time_d = time_h/24) %>%
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
  

# lecture 18 --------------------------------------------------------------

  
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
  
  
  binomNLL2 <- function(params, N, k){
    a = params[1]
    h = params[2]
    pred_prob = a/ (1+a*h*N)
    
    -sum(dbinom(x = k,size = N, prob = pred_prob,log = TRUE))
    
  }  
  
  parnames(binomNLL2) <- c("a","h") # quirk of mle2: need to set the parm names
  
  
  m1.bfgs.bad_start <- mle2(minuslogl = binomNLL2,
                            start = c(a=.01,h=10),
                            data = list(k = ReedfrogFuncresp$Killed,
                                        N = ReedfrogFuncresp$Initial),
                            method = "BFGS")
  
  
  
  
  
  m1.bfgs <- mle2(minuslogl = binomNLL2,
                  start = c(a=.5,h=2),
                  data = list(k = ReedfrogFuncresp$Killed,
                              N = ReedfrogFuncresp$Initial),
                  method = "BFGS")
  
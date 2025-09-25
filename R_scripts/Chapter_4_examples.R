# Chapter 4

# example figure ----------------------------------------------------------

x_vec <- 1:100
y_vec <- sapply(X = x_vec,FUN = function(x){x*2+rnorm(n = 1,mean = 0,sd = 20)})


plot(x = x_vec,
     y = y_vec,xlab = "Predictor",
     ylab = "Response",col="black")

abline(a = 0,
       b = 2,
       col="blue")


hist(y_vec,main = "",xlab = "Response")


# discrete v continuous ---------------------------------------------------

set.seed(2005)
hist(rpois(n = 1000,lambda = 1),
     main = "Discrete:Poisson",breaks = 100)

set.seed(2005)
hist(rnorm(n = 1000,mean = 2,sd = 1),
     main = "Continuous:Normal",breaks = 100)


# mean example ------------------------------------------------------------

set.seed(2005)

x_vec <- seq(from=-10,to=10,by=0.1)
plot(x = x_vec,
     y = dnorm(mean = 0,sd = 1,x = x_vec),
     xlab = "Some variable",
     ylab = "Probability density")


abline(v = 0,col="blue")


# var example -------------------------------------------------------------


set.seed(2005)

x_vec <- seq(from=-10,to=10,by=0.1)

plot(x = x_vec,
     y = dnorm(mean = 0,sd = 1,x = x_vec),
     xlab = "Some variable",
     ylab = "Probability density")

abline(v = 0+sd(x_vec),col="blue")
abline(v = 0-sd(x_vec),col="blue")


# median example ----------------------------------------------------------


set.seed(2005)

med_vec <- rpois(n = 39,lambda = 2)
hist(x = med_vec,
     main = "Discrete:Poisson",
     breaks = 10,xlab = "Some variable")

abline(v = mean(med_vec),col="blue",lwd=3)
abline(v = median(med_vec),col="orange",lwd=3)
abline(v = as.numeric(names(which.max(table(med_vec)))),
       col="hotpink",
       lwd=3)



# examples of working with distributions ----------------------------------

avonet <- read.csv("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.csv")

var(avonet$Mass) == (sd(avonet$Mass)^2)

sqrt(var(avonet$Mass)) == sd(avonet$Mass)

var(avonet$Mass)^.5 == sd(avonet$Mass) #raising to the 0.5 power is identical to taking the square root.

# playing with distributions ----------------------------------------------

  # Normal
  
    x_vector <- seq(from=-10,to=10,by=0.1)

    norm_density_vector <- dnorm(x = x_vector,mean = 0,sd = 1)
  
    plot(norm_density_vector ~ x_vector)
    
    plot(dnorm(x = x_vector,mean = 0,sd = 1) ~ x_vector)
    
    plot(dnorm(x = x_vector,mean = 1,sd = 1) ~ x_vector)
    
    plot(dnorm(x = x_vector,mean = 2,sd = 1) ~ x_vector)

  # Binomial
    
    discrete_x_vector <- seq(from=0,to=20,by=1) #have to make a discrete version, since the binomial only applies to integers
    
    binom_density_vector <- dbinom(x = discrete_x_vector,
                                   size = 0,prob = .1)
    
    plot(dbinom(x = discrete_x_vector,size = 10,prob = .1) ~ discrete_x_vector,col="blue",ylim=c(0,1))
    plot(dbinom(x = discrete_x_vector,size = 50,prob = .1) ~ discrete_x_vector,col="blue",ylim=c(0,1))
    plot(dbinom(x = discrete_x_vector,size = 100,prob = .1) ~ discrete_x_vector,col="blue",ylim=c(0,1))
    
    plot(dbinom(x = discrete_x_vector,size = 20,prob = .1) ~ discrete_x_vector,col="blue",ylim=c(0,1))
    plot(dbinom(x = discrete_x_vector,size = 20,prob = .5) ~ discrete_x_vector,col="blue",ylim=c(0,1))
    plot(dbinom(x = discrete_x_vector,size = 20,prob = .9) ~ discrete_x_vector,col="blue",ylim=c(0,1))



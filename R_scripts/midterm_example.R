# how does slope impact power?  

# how does slope impact power?  

sample_size <- 20
a <- 2
b <- 1
sd <- 8

nsim <- 400
bvec <- seq(-2, 2, by = 0.1)
power.b <- numeric(length(bvec))
pval <- numeric(nsim)


for(j in 1:length(bvec)){
  for(i in 1:nsim){
    
    x <- sample(x = 1:20,
                size = sample_size,
                replace = TRUE)
    
    b <- bvec[j]
    y_det <- a + b*x
    y <- rnorm(n = length(y_det),
               mean = y_det,
               sd = sd)
    
    m <- lm(y ~ x)
    
    #get p-value
    
    pval[i] <- coef(summary(m))["x","Pr(>|t|)"]
    
  }#end i lloop
  power.b[j] <- sum(pval< 0.05)/nsim
  
}#end j loop

plot(power.b ~ bvec,main = sample_size)


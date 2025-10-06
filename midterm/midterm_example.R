
# Part 1 useful code ------------------------------------------------------

  # Citing R

    citation()

  # Citing an R package
    
    citation("bbmle")

# Part 2 code to load data ------------------------------------------------

library(readr)

twoa <- read_rds("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/midterm/2a.RDS")

twob <- read_rds("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/midterm/2b.RDS")

twoc <- read_rds("https://github.com/bmaitner/Statistical_ecology_course/raw/refs/heads/main/midterm/2c.RDS")


# Part 3 example code -----------------------------------------------------



# how does slope impact power?  


sample_size <- 20
a <- 2
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



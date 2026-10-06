
# Part 1 useful code ------------------------------------------------------

  # Citing R

    citation()

  # Citing an R package

    citation("bbmle")

# Part 2 code to load data ------------------------------------------------

library(readr)

twoa <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2a.RDS")

twob <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2b.RDS")

twoc <- read_rds("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/midterm/b_2c.RDS")


# Part 3 example code -----------------------------------------------------



# how does the amount of noise impact power?

# This runs at ONE sample size. Your job is to repeat it across several.


sample_size <- 20
a <- 2
b <- 1

nsim <- 400
sdvec <- seq(1, 20, by = 1)
power.sd <- numeric(length(sdvec))
pval <- numeric(nsim)


for(j in 1:length(sdvec)){
  for(i in 1:nsim){

    x <- sample(x = 1:20,
                size = sample_size,
                replace = TRUE)

    sd <- sdvec[j]
    y_det <- a + b*x
    y <- rnorm(n = length(y_det),
               mean = y_det,
               sd = sd)

    m <- lm(y ~ x)

    #get p-value

    pval[i] <- coef(summary(m))["x","Pr(>|t|)"]

  }#end i loop
  power.sd[j] <- sum(pval < 0.05)/nsim

}#end j loop

plot(power.sd ~ sdvec, main = sample_size, ylim = c(0, 1))

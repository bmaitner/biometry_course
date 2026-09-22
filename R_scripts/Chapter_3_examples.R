# Code for chapter 3 examples
#############################
#
# Deterministic functions. Sections below follow the published book:
#   3.1  Introduction
#   3.2  Finding out about functions numerically   (Lecture 9)
#   3.3  Finding out about functions analytically  (Lecture 9)
#   3.4  Bestiary of functions                     (Lecture 10)


# Load libraries ----------------------------------------------------------

  library(emdbook)


# What a function is ------------------------------------------------------

  # You have been using functions all semester: read.csv(), mean(), hist(),
  # filter(), ggplot(). Each takes inputs (arguments), does something, and
  # returns a result.

    mean(c(2, 4, NA))                  # NA
    mean(c(2, 4, NA), na.rm = TRUE)    # na.rm has a default of FALSE

  # A function is just code someone saved under a name. Type the name without
  # brackets to see it:

    sd

  # sd() is sqrt() of var(), with a default for na.rm.

  # Why write your own? To stop copying and pasting, to fix mistakes in one
  # place, to give an idea a name, and because an equation is a function: f(x)
  # in math, function(x) in R.

  # R has no built-in standard error of the mean, so write one. (stderr() exists,
  # but it is the stream R writes error messages to, not a standard error.)

    standard_error <- function(x){

      sd(x) / sqrt(length(x))

    }

    standard_error(c(2, 4, 6, 8))

  # x is a placeholder: whatever you pass in becomes x inside the function.

  # Another example, and a first translation of an equation into R:
  #   C = (F - 32) * 5/9

    f_to_c <- function(temp_f){

      (temp_f - 32) * 5 / 9

    }

    f_to_c(c(32, 98.6, 212))


# The data behind Figure 3.1 ----------------------------------------------

  # Tadpole predation as a function of tadpole size. 15 observations.

    data(ReedfrogSizepred)

    tadpoles <- ReedfrogSizepred

      str(tadpoles)

      plot(x = tadpoles$TBL,
           y = tadpoles$Kill,
           xlab = "Tadpole body length (mm)",
           ylab = "Number killed")

    # Chapter 2 would stop here: the pattern is humped, and skewed right.
    # Chapter 3 asks what function has that shape, and what its parameters
    # would mean.

    # The shape we need, read off the plot:
    #   - it rises from the smallest tadpoles to about 12 mm
    #   - it peaks around 12 mm
    #   - it falls back toward zero for the biggest tadpoles
    #
    # Below, each candidate function gets held up against that list.


# Writing your own function -----------------------------------------------

  # You already did this in Lecture 2, where this function was called
  # holling2(). Written with a and b it is the Michaelis-Menten form, so here
  # it is named for that:

    michaelis_menten <- function(x, a, b){

      a * x / (b + x)

    }

    michaelis_menten(x = 5, a = 2, b = 1)

  # That is one of two ways to write the same curve.
  #
  #   Mechanistic, Holling type II:          f(x) = alpha x / (1 + alpha h x)
  #     alpha = attack rate, h = handling time
  #
  #   Phenomenological, Michaelis-Menten:     f(x) = a x / (b + x)
  #     a = asymptote (the maximum), b = half-saturation, where f(x) = a/2
  #
  # They are identical when a = 1/h and b = 1/(alpha h). Which one you write
  # depends on why you are using it: the first when attack rate and handling
  # time are the question, the second when you want parameters you can read
  # off a plot.

    holling_type2 <- function(x, alpha, h){

      alpha * x / (1 + alpha * h * x)

    }

    holling_type2(x = c(1, 5, 50), alpha = 2, h = 0.5)
    michaelis_menten(x = c(1, 5, 50), a = 1 / 0.5, b = 1 / (2 * 0.5))   # same numbers

  # Default values save typing. Anything you do not supply uses the default.

    ricker <- function(x, a = 1, b = 1){

      a * x * exp(-b * x)

    }

      ricker(x = 2)               # uses a = 1, b = 1
      ricker(x = 2, a = 3)        # uses b = 1
      ricker(x = 2, a = 3, b = 0.5)

  # Note the notation difference. In math this is ax e^(-bx). In R it is
  # a * x * exp(-b * x). Every multiplication needs a *, and exp() is a
  # function call. Math notation in R is an error.


# Drawing a function ------------------------------------------------------

  # curve() computes and plots a function over a range of x.

    curve(ricker(x, a = 1, b = 1), from = 0, to = 8)

  # add = TRUE draws on top of an existing plot, so you can compare.

    curve(ricker(x, a = 1, b = 1),   from = 0, to = 8, ylim = c(0, 0.8))
    curve(ricker(x, a = 1, b = 0.5), add = TRUE, col = "red")
    curve(ricker(x, a = 1, b = 2),   add = TRUE, col = "blue")

  # curve() expects the variable to be called x. That is a quirk of curve(),
  # not a rule about functions.


# Computing values instead of drawing them --------------------------------

  # If you want the numbers, make your own vector of x values.

    xvec <- seq(from = 0, to = 8, length.out = 100)

    yvec <- ricker(xvec, a = 1, b = 1)

      head(yvec)

      plot(xvec, yvec, type = "l")

  # That worked because ricker() is "vectorized": every operation inside it
  # (*, exp) already works on whole vectors. Most simple functions are.

  # If a function is not vectorized, sapply() runs it one element at a time
  # and collects the answers. This is the tidier relative of the for loop
  # from Lecture 7:

    yvec2 <- sapply(X = xvec, FUN = ricker)

      identical(round(yvec, 10), round(yvec2, 10))

  # sapply is shorter and you do not have to create the output vector first.


# First try: the Michaelis-Menten curve against the data ------------------

  # It rises from zero, which is the first item on the list.

    michaelis_menten <- function(x, a = 1, b = 1) a * x / (b + x)

    plot(tadpoles$TBL, tadpoles$Kill, xlim = c(0, 40), ylim = c(0, 6),
         xlab = "Tadpole body length (mm)", ylab = "Number killed")

    curve(michaelis_menten(x, a = 4, b = 5), add = TRUE, col = "red", lwd = 2)

  # Right start, wrong ending. It levels off and never comes back down, and no
  # choice of a and b changes that. So we need something that falls.


# Second try: the negative exponential ------------------------------------

  # The simplest curve that falls. Starts at a, decays toward zero.

    negexp <- function(x, a = 1, b = 1) a * exp(-b * x)

      curve(negexp(x, a = 1, b = 1), from = 0, to = 7)

    # a is the value at x = 0. b controls how fast it falls.

      curve(negexp(x, a = 1, b = 0.5), from = 0, to = 7, ylim = c(0, 3))
      curve(negexp(x, a = 2, b = 0.5), add = TRUE, col = "red")
      curve(negexp(x, a = 3, b = 0.5), add = TRUE, col = "blue")

  # Against the data:

    plot(tadpoles$TBL, tadpoles$Kill, xlim = c(0, 40), ylim = c(0, 6),
         xlab = "Tadpole body length (mm)", ylab = "Number killed")

    curve(negexp(x, a = 6, b = 0.1), add = TRUE, col = "red", lwd = 2)

  # Right ending, wrong start. It is always highest at x = 0, so it says the
  # smallest tadpoles are the most at risk, and the data say 12 mm is worst.


# Put them together: the Ricker -------------------------------------------

  # Michaelis-Menten got the rise, the exponential got the fall. Multiply
  # something that rises by something that falls and you get a hump.

  # Ricker: rises from zero, peaks, then decays. Good for humped, right-
  # skewed patterns, which is what the tadpole data looks like.

    curve(ricker(x, a = 1, b = 1), from = 0, to = 8)

  # Why does it hump? It is a straight line through the origin multiplied by
  # a decaying exponential. Near zero the line wins; far out the exponential
  # wins. Draw all three and you can see the handover.

    curve(1 * x,        from = 0, to = 8, ylim = c(0, 3), lty = 2)
    curve(exp(-x),      add = TRUE, lty = 2)
    curve(x * exp(-x),  add = TRUE, col = "red", lwd = 2)

    # curve() wants an expression, not a bare variable name, so the straight
    # line has to be written as 1 * x. curve(x, ...) looks for a function
    # called x and errors with: could not find function "x".


# Asking questions about a function ---------------------------------------

  # You can answer most of these by looking, or by computing. You do not need
  # calculus to get started, though the book does the algebra for you.


  # What happens at the ends?

    ricker(0, a = 1, b = 1)            # starts at zero
    ricker(c(10, 100, 1000), a = 1, b = 1)   # decays back to zero

    negexp(0, a = 3, b = 1)            # starts at a
    negexp(c(10, 100), a = 3, b = 1)   # decays to zero


  # Where is the peak?

    # Numerically: compute a lot of values and find the biggest.

      xvec <- seq(from = 0, to = 20, length.out = 10000)

      yvec <- ricker(xvec, a = 1, b = 0.25)

      xvec[which.max(yvec)]

    # The book does the calculus and gets x = 1/b exactly:

      1 / 0.25

    # Notice what that means: the peak position depends only on b. Changing a
    # stretches the curve vertically but does not move the peak sideways.

      curve(ricker(x, a = 1, b = 0.25), from = 0, to = 20, ylim = c(0, 4.6))
      curve(ricker(x, a = 3, b = 0.25), add = TRUE, col = "red")
      abline(v = 1/0.25, lty = 3)


  # Where does it fall to half its starting value?

    # For the negative exponential the book gives log(2)/b. Check it:

      log(2) / 0.5

      negexp(log(2) / 0.5, a = 1, b = 0.5)   # should be 0.5

    # This is the "half-life" idea, and it is why b is a rate: bigger b means
    # a shorter half-life.


# Eyeballing a fit to the tadpole data ------------------------------------

  # The point of all this is to get starting values you could hand to a
  # fitting routine later. Read the parameters off the picture.

    plot(x = tadpoles$TBL,
         y = tadpoles$Kill,
         xlab = "Tadpole body length (mm)",
         ylab = "Number killed",
         xlim = c(0, 40),
         ylim = c(0, 6))

    # The hump looks like it sits near TBL = 12, and gets to about 4 killed.

    # Peak is at 1/b, so:

      b_eye <- 1 / 12

    # Height at the peak is a / (b * exp(1)), so if that should be 4:

      a_eye <- 4 * b_eye * exp(1)

      a_eye

    curve(ricker(x, a = a_eye, b = b_eye), add = TRUE, col = "red", lwd = 2)

  # How good is it? Sum the squared distances between data and curve.

    sum((tadpoles$Kill - ricker(tadpoles$TBL, a = a_eye, b = b_eye))^2)

  # It is not a great fit, and that is honest: Bolker's Figure 3.1 makes the
  # same point. The right tail of a Ricker is too heavy for these data. Fixing
  # that means modifying the function, which is section 3.4 and Lecture 10.


# Lecture 10: the bestiary of functions ============================================


# Reading a function by its shape -----------------------------------------

  # Ask three questions of any function: what happens at the left end, at the
  # right end, and in between? Bolker's Table 3.1 sorts the bestiary that way.
  # Six shapes cover most of what you will meet:

    par(mfrow = c(2, 3))

      curve(x / (1 + x), 0, 10, main = "Saturating: Michaelis-Menten")
      curve(plogis(x, location = 5, scale = 1), 0, 10, main = "S-shaped: logistic")
      curve(x * exp(-x), 0, 8, main = "Humped: Ricker")
      curve(exp(-0.5 * x), 0, 10, main = "Decreasing: negative exponential")
      curve(x^2, 0, 3, main = "Power law: a x^b")
      curve(ifelse(x < 5, x, 5), 0, 10, main = "Switch: hockey stick")

    par(mfrow = c(1, 1))


# The right curve depends on the question ---------------------------------

  # Michaelis-Menten failed on tadpole SIZE. On tadpole DENSITY it fits,
  # because predators are limited by handling time.

    data(ReedfrogFuncresp)

    kills_by_density <- ReedfrogFuncresp

    michaelis_menten <- function(x, a = 1, b = 1) a * x / (b + x)

    plot(kills_by_density$Initial, kills_by_density$Killed,
         xlim = c(0, 100), ylim = c(0, 40),
         xlab = "Number of tadpoles in the tank", ylab = "Number killed")

    curve(michaelis_menten(x, a = 60, b = 100), add = TRUE, col = "red", lwd = 2)

  # How high does it go? Very different asymptotes fit about equally well:

    ss_mm <- function(a, b) {
      sum((kills_by_density$Killed - michaelis_menten(kills_by_density$Initial, a, b))^2)
    }

    ss_mm(a = 60,  b = 100)    # about 404
    ss_mm(a = 150, b = 390)    # about 376

  # The data never get near the asymptote, so they cannot tell you where it is.


# Four ways to change a function ------------------------------------------

  # Scale a * f(x), stretch f(x / b), shift f(x - c), bend f(x)^alpha

    base <- function(x) x / (1 + x)

    curve(base(x), 0, 10, ylim = c(0, 2), lty = 2)
    curve(2 * base(x),              add = TRUE, col = "red")      # scale
    curve(base(x / 3),              add = TRUE, col = "blue")     # stretch
    curve(base(pmax(x - 2, 0)),     add = TRUE, col = "orange")   # shift
    curve(base(x)^3,                add = TRUE, col = "purple")   # bend

  # Only the power changes the shape itself: cubing a saturating curve makes it
  # S-shaped.


# Power laws --------------------------------------------------------------

  # f(x) = a * x^b. On log-log axes this is a straight line with slope b.

    avonet <- read.csv("data/Avonet/AVONET1_BirdLife.csv")

    fit <- lm(log10(Mass) ~ log10(Tarsus.Length), data = avonet)

    coef(fit)    # slope about 2.17: mass rises as tarsus length to the 2.2

    plot(log10(avonet$Tarsus.Length), log10(avonet$Mass),
         pch = 16, cex = 0.3, col = rgb(0, 0, 0, 0.2))
    abline(fit, col = "red", lwd = 2)

  # Scaled-up copies of the same bird would give a slope of 3. Many processes
  # produce power laws, so be careful reading a mechanism off the exponent.


# Fixing the tadpoles: the power-Ricker -----------------------------------

  # Written with the height and position of the peak as parameters, plus a
  # power that narrows the hump. With alpha = 1 it is the Ricker.

    power_ricker <- function(x, height, peak, alpha){

      height * (x / peak * exp(1 - x / peak))^alpha

    }

    ss_pr <- function(alpha) {
      sum((tadpoles$Kill - power_ricker(tadpoles$TBL, 4, 12, alpha))^2)
    }

    ss_pr(1)    # 87.5, the same as last lecture's eyeballed Ricker
    ss_pr(2)    # about 58
    ss_pr(6)    # about 24, better than the best plain Ricker (24.9)

    plot(tadpoles$TBL, tadpoles$Kill, xlim = c(0, 40), ylim = c(0, 6))
    curve(power_ricker(x, 4, 12, 1), add = TRUE, lty = 2)
    curve(power_ricker(x, 4, 12, 6), add = TRUE, col = "red", lwd = 2)

  # The unconstrained best fit has alpha near 38 and a score of about 5: a spike
  # at 12 mm. It predicts about 1.4 kills at 15 mm and 0.1 at 18 mm, where there
  # are no data at all. A better score is not the same as a better description.

    power_ricker(c(12, 15, 18), height = 4, peak = 12, alpha = 38)


# Piecewise functions with ifelse() (section 3.6.2) -----------------------

  # ifelse(condition, value if true, value if false), on a whole vector at once.

    hockey_stick <- function(x, a, s){

      ifelse(x < s, a * x, a * s)

    }

    curve(hockey_stick(x, a = 2, s = 5), from = 0, to = 10)

    threshold <- function(x, a1, a2, s){

      ifelse(x < s, a1, a2)

    }

    curve(threshold(x, a1 = 1, a2 = 3, s = 5), from = 0, to = 10, n = 1001)


# Derivatives with D() (section 3.6.3) ------------------------------------

  # D() takes a derivative symbolically; eval() fills in numbers.

    d_ricker <- D(expression(a * x * exp(-b * x)), "x")

    d_ricker

    eval(d_ricker, list(a = 1, b = 0.25, x = 1 / 0.25))   # 0: the peak is at 1/b
    eval(d_ricker, list(a = 2, b = 0.25, x = 0))          # 2: the initial slope is a

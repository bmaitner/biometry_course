# Code for chapter 1 examples
#############################

# Covers lectures 2 and 3.
# Chapter 1 is mostly conceptual, so most of this is either
# illustrating an idea from the text or working through the R supplement (1.7).


# begin lecture 2 ---------------------------------------------------------


# A shape you've seen before ----------------------------------------------

  # Section 1.3 uses this curve to make a point about mechanistic vs.
  # phenomenological models.  Let's just look at the shape first.

    curve(2 * x / (1 + x),
          from = 0,
          to = 10,
          lwd = 2,
          xlab = "Prey density",
          ylab = "Prey eaten per predator")

  # Where else in biology have you seen a curve that starts at zero,
  # rises steeply, and then levels off?


# Same curve, two justifications ------------------------------------------

  # The equation is f(x) = ax / (b + x)
  # Written as a function so we can change a and b:

    holling2 <- function(x, a, b){

      a * x / (b + x)

    }

  # a is roughly the attack rate, b is related to handling time.
  # Try changing them and see what each one does to the shape.

    curve(holling2(x, a = 2, b = 1), from = 0, to = 10,
          lwd = 2, ylim = c(0, 4),
          xlab = "Prey density", ylab = "Prey eaten per predator")

    curve(holling2(x, a = 4, b = 1), from = 0, to = 10,
          lwd = 2, col = "blue", add = TRUE)

    curve(holling2(x, a = 2, b = 4), from = 0, to = 10,
          lwd = 2, col = "orange", add = TRUE)

    legend("bottomright",
           legend = c("a = 2, b = 1", "a = 4, b = 1", "a = 2, b = 4"),
           col = c("black", "blue", "orange"),
           lwd = 2)

  # Which parameter sets the height of the asymptote?
  # Which one sets how fast we get there?

  # Note that nothing above tells you WHY you picked this curve.
  # That choice is what makes it mechanistic or phenomenological.
  # We'll come back to curves like this in chapter 3, and we'll fit
  # this one to real tadpole predation data in chapter 7.


# The same shape, for a completely different reason ------------------------

  # A straight line makes the same point with less machinery:

    x_vec <- 1:20
    y_vec <- 3 + 2 * x_vec + rnorm(n = 20, mean = 0, sd = 4)

    plot(x = x_vec, y = y_vec,
         xlab = "Predictor", ylab = "Response")

    abline(a = 3, b = 2, col = "blue")

  # Phenomenological: the scatterplot looked straight.
  # Mechanistic: you expect a constant per-unit rate of change.
  # Same line either way.


# Three kinds of variability ----------------------------------------------

  # Section 1.3.2 splits randomness into measurement error,
  # demographic stochasticity, and environmental stochasticity.

  # Demographic stochasticity: identical units, different outcomes.
  # Twenty tadpoles, each with a 30% chance of being eaten.
  # Run this line several times -- the answer changes every time.

    rbinom(n = 1, size = 20, prob = 0.3)

  # Do it 1000 times to see the spread:

    eaten <- rbinom(n = 1000, size = 20, prob = 0.3)

    hist(eaten,
         breaks = 0:20,
         main = "",
         xlab = "Tadpoles eaten out of 20")

    abline(v = 20 * 0.3, col = "blue", lwd = 3)

  # Nothing about the tadpoles or the predator changed between runs.
  # The variation is in the process itself.

  # Measurement error: the truth is fixed, our observation of it isn't.

    true_mass <- 10

    observed_mass <- true_mass + rnorm(n = 1000, mean = 0, sd = 1)

    hist(observed_mass,
         main = "",
         xlab = "Observed mass (true value = 10)")

    abline(v = true_mass, col = "blue", lwd = 3)

  # Both histograms have spread, but they mean different things.
  # If we mis-measure a population it is still there next year.
  # If a predator eats it, it isn't.


# begin lecture 3 ---------------------------------------------------------


# R supplement (1.7): the basics ------------------------------------------

  # Bolker's chapter 1 supplement is about getting R working.
  # We installed everything last time, so here's the sample session.

  # R as a calculator

    2 * 8

    sqrt(25)

  # Assignment.  The book uses "=", but "<-" is the more common style
  # and is what we'll use in this course.

    x <- sqrt(36)

    x

  # Note that R doesn't print anything when you assign.
  # Typing the object's name is what prints it.


# Getting help ------------------------------------------------------------

    ?sqrt              # help page for a specific function

    example(sqrt)      # run the examples from that help page

    help.search("correlation")   # search for a topic

    # help.start()     # opens the full help system in a browser


# Installing packages -----------------------------------------------------

  # We'll need these later in the course.  Only run once.

    # install.packages(c("emdbook", "bbmle", "tidyverse"))

  # Once installed, load them with library() each session:

    # library(emdbook)


# Sample session: frogs and tadpoles --------------------------------------

  # Seed the random number generator so we all get the same answers.

    set.seed(101)

  # Adult frog density in 20 populations, entered by hand with c()

    frogs <- c(1.1, 1.3, 1.7, 1.8, 1.9, 2.1, 2.3, 2.4,
               2.5, 2.8, 3.1, 3.3, 3.6, 3.7, 3.9, 4.1,
               4.5, 4.8, 5.1, 5.3)

  # Tadpole density: on average twice the frog density, plus noise

    tadpoles <- rnorm(n = 20, mean = 2 * frogs, sd = 0.5)

    tadpoles

  # You can leave the argument names out -- rnorm(20, 2*frogs, 0.5) works --
  # but naming them is clearer and safer.

  # Plot tadpoles against frogs, and add the line we know is underneath

    plot(x = frogs, y = tadpoles)

    abline(a = 0, b = 2)

  # Which parts of the scatter are "real" and which are the rnorm() we added?


# Transforming and summarizing --------------------------------------------

  # Log the response

    log_tadpoles <- log(tadpoles)

    plot(x = frogs, y = log_tadpoles)

  # Three ways to get a similar plot:

    plot(frogs, log(tadpoles))

    plot(frogs, tadpoles, log = "y")   # adjusts the axis, not the values

  # Summary statistics

    mean(tadpoles)

    sd(tadpoles)

    summary(tadpoles)

  # Correlation, and a test of it

    cor(frogs, tadpoles)

    cor.test(frogs, tadpoles)

  # Compare this with the Sandin & Pacala example from lecture 2.
  # cor.test() tells you whether there's an association.
  # It doesn't tell you the slope, the units, or the mechanism.

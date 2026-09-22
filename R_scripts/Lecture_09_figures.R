# Figures for Lecture 9 (Deterministic functions I)
###################################################
#
# Run from the project root:
#
#   source("R_scripts/Lecture_09_figures.R")
#
# Output goes to lectures/figures/. The tadpole data is Bolker's Figure 3.1
# dataset and ships with emdbook.

  library(emdbook)

  data(ReedfrogSizepred)

  tadpoles <- ReedfrogSizepred

  fig_dir <- "lectures/figures"

  if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)

  open_png <- function(name, width = 900, height = 650) {
    png(file.path(fig_dir, name), width = width, height = height, res = 110)
  }

  ricker <- function(x, a = 1, b = 1) a * x * exp(-b * x)

  negexp <- function(x, a = 1, b = 1) a * exp(-b * x)


# 1. The data, with no curve on it ------------------------------------------

  open_png("09_01_tadpoles.png")

    plot(x    = tadpoles$TBL,
         y    = tadpoles$Kill,
         xlab = "Tadpole body length (mm)",
         ylab = "Number killed",
         main = "What curve would you draw through this?",
         pch  = 16,
         cex  = 1.4,
         xlim = c(0, 40),
         ylim = c(0, 6))

  dev.off()


# 2. The negative exponential, varying a ------------------------------------

  open_png("09_02_negexp_a.png")

    curve(negexp(x, a = 1, b = 1), from = 0, to = 7,
          ylim = c(0, 3),
          xlab = "x", ylab = "y",
          main = "a * exp(-b * x):  changing a",
          lwd = 2)

    curve(negexp(x, a = 2, b = 1), add = TRUE, col = "red",  lwd = 2)
    curve(negexp(x, a = 3, b = 1), add = TRUE, col = "blue", lwd = 2)

    legend("topright", lwd = 2, bty = "n",
           col = c("black", "red", "blue"),
           legend = c("a = 1", "a = 2", "a = 3"))

  dev.off()


# 3. The negative exponential, varying b ------------------------------------

  open_png("09_03_negexp_b.png")

    curve(negexp(x, a = 1, b = 0.5), from = 0, to = 7,
          ylim = c(0, 1.1),
          xlab = "x", ylab = "y",
          main = "a * exp(-b * x):  changing b",
          lwd = 2)

    curve(negexp(x, a = 1, b = 1), add = TRUE, col = "red",  lwd = 2)
    curve(negexp(x, a = 1, b = 2), add = TRUE, col = "blue", lwd = 2)

    legend("topright", lwd = 2, bty = "n",
           col = c("black", "red", "blue"),
           legend = c("b = 0.5", "b = 1", "b = 2"))

  dev.off()


# 4. Where the Ricker peaks -------------------------------------------------

  # The peak sits at x = 1/b, whatever a is. a only stretches it vertically.

  open_png("09_04_ricker_peak.png")

    curve(ricker(x, a = 1, b = 0.5), from = 0, to = 12,
          ylim = c(0, 1.6),
          xlab = "x", ylab = "y",
          main = "a * x * exp(-b * x):  the peak sits at x = 1/b",
          lwd = 2)

    curve(ricker(x, a = 1, b = 0.25), add = TRUE, col = "red",  lwd = 2)
    curve(ricker(x, a = 1, b = 1),    add = TRUE, col = "blue", lwd = 2)

    abline(v = c(1/0.5, 1/0.25, 1/1), lty = 3,
           col = c("black", "red", "blue"))

    legend("topright", lwd = 2, bty = "n",
           col = c("red", "black", "blue"),
           legend = c("b = 0.25, peak at 4", "b = 0.5, peak at 2", "b = 1, peak at 1"))

  dev.off()


# 5. Why the Ricker humps ---------------------------------------------------

  # It is a straight line through the origin multiplied by a decaying
  # exponential. One term wins at each end.

  open_png("09_05_ricker_parts.png", width = 950)

    curve(1 * x, from = 0, to = 8, ylim = c(0, 3),
          xlab = "x", ylab = "y",
          main = "x  times  exp(-x)  =  x * exp(-x)",
          lty = 2, col = "grey40", lwd = 2)

    curve(exp(-x),      add = TRUE, lty = 2, col = "grey40", lwd = 2)
    curve(x * exp(-x),  add = TRUE, col = "red", lwd = 3)

    legend("topright", bty = "n",
           lwd = c(2, 2, 3), lty = c(2, 2, 1),
           col = c("grey40", "grey40", "red"),
           legend = c("x  (rises)", "exp(-x)  (falls)", "x * exp(-x)"))

  dev.off()


# 6. An eyeballed Ricker on the tadpole data --------------------------------

  # Read the peak off the data: it is near TBL = 12 and about 4 killed.
  # Peak of a Ricker is at x = 1/b, so b = 1/12.
  # Height at the peak is a / (b * e), so a = 4 * b * e.

  b_eye <- 1 / 12

  a_eye <- 4 * b_eye * exp(1)

  open_png("09_06_tadpoles_fitted.png")

    plot(x    = tadpoles$TBL,
         y    = tadpoles$Kill,
         xlab = "Tadpole body length (mm)",
         ylab = "Number killed",
         main = "A Ricker, eyeballed",
         pch  = 16,
         cex  = 1.4,
         xlim = c(0, 40),
         ylim = c(0, 6))

    curve(ricker(x, a = a_eye, b = b_eye), add = TRUE, col = "red", lwd = 3)

  dev.off()

  message("a = ", round(a_eye, 3), ", b = ", round(b_eye, 4))

  message("Wrote 6 figures to ", fig_dir)

# Figures for Lecture 6 (Exploratory analyses II)
#################################################
#
# Run from the project root:
#
#   source("R_scripts/Lecture_06_figures.R")
#
# Output goes to lectures/figures/. Everything uses AVONET, which students have
# been working with since Lecture 4.

  avonet <- read.csv("data/Avonet/AVONET1_BirdLife.csv")

  fig_dir <- "lectures/figures"

  if (!dir.exists(fig_dir)) dir.create(fig_dir, recursive = TRUE)

  open_png <- function(name, width = 900, height = 650) {
    png(file.path(fig_dir, name), width = width, height = height, res = 110)
  }


# 1. Four beak measurements, all at once ------------------------------------

  # Culmen and Nares are two ways of measuring the same beak, and it shows:
  # the top-left panel is nearly a straight line (r = 0.97).

  beak <- avonet[c("Beak.Length_Culmen", "Beak.Length_Nares",
                   "Beak.Width", "Beak.Depth")]

  open_png("06_01_pairs_beak.png", width = 900, height = 800)

    pairs(beak,
          pch  = 16,
          cex  = 0.3,
          col  = rgb(0, 0, 0, 0.15),
          main = "pairs(beak)")

  dev.off()


# 2. Five traits on a log scale ---------------------------------------------

  traits <- avonet[c("Beak.Length_Culmen", "Tarsus.Length",
                     "Wing.Length", "Tail.Length", "Mass")]

  open_png("06_02_pairs_traits.png", width = 950, height = 850)

    pairs(log10(traits),
          pch  = 16,
          cex  = 0.3,
          col  = rgb(0, 0, 0, 0.15),
          main = "pairs(log10(traits))")

  dev.off()


# 3. Two panels side by side, free y axes -----------------------------------

  # par(mfrow) splits the plotting window. No loop needed for two panels, and
  # this is the version with the trap in it: each panel picks its own y axis,
  # so 20 scavengers look as numerous as 6115 carnivores.

  carnivores <- avonet[which(avonet$Trophic.Level == "Carnivore"), ]
  scavengers <- avonet[which(avonet$Trophic.Level == "Scavenger"), ]

  open_png("06_03_mfrow_free.png", width = 1000, height = 500)

    par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))

      hist(log10(carnivores$Mass),
           main   = "Carnivore",
           xlab   = "log10 mass (g)",
           breaks = seq(0, 5.2, 0.2),
           xlim   = c(0, 5.2),
           col    = "grey80")

      hist(log10(scavengers$Mass),
           main   = "Scavenger",
           xlab   = "log10 mass (g)",
           breaks = seq(0, 5.2, 0.2),
           xlim   = c(0, 5.2),
           col    = "grey80")

    par(mfrow = c(1, 1))

  dev.off()


# 4. The same two with a shared y axis --------------------------------------

  open_png("06_04_mfrow_fixed.png", width = 1000, height = 500)

    par(mfrow = c(1, 2), mar = c(4, 4, 3, 1))

      hist(log10(carnivores$Mass),
           main   = paste0("Carnivore (n = ", nrow(carnivores), ")"),
           xlab   = "log10 mass (g)",
           breaks = seq(0, 5.2, 0.2),
           xlim   = c(0, 5.2),
           ylim   = c(0, 1000),
           col    = "grey80")

      hist(log10(scavengers$Mass),
           main   = paste0("Scavenger (n = ", nrow(scavengers), ")"),
           xlab   = "log10 mass (g)",
           breaks = seq(0, 5.2, 0.2),
           xlim   = c(0, 5.2),
           ylim   = c(0, 1000),
           col    = "grey80")

    par(mfrow = c(1, 1))

  dev.off()


# 5. All four groups, using a loop ------------------------------------------

  # The same plot four times, written once. ylim is set in one place rather
  # than four, which is half the argument for doing it this way.

  trophic_levels <- c("Carnivore", "Herbivore", "Omnivore", "Scavenger")

  open_png("06_05_loop_four_panels.png", width = 1000, height = 800)

    par(mfrow = c(2, 2), mar = c(4, 4, 3, 1))

      for (level in trophic_levels) {

        group <- avonet[which(avonet$Trophic.Level == level), ]

        hist(log10(group$Mass),
             main   = paste0(level, " (n = ", nrow(group), ")"),
             xlab   = "log10 mass (g)",
             breaks = seq(0, 5.2, 0.2),
             xlim   = c(0, 5.2),
             ylim   = c(0, 1000),
             col    = "grey80")

      }

    par(mfrow = c(1, 1))

  dev.off()


# 6. A figure with a trend line and real labels -----------------------------

  open_png("06_06_trend.png")

    par(mfrow = c(1, 1), mar = c(5, 4, 3, 1))

    plot(x    = log10(avonet$Mass),
         y    = log10(avonet$Wing.Length),
         xlab = "Body mass (log10 g)",
         ylab = "Wing length (log10 mm)",
         main = "Wing length scales with body mass in 11,009 bird species",
         pch  = 16,
         cex  = 0.3,
         col  = rgb(0, 0, 0, 0.2))

    fit <- lm(log10(Wing.Length) ~ log10(Mass), data = avonet)

    abline(fit, col = "red", lwd = 3)

  dev.off()

  print(round(coef(fit), 3))   # slope 0.339


  message("Wrote 7 figures to ", fig_dir)

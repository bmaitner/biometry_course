# Figures for Lecture 29 (Open science)
#######################################
#
# Run from the project root:
#
#   source("R_scripts/Lecture_29_figures.R")
#
# Draws the world map used on the "Open source reduces wasted efforts" slide,
# in a Mollweide projection, from the maps package's world database. The other
# Lecture 29 images are photos and screenshots; see lectures/figures/README.md.

  world <- maps::map("world", plot = FALSE, fill = TRUE)

  # Mollweide projection: solve 2*theta + sin(2*theta) = pi * sin(latitude)
  # for theta by Newton's method, then scale

  mollweide <- function(lon, lat){
    phi <- lat * pi / 180
    theta <- phi
    for (k in 1:30) {
      f <- 2 * theta + sin(2 * theta) - pi * sin(phi)
      d <- 2 + 2 * cos(2 * theta)
      theta <- ifelse(abs(d) < 1e-9, theta, theta - f / d)
    }
    list(x = 2 * sqrt(2) / pi * (lon * pi / 180) * cos(theta),
         y = sqrt(2) * sin(theta))
  }

  projected <- mollweide(world$x, world$y)

  png("lectures/figures/29_world_map.png", width = 1540, height = 950, bg = "white")

    par(mar = c(0, 0, 0, 0))

    plot(NA, xlim = c(-2.9, 2.9), ylim = c(-1.45, 1.45), asp = 1,
         axes = FALSE, xlab = "", ylab = "")

    edge <- seq(0, 2 * pi, length.out = 400)
    polygon(2 * sqrt(2) * cos(edge), sqrt(2) * sin(edge),
            col = "#5b9bd5", border = "#3a6f9e", lwd = 3)

    polygon(projected$x, projected$y, col = "#8fbf6a", border = "#6a8f4f", lwd = 0.6)

  dev.off()

# Assignment 3, Part 1: model modification and selection
#
# Three biological questions, each with a starting model already written and
# fitted. Your job, for each one:
#
#   1. Fit the starting model as given and look at its estimates.
#   2. Build alternative models. Each question below lists ideas, but you are
#      free to try others, including adding parameters.
#   3. Compare all of your models for that question with AICtab().
#   4. Say which model (or models) you would keep, and why, in terms of the
#      biology, not only the AIC.
#
# Lecture 18 covers everything you need: the formula version of mle2(), the
# parameters = argument for letting a parameter differ between groups, and the
# rules for a fair comparison.

library(bbmle)

# The data are in the course data package. If you have not installed it yet:
#   install.packages("remotes")
#   remotes::install_github("bmaitner/biometry_course", subdir = "biometrydata")
# If you cannot install it, each section gives a read.csv() or readRDS() line
# that loads the same data from the course repository.

library(biometrydata)


# 1a: Competition between bean beetles ----------------------------------------

  # Seed beetles lay their eggs on beans, and the larvae develop inside them,
  # so beetles sharing a dish of beans compete for food. Each row is one dish:
  # a known number of females of two species placed on 2 g of beans, and the
  # number of offspring of each species that emerged.
  #
  # Here we model the offspring of Callosobruchus maculatus (species 1, "Cmac")
  # when it shares beans with Callosobruchus subinnotatus (species 2, "Csub").
  #
  #   start_females_1   C. maculatus females placed in the dish
  #   start_females_2   C. subinnotatus females placed in the dish
  #   progeny_1         C. maculatus offspring that emerged
  #
  # ?beetle_competition_interspecific describes the experiment.

  beetles <- beetle_competition_interspecific
  # or: beetles <- read.csv("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Beetle_competition/competition_interspecific.csv")

  beetles <- beetles[beetles$pair == "Cmac_Csub" & !is.na(beetles$progeny_1), ]

  # plot if you like: offspring per female against the number of competitors

  plot(beetles$start_females_1 + beetles$start_females_2,
       beetles$progeny_1 / beetles$start_females_1,
       xlab = "females in the dish, both species",
       ylab = "C. maculatus offspring per female")

  # The starting model is a competition model in the Beverton-Holt family:
  #
  #   expected offspring = R * N1 / (1 + (a11 * N1 + a12 * N2)^d)
  #
  #   R     offspring per female with no competition at all
  #   a11   how much each C. maculatus female reduces that (within species)
  #   a12   how much each C. subinnotatus female reduces it (between species)
  #   d     how sharply competition bites as the dish fills up
  #   k     negative binomial size: how variable dishes are
  #
  # Bounds keep every parameter positive, so the optimizer cannot try
  # impossible values. If you remove a parameter, remove it from start, lower
  # and upper too.

  beetle.fit <- mle2(progeny_1 ~ dnbinom(mu = R * start_females_1 /
                                           (1 + (a11 * start_females_1 +
                                                 a12 * start_females_2)^d),
                                         size = k),
                     start = list(R = 20, a11 = 0.1, a12 = 0.1, d = 1, k = 2),
                     lower = c(R = 0.01, a11 = 0, a12 = 0, d = 0.1, k = 0.01),
                     upper = c(R = 1000, a11 = 10, a12 = 10, d = 10, k = 100),
                     method = "L-BFGS-B",
                     data = beetles)

  coef(beetle.fit)
  AIC(beetle.fit)

  # Questions to build models around:
  #   - Is d needed? With d = 1 (leave it out of the formula) this is the
  #     classic Beverton-Holt model.
  #   - Does C. subinnotatus affect C. maculatus at all? (What value of a12
  #     would mean "no"?)
  #   - Is a C. subinnotatus female as harmful as a C. maculatus female?
  #     (Hint: use one parameter for both.)
  #   - A different shape: the Ricker model,
  #     R * N1 * exp(-a11 * N1 - a12 * N2). Is it nested in the starting model?


# 1b: Wing length in hawks and eagles -----------------------------------------

  # Long-distance migrants should benefit from longer wings, which make
  # sustained flight cheaper. Do migratory hawks and eagles (family
  # Accipitridae) have longer wings than residents of the same body mass?
  #
  #   Wing.Length   mm
  #   Mass          g
  #   migration     resident, partial (some populations migrate), or migrant
  #
  # Each row is a species, so 249 species in all. One caution worth a
  # sentence in your answer: related species share traits, so species are not
  # fully independent data points. Accounting for that is beyond this course.

  hawks <- avonet
  # or: hawks <- readRDS(url("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Avonet/AVONET1_BirdLife.rds"))

  hawks <- hawks[hawks$Family1 == "Accipitridae", c("Species1", "Wing.Length", "Mass", "Migration")]
  hawks <- na.omit(hawks)
  hawks$migration <- factor(hawks$Migration, levels = 1:3,
                            labels = c("resident", "partial", "migrant"))

  # plot if you like

  plot(log(hawks$Mass), log(hawks$Wing.Length), col = hawks$migration,
       xlab = "log body mass", ylab = "log wing length")
  legend("topleft", levels(hawks$migration), col = 1:3, pch = 1)

  # The starting model: wing length is lognormal, and its log rises linearly
  # with log mass. That is a power law, wing = e^int * mass^b, the usual way
  # one body measurement scales with another.
  #
  #   int     wing length at a given mass (on the log scale)
  #   b       how fast wing length rises with mass
  #   log_s   the log of the scatter around the line. Fitting the log keeps
  #           the standard deviation positive, as in Lecture 16
  #
  # parameters = lets every one of the three differ among the migration
  # classes, which is deliberately more than the data are likely to support.

  hawk.fit <- mle2(Wing.Length ~ dlnorm(meanlog = int + b * log(Mass),
                                        sdlog = exp(log_s)),
                   start = list(int = 3, b = 0.3, log_s = -2),
                   parameters = list(int ~ migration,
                                     b ~ migration,
                                     log_s ~ migration),
                   data = hawks)

  coef(hawk.fit)
  AIC(hawk.fit)

  # Questions to build models around:
  #   - Do migrants have longer wings for their mass? (Which parameter is that?)
  #   - Does wing length scale with mass differently in migrants?
  #   - Are some migration classes more variable than others?
  #   - Is the distinction between partial migrants and full migrants needed,
  #     or would migrant versus resident do? (You would need a new column.)


# 1c: Reef fish species richness ----------------------------------------------

  # How many fish species does a diver record on a survey of a Florida coral
  # reef, and what explains the differences?
  #
  #   species_richness   number of species recorded on the survey
  #   depth              tens of metres (so 1.5 is 15 m)
  #   visibility         underwater visibility, tens of metres
  #   year               years since 2014
  #   region             Tortugas, Keys, or North (Miami to Martin County)
  #   protected          "yes" inside a marine protected area, otherwise "no"
  #
  # Depth and visibility are in tens of metres because depth is squared in
  # the model, and squaring 30 m gives numbers large enough to stall the
  # optimizer. Rescaling a covariate changes nothing about the biology.

  reef <- reef_fish_surveys
  # or: reef <- read.csv("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/Reef_fish/NCRMP_reef_fish_surveys.csv")

  reef$depth <- reef$DEPTH / 10
  reef$visibility <- reef$UNDERWATER_VISIBILITY / 10
  reef$year <- reef$YEAR - 2014
  reef$region <- factor(reef$REGION_DESCRIPTION,
                        levels = c("Dry Tortugas",
                                   "Florida Keys: from Key West to Miami",
                                   "Miami to North Martin County"),
                        labels = c("Tortugas", "Keys", "North"))
  reef$protected <- ifelse(reef$MPA_NAME == "Unprotected", "no", "yes")

  # plot if you like

  plot(reef$DEPTH, reef$species_richness, col = rgb(0, 0, 0, 0.1),
       xlab = "depth (m)", ylab = "species recorded")

  # The starting model: richness is Poisson, its log rises and then falls
  # with depth (the d2 * depth^2 term makes a hump), and it also depends on
  # visibility, year, region and protection.

  reef.fit <- mle2(species_richness ~ dpois(lambda = exp(int +
                                                         d1 * depth +
                                                         d2 * depth^2 +
                                                         v * visibility +
                                                         t * year)),
                   start = list(int = 3, d1 = 0, d2 = 0, v = 0, t = 0),
                   parameters = list(int ~ region + protected),
                   data = reef)

  coef(reef.fit)
  AIC(reef.fit)

  # Questions to build models around:
  #   - Is the Poisson the right distribution? Check before anything else:
  #     what did Lecture 15 use var() / mean() for?
  #   - With 8,560 surveys, AIC may keep nearly every term. If so, which
  #     effects are large enough to matter? Back-transform them: exp() of a
  #     coefficient is the multiplier on expected richness.
  #   - Visibility is a property of the water on the day, not of the reef.
  #     What might a visibility effect be measuring?
  #   - Does protection matter once region is accounted for?

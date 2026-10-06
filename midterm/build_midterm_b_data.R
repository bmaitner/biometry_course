# Build the Part 2 datasets for Midterm B (Fall 2026).
#
# Each is a subsample of data already in the repository, saved as a two-column
# data frame with the predictor first. Re-running this reproduces the exact
# files because of the seed. Midterm A's 2a/2b/2c.RDS are untouched.
#
# Expected answers are in Midterm_b_key.md (gitignored).
#
# Run from the project root:  source("midterm/build_midterm_b_data.R")

set.seed(2026)

# b_2a: bird egg mass vs adult body mass  (power law, lognormal)
a <- readRDS("data/Amniote_traits/Amniote_Database_Aug_2015.rds")
a[a == -999] <- NA
bird <- a[a$class == "Aves" & !is.na(a$egg_mass_g) & !is.na(a$adult_body_mass_g), ]
i <- sample(nrow(bird), 250)
b_2a <- data.frame(Adult.Body.Mass.g = round(bird$adult_body_mass_g[i], 1),
                   Egg.Mass.g        = round(bird$egg_mass_g[i], 2))
saveRDS(b_2a, "midterm/b_2a.RDS")

# b_2b: reef fish species richness vs total abundance  (saturating, neg binomial)
s <- read.csv("data/Reef_fish/NCRMP_reef_fish_surveys.csv")
s <- s[complete.cases(s[, c("species_richness", "total_abundance")]) &
       s$total_abundance > 0, ]
j <- sample(nrow(s), 250)
b_2b <- data.frame(Total.Fish.Abundance = round(s$total_abundance[j], 1),
                   Species.Richness     = s$species_richness[j])
saveRDS(b_2b, "midterm/b_2b.RDS")

# b_2c: coral hard bottom cover vs rugosity  (proportion, beta)
cr <- read.csv("data/Coral/CRCP_Benthic_Cover_Florida_7018_0ee5_9488.csv")[-1, ]
for (v in c("HARDBOTTOM_P", "WTD_RUG")) cr[[v]] <- as.numeric(cr[[v]])
agg <- aggregate(HARDBOTTOM_P ~ PRIMARY_SAMPLE_UNIT + STATION_NR, data = cr, FUN = sum)
rug <- unique(cr[, c("PRIMARY_SAMPLE_UNIT", "STATION_NR", "WTD_RUG")])
m <- merge(agg, rug)
m <- m[complete.cases(m) & m$HARDBOTTOM_P <= 100 & m$HARDBOTTOM_P >= 0, ]
k <- sample(nrow(m), 150)
b_2c <- data.frame(Rugosity              = round(m$WTD_RUG[k], 3),
                   Hard.Bottom.Cover.Pct = round(m$HARDBOTTOM_P[k], 1))
saveRDS(b_2c, "midterm/b_2c.RDS")

# report what each looks like
for (nm in c("b_2a", "b_2b", "b_2c")) {
  d <- get(nm)
  cat("\n==", nm, dim(d), paste(names(d), collapse = " ~ "), "\n")
  cat("  x range:", signif(range(d[[1]]), 3), "  y range:", signif(range(d[[2]]), 3), "\n")
  cat("  r raw:", round(cor(d[[1]], d[[2]]), 2),
      " r log-log:", round(suppressWarnings(cor(log10(d[[1]] + 0.01), log10(d[[2]] + 0.01))), 2), "\n")
}
cat("\nrichness mean", round(mean(b_2b$Species.Richness), 1),
    "var/mean", round(var(b_2b$Species.Richness) / mean(b_2b$Species.Richness), 2), "\n")
cat("cover mean", round(mean(b_2c$Hard.Bottom.Cover.Pct), 1),
    " pct at 100:", round(mean(b_2c$Hard.Bottom.Cover.Pct == 100), 2), "\n")

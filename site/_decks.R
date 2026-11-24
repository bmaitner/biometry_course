# What the site knows about the decks, shared by index.qmd (the lists of links)
# and copy_decks.R (the navigation added to each deck). Paths are relative to
# site/, which is where Quarto runs both.

# A deck can set `site-title:` in its front matter to be listed under a
# different name from its title slide (Lecture 1's title slide just says
# "Biometry").
deck_title <- function(f) {
  fm <- rmarkdown::yaml_front_matter(f)
  if (!is.null(fm[["site-title"]])) fm[["site-title"]] else fm$title
}

# One row per deck whose rendered HTML is committed next to its source, since
# that file is what the site serves.
deck_info <- function(dir, pattern) {
  qmd <- list.files(file.path("..", dir), pattern = pattern, full.names = TRUE)
  qmd <- qmd[file.exists(sub("\\.qmd$", ".html", qmd))]
  data.frame(
    base  = sub("\\.qmd$", "", basename(qmd)),
    title = vapply(qmd, deck_title, ""),
    row.names = NULL
  )
}

lecture_info <- function() {
  lectures <- deck_info("lectures", "^Lecture_\\d+_.*\\.qmd$")
  lectures$num <- as.integer(sub("^Lecture_(\\d+)_.*", "\\1", lectures$base))
  lectures$solutions <- grepl("solution", lectures$base)
  lectures[order(lectures$num, lectures$solutions), ]
}

supplement_info <- function() {
  deck_info("supplements", "^\\d+_.*\\.qmd$")
}

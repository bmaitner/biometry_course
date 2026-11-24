# Post-render step for the course website (see _quarto.yml).
#
# Copies the committed, self-contained deck HTML into the built site, so the
# links that index.qmd writes (lectures/<deck>.html, supplements/<file>.html)
# resolve. Quarto runs this from the site/ folder after every render, locally
# and in CI, so the local preview and the published site are built the same way.

out <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_site")

for (dir in c("lectures", "supplements")) {
  files <- list.files(file.path("..", dir), pattern = "\\.html$",
                      full.names = TRUE)
  dest <- file.path(out, dir)
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  copied <- file.copy(files, dest, overwrite = TRUE)
  if (!all(copied)) {
    stop("Could not copy into the site: ",
         paste(basename(files[!copied]), collapse = ", "))
  }
  message("Copied ", length(files), " files from ", dir, "/")
}

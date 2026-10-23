# Render the midterm from Markdown to Word and HTML.
#
# Each Midterm_*.md is the source of truth -- edit those, then run this script
# to regenerate the .docx students download. Each file is named for the year
# it was given: Midterm_2025, Midterm_2026, and so on. Old versions are kept so
# students have past midterms to practice on. Add next year's as Midterm_2027
# rather than editing this year's.
#
# Run from the project root:  source("midterm/render_midterm.R")

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. It is in renv.lock -- run renv::restore() first.")
}

library(rmarkdown)

# Find every midterm source in this folder

  midterm_files <- list.files(path = "midterm",
                              pattern = "^Midterm_.*[.]md$",
                              full.names = TRUE)

# Answer keys are deliberately NOT rendered here, so a key never ends up sitting
# next to the student copy in the same format. Render one by hand if you want it.

  midterm_files <- midterm_files[!grepl("_key[.]md$", midterm_files)]

  if (length(midterm_files) == 0) {
    stop("No Midterm_*.md files found. Are you running this from the project root?")
  }

# Render each one to Word and HTML, alongside its source

  for (midterm in midterm_files) {

    for (fmt in c("word_document", "html_document")) {

      render(input = midterm,
             output_format = fmt,
             output_dir = "midterm",
             quiet = TRUE)

    }

  }

message("Rendered ", length(midterm_files), " midterms:")
message(paste0("  ", sub("[.]md$", ".docx", basename(midterm_files)), collapse = "\n"))

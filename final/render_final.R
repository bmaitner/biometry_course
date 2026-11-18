# Render the final project instructions from Markdown to Word and HTML.
#
# Final_Project.md is the source of truth: edit it, then run this script to
# regenerate the .docx students download (and the .html, which is not
# committed). Re-run it after every edit or the versions will disagree.
#
# Run from the project root:  source("final/render_final.R")

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. It is in renv.lock: run renv::restore() first.")
}

library(rmarkdown)

  final_file <- "final/Final_Project.md"

  if (!file.exists(final_file)) {
    stop("final/Final_Project.md not found. Are you running this from the project root?")
  }

# Render to Word and HTML, alongside the source

  for (fmt in c("word_document", "html_document")) {

    render(input = final_file,
           output_format = fmt,
           output_dir = "final",
           quiet = TRUE)

  }

message("Rendered final/Final_Project.docx and final/Final_Project.html")

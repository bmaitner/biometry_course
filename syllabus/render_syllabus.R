# Render the syllabus from Markdown to HTML and Word.
#
# syllabus.md is the source of truth -- edit that file, then run this script to
# regenerate the shareable versions. The rendered outputs are gitignored on
# purpose: keeping a rendered copy in version control just means it goes stale.
#
# Run from the project root:  source("syllabus/render_syllabus.R")

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. It is in renv.lock -- run renv::restore() first.")
}

library(rmarkdown)

# Render to each format in turn. output_dir keeps the results next to the source.

  for (fmt in c("html_document", "word_document")) {

    render(input = "syllabus/syllabus.md",
           output_format = fmt,
           output_dir = "syllabus",
           quiet = TRUE)

  }

message("Wrote syllabus/syllabus.html and syllabus/syllabus.docx")

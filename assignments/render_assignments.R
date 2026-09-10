# Render the assignments from Markdown to Word and HTML.
#
# Each Assignment_N.md is the source of truth -- edit those, then run this
# script to regenerate the .docx and .html that students download. Both the
# source and the rendered files are kept in the repo, so remember to re-run
# this after editing an assignment or the versions will disagree.
#
# Run from the project root:  source("assignments/render_assignments.R")

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. It is in renv.lock -- run renv::restore() first.")
}

library(rmarkdown)

# Find every assignment source. Assignment 3 lives in its own subfolder
# because it ships with a starter script, so search recursively.

  assignment_files <- list.files(path = "assignments",
                                 pattern = "^Assignment_.*[.]md$",
                                 full.names = TRUE,
                                 recursive = TRUE)

  if (length(assignment_files) == 0) {
    stop("No Assignment_*.md files found. Are you running this from the project root?")
  }

# Render each one to Word and HTML, alongside its source

  for (assignment in assignment_files) {

    for (format in c("word_document", "html_document")) {

      render(input         = assignment,
             output_format = format,
             output_dir    = dirname(assignment),
             quiet         = TRUE)

    }

  }

message("Rendered ", length(assignment_files), " assignments:")
message(paste0("  ", assignment_files, collapse = "\n"))

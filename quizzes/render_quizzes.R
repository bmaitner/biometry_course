# Render the quizzes from Markdown to Word.
#
# Each Quiz_*.md is the source of truth -- edit those, then run this script to
# regenerate the .docx you print from. Unlike the syllabus, both the source and
# the rendered .docx are kept in the repo, so remember to re-run this after
# editing a quiz or the two will disagree.
#
# Run from the project root:  source("quizzes/render_quizzes.R")

if (!requireNamespace("rmarkdown", quietly = TRUE)) {
  stop("rmarkdown is not installed. It is in renv.lock -- run renv::restore() first.")
}

library(rmarkdown)

# Find every quiz source in this folder

  quiz_files <- list.files(path = "quizzes",
                           pattern = "^Quiz_.*[.]md$",
                           full.names = TRUE)

  if (length(quiz_files) == 0) {
    stop("No Quiz_*.md files found. Are you running this from the project root?")
  }

# Render each one to Word, alongside its source

  for (quiz in quiz_files) {

    render(input = quiz,
           output_format = "word_document",
           output_dir = "quizzes",
           quiet = TRUE)

  }

message("Rendered ", length(quiz_files), " quizzes:")
message(paste0("  ", sub("[.]md$", ".docx", basename(quiz_files)), collapse = "\n"))

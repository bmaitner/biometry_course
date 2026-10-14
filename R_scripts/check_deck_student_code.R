# Check that the code students are told to type actually runs.
#
# Why this exists: on 2026-10-06, Lecture 13 asked students to run
# mean(cardinals) on a dataset nothing had told them to load. The deck itself
# rendered fine, because its hidden setup chunk loads the data. The student path
# was broken and the slides did not work in class.
#
# This script extracts every code block marked "Type and run" (the ::: {.type-it}
# divs) from a deck, in slide order, and runs them in sequence in this session,
# exactly as a student typing along would. It reports the first block that fails.
#
# Run from the project root:
#   source("R_scripts/check_deck_student_code.R")
#   check_deck("lectures/Lecture_13_stochastic_simulations.qmd")
#   check_all_decks()
#
# Expect two kinds of legitimate failure, which the output labels rather than
# hides:
#   - fill-in-the-blank exercises: an empty function body, ____ marking a piece
#     the student supplies, or a comment such as "your NLL goes here"
#   - "use your own data" blocks that reference my_data or your_file.csv
# Anything else is a real bug: an object used before anything created it.

check_deck <- function(path, verbose = TRUE) {

  src <- paste(readLines(path, warn = FALSE), collapse = "\n")

  # every r chunk inside a ::: {.type-it} div, in order
  pattern <- "(?s)::: \\{\\.type-it\\}\\s*```\\{r\\}\\n(.*?)```"
  m <- gregexpr(pattern, src, perl = TRUE)
  hits <- regmatches(src, m)[[1]]

  if (length(hits) == 0) {
    message(basename(path), ": no type-and-run blocks")
    return(invisible(TRUE))
  }

  bodies <- sub("(?s)^.*?```\\{r\\}\\n", "", hits, perl = TRUE)
  bodies <- sub("(?s)```\\s*$", "", bodies, perl = TRUE)
  bodies <- lapply(strsplit(bodies, "\n"), function(x) x[!grepl("^#\\|", x)])

  env <- new.env(parent = globalenv())
  pdf(NULL)
  on.exit(dev.off(), add = TRUE)

  ok <- TRUE

  for (i in seq_along(bodies)) {

    code <- paste(bodies[[i]], collapse = "\n")
    first <- grep("^\\s*($|#)", bodies[[i]], invert = TRUE, value = TRUE)[1]

    result <- try(eval(parse(text = code), envir = env), silent = TRUE)

    if (inherits(result, "try-error")) {

      msg <- conditionMessage(attr(result, "condition"))

      expected <- grepl("my_data|your_file", code) ||
                  grepl("____", code) ||
                  grepl("goes here|fill in|your .*here", code, ignore.case = TRUE) ||
                  grepl("\\{\\s*\\n\\s*\\}", code)

      label <- if (expected) "expected" else "PROBLEM"

      message(sprintf("%s  block %d [%s]\n    %s: %s",
                      basename(path), i, substr(first, 1, 50), label, msg))

      if (!expected) ok <- FALSE

      break   # everything after this would fail too
    }
  }

  if (ok && verbose) message(basename(path), ": student code runs cleanly")

  invisible(ok)
}

check_all_decks <- function() {

  decks <- list.files("lectures", pattern = "[.]qmd$", full.names = TRUE)
  invisible(vapply(decks, check_deck, logical(1)))

}

# Check a deck's source for stray control characters -----------------------
#
# Writing slides with scripts makes it easy to lose a backslash. A LaTeX
# command such as backslash-alpha, written inside a non-raw Python string,
# becomes a bell character, and the slide then shows mojibake where the Greek
# letter should be. This has happened twice, once inside this very comment.
# Control characters are never intentional in a .qmd, so flag any that appear.

check_deck_characters <- function(path) {

  raw <- readBin(path, "raw", file.size(path))

  bad <- raw[raw < as.raw(9) | (raw > as.raw(13) & raw < as.raw(32))]

  if (length(bad) > 0) {
    message(sprintf("%s: %d stray control character(s): %s",
                    basename(path), length(bad),
                    paste(unique(sprintf("0x%02x", as.integer(bad))),
                          collapse = " ")))
    return(invisible(FALSE))
  }

  invisible(TRUE)

}

check_all_characters <- function() {

  decks <- list.files("lectures", pattern = "[.]qmd$", full.names = TRUE)
  ok <- vapply(decks, check_deck_characters, logical(1))
  if (all(ok)) message("no stray control characters in any deck")
  invisible(ok)

}

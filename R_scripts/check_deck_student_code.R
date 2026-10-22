# Check that the code students are told to type actually runs.
#
# Why this exists: on 2026-10-06, Lecture 13 asked students to run
# mean(cardinals) on a dataset nothing had told them to load. The deck itself
# rendered fine, because its hidden setup chunk loads the data. The student path
# was broken and the slides did not work in class.
#
# This script extracts every code block marked "Type and run" (the ::: {.type-it}
# divs) from a deck, in slide order, and runs them in sequence in this session,
# exactly as a student typing along would.
#
# Run from the project root:
#   source("R_scripts/check_deck_student_code.R")
#   check_deck("lectures/Lecture_16_complex_functions.qmd")
#   check_all_decks()
#
# Every block is reported, and a failure gets one of four labels:
#
#   fails by design  a block written to produce an error, so students can read
#                    it. Marked by a comment saying "on purpose" or
#                    "deliberately". Nothing downstream depends on it.
#   expected         a fill-in exercise: ____ marks a piece the student supplies,
#                    or a comment such as "your NLL goes here", or an empty body
#   skipped          fails only because it needs an object that one of those
#                    exercises would have created
#   PROBLEM          anything else, which means an object is used before
#                    anything created it. This is the bug the script is for.
#
# Checking does not stop at the first failure, because exercises sit in the
# middle of a deck and there is real code after them. A deck's exercises are
# verified end to end by rendering its companion *_exercise_solutions.qmd, where
# the blanks are filled in and every chunk is evaluated.

# Installing is a step students take once, on their own machine; it is not part
# of the code path being checked. A block that tells students to run
# install.packages() or remotes::install_github() would otherwise install
# packages every time the checker runs, including in CI. Those lines are
# dropped before a block is run or scanned for the packages it needs; the
# packages themselves are installed by the CI workflow.

# Where the decks live. Supplements are checked on the same terms as lectures:
# nobody is in the room when one is read, so code that has quietly stopped
# working there is worse than in a lecture, not better. Added 2026-10-22 with
# the first supplement that has type-and-run blocks.

deck_dirs <- function() c("lectures", "supplements")

all_decks <- function(dirs = deck_dirs()) {
  unlist(lapply(dirs[dir.exists(dirs)],
                function(d) list.files(d, pattern = "[.]qmd$", full.names = TRUE)),
         use.names = FALSE)
}

drop_install_lines <- function(lines) {

  keep <- rep(TRUE, length(lines))
  depth <- 0    # open parentheses left by an install call spanning several lines

  for (i in seq_along(lines)) {
    starts <- grepl("install[.]packages[(]|install_github[(]", lines[i])
    if (starts || depth > 0) {
      keep[i] <- FALSE
      code <- sub("#.*$", "", lines[i])
      depth <- depth + lengths(regmatches(code, gregexpr("[(]", code))) -
                       lengths(regmatches(code, gregexpr("[)]", code)))
    }
  }

  lines[keep]
}

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
  bodies <- lapply(bodies, drop_install_lines)

  env <- new.env(parent = globalenv())
  pdf(NULL)
  on.exit(dev.off(), add = TRUE)

  unresolved <- character(0)   # objects an unfinished exercise would have made
  problems <- 0

  for (i in seq_along(bodies)) {

    code <- paste(bodies[[i]], collapse = "\n")
    first <- grep("^\\s*($|#)", bodies[[i]], invert = TRUE, value = TRUE)[1]

    # anything this block assigns, in case the block does not finish
    assigns <- grep("^\\s*[A-Za-z.][A-Za-z._0-9]*\\s*<-", bodies[[i]], value = TRUE)
    targets <- trimws(sub("\\s*<-.*$", "", assigns))

    result <- try(eval(parse(text = code), envir = env), silent = TRUE)

    if (inherits(result, "try-error")) {

      msg <- conditionMessage(attr(result, "condition"))

      by_design <- grepl("on purpose|deliberately", code, ignore.case = TRUE)

      redacted <- grepl("my_data|your_file", code) ||
                  grepl("____", code) ||
                  grepl("goes here|fill in|call your|your .*here", code,
                        ignore.case = TRUE) ||
                  grepl("\\{\\s*\\n\\s*\\}", code)

      # a later block is downstream if it uses, or complains about, something an
      # unfinished exercise was supposed to create
      downstream <- length(unresolved) > 0 &&
                    any(vapply(unresolved, function(nm){
                      pat <- paste0("\\b", gsub(".", "[.]", nm, fixed = TRUE), "\\b")
                      grepl(pat, code) || grepl(nm, msg, fixed = TRUE)
                    }, logical(1)))

      label <- if (by_design) {
        "fails by design"
      } else if (redacted) {
        "expected, student supplies the code"
      } else if (downstream) {
        "skipped, needs an exercise above"
      } else {
        "PROBLEM"
      }

      if (label == "PROBLEM") { problems <- problems + 1 }

      # later blocks may legitimately depend on what this one did not finish.
      # Only count a target as unfinished if it is missing, or is a function
      # whose body the student was supposed to write and has not.
      if (redacted || downstream) {
        for (nm in targets) {
          if (!exists(nm, envir = env, inherits = FALSE)) {
            unresolved <- c(unresolved, nm)
          } else {
            obj <- get(nm, envir = env)
            if (is.function(obj) && length(body(obj)) <= 1) {
              unresolved <- c(unresolved, nm)
            }
          }
        }
      }

      message(sprintf("%s  block %d [%s]\n    %s: %s",
                      basename(path), i, substr(first, 1, 50), label, msg))
    }
  }

  ok <- problems == 0

  if (ok && verbose) {
    message(basename(path), ": student code runs cleanly (",
            length(bodies), " blocks)")
  }
  if (!ok) {
    message(basename(path), ": ", problems, " real problem(s)")
  }

  invisible(ok)
}

check_all_decks <- function() {

  invisible(vapply(all_decks(), check_deck, logical(1)))

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

  # A lost backslash before t is a tab, which the test above lets through
  # because tabs are legal in a source file. Inside math they never are: \text
  # and \times become a tab plus "ext" and "imes", and the slide shows garbled
  # italics. Happened on 2026-10-21, in Lecture 18's AIC formula.
  lines <- readLines(path, warn = FALSE)
  tabbed_math <- which(grepl("\t", lines) & grepl("[$]", lines))

  if (length(tabbed_math) > 0) {
    message(sprintf("%s: tab character inside math on line(s) %s",
                    basename(path), paste(tabbed_math, collapse = ", ")))
    return(invisible(FALSE))
  }

  invisible(TRUE)

}

check_all_characters <- function() {

  ok <- vapply(all_decks(), check_deck_characters, logical(1))
  if (all(ok)) message("no stray control characters in any deck")
  invisible(ok)

}

# What packages does the student path need? ---------------------------------
#
# Not the same question as what renv::dependencies() answers. The type-and-run
# blocks carry `#| eval: false`, because the deck must not run student code at
# render time, and renv skips chunks it will not evaluate. So renv reports that
# Lecture 26 needs nothing but knitr, while a student following it needs
# tidyverse and reprex.
#
# This scans the blocks the checker actually executes, which is the only
# definition that matters for CI. Added 2026-10-18, after the check workflow
# failed on packages its hand-written list had never heard of.

deck_packages <- function(dirs = deck_dirs()) {

  decks <- all_decks(dirs)
  pattern <- "(?s)::: \\{\\.type-it\\}\\s*```\\{r\\}\\n(.*?)```"

  pkgs <- character(0)

  for (path in decks) {

    src <- paste(readLines(path, warn = FALSE), collapse = "\n")
    hits <- regmatches(src, gregexpr(pattern, src, perl = TRUE))[[1]]
    if (length(hits) == 0) next

    code <- paste(drop_install_lines(strsplit(paste(hits, collapse = "\n"), "\n")[[1]]),
                  collapse = "\n")

    # library(x) and require(x)
    m <- regmatches(code, gregexpr("(?:library|require)[(]([A-Za-z.][A-Za-z._0-9]*)",
                                   code, perl = TRUE))[[1]]
    pkgs <- c(pkgs, sub("^(?:library|require)[(]", "", m))

    # x::y
    m2 <- regmatches(code, gregexpr("([A-Za-z.][A-Za-z._0-9]*)::", code, perl = TRUE))[[1]]
    pkgs <- c(pkgs, sub("::$", "", m2))
  }

  sort(unique(pkgs))
}

# Fail early, and say exactly what to install, rather than letting the deck
# checker report a confusing "object not found" twenty blocks later.

check_deck_packages <- function(dirs = deck_dirs()) {

  needed <- deck_packages(dirs)
  missing <- needed[!needed %in% rownames(installed.packages())]

  if (length(missing) > 0) {
    message("student code needs packages that are not installed:")
    for (m in missing) message("  - ", m)
    message("install them, or add them to .github/workflows/check.yaml")
    return(invisible(FALSE))
  }

  message("all ", length(needed), " packages the student path needs are installed")
  invisible(TRUE)

}

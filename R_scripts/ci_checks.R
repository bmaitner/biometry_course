# The automated checks, in one place.
#
# Run locally, from the project root, before pushing:
#
#   Rscript R_scripts/ci_checks.R
#
# This is the same script .github/workflows/check.yaml runs, so a green run
# here means a green run there. Takes about 25 seconds, most of it downloading
# the BBS file that the type-and-run blocks use.
#
# What it checks, and why each one is here:
#
#   1. No stray control characters. Writing slides through a script makes it
#      easy to lose a backslash, and a LaTeX command inside a non-raw string
#      becomes a bell character. This happened three times in Fall 2026 and the
#      only symptom is garbled text on the rendered slide.
#
#   2. The student path works. Every "Type and run" block, in slide order, in a
#      fresh session. Lecture 13 rendered perfectly while being broken for
#      students, because its hidden setup chunk loaded data the students were
#      never told to load. That was discovered in class.
#
# Both checks run even if the first fails, so one push tells you everything
# that is wrong rather than one thing at a time.
#
# What this does NOT check: whether the numbers quoted in the speaker notes are
# the numbers the code produces. Nothing automated catches that. Rendering a
# deck proves the code runs, not that the sentences around it are true.

source("R_scripts/check_deck_student_code.R")

failures <- character(0)

message("--- control characters ---")
if (!all(check_all_characters())) {
  failures <- c(failures, "stray control characters in a deck")
}

message("\n--- student code, in slide order ---")
if (!all(check_all_decks())) {
  failures <- c(failures, "a type-and-run block is broken")
}

if (length(failures) > 0) {
  message("\nFAILED:")
  for (f in failures) message("  - ", f)
  quit(status = 1)
}

message("\nall checks passed")

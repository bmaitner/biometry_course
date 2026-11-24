# Post-render step for the course website (see _quarto.yml).
#
# Copies the committed, self-contained deck HTML into the built site, so the
# links that index.qmd writes (lectures/<deck>.html, supplements/<file>.html)
# resolve. Quarto runs this from the site/ folder after every render, locally
# and in CI, so the local preview and the published site are built the same way.
#
# On the way in, each copy gets two things the decks do not have on their own,
# added here rather than in the decks so that the committed HTML (what gets
# taught from) stays exactly as rendered:
#
#   - A small navigation bar, bottom left: back to the list, and the previous
#     and next lecture. Without it the only way out of a deck was the browser's
#     back button.
#   - Slide changes no longer pile up in the browser history. revealjs pushes
#     every slide onto it by default, so leaving a deck by "back" meant pressing
#     it once per slide (found 2026-11-24, the day the site went up). Slides
#     still get their own URL, so a link to slide 12 still works.

source("_decks.R")

out <- Sys.getenv("QUARTO_PROJECT_OUTPUT_DIR", "_site")

escape_html <- function(x) {
  x <- gsub("&", "&amp;", x, fixed = TRUE)
  x <- gsub("<", "&lt;", x, fixed = TRUE)
  x <- gsub(">", "&gt;", x, fixed = TRUE)
  gsub("\"", "&quot;", x, fixed = TRUE)
}

nav_link <- function(text, href, title = NULL) {
  sprintf('<a href="%s"%s>%s</a>', href,
          if (is.null(title)) "" else sprintf(' title="%s"', escape_html(title)),
          text)
}

nav_snippet <- function(links) {
  paste0(
    '\n<nav class="site-nav" aria-label="Course navigation">',
    paste(links, collapse = '<span aria-hidden="true">|</span>'),
    '</nav>
<style>
.site-nav { position: fixed; left: 3em; bottom: 0.6em; z-index: 40;
  font: 16px/1.4 "Source Sans Pro", Helvetica, Arial, sans-serif;
  color: #888; opacity: 0.7; }
.site-nav:hover, .site-nav:focus-within { opacity: 1; }
.site-nav a { color: #555; text-decoration: none; padding: 0 0.35em; }
.site-nav a:hover, .site-nav a:focus { color: #2a7ab0; text-decoration: underline; }
.site-nav.site-nav-page { position: static; padding: 0.6em 1em; opacity: 1; }
html.print-pdf .site-nav { display: none; }
@media print { .site-nav { display: none; } }
</style>
<script>
(function () {
  var nav = document.querySelector(".site-nav");
  if (!window.Reveal) { nav.classList.add("site-nav-page");
    document.body.insertBefore(nav, document.body.firstChild); return; }
  var noHistory = function () { Reveal.configure({ history: false }); };
  if (Reveal.isReady()) noHistory(); else Reveal.on("ready", noHistory);
})();
</script>\n')
}

# Insert before the last </body>. Work on raw bytes: the decks are UTF-8 with
# large embedded images, and some contain "</body>" inside embedded scripts.
inject <- function(file, snippet) {
  bytes <- readBin(file, "raw", file.size(file))
  at <- grepRaw("</body>", bytes, fixed = TRUE, all = TRUE)
  if (length(at) == 0) stop("No </body> in ", file)
  at <- at[length(at)]
  writeBin(c(bytes[seq_len(at - 1)], charToRaw(enc2utf8(snippet)),
             bytes[at:length(bytes)]), file)
}

# Lectures: previous and next run through the lectures themselves; a solutions
# deck links back to its own lecture instead.
lectures <- lecture_info()
main <- lectures[!lectures$solutions, ]
home <- nav_link("All lectures", "../index.html#lectures")
deck <- function(row, text) {
  nav_link(text, paste0(row$base, ".html"),
           sprintf("Lecture %d: %s", row$num, row$title))
}

dest <- file.path(out, "lectures")
dir.create(dest, recursive = TRUE, showWarnings = FALSE)

for (i in seq_len(nrow(lectures))) {
  row <- lectures[i, ]
  if (row$solutions) {
    own <- main[main$num == row$num, ]
    links <- c(if (nrow(own)) deck(own[1, ], paste0("&lsaquo; Lecture ", row$num)),
               home)
  } else {
    k <- match(row$base, main$base)
    links <- c(if (k > 1) deck(main[k - 1, ], paste0("&lsaquo; Lecture ", main$num[k - 1])),
               home,
               if (k < nrow(main)) deck(main[k + 1, ], paste0("Lecture ", main$num[k + 1], " &rsaquo;")))
  }
  to <- file.path(dest, paste0(row$base, ".html"))
  if (!file.copy(file.path("..", "lectures", paste0(row$base, ".html")), to,
                 overwrite = TRUE)) stop("Could not copy ", row$base)
  inject(to, nav_snippet(links))
}
message("Copied ", nrow(lectures), " lecture decks")

# Supplements: the reading page and the slides, both linking back to the list.
dest <- file.path(out, "supplements")
dir.create(dest, recursive = TRUE, showWarnings = FALSE)
supp_home <- nav_link("All supplements", "../index.html#supplements")

for (base in supplement_info()$base) {
  for (file in paste0(base, c(".html", "-slides.html"))) {
    to <- file.path(dest, file)
    if (!file.copy(file.path("..", "supplements", file), to, overwrite = TRUE))
      stop("Could not copy ", file)
    inject(to, nav_snippet(supp_home))
  }
}
message("Copied ", length(supplement_info()$base), " supplements")

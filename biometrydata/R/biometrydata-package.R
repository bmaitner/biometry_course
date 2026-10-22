#' biometrydata: datasets for the Biometry course
#'
#' Every dataset used in Biometry (PCB 6455 / BSC 4933), so that loading data in
#' class is `library(biometrydata)` rather than a long URL.
#'
#' Each dataset is identical to downloading the matching file from `data/` in
#' the course repository, and its help page gives that link. Use whichever is
#' convenient; the numbers are the same.
#'
#' ```
#' library(biometrydata)
#'
#' occ <- bobwhite_occupancy
#' head(occ)
#'
#' # the same table, downloaded
#' occ <- read.csv("https://github.com/bmaitner/biometry_course/raw/refs/heads/main/data/class_examples/bobwhite_occupancy.csv")
#' ```
#'
#' List everything with `data(package = "biometrydata")`.
#'
#' Files that are not tables R reads directly (spreadsheets, the PANGAEA `.tab`
#' export, the beetle datasheets and protocols) are installed with the package,
#' in folders named as in the repository:
#'
#' ```
#' list.files(system.file("extdata", package = "biometrydata"), recursive = TRUE)
#'
#' amphibians_file <- system.file("extdata", "European_amphibians", "oo_32985.xlsx",
#'                                package = "biometrydata")
#' ```
#'
#' @keywords internal
"_PACKAGE"

# biometrydata

Every dataset used in Biometry (PCB 6455 / BSC 4933, USF), as an R package.

## Install

```r
install.packages("remotes")    # once, if you do not have it
remotes::install_github("bmaitner/biometry_course", subdir = "biometrydata")
```

The download is large. `install_github()` fetches the whole course repository,
about 280 MB, and installs only this package from it, about 80 MB, almost all of
which is the deer movement data. Reinstall the same way to pick up any updates.

## Use

```r
library(biometrydata)

occ <- bobwhite_occupancy      # a dataset, ready to use
?bobwhite_occupancy            # what it is, where it came from, its license
data(package = "biometrydata") # everything in the package
```

## Or download the files

Nothing here replaces the files in [`data/`](../data). They stay where they
are, and every `read.csv()` and `readRDS()` link in the course materials keeps
working. Each dataset in the package is identical to downloading its file, and
each help page gives the link.

## Updating the package data

The files in `data/` are the originals. After any of them change, rebuild the
package's copies from the project root:

```r
source("data/class_examples/make_class_examples.R")   # if the class examples changed
source("biometrydata/data-raw/build_package_data.R")
```

then regenerate the help pages after editing `R/data.R`:

```r
roxygen2::roxygenise("biometrydata")
```

`build_package_data.R` stops with an error if a dataset in `data/` is not in
the package, so a new dataset cannot be forgotten. Add it to the `tables` list
in that script and give it a help page in `R/data.R`.

## Licenses

The datasets keep their original licenses, which differ; see `LICENSE` and
each help page. `mangroves` is CC-BY-NC: not for commercial use.


<!-- README.md is generated from README.Rmd. Please edit that file -->

# Mets

<!-- badges: start -->

<!-- badges: end -->

The goal of Mets is to explore the arts of The Metropolitan Museum of
Art.

## Installation

You can install the released version of Mets from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("Mets")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("whj0911/Mets")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(Mets)
## arts_overview

## arts_images
```

There is a demo of the two
functions

``` r
# arts_overview(q = "french", isOnView = "true", hasImages = "true", medium = "Silk")
```

Input the ObjectIDs you got from the overview function

``` r
# arts_images(c(197742, 197743))
```

## arts\_overview

There are 7 parameters: “q”, “isOnView”, “medium”, “hasImages”,
“geoLocation”, “dateBegin”, and “dateEnd”. The q is the main query,
which is required. Others can be ignored, but the more conditions you
input, the less results it returns, which will make the process faster.
eg. just try, q = “sunflowers” or “China”; isOnView = “true”; medium =
“Silk”.

The result shows a head of first 6 observations, and the whole dataframe
will automatically be saved as “arts\_overview.csv” file.

## Keep in mind

The more specific parameters you input using arts\_overview, the less
objects it returns, which helps to extract data smoothly, since there
are more than 470,000 artworks in the Mets database.

When the result you may get exceeds 100 or so, the process will become
pretty slow, or the Rstudio may collapse, or the computer even freeszes
that definitely is not what you want.

For the arts\_overview function, each parameter is case sensitive, and a
quotation sigh is required.

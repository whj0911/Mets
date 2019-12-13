
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

Make sure attach these packages

``` r
library(dplyr)
#> 
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#> 
#>     filter, lag
#> The following objects are masked from 'package:base':
#> 
#>     intersect, setdiff, setequal, union
library(stringr)
library(knitr)
library(httr)
```

There is a demo of the two functions

``` r
library(Mets)
arts_overview(q = "french", isOnView = "true", hasImages = "true", medium = "Silk")
#>   objectID objectName culture period reign        artistDisplayName
#> 1   197742   Armchair                      Nicolas-Quinibert Foliot
#> 2   197743   Armchair                      Nicolas-Quinibert Foliot
#>            artistDisplayBio                                          medium
#> 1 1706–1776, warden 1750/52 Carved and gilded beech; wool and silk tapestry
#> 2 1706–1776, warden 1750/52 Carved and gilded beech; wool and silk tapestry
#>                                              dimensions city country region
#> 1     40 1/4 x 31 x 25 1/2 in. (102.2 x 78.7 x 64.8 cm)                    
#> 2 40 5/8 x 29 3/4 x 25 1/2 in. (103.2 x 75.6 x 64.8 cm)                    
#>   excavation     classification
#> 1            Woodwork-Furniture
#> 2            Woodwork-Furniture
#>                                                objectURL
#> 1 https://www.metmuseum.org/art/collection/search/197742
#> 2 https://www.metmuseum.org/art/collection/search/197743
```

Input the ObjectIDs you got from the overview function

``` r
library(Mets)
arts_images(c(197742, 197743))
```

| objectID | objectName | primaryImageSmall                                                   |
| :------- | :--------- | :------------------------------------------------------------------ |
| 197742   | Armchair   | ![](https://images.metmuseum.org/CRDImages/es/web-large/152737.jpg) |
| 197743   | Armchair   | ![](https://images.metmuseum.org/CRDImages/es/web-large/152738.jpg) |

``` r
# arts_images(c(438815, 436703, 436965, 435997, 436706, 437439))
```

## Function arts\_overview

There are 7 parameters: “q”, “isOnView”, “medium”, “hasImages”,
“geoLocation”, “dateBegin”, and “dateEnd”. The q is the main query,
which is required. Others can be ignored, but the more conditions you
input, the less results it returns, which makes the process faster.

eg. just try, q = “sunflowers” or “China”, isOnView = “true”, medium =
“Silk”; or q = “Auguste Renoir”, hasImages = “true”.

The result shows a head of first 6 observations, and the whole dataframe
will automatically be saved as “arts\_overview.csv” file.

## Function arts\_images

Multiple Input, like: c(438815, 436703, 436965, 435997, 436706, 437439)
Again, an ID that does not exist will be indicated on the Console,
although few numbers ranging from 1 to 470,000 are truly absent. eg, try
197, 1970, 19700, and 197000.

## Keep in mind

The more specific parameters you input using arts\_overview, the less
objects it returns, which helps to extract data smoothly, since there
are more than 470,000 artworks in the Mets database.

When the result you may get exceeds 100 or so, the process becomes
pretty slow, or the Rstudio may collapse, or the computer even freeszes
that definitely is not what you want.

For the arts\_overview function, each parameter is case sensitive except
for q, and a quotation sigh is required for all.

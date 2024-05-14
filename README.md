
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emberr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml)
[![Project Status:
WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
<!-- badges: end -->

The goal of emberr is to provide functions to query and retrieve data
from the [Ember](https://ember-climate.org/)
[API](https://ember-climate.org/data/api/).

You can view the [API documentation](https://api.ember-climate.org/docs)
for details. Please note the license information provided by Ember:

\*Our data is published using the CC-BY-4.0 license. Anyone is able to
use our data for any purpose (personal, commercial, etc.). The only
requirements by this license are that:

1)  Ember is cited as the data source. E.g. ‘Monthly electricity
    generation data, Ember’
2)  You may not add any additional legal/technological restrictions to
    the data.\*

See this [blog
post](https://andypicke.quarto.pub/portfolio/posts/emberr/emberr.html)
for a description and examples of the package.

## Installation

You can install the development version of
[emberr](https://github.com/andypicke/emberr) from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andypicke/emberr")
```

You will need to sign up for a free API key.

The package assumes you have stored your API key in your .Renviron file
as *EMBER_API_KEY*

## Example

Get monthly electricity generation data for 2021-2023. By Default this
returns data for all countries/regions (“entities”).

``` r
library(emberr)

gen <- emberr::get_ember_data(dataset = "electricity-generation", temporal_resolution = "monthly", min_date = 2021, max_date = 2023)

head(gen)
#>   entity entity_code is_aggregate_entity       date    series
#> 1 Africa        <NA>                TRUE 2021-01-01 Bioenergy
#> 2 Africa        <NA>                TRUE 2021-01-01     Clean
#> 3 Africa        <NA>                TRUE 2021-01-01      Coal
#> 4 Africa        <NA>                TRUE 2021-01-01    Demand
#> 5 Africa        <NA>                TRUE 2021-01-01    Fossil
#> 6 Africa        <NA>                TRUE 2021-01-01       Gas
#>   is_aggregate_series generation_twh share_of_generation_pct
#> 1               FALSE           0.11                    0.16
#> 2                TRUE          16.22                   24.00
#> 3               FALSE          20.04                   29.65
#> 4                TRUE          67.58                  100.00
#> 5                TRUE          51.36                   76.00
#> 6               FALSE          29.30                   43.36
```

Get options for the *entity* parameter:

``` r

options <- emberr::get_ember_options(dataset = "electricity-generation", filter_name = "entity")
#> No encoding supplied: defaulting to UTF-8.

str(options)
#>  chr [1:228] "ASEAN" "Afghanistan" "Africa" "Albania" "Algeria" ...
```

Retrieve data for just one country/region:

``` r

df_usa <- emberr::get_ember_data(entity = "United States")

str(df_usa)
#> 'data.frame':    153 obs. of  8 variables:
#>  $ entity                 : chr  "United States" "United States" "United States" "United States" ...
#>  $ entity_code            : chr  "USA" "USA" "USA" "USA" ...
#>  $ is_aggregate_entity    : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ date                   : chr  "2015" "2015" "2015" "2015" ...
#>  $ series                 : chr  "Bioenergy" "Clean" "Coal" "Demand" ...
#>  $ is_aggregate_series    : logi  FALSE TRUE FALSE TRUE TRUE FALSE ...
#>  $ generation_twh         : num  63.6 1353.7 1352.4 4150.7 2730.3 ...
#>  $ share_of_generation_pct: num  1.56 33.15 33.11 101.63 66.85 ...
```

You can also retrieve data for multiple countries/regions:

``` r

df <- get_ember_data(min_date = 2020, entity = "United States,United Kingdom")
str(df)
#> 'data.frame':    132 obs. of  8 variables:
#>  $ entity                 : chr  "United Kingdom" "United Kingdom" "United Kingdom" "United Kingdom" ...
#>  $ entity_code            : chr  "GBR" "GBR" "GBR" "GBR" ...
#>  $ is_aggregate_entity    : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ date                   : chr  "2020" "2020" "2020" "2020" ...
#>  $ series                 : chr  "Bioenergy" "Clean" "Coal" "Demand" ...
#>  $ is_aggregate_series    : logi  FALSE TRUE FALSE TRUE TRUE FALSE ...
#>  $ generation_twh         : num  39.36 184.78 5.49 330.37 127.24 ...
#>  $ share_of_generation_pct: num  12.61 59.22 1.76 105.88 40.78 ...
```

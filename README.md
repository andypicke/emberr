
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emberr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml)

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

## Installation

You can install the development version of emberr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("andypicke/emberr")
```

You will need to sign up for a free API key.

The package assumes you have stored your API key in your .Renviron file
as *EMBER_API_KEY*

## Example

Get monthly electiricty generation data for 2021-2023:

``` r
library(emberr)

gen <- emberr::get_electricity_generation(temporal_resolution = "monthly", min_date = 2021, max_date = 2023)
#> No encoding supplied: defaulting to UTF-8.

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

Get options for *entity* parameter

``` r

options <- emberr::get_ember_options(dataset = "electricity-generation", filter_name = "entity")
#> No encoding supplied: defaulting to UTF-8.

str(options)
#>  chr [1:228] "ASEAN" "Afghanistan" "Africa" "Albania" "Algeria" ...
```

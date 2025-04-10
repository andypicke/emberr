
<!-- README.md is generated from README.Rmd. Please edit that file -->

# emberr

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![R-CMD-check](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/andypicke/emberr/actions/workflows/R-CMD-check.yaml)
[![Project Status:
WIP](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
<!-- badges: end -->

The goal of {emberr} is to provide functions to query and retrieve data
from the [Ember](https://ember-energy.org/)
[API](https://ember-energy.org/data/api/).

You can view the [API documentation](https://api.ember-energy.org/docs)
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

You will need to sign up for a free API key from Ember.

The package assumes you have stored your API key in your .Renviron file
as *EMBER_API_KEY*. You can also pass in an API key explicitly to each
function.

## Using the package

The main function to retrieve a dataset from the api is
*get_ember_data()*.

There are 4 main datasets available from the API (these correspond to
the *dataset* option in *get_ember_data()*: - electricity-generation -
power-sector-emissions - electricity-demand - carbon-intensity

Each dataset is available in yearly or monthly resolution (the
*temporal_resolution* option in *get_ember_data()*).

Countries/regions are contained in the *entity* variable.

## Example

Get monthly electricity generation data for 2021-2023. By Default this
returns data for all countries/regions (“entities”).

``` r
library(emberr)

gen <- emberr::get_ember_data(dataset = "electricity-generation", 
                              temporal_resolution = "monthly", 
                              min_date = 2021, 
                              max_date = 2023)

head(gen)
#>          entity entity_code is_aggregate_entity       date    series
#> 1 United States         USA               FALSE 2021-01-01 Bioenergy
#> 2 United States         USA               FALSE 2021-01-01     Clean
#> 3 United States         USA               FALSE 2021-01-01      Coal
#> 4 United States         USA               FALSE 2021-01-01    Demand
#> 5 United States         USA               FALSE 2021-01-01    Fossil
#> 6 United States         USA               FALSE 2021-01-01       Gas
#>   is_aggregate_series generation_twh share_of_generation_pct
#> 1               FALSE           4.82                    1.37
#> 2                TRUE         140.61                   40.01
#> 3               FALSE          81.24                   23.12
#> 4                TRUE         355.60                  101.18
#> 5                TRUE         210.85                   59.99
#> 6               FALSE         126.53                   36.00
```

The *series* variable specifies the fuel type:

``` r
unique(gen$series)
#>  [1] "Bioenergy"                            
#>  [2] "Clean"                                
#>  [3] "Coal"                                 
#>  [4] "Demand"                               
#>  [5] "Fossil"                               
#>  [6] "Gas"                                  
#>  [7] "Hydro"                                
#>  [8] "Hydro, bioenergy and other renewables"
#>  [9] "Net imports"                          
#> [10] "Nuclear"                              
#> [11] "Other fossil"                         
#> [12] "Other renewables"                     
#> [13] "Renewables"                           
#> [14] "Solar"                                
#> [15] "Total generation"                     
#> [16] "Wind"                                 
#> [17] "Wind and solar"
```

You can specify a single year instead of a min and max date:

``` r

gen_2023 <- emberr::get_ember_data(dataset = "electricity-generation", 
                              temporal_resolution = "monthly", 
                              year = 2023)

head(gen_2023)
#>   entity entity_code is_aggregate_entity       date    series
#> 1 Sweden         SWE               FALSE 2023-01-01 Bioenergy
#> 2 Sweden         SWE               FALSE 2023-01-01     Clean
#> 3 Sweden         SWE               FALSE 2023-01-01    Demand
#> 4 Sweden         SWE               FALSE 2023-01-01    Fossil
#> 5 Sweden         SWE               FALSE 2023-01-01       Gas
#> 6 Sweden         SWE               FALSE 2023-01-01     Hydro
#>   is_aggregate_series generation_twh share_of_generation_pct
#> 1               FALSE           0.94                    6.12
#> 2                TRUE          15.36                  100.00
#> 3                TRUE          12.77                   83.14
#> 4                TRUE           0.00                    0.00
#> 5               FALSE           0.00                    0.00
#> 6               FALSE           6.10                   39.71
```

The *get_ember_options()* function can be used to return all options for
a variable. For example, get options for the *entity* parameter:

``` r

options <- emberr::get_ember_options(dataset = "electricity-generation", filter_name = "entity")

str(options)
#>  chr [1:228] "ASEAN" "Afghanistan" "Africa" "Albania" "Algeria" ...
```

or the *series* parameter:

``` r

options_series <- emberr::get_ember_options(dataset = "electricity-generation", filter_name = "series")

options_series
#>  [1] "Bioenergy"                            
#>  [2] "Clean"                                
#>  [3] "Coal"                                 
#>  [4] "Demand"                               
#>  [5] "Fossil"                               
#>  [6] "Gas"                                  
#>  [7] "Hydro"                                
#>  [8] "Hydro, bioenergy and other renewables"
#>  [9] "Net imports"                          
#> [10] "Nuclear"                              
#> [11] "Other fossil"                         
#> [12] "Other renewables"                     
#> [13] "Renewables"                           
#> [14] "Solar"                                
#> [15] "Total generation"                     
#> [16] "Wind"                                 
#> [17] "Wind and solar"
```

Retrieve data for just one country/region by specifying an entity:

``` r

df_usa <- emberr::get_ember_data(entity = "United States")

str(df_usa)
#> 'data.frame':    153 obs. of  8 variables:
#>  $ entity                 : chr  "United States" "United States" "United States" "United States" ...
#>  $ entity_code            : chr  "USA" "USA" "USA" "USA" ...
#>  $ is_aggregate_entity    : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ date                   : int  2015 2015 2015 2015 2015 2015 2015 2015 2015 2015 ...
#>  $ series                 : chr  "Bioenergy" "Clean" "Coal" "Demand" ...
#>  $ is_aggregate_series    : logi  FALSE TRUE FALSE TRUE TRUE FALSE ...
#>  $ generation_twh         : num  63.6 1353.7 1352.4 4150.7 2730.3 ...
#>  $ share_of_generation_pct: num  1.56 33.15 33.11 101.63 66.85 ...
```

You can also retrieve data for multiple countries/regions (entities) by
passing a comma-separated list:

``` r

df <- get_ember_data(min_date = 2020, entity = "United States,United Kingdom")
str(df)
#> 'data.frame':    132 obs. of  8 variables:
#>  $ entity                 : chr  "United Kingdom" "United Kingdom" "United Kingdom" "United Kingdom" ...
#>  $ entity_code            : chr  "GBR" "GBR" "GBR" "GBR" ...
#>  $ is_aggregate_entity    : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
#>  $ date                   : int  2020 2020 2020 2020 2020 2020 2020 2020 2020 2020 ...
#>  $ series                 : chr  "Bioenergy" "Clean" "Coal" "Demand" ...
#>  $ is_aggregate_series    : logi  FALSE TRUE FALSE TRUE TRUE FALSE ...
#>  $ generation_twh         : num  39.53 184.8 5.49 333.15 130.1 ...
#>  $ share_of_generation_pct: num  12.55 58.69 1.74 105.8 41.31 ...
```

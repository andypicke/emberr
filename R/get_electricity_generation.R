#' Get Ember electricity-generation data from API
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date default=2015
#' @param max_date default=2023
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns df Dataframe of requested data
#' @export

get_electricity_generation <- function(temporal_resolution = "yearly",
                                       min_date = "2015",
                                       max_date = "2023",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  base_url <- "https://api.ember-climate.org/v1/"

  endpoint <- "electricity-generation/"

  query_url <- paste0(base_url, endpoint, temporal_resolution, "?",
                      "start_date=", min_date, "&end_date=", max_date,
                      "&api_key=", api_key)

  df <- get_api_request(query_url)

  return(df)
}

#' Get Ember electricity-generation data from API
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date default=2015
#' @param max_date default=2023
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")

get_electricity_generation <- function(temporal_resolution = "yearly",
                                       min_date = "2015",
                                       max_date = "2023",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  base_url <- "https://api.ember-climate.org/v1/"

  endpoint <- "electricity-generation/"

  query_url <- paste0(base_url, endpoint, temporal_resolution, "?",
                      "start_date=", min_date, "&end_date=", max_date,
                      "&api_key=", api_key)

  resp <- httr::GET(query_url)

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  resp_parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"))

  df <- resp_parsed$data

  return(df)
}

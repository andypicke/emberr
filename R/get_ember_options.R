#' Get parameter options for Ember API
#' @param endpoint Default="electricity-generation"
#' @param temporal_resolution default ="yearly"
#' @param param Parameter to get options for
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns options List of options for specified parameter
#' @export

get_ember_options <- function(endpoint = "electricity-generation",
                              temporal_resolution = "yearly",
                              param = "entity",
                              api_key = Sys.getenv("EMBER_API_KEY")){

  base_url <- "https://api.ember-climate.org/v1/options/"


  query_url <- paste0(base_url, endpoint, "/", temporal_resolution, "/", param, "?api_key=", api_key)

  resp <- httr::GET(query_url)

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  resp_parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"))

  options <- resp_parsed$options

  return(options)

}

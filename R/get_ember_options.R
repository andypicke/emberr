#' Get API parameter options for Ember dataset
#' @param dataset Default="electricity-generation"
#' @param temporal_resolution default ="yearly"
#' @param filter_name Parameter to get options for (ex: entity, series, date. Default = "entity")
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns options List of options for specified parameter
#' @export

get_ember_options <- function(dataset = c("electricity-generation", "power-sector-emissions", "electricity-demand", "carbon-intensity"),
                              temporal_resolution = c("yearly", "monthly"),
                              filter_name = "entity",
                              api_key = Sys.getenv("EMBER_API_KEY")){

  # check inputs
  dataset <- match.arg(dataset)
  temporal_resolution <- match.arg(temporal_resolution)

  base_url <- "https://api.ember-climate.org/v1/options/"

  query_url <- paste0(base_url, dataset, "/", temporal_resolution, "/", filter_name, "?api_key=", api_key)

  resp <- httr::GET(query_url)

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  resp_parsed <- jsonlite::fromJSON(httr::content(resp, as = "text", encoding = "UTF-8"))

  options <- resp_parsed$options

  return(options)

}

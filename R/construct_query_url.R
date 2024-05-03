#' Construct query URL for Ember data API
#' @param endpoint Default = "electricity-generation"
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date Mininum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns query_url API query URL for specified parameters
#' @export
#'
construct_query_url <- function(endpoint = "electricity-generation",
                                temporal_resolution = "yearly",
                                min_date = "2015",
                                max_date = "2023",
                                entity = "all",
                                api_key = Sys.getenv("EMBER_API_KEY")) {
  base_url <- "https://api.ember-climate.org/v1/"

  if (entity == "all") {
    entity_str <- ""
  } else {
    entity_str <- paste0("entity=", stringr::str_replace_all(entity, " ", "%20"), "&") # '%20' replaces space in URL
  }

  query_url <- paste0(
    base_url, endpoint, "/", temporal_resolution, "?",
    entity_str,
    "start_date=", min_date, "&end_date=", max_date,
    "&api_key=", api_key
  )

  return(query_url)
}

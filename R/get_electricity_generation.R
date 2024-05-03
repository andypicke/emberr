#' Get Ember electricity-generation data from API
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date Mininum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns df Dataframe of requested data
#' @export

get_electricity_generation <- function(temporal_resolution = "yearly",
                                       min_date = "2015",
                                       max_date = "2023",
                                       entity = "all",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  base_url <- "https://api.ember-climate.org/v1/"

  endpoint <- "electricity-generation/"

  if (entity == "all") {
    entity_str <- ""
  } else {
    entity_str <- paste0("entity=", stringr::str_replace(entity, " ", "%20"), "&") # '%20' replaces space in URL
  }

  query_url <- paste0(base_url, endpoint, temporal_resolution, "?",
                      entity_str,
                      "start_date=", min_date, "&end_date=", max_date,
                      entity_str,
                      "&api_key=", api_key)

  df <- get_api_request(query_url)

  return(df)
}

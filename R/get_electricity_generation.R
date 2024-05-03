#' Get Ember electricity-generation data from API
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date Mininum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns df Dataframe of requested data
#' @export
#' @seealso [get_ember_options()]

get_electricity_generation <- function(temporal_resolution = "yearly",
                                       min_date = "2015",
                                       max_date = "2023",
                                       entity = "all",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  query_url <- construct_query_url(endpoint = "electricity-generation", temporal_resolution, min_date, max_date, entity, api_key)

  df <- get_api_request(query_url)

  return(df)
}

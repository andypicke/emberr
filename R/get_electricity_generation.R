#' Get Ember electricity-generation data from API
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param year (optional) If specified, retrieve data for a single year
#' @param min_date Mininum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns df Dataframe of requested data
#' @export
#' @seealso [get_ember_options()]

get_electricity_generation <- function(temporal_resolution = c("yearly", "monthly"),
                                       year = NA,
                                       min_date = "2015",
                                       max_date = "2023",
                                       entity = "all",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  # check input
  temporal_resolution <- match.arg(temporal_resolution)

  df <- get_ember_data(dataset = "electricity-generation", temporal_resolution, year, min_date, max_date, entity, api_key)

  return(df)
}

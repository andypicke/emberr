#' Get Ember-climate data from API
#' @param dataset Dataset to retrieve. Default = "electricity-generation". Other options are "power-sector-emissions", "electricity-demand", and "carbon-intensity"
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param min_date Minimum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns df Dataframe of requested data
#' @export
#' @seealso [get_ember_options()]

get_ember_data <- function(dataset = c("electricity-generation", "power-sector-emissions", "electricity-demand", "carbon-intensity"),
                                       temporal_resolution = c("yearly", "monthly"),
                                       min_date = "2015",
                                       max_date = "2023",
                                       entity = "all",
                                       api_key = Sys.getenv("EMBER_API_KEY")) {

  # check inputs
  dataset <- match.arg(dataset)
  temporal_resolution <- match.arg(temporal_resolution)

  query_url <- construct_query_url(endpoint = dataset,
                                   temporal_resolution = temporal_resolution,
                                   min_date = min_date,
                                   max_date = max_date,
                                   entity = entity,
                                   api_key = api_key)

  df <- get_api_request(query_url)

  return(df)
}

#' Construct query URL for Ember data API
#' @param endpoint Default = "electricity-generation"
#' @param temporal_resolution "yearly" (default) or "monthly"
#' @param year (optional) If specified, retrieve data for a single year
#' @param min_date Mininum date to retrieve data for. YYYY or YYYY-MM format. Default=2015
#' @param max_date Maximum date to retrieve data for. YYYY or YYYY-MM format. Default=2023
#' @param entity List of comma-separated country(s) or region(s) to return data for. Default is all (no filter)
#' @param api_key Default is Sys.getenv("EMBER_API_KEY")
#' @returns query_url API query URL for specified parameters
#' @export
#'
construct_query_url <- function(endpoint = c("electricity-generation", "power-sector-emissions", "electricity-demand", "carbon-intensity"),
                                temporal_resolution = c("yearly", "monthly"),
                                year = NA,
                                min_date = "2015",
                                max_date = "2023",
                                entity = "all",
                                api_key = Sys.getenv("EMBER_API_KEY")) {
  base_url <- "https://api.ember-energy.org/v1/"

  # check inputs
  endpoint <- match.arg(endpoint)
  temporal_resolution <- match.arg(temporal_resolution)

  # if year supplied, use that
  if (!is.na(year)) {
    if (temporal_resolution == "yearly") {
      min_date <- year
      max_date <- year
    } else {
      min_date <- year
      max_date <- year + 1
    }
  }

  if (entity == "all") {
    entity_str <- ""
  } else {
    entity <- stringr::str_replace_all(entity, " ,", ",") # remove spaces before/after commas in entity list
    entity <- stringr::str_replace_all(entity, ", ", ",")
    entity_str <- paste0("entity=", stringr::str_replace_all(entity, " ", "%20"), "&") # '%20' replaces space in URL
  }

  # build entire query url
  query_url <- paste0(
    base_url, endpoint, "/", temporal_resolution, "?",
    entity_str,
    "start_date=", min_date, "&end_date=", max_date,
    "&api_key=", api_key
  )

  return(query_url)
}

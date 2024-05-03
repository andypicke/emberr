#' Make API GET request and return data
#' @param query_url URL for the API query
#' @returns data from the API response
#' @export

get_api_request <- function(query_url){

  # send GET request
  resp <- httr::GET(query_url)

  # check if successful response code returned
  if (resp$status_code != 200) {
    stop(paste("API returned not 200 status code: ", resp$status_code))
  }

  #parse response
  resp_parsed <- jsonlite::fromJSON(httr::content(resp, as = "text"))

  # return the data
  df <- resp_parsed$data
}

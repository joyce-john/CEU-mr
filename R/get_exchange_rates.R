#' Look up the historical exchange rate between a base and target currency. Defaults to USD - HUF.
#' @param start_date date
#' @param end_date date
#' @param base_currency currency symbol
#' @param target_currency currency symbol
#' @param retried number of times the function has been retried
#' @return \code{data.table} object
#' @export
#' @importFrom logger log_error log_info
#' @importFrom checkmate assert_numeric
#' @importFrom data.table data.table
#' @importFrom httr GET content
#' @examples
#' get_exchange_rates()
#' get_usdhufs("USD", "EUR", start_date = "2021-04-18", end_date = "2021-05-18")
get_exchange_rates <- function(base_currency = "USD", target_currency = "HUF", start_date = Sys.Date() - 30, end_date = Sys.Date(), retried = 0) {
  tryCatch({
    response <- GET(
      'https://api.exchangerate.host/timeseries',
      query = list(
        start_date = start_date,
        end_date = end_date,
        base = base_currency,
        symbols = target_currency
      )
    )
    exchange_rates <- content(response)$rates
    historical_rates <- data.table(
      date = as.Date(names(exchange_rates)),
      rate = as.numeric(unlist(exchange_rates)))
    assert_numeric(historical_rates$rate)
  }, error = function(e) {
    ## str(e)
    log_error(e$message)
    Sys.sleep(1 + retried ^ 2)
    get_exchange_rates(start_date = Sys.Date() - 30, end_date = Sys.Date(), base_currency = "USD", target_currency = "HUF", retried = retried + 1)
  })
  log_info("Historical rate query: price of 1 {base_currency} in {target_currency}")
  historical_rates
}

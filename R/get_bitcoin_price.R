#' Gets the price of BTC in USD
#' @return number
#' @export
#' @import data.table
#' @importFrom binancer binance_coins_prices
#' @importFrom scales dollar
#' @importFrom logger log_info
#' @examples
#' get_bitcoin_price()
get_bitcoin_price <- function() {

  btcusd <- binance_coins_prices()[symbol == 'BTC', usd]

  log_info("1 BTC = {dollar(btcusd)}")

  return(btcusd)

}

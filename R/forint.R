#' Formats numbers as Hungarian Forint
#' @param x number of forint
#' @return formatted string
#' @export
#' @importFrom checkmate assert_number
#' @importFrom scales dollar
#' @examples
#' forint(42)
#' forint(100246.73)
forint <- function(x) {
  assert_number(x)
  dollar(x, prefix = "", suffix = " Ft")
}

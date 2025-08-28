#' Finding moving average over defined week interval
#'
#' @param focal_date the date your interval is centered around
#' @param dates a vector of dates that the function will create an interval from
#' @param value a vector of values you wish to take the moving average of
#' @param interval_wks size of the interval you wish to average across, in weeks
#'
#' @returns moving average(s) based on the arguments provided
#' @export
#'
#' @examples 
moving_average <- function(focal_date, dates, value, interval_wks) {
  # calculating interval window within your dates vector
  is_in_window <- (dates > focal_date - (interval_wks / 2) * 7) &
    (dates < focal_date + (interval_wks / 2) * 7)
  
  # subsetting the values that correspond with your interval window
   window_value <- value[is_in_window]
   
  # prints result
  result <- mean(window_value, na.rm = TRUE)
  return(result)
}
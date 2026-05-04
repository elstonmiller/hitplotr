#' Plotting function for dashboard
#'
#' @param df dataframe containing long form game by game data from the `long_form` function.
#'
#' @return time series plot with rolling values colored by stat.
#'
#' @export
plot_single <- function(df) {
ggplot2::ggplot(df, ggplot2::aes(x = date, y = value, color = stat))+
    ggplot2::geom_line(linewidth = 1)+
    ggplot2::labs(
      title = "Rolling Statistical Progression",
      x = "Date",
      y = "Value",
      color = "Stat"
    )+
    ggplot2::theme_bw()
}

#' Pulling together functions to put the plotting workflow in one function
#'
#' @param df dataframe containing wide form game by game data, similar structure to [playerSample].
#'
#' @return time series plot with rolling values colored by stat.
#'
#' @export
rolling_plot <- function(df){
  df <- standardize_names(df)
  df <- rolling_stats(df)
  df <- long_form(df)

  return(df)
}


#' Calculate rolling stats
#'
#' @param df dataframe containing game by game stats, cleaned by the `standardize_names()` function.
#'
#' @return new dataframe containing rolling stats for each game since the beginning of data.
#'
#' @examples
#' rolling_stats(playerSample)
#'
#' @export
#'
rolling_stats <- function (df){
  # ensure chronological order
  df <- df[order(df$date),]
  # gather rolling stats
  #ba
  ba <- round(cumsum(df$h) / cumsum(df$ab), 3)
  #obp
  obp <- round((cumsum(df$h) + cumsum(df$bb) + cumsum(df$hbp)) / (cumsum(df$ab) + cumsum(df$bb) + cumsum(df$hbp) + cumsum(df$sac)), 3)
  #slg
  singles <- cumsum(df$h) - cumsum(df$x2b) - cumsum(df$x3b) - cumsum(df$hr)
  total_bases <- singles + (2 * cumsum(df$x2b)) + (3 * cumsum(df$x3b)) + (4 * cumsum(df$hr))
  slg <- round(total_bases / cumsum(df$ab), 3)
  #ops
  ops <- obp + slg
  #bb%
  bb_pct <- round(cumsum(df$bb) / cumsum(df$pa), 3)
  #k%
  k_pct <- round(cumsum(df$k) / cumsum(df$pa), 3)

  #combine to df
  df <- data.frame(
    date = df$date,
    ba,
    obp,
    slg,
    ops,
    bb_pct,
    k_pct)

  return(df)
}

#' Convert rolling stats to long format for shiny plotting
#'
#' @param df dataframe built by function `rolling_stats()`containing game by game rolling season stats.
#'
#' @return dataframe containing data transformed into long format
#'
#' @export
long_form <- function (df) {
  df <- tidyr::pivot_longer(
    df,
    cols = c(ba, obp, slg,ops,bb_pct,k_pct),
    names_to = "stat",
    values_to = "value"
  )
  df <- dplyr::mutate(
    df,
    stat = dplyr::recode(
      stat,
      ba = "Batting Average",
      obp = "On Base Percentage",
      slg = "Slugging Percentage",
      ops = "OPS",
      bb_pct = "Walk Rate",
      k_pct = "Strikeout Rate"
      )
  )
return(df)
}


#' Calculate Season Totals
#'
#' @param df dataframe of game by game statistics.
#'
#' @return Dataframe with aggregated statistics
#'
#' @export

season_totals <- function(df) {
  totals <- data.frame(
    games = nrow(df),
    pa = sum(df$pa),
    ab    = sum(df$ab),
    r     = sum(df$r),
    h     = sum(df$h),
    rbi   = sum(df$rbi),
    x2b   = sum(df$x2b),
    x3b   = sum(df$x3b),
    hr    = sum(df$hr),
    sac   = sum(df$sac),
    bb    = sum(df$bb),
    k     = sum(df$k),
    hbp   = sum(df$hbp),
    roe   = sum(df$roe),
    fc    = sum(df$fc),
    sb    = sum(df$sb),
    cs    = sum(df$cs)
  )
  return(totals)
}

#' Batting Average
#'
#' @param df dataframe containing "h" & "ab"
#'
#' @return new column containing batting average.
#'
#' @examples
#' avg(playerSample)
#'
#' @export

avg <- function(df) {
  df$ba <- round(df$h / df$ab, 3)
  return(df)
}

#' On base percentage
#'
#' @param df dataframe containing season totals for "h", "bb", "hbp","ab" & "sac"
#'
#' @return new column containing batting average.
#'
#' @examples
#' obp(playerSample)
#'
#' @export

obp <- function(df) {
  df$obp <- round((df$h + df$bb + df$hbp) / (df$ab + df$bb + df$hbp + df$sac), 3)
  return(df)
  }

#' Slugging
#'
#' @param df dataframe containing season totals "h", "x2b", "x3b","hr" & "ab"
#'
#' @return new column containing "slg".
#'
#' @examples
#' slg(playerSample)
#'
#' @export

slg <- function(df) {
  singles <- df$h - df$x2b - df$x3b - df$hr
  total_bases <- singles + (2 * df$x2b) + (3 * df$x3b) + (4 * df$hr)
  df$slg <- round(total_bases / df$ab, 3)
  return(df)
}


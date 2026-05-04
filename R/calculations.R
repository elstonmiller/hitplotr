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

#' OPS
#'
#' @param df dataframe containing season totals "obp" & "slg"
#'
#' @return new column containing "ops".
#'
#' @examples
#' df <- playerSample
#' df <- obp(df)
#' df <- slg(df)
#' ops(df)
#'
#' @export

ops <- function(df) {
  df$ops <- round(df$obp + df$slg, 3)
  return(df)
}

#' Stolen Base %
#'
#' @param df dataframe containing season totals "sb" & "cs"
#'
#' @return new column containing "sbp".
#'
#' @examples
#' sb_pct(playerSample)
#'
#' @export

sb_pct <- function(df) {
  df$sb_pct <- round(df$sb / (df$sb + df$cs), 3)
  return(df)
}

#' Walk Rate (BB%)
#'
#' @param df dataframe containing season totals "pa" & "bb"
#'
#' @return new column containing "bb_pct".
#'
#' @examples
#' bb_pct(playerSample)
#'
#' @export

bb_pct <- function(df) {
  df$bb_pct <- round(df$bb / df$pa, 3)
  return(df)
}

#' Strikeout Rate (K%)
#'
#' @param df dataframe containing season totals "k" & "bb"
#'
#' @return new column containing "k_pct".
#'
#' @examples
#' k_pct(playerSample)
#'
#' @export

k_pct <- function(df) {
  df$k_pct <- round(df$k / df$pa, 3)
  return(df)
}

#' Season Totals
#'
#' @param df dataframe containing game by game stats.
#'
#' @return new dataframe containing a season summary.
#'
#' @examples
#' season_summary(playerSample)
#'
#' @export

season_summary <- function(df) {
  # calculate season totals
  df <- season_totals(df)
  # create summary stats
  df <- avg(df)
  df <- obp(df)
  df <- slg(df)
  df <- ops(df)
  df <- bb_pct(df)
  df <- k_pct(df)
  df <- sb_pct(df)
  # isolate desired columns
  df <- df[, c("games","pa","ab","h","ba","obp","slg","ops","rbi","r","hr","bb_pct","k_pct","sb","sb_pct")]
  cnames <- c("Games Played", "Plate Appearences", "At-Bats", "Hits", "AVG", "OBP", "SLG", "OPS", "RBI", "Runs", "Homeruns", "Walk Rate", "K Rate", "Stolen Bases", "Stolen Base Rate")
  colnames(df) <- cnames
  return(df)
}

#' Table workflow
#'
#' @param df dataframe containing game by game stats ideally identical in form to [playerSample].
#'
#' @return dataframe containing a season summary.
#'
#' @examples
#' makeTable(playerSample)
#'
#' @export
makeTable <- function(df) {
  df <- standardize_names(df)
  df <- season_summary(df)
  return(df)
}


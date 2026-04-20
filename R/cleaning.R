#' Adjust Common Baseball Terminology to Integrate into Functions
#'
#' @param df data.frame containing all the required columns [playerSample]
#'
#' @return data.frame with standardized column names
#' @export
#'

standardize_names <- function(df) {
  names(df) <- tolower(names(df))
  names(df) <- gsub(" ", "", names(df))
  names(df) <- gsub("_", "", names(df))

  replacements <-
    c(
    "hits" = "h",
    "atbats" = "ab",
    "runs" = "r",
    "runsbattedin" = "rbi",
    "doubles" = "x2b",
    "2b" = "x2b",
    "double" = "x2b",
    "triples" = "x3b",
    "3b" = "x3b",
    "triple" = "x3b",
    "homerun" = "hr",
    "homeruns" = "hr",
    "sacrifice" = "sac",
    "walks" = "bb",
    "walk" = "bb",
    "strikeout" = "k",
    "strikeouts" = "k",
    "so" = "k",
    "hitbypitch" = "hbp",
    "hitbypitches" = "hbp",
    "reachedonerror" = "roe",
    "fielderschoice" = "fc",
    "fielder'schoice" = "fc",
    "stolenbases" = "sb",
    "stolenbase" = "sb",
    "caughtstealing" = "cs"
    )

  names(df) <- dplyr::recode(names(df), !!!replacements)

  return(df)
}

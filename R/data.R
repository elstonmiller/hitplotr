#' Sample Player data
#'
#'Sample data to demonstrate the correct columns and data types for player data.
#'
#' @format dataframe with one row per game
#' * `date` - Date data type including year to ensure accurate calculations. Date of each game.
#' * `pa` - Plate appearances
#' * `ab` - At bats
#' * `r` - Runs
#' * `h` - Hits
#' * `rbi` - Runs batted in
#' * `x2b` - Doubles
#' * `x3b` - Triples
#' * `hr` - Home runs
#' * `sac` - Sacrifice bunts/flies
#' * `bb` - Walks
#' * `k` - Strikeouts
#' * `hbp` - Hit by pitch
#' * `roe` - Reached on error
#' * `fc` - Fielder's choice
#' * `sb` - Stolen bases
#' * `cs` - Caught stealing
#'
#' @examples
#' data("playerSample", package = "hitplotr")
#' head(playerSample)
#'
#'@source Sample dataset for simulation
"playerSample"

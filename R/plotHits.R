#' Main Plotting Function
#'
#' @param df dataframe containing game by game player data in the same format as [playerSample]
#'
#' @return a shiny app with summarized statistics organized in a table and an interactive cumulative plot.
#'
#' @examples
#' \dontrun{
#' plotHits(playerSample)}
#'
#' @export
plotHits <- function(df) {
  # Define UI for application that draws a histogram
  ui <- shiny::fluidPage(

      # Application title
      shiny::titlePanel("Season Summary"),

      # Table
      shiny::tableOutput("table"),
      shiny::br(),

      # Plot
      shiny::plotOutput("plot"),
      shiny::br(),

      # Plot Controls
      shiny::checkboxGroupInput(
        "stat",
        "Select stats to display",
        choices = c("Batting Average",
                    "On Base Percentage",
                    "Slugging Percentage",
                    "OPS",
                    "Walk Rate",
                    "Strikeout Rate"),
        selected = "Batting Average"
     )
  )

  server <- function(input, output, session) {

    # Create Table
    Table_data <- df

    output$table <- shiny::renderTable({
      makeTable(Table_data)
    })

    # Create Plot
    output$plot <- shiny::renderPlot({
      Plot_data <- rolling_plot(df)
      Plot_data <- dplyr::filter(Plot_data, stat %in% input$stat)
      plot_single(Plot_data)
    })
  }

  # Run the application
  shiny::shinyApp(ui = ui, server = server)
}
plotHits(playerSample)

# Important notes:
# * File organization doesn't matter, define your function in any place in "R/"
# * ui is a function!
# * shiny functions are assumed to be named after a pattern, by default we look for all
#  functions names containing "_ui", "_server", "Ui", "Server", "UI" and "server".
#  The diagram will include those functions and functions which call them

# app --------------------------------------------------------------------------

#' @export
histogramApp <- function() {
  shinyApp(ui, server)
}

# main ui function -------------------------------------------------------------

ui <- function() {
  fluidPage(
    histogramUI("hist1")
  )
}

# main server function ---------------------------------------------------------

server <- function(input, output, session) {
  histogramServer("hist1")
}

# module -----------------------------------------------------------------------

histogramUI <- function(id) {
  tagList(
    selectInput(NS(id, "var"), "Variable", choices = names(mtcars)),
    numericInput(NS(id, "bins"), "bins", value = 10, min = 1),
    plotOutput(NS(id, "hist"))
  )
}

histogramServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    data <- reactive(mtcars[[input$var]])
    output$hist <- renderPlot({
      hist(data(), breaks = input$bins, main = input$var)
    }, res = 96)
  })
}

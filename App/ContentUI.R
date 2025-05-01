ContentUI <- function (id) {
  ns <- NS(id)
  
  div(fluidRow(column(6, h3("Title"), style = 'margin-left:15px')),
      tags$br(),
      fluidRow(column (6, box(width = 12,
                               sliderInput(inputId = ns("num"),
                                           label = "Choose a number",
                                           value = 25, min = 1, max = 100),
                               textInput(inputId = ns("title"),
                                         label = "Write a title",
                                         value = "Histogram of Random Normal Values"),
                               actionButton(inputId = ns("click"), label = "Update Plot")))
               ),
      fluidRow(box(width = 12, plotOutput(ns("hist")))))
}
HomeUI <- function (id) {
  ns <- NS(id)
  div(fluidRow(column(8, offset = 2,
                  h1("Welcome!", style = "font-size:100px; color: #222d32"),
                  align = "center",
                  style = 'padding-top:25px')
               ),
      fluidRow(column(4, offset = 4,
                      actionBttn(ns("enter"),
                                 "Enter",
                                 icon = icon("arrow-right"),
                                 color = "primary",
                                 style = "stretch",
                                 # style = 'width: 100%;',
                                 size = "lg"),
                      align = "center"
                      )
               ),
      )
}
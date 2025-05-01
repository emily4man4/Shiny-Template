DebugUI <- function (id) {
  ns <- NS(id)
  
  div(fluidRow(column(10, 
                      textInput(ns("text_in"), 
                                label = "Debug...", 
                                width = '100%')),
               column(2, 
                      actionButton(ns("debug_help"), 
                                   label = "?", 
                                   style = 'margin-top:25px'),
                      bsTooltip(ns("debug_help"), 
                                title = "Type in reactive code here to see result. For example, if values$data is a reactive data frame used to create a reactive data table within the app, then type values$data to view the data frame. Pressing the Run button will refresh the results and reflect any updates that have been made since the previous run.", 
                                placement = "right", 
                                trigger = "hover", 
                                options = NULL))),
      fluidRow(column(4,
                      actionButton(ns("debug_button"), 
                                   label = "Run")
      )),
      fluidRow(column(12, 
                      verbatimTextOutput(ns("text_out"))))
  )
}
DebugServer <- function (input, output, session) {
  data <- eventReactive(input$debug_button, {
    eval(parse(text = input$text_in))
  })
  output$text_out <- renderPrint({
    print(data())
  })
}
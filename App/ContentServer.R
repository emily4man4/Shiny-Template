ContentServer <- function (input, output, session) {
    title <- eventReactive(input$click, {
      input$title
    })
    output$hist <- renderPlot({
      hist(rnorm(input$num), main = title())
    })
}
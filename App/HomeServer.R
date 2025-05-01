HomeServer <- function (input, output, session, parent) {
  observeEvent(input$enter, {
    updateTabItems(session = parent, "tabs", "content")
  })
}
library(shiny)
library(shinydashboard)
library(rhandsontable)
library(shinyBS)
library(shinybusy)
library(shinyWidgets)

source("HomeServer.R")
source("HomeUI.R")
source("ContentServer.R")
source("ContentUI.R")
source("AboutServer.R")
source("AboutUI.R")
source("DebugServer.R")
source("DebugUI.R")

ui <- dashboardPage(
  dashboardHeader(title = "App Name",
                  tags$li(a(href='https://phastar.com/',
                            img(src='PHLogo.png', title = "Company Home", height='20', width='100')),
                          class = "dropdown")
  ),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Home", tabName = "home", icon = icon("home")),
      menuItem("Content", tabName = "content", icon = icon("table")),
      menuItem("About", tabName = "about", icon = icon("info")),
      menuItem("Debug", tabName = "debug")
    )
  ),
  dashboardBody(
    
    ## Uncomment the following code to add a popup whenever you try to close the app browser window to 
    ## confirm you actually want to leave
    
    # Navigation prompt
    # tags$head(tags$script(HTML("
    #     // Enable navigation prompt
    #     window.onbeforeunload = function() {
    #         return 'Are you sure you want to exit? Any unsaved changes will be lost.';
    #     };
    # "))),
    
    ## busy_start_up adds a GIF that displays for the given amount of time in timeout when you launch the app
    ## save any gif in the www folder and use it as the source (src) to use the GIF when launching the app
    ## Comment out this section of code to remove the GIF loading screen upon launch
    busy_start_up(
      loader = tags$img(
        src = "loading.gif",
      ),
      timeout = 1500,
    ),
    
    tabItems(
      tabItem(tabName = "home", HomeUI("home")),
      tabItem(tabName = "content", ContentUI("content")),
      tabItem(tabName = "about", AboutUI("about")),
      tabItem(tabName = "debug", DebugUI("debug"))
      )
  )
)

server <- function(session, input, output) {
  callModule(HomeServer, id = "home", parent = session)
  callModule(ContentServer, id = "content")
  callModule(AboutServer, id = "about")
  callModule(DebugServer, id = "debug")
}

shinyApp(ui, server)

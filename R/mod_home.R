#' home UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_home_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::box(width = 12,
        title = "Abstract",
        "abstract"
      ),
      shinydashboard::box(width = 12,
        title = "Usage",
        "usage"
      ),
      shinydashboard::box(width = 12,
        title = "Funding",
        "funding"
      )
    )
  )
}
    
#' home Server Functions
#'
#' @noRd 
mod_home_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_home_ui("home_1")
    
## To be copied in the server
# mod_home_server("home_1")

#' epimut_viz UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_epimut_viz_ui <- function(id){
  ns <- NS(id)
  tagList(
    uiOutput(ns("selector_epimutations")),
    shinyWidgets::materialSwitch(
      inputId = ns("annotation_genes"), 
      label = "Genes annotation",
      status = "primary"
    ),
    shinyWidgets::materialSwitch(
      inputId = ns("regulation"), 
      label = "Chromatin marks: H3K4me3, H3K27me3 and H3K27ac",
      status = "primary"
    ),
    shinycssloaders::withSpinner(plotOutput(ns("epi_plot")))
  )
}
    
#' epimut_viz Server Functions
#'
#' @noRd 
mod_epimut_viz_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$selector_epimutations <- renderUI({
      selectInput(
        inputId = ns("selected_epimutation"), 
        label = "Epimutation to visualize", 
        choices = results$results$epi_id
      )
    })
    
    output$epi_plot <- renderPlot({
      plot <- plot_epimutations(as.data.frame(results$results[results$results$epi_id == input$selected_epimutation,]), 
                                loaded_dataset$data,
                                genes_annot = input$annotation_genes,
                                regulation = input$regulation)
      plot
    })
  })
}
    
## To be copied in the UI
# mod_epimut_viz_ui("epimut_viz_1")
    
## To be copied in the server
# mod_epimut_viz_server("epimut_viz_1")

#' data_selection UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_data_selection_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::box(
        title = "Available datasets",
        HTML("<ul><li>
             4 case samples IDAT files (<a href='https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE131350'>GEO: GSE131350</a>) + 
             <code>reference_panel</code>: a <code>RGChannelSet</code> class object containing 22 healthy individuals 
             (<a href='https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE12782'>GEO: GSE127824</a>). This dataset is to test 
             the pre-process functionality.
             </li>
             <li>
             <code>reference_panel</code>: a <code>GenomicRatioSet</code> class object containing 22 healthy individuals 
             (<a href='https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE12782'>GEO: GSE127824</a>). This dataset is to test 
             the one leave out epimutations functionality.
             </li>
             <li>
             <code>methy</code>: a <code>GenomicRatioSet</code> object which includes 49 controls (
             <a href='https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104812'>GEO: GSE104812</a>) and 3 cases (
             <a href='https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi'>GEO: GSE97362</a>).
             </li>
             </ul>")
      ),
      shinydashboard::box(
        title = "Select dataset",
        shiny::selectInput(
          inputId = ns("dataset_selector"),
          label = "Datasets",
          choices = c("IDAT files", "Reference panel", "Methy")
        ),
        shiny::actionButton(
          inputId = ns("dataset_selector_trigger"),
          label = "Load dataset"
        )
      )
    )
  )
}
    
#' data_selection Server Functions
#'
#' @noRd 
mod_data_selection_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$dataset_selector_trigger, {
      withProgress(message = 'Loading dataset...', value = 0.5, {
        # Load ExperimentHub
        tempdir <- tempdir()
        eh <- ExperimentHub::ExperimentHub(cache = tempdir)
        
        # Get selected data
        if(input$dataset_selector == "IDAT files"){
          loaded_dataset$baseDir <- system.file("extdata", package = "epimutacionsData")
          # loaded_dataset$targets <- minfi::read.metharray.sheet(loaded_dataset$baseDir)
          loaded_dataset$reference_panel <- eh[["EH6691"]]
          loaded_dataset$pattern <- "SampleSheet.csv"
          shinyjs::js$enableTab("Preprocessing")
        } else if (input$dataset_selector == "Reference panel") {
          library(epimutacions)
          data(GRset)
          loaded_dataset$data <- GRset
          shinyjs::js$enableTab("epi_panel")
        } else if (input$dataset_selector == "Methy") {
          loaded_dataset$data <- eh[["EH6690"]]
          shinyjs::js$enableTab("epi_panel")
        }
      })
      shinyjs::js$enableTabItem("epimutations")
    })
  })
}
    
## To be copied in the UI
# mod_data_selection_ui("data_selection_1")
    
## To be copied in the server
# mod_data_selection_server("data_selection_1")

#' pre_process UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_pre_process_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::box(
        title = "Definition of method",
        selectInput(
          inputId = ns("preprocess_method"), 
          label = "Method of preprocess", 
          choices = c("raw", "illumina", "swan", "quantile", "noob", "funnorm")
        )
      ),
      shinydashboard::box(
        title = "Parameters of method",
        uiOutput(ns("preprocess_parameters_ui"))
      ),
      actionButton(
        inputId = ns("trigger_preprocess"), 
        label = "Preprocess data"
      )
    )
  )
}

#' pre_process Server Functions
#'
#' @noRd 
mod_pre_process_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$preprocess_parameters_ui <- renderUI({
      if(input$preprocess_method %in% c("illumina")){
        tagList(
          selectInput(
            inputId = ns("illumina.bg.correct"), 
            label = "Background correction", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("illumina.normalize"), 
            label = "Controls normalization", 
            choices = c("controls", "no")
          ),
          numericInput(
            inputId = ns("illumina.reference"), 
            label = "Reference array for control normalization", 
            value = 1
          )
        )
      } else if (input$preprocess_method %in% c("raw", "swan")) {
        "No parameters for selected method"
      } else if (input$preprocess_method %in% c("quantile")) {
        tagList(
          selectInput(
            inputId = ns("quantile.fixOutliers"), 
            label = "Low outlier Meth and Unmeth signals will be fixed", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("quantile.removeBadSamples"), 
            label = "Remove bad samples", 
            choices = c("TRUE", "FALSE")
          ),
          numericInput(
            inputId = ns("quantile.badSampleCutoff"), 
            label = "The cutoff to label samples as ‘bad’", 
            value = 10.5
          ),
          selectInput(
            inputId = ns("quantile.quantileNormalize"), 
            label = "Performs quantile normalization", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("quantile.stratified"), 
            label = "Performs quantile normalization within region strata", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("quantile.mergeManifest"), 
            label = "Merged to the output the information in the associated manifest package", 
            choices = c("TRUE", "FALSE")
          )
        )
      } else if (input$preprocess_method %in% c("noob")) {
        tagList(
          numericInput(
            inputId = ns("noob.offset"), 
            label = "Offset for the normexp background correct", 
            value = 15
          ),
          selectInput(
            inputId = ns("noob.dyeCorr"), 
            label = "Performs dye normalization", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("noob.dyeMethod"), 
            label = "Dye bias correction to be done", 
            choices = c("single", "reference")
          )
        )
      } else if (input$preprocess_method %in% c("funnorm")) {
        tagList(
          numericInput(
            inputId = ns("funnorm.nPCs"), 
            label = "The number of principal components from the control probes", 
            value = 2
          ),
          selectInput(
            inputId = ns("funnorm.bgCorr"), 
            label = "Performs NOOB background correction before functional normalization", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("funnorm.dyeCorr"), 
            label = "Performs dye normalization", 
            choices = c("TRUE", "FALSE")
          ),
          selectInput(
            inputId = ns("funnorm.keepCN"), 
            label = "Keeps copy number estimates", 
            choices = c("TRUE", "FALSE")
          )
        )
      }
    })
    
    observeEvent(input$trigger_preprocess, {
      parameters <- loaded_dataset$data <- epimutacions::norm_parameters(
        illumina = list(
          "bg.correct" = FALSE,
          "normalize" = "controls",
          "reference" = 1
        ),
        quantile = list(
          "fixOutliers" = TRUE,
          "removeBadSamples" = FALSE,
          "badSampleCutoff" = 10.5,
          "quantileNormalize" = TRUE,
          "stratified" = TRUE,
          "mergeManifest" = FALSE
        ),
        noob = list(
          "offset" = 15,
          "dyeCorr" = TRUE,
          "dyeMethod" = "single"
        ),
        funnorm = list(
          "nPCs" = 2,
          "bgCorr" = TRUE,
          "dyeCorr" = TRUE,
          "keepCN" = FALSE
        )
      )
      
      withProgress(message = 'Preprocessing...', value = 0.5, {
        loaded_dataset$data <- epimutacions::epi_preprocess(
          loaded_dataset$baseDir, 
          loaded_dataset$reference_panel, 
          pattern = loaded_dataset$pattern)
      })
      shinyjs::js$enableTab("Epimutations")
    })
  })
}

## To be copied in the UI
# mod_pre_process_ui("pre_process_1")

## To be copied in the server
# mod_pre_process_server("pre_process_1")

#' epimut UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_epimut_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(
      shinydashboard::box(
        title = "Definition of method",
        shinyWidgets::materialSwitch(
          inputId = ns("one_leave_out"), 
          label = "One leave out",
          status = "primary"
        ),
        uiOutput(ns("control_variable_selector")),
        uiOutput(ns("control_variable_case_encoding")),
        uiOutput(ns("control_variable_control_encoding")),
        selectInput(
          inputId = ns("epimut_method"), 
          label = "Epimutation identification method",
          choices = c("manova", "mlm", "iForest", "mahdist", "quantile", "beta")
        )
      ),
      shinydashboard::box(
        title = "Parameters of method",
        uiOutput(ns("epi_parameters_ui")),
        actionButton(
          inputId = ns("trigger_epimutations"), 
          label = "Discover epimutations"
        )
      ),
      DT::DTOutput(ns("epi_results_table"))
    )
  )
}

#' epimut Server Functions
#'
#' @noRd 
mod_epimut_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(input$one_leave_out, {
      if(input$one_leave_out){
        shinyjs::disable("control_variable_selector_value")
        shinyjs::disable("case_encoding_value")
        shinyjs::disable("control_encoding_value")
      } else {
        shinyjs::enable("control_variable_selector_value")
        shinyjs::enable("case_encoding_value")
        shinyjs::enable("control_encoding_value")
      }
    })
    
    output$control_variable_selector <- renderUI({
      selectInput(
        inputId = ns("control_variable_selector_value"),
        label = "Select the case/control variable",
        choices = colnames(SummarizedExperiment::colData(loaded_dataset$data)),
      )
    })
    
    output$control_variable_case_encoding <- renderUI({
      selectInput(
        inputId = ns("case_encoding_value"),
        label = "Select the case encoding",
        choices = unique(loaded_dataset$data[[input$control_variable_selector_value]])
      )
    })
    
    output$control_variable_control_encoding <- renderUI({
      selectInput(
        inputId = ns("control_encoding_value"),
        label = "Select the control encoding",
        choices = unique(loaded_dataset$data[[input$control_variable_selector_value]])
      )
    })
    
    output$epi_parameters_ui <- renderUI({
      if(input$epimut_method %in% c("manova", "mlm")){
        numericInput(
          inputId = ns("pvalue_cutoff"),
          label = "P-value cutoff", 
          value = 0.05
        )
      } else if (input$epimut_method %in% c("iForest")) {
        tagList(
          numericInput(
            inputId = ns("outlier_score_cutoff"),
            label = "Outliser score cutoff", 
            value = 0.7
          ),
          numericInput(
            inputId = ns("ntrees"),
            label = "Number of trees", 
            value = 100
          )
        )
      } else if (input$epimut_method %in% c("mahdist")) {
        selectInput(
          inputId = ns("nsamp"),
          label = "Number of samples", 
          choices = c("deterministic", "best", "exact")
        )
      } else if (input$epimut_method %in% c("quantile")) {
        tagList(
          numericInput(
            inputId = ns("window_sz"),
            label = "Max window size", 
            value = 1000
          ),
          numericInput(
            inputId = ns("offset_abs"),
            label = "Absolute offset", 
            value = 0.15
          ),
          numericInput(
            inputId = ns("qsup"),
            label = "Outlier upper threshold", 
            value = 0.995
          ),
          numericInput(
            inputId = ns("qinf"),
            label = "Outlier lower threshold", 
            value = 0.005
          )
        )
      } else if (input$epimut_method %in% c("beta")) {
        tagList(
          numericInput(
            inputId = ns("pvalue_cutoff_beta"),
            label = "P-value cutoff", 
            value = 0.0000001
          ),
          numericInput(
            inputId = ns("diff_threshold"),
            label = "Difference threshold", 
            value = 0.1
          )
        )
      }
    })
    
    observeEvent(input$trigger_epimutations, {
      library(ExperimentHub)
      library(epimutacions)
      tryCatch({
        parameters <- epimutacions::epi_parameters(
          manova = list(
            "pvalue_cutoff" = input$pvalue_cutoff
          ),
          mlm = list(
            "pvalue_cutoff" = input$pvalue_cutoff
          ),
          iForest = list(
            "outlier_score_cutoff" = input$outlier_score_cutoff,
            "ntrees" = input$ntrees
          ),
          mahdist = list(
            "nsamp" = input$nsamp
          ),
          quantile = list(
            "window_sz" = input$window_sz,
            "offset_abs" = input$offset_abs,
            "qsup" = input$qsup,
            "qinf" = input$qinf
          ),
          beta = list(
            "pvalue_cutoff" = input$pvalue_cutoff_beta,
            "diff_threshold" = input$diff_threshold
          )
        )
        if(!input$one_leave_out){
          withProgress(message = 'Discovering epimutations...', value = 0.5, {
            case_samples <- loaded_dataset$data[,loaded_dataset$data[[input$control_variable_selector_value]] == input$case_encoding_value]
            control_samples <- loaded_dataset$data[,loaded_dataset$data[[input$control_variable_selector_value]] == input$control_encoding_value]
            results$results <- epimutacions::epimutations(case_samples,
                                                          control_samples,
                                                          method = input$epimut_method,
                                                          epi_params = parameters)
          })
        } else {
          withProgress(message = 'Discovering epimutations...', value = 0.5, {
            results$results <- epimutacions::epimutations_one_leave_out(
              loaded_dataset$data,
              method = input$epimut_method,
              epi_params = parameters
            )
            results$results <- results$results[!is.na(results$results$cpg_n),]
          })
        }
        results$results %>% dplyr::relocate(epi_region_id, .before = epi_id) -> results$results
        shinyjs::js$enableTab("Visualization")
      }, error = function(w){
        showNotification(paste(w), type = "error")
      })
      # case_samples <- data[,data[["status"]] == "case"]
      # control_samples <- data[,data[["status"]] == "control"]
      # results <- epimutacions::epimutations(case_samples, control_samples, method = "manova")
    })
    output$epi_results_table <- DT::renderDT(
      options = list(
        scrollX = TRUE),
      results$results
    )
  })
}

## To be copied in the UI
# mod_epimut_ui("epimut_1")

## To be copied in the server
# mod_epimut_server("epimut_1")

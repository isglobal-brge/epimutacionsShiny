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
        "Epimutations are rare alterations of the normal DNA methylation pattern at specific loci, which can
lead to rare diseases. Methylation microarrays enable genome-wide epimutation detection, but
technical limitations prevent their use in clinical settings: methods applied to rare diseases’ data
cannot be easily incorporated to standard analyses pipelines, while outlier methods implemented in R
packages (ramr) have not been validated for rare diseases. We have developed epimutacions, a
Bioconductor package implementing six statistical methods to detect epimutations. Additionally, we
have created an user-friendly Shiny app to facilitate epimutations detection to non-bioinformatician users. All methods implemented in epimutacions outperformed methods in ramr, in three public
datasets with experimentally validated epimutations. We then evaluated which technical and
biological factors affected epimutations’ detection in two healthy child cohorts. Technical batch and
sex were the most relevant factors that limit epimutations detection. In these cohorts, most
epimutations did not correlate with detectable regional gene expression changes. Finally, we applied
epimutacions to a dataset having individuals diagnosed with autism disorder, to exemplify how to use
epimutations in a clinical setting. Overall, we present epimutacions a new Bioconductor package for
incorporating epimutations detection to rare disease diagnosis and provide guidelines for the design
and data analyses."
      ),
      shinydashboard::box(width = 12,
        title = "Funding",
        "The research leading to these results has received funding from La Fundació Marató de TV3 (Grant
number 504/C/2020) [SB and JRG] and the Spanish Ministry of Health (FIS-PI19/00166) co-funded by
FEDER, and the Generalitat de Catalunya through the Consolidated Research Group (2017SGR01974)
[LAPJ]. The HELIX project was funded by the European Community's Seventh Framework Programme
[FP7/2007–2013] under grant agreement no 308333. INMA data collections were supported by
grants from the Instituto de Salud Carlos III, CIBERESP, and the Generalitat de Catalunya-CIRIT.
ISGlobal acknowledges support from the Spanish Ministry of Science and Innovation through the
“Centro de Excelencia Severo Ochoa 2019-2023” Program (CEX2018-000806-S), and support from
the Generalitat de Catalunya through the CERCA Program. MELIS-UPF acknowledges also support
form the Spanish National Investigation Agency (AEI) through the “Unidad de Excelencia María de
Maeztu (CEX2018-000792-MDM)”. CR-A received a postdoctoral contract of CIBERER.
Funding for open access charge: La Fundació Marató de TV3. "
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

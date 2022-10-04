#' aknowledgements UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_aknowledgements_ui <- function(id){
  ns <- NS(id)
  tagList(
    fluidRow(shinydashboard::box(width = 12,
    HTML("<div class='horizontal-scroll'><table class='table table-condensed'>
<colgroup>
<col width='14%'>
<col width='21%'>
<col width='17%'>
<col width='31%'>
<col width='14%'>
</colgroup>
<thead>
<tr class='header'>
<th align='left'>Name</th>
<th align='left'>Surname</th>
<th align='center'>ORCID</th>
<th align='left'>Affiliation</th>
<th align='left'>Team</th>
</tr>
</thead>
<tbody>
<tr class='odd'>
<td align='left'>Leire</td>
<td align='left'>Abarrategui</td>
<td align='center'>0000-0002-1175-038X</td>
<td align='left'>Faculty of Medical Sciences, Newcastle University, Newcastle-Upon-Tyne, UK; Autonomous University of Barcelona (UAB), Barcelona, Spain</td>
<td align='left'>Development</td>
</tr>
<tr class='even'>
<td align='left'>Lordstrong</td>
<td align='left'>Akano</td>
<td align='center'>0000-0002-1404-0295</td>
<td align='left'>College of Medicine, University of Ibadan</td>
<td align='left'>Development</td>
</tr>
<tr class='odd'>
<td align='left'>James</td>
<td align='left'>Baye</td>
<td align='center'>0000-0002-0078-3688</td>
<td align='left'>Wellcome/MRC Cambridge Stem Cell Institute, University of Cambridge, Cambridge CB2 0AW, UK; Department of Physics, University of Cambridge, Cambridge CB2 3DY, UK</td>
<td align='left'>Development</td>
</tr>
<tr class='even'>
<td align='left'>Alejandro</td>
<td align='left'>Caceres</td>
<td align='center'>-</td>
<td align='left'>ISGlobal, Barcelona Institute for Global Health, Dr Aiguader 88, 08003 Barcelona, Spain; Centro de Investigación Biomédica en Red en Epidemiología y Salud Pública (CIBERESP), Madrid, Spain</td>
<td align='left'>Development</td>
</tr>
<tr class='odd'>
<td align='left'>Carles</td>
<td align='left'>Hernandez-Ferrer</td>
<td align='center'>0000-0002-8029-7160</td>
<td align='left'>Centro Nacional de Análisis Genómico (CNAG-CRG), Center for Genomic, Regulation; Barcelona Institute of Science and Technology (BIST), Barcelona, Catalonia, Spain</td>
<td align='left'>Development</td>
</tr>
<tr class='even'>
<td align='left'>Pavlo</td>
<td align='left'>Hrab</td>
<td align='center'>0000-0002-0742-8478</td>
<td align='left'>Department of Genetics and Biotechnology, Biology faculty, Ivan Franko National University of Lviv</td>
<td align='left'>Validation</td>
</tr>
<tr class='odd'>
<td align='left'>Raquel</td>
<td align='left'>Manzano</td>
<td align='center'>0000-0002-5124-8992</td>
<td align='left'>Cancer Research UK Cambridge Institute; University of Cambridge, Cambridge, United Kingdom</td>
<td align='left'>Reporting</td>
</tr>
<tr class='even'>
<td align='left'>Margherita</td>
<td align='left'>Mutarelli</td>
<td align='center'>0000-0002-2168-5059</td>
<td align='left'>Institute of Applied Sciences and Intelligent Systems (ISASI-CNR)</td>
<td align='left'>Validation</td>
</tr>
<tr class='odd'>
<td align='left'>Carlos</td>
<td align='left'>Ruiz-Arenas</td>
<td align='center'>0000-0002-6014-3498</td>
<td align='left'>Centro de Investigación Biomédica en Red de Enfermedades Raras (CIBERER), Barcelona, Spain; Universitat Pompeu Fabra (UPF), Barcelona, Spain</td>
<td align='left'>Reporting</td>
</tr>
<tr class='even'>
<td align='left'>Xavier</td>
<td align='left'>Escribà-Montagut</td>
<td align='center'>-</td>
<td align='left'>ISGlobal, Barcelona Institute for Global Health, Dr Aiguader 88, 08003 Barcelona, Spain</td>
<td align='left'>R Shiny</td>
</tr>
</tbody>
</table></div>")
  )))
}
    
#' aknowledgements Server Functions
#'
#' @noRd 
mod_aknowledgements_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_aknowledgements_ui("aknowledgements_1")
    
## To be copied in the server
# mod_aknowledgements_server("aknowledgements_1")

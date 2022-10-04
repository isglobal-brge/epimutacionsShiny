#' layout 
#'
#' @description A utils function
#'
#' @return The return value, if any, from executing the utility.
#'
#' @noRd
#' 
#' 
header <- shinydashboard::dashboardHeader(title = "epimutacionsShiny")

sidebar <- shinydashboard::dashboardSidebar(
  shinydashboard::sidebarMenu(
    shinydashboard::menuItem("Home", tabName = "home"),
    shinydashboard::menuItem("Data selection", tabName = "dataSelection"),
    shinydashboard::menuItem("Epimutations", tabName = "epimutations"),
    shinydashboard::menuItem("Acknowledgements", tabName = "aknowledgements")
  )
)

homeTab <- shinydashboard::tabItem("home",
                                   mod_home_ui("home_module")
)

dataSelection <- shinydashboard::tabItem("dataSelection",
                                         mod_data_selection_ui("dataSelection_module")
)

preprocessing_panel <- tabPanel("Preprocessing",
                                mod_pre_process_ui("preprocessing_panel_module")
)

epimutations_panel <- tabPanel("Epimutations", value = "epi_panel",
                               mod_epimut_ui("epimutations_panel_module")
)

epi_visualization <- tabPanel("Visualization",
                              mod_epimut_viz_ui("epi_visualization_module")
                              
)

epimutations <- shinydashboard::tabItem("epimutations",
                                        fluidRow(
                                          shinydashboard::tabBox(
                                            id = "epimutations_tabset",
                                            width = 12,
                                            selected = "none",
                                            preprocessing_panel,
                                            epimutations_panel,
                                            epi_visualization
                                          )
                                        )
)

aknowledgements <- shinydashboard::tabItem("aknowledgements",
                                           mod_aknowledgements_ui("aknowledgements_module")
)

jscode_tab <- "
shinyjs.disableTab = function(name) {
  var tab = $('.nav li a[data-value=' + name + ']');
  tab.bind('click.tab', function(e) {
    e.preventDefault();
    return false;
  });
  tab.addClass('disabled');
}

shinyjs.enableTab = function(name) {
  var tab = $('.nav li a[data-value=' + name + ']');
  tab.unbind('click.tab');
  tab.removeClass('disabled');
}

shinyjs.disableTabItem = function(name) {
  var tab = $('.sidebar-menu li a[data-value=' + name + ']');
  tab.bind('click.tab', function(e) {
    e.preventDefault();
    return false;
  });
  tab.addClass('disabled');
}

shinyjs.enableTabItem = function(name) {
  var tab = $('.sidebar-menu li a[data-value=' + name + ']');
  tab.unbind('click.tab');
  tab.removeClass('disabled');
}
"
css_tab <- "
.nav li a.disabled {
  background-color: #aaa !important;
  color: #333 !important;
  cursor: not-allowed !important;
  border-color: #aaa !important;
}

.sidebar-menu li a.disabled {
  background-color: #aaa !important;
  color: #333 !important;
  cursor: not-allowed !important;
  border-color: #aaa !important;
}
"

body <- shinydashboard::dashboardBody(
  # shinyjs::useShinyjs(),
  shinyjs::inlineCSS(css_tab),
  # shinyjs::extendShinyjs(text = jscode_tab, functions = c("enableTab", "disableTab", "disableTabItem", "enableTabItem")),
  shinydashboard::tabItems(
    homeTab,
    dataSelection,
    epimutations,
    aknowledgements
  )
)
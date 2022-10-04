# Building a Prod-Ready, Robust Shiny Application.
#
# README: each step of the dev files is optional, and you don't have to
# fill every dev scripts before getting started.
# 01_start.R should be filled at start.
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
#
#
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################

# Engineering

## Dependencies ----
usethis::use_package( "epimutacionsData" )
usethis::use_package( "minfi" )
usethis::use_package( "Rsamtools" )
usethis::use_package( "epimutacions" )
usethis::use_package( "ensembldb" )
usethis::use_package( "Gviz" )
usethis::use_package( "shinycssloaders" )
usethis::use_package( "shinyWidgets" )
usethis::use_package( "TxDb.Hsapiens.UCSC.hg19.knownGene" )
usethis::use_package( "TxDb.Hsapiens.UCSC.hg38.knownGene" )
usethis::use_package( "TxDb.Hsapiens.UCSC.hg18.knownGene" )
usethis::use_package( "IlluminaHumanMethylation450kmanifest" )
usethis::use_package( "IlluminaHumanMethylationEPICmanifest" )
usethis::use_package( "IlluminaHumanMethylation450kanno.ilmn12.hg19" )
usethis::use_package( "AnnotationDbi" )
usethis::use_package( "Homo.sapiens" )
usethis::use_package( "cowplot" )
usethis::use_package( "shinyjs" )
usethis::use_package( "AnnotationHub" )
usethis::use_package( "golem" )
usethis::use_package( "shinydashboard" )
usethis::use_package( "ExperimentHub" )
usethis::use_package( "reshape2" )
usethis::use_package( "ggrepel" )

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "data_selection", with_test = TRUE) # Name of the module
golem::add_module(name = "pre_process", with_test = TRUE) # Name of the module
golem::add_module(name = "epimut", with_test = TRUE) # Name of the module
golem::add_module(name = "epimut_viz", with_test = TRUE) # Name of the module
golem::add_module(name = "aknowledgements", with_test = TRUE) # Name of the module
golem::add_module(name = "home", with_test = TRUE) # Name of the module
golem::add_module(name = "mod_epimut_ui_module_ui", with_test = TRUE) # Name of the module

## Add helper functions ----
## Creates fct_* and utils_*
golem::add_fct("helpers", with_test = TRUE)
golem::add_utils("data", with_test = TRUE)
golem::add_utils("layout", with_test = TRUE)

## External resources
## Creates .js and .css files at inst/app/www
golem::add_js_file("script")
golem::add_js_handler("handlers")
golem::add_css_file("custom")
golem::add_sass_file("custom")

## Add internal datasets ----
## If you have data in your package
usethis::use_data_raw(name = "my_dataset", open = FALSE)

## Tests ----
## Add one line by test you want to create
usethis::use_test("app")

# Documentation

## Vignette ----
usethis::use_vignette("epimutacionsShiny")
devtools::build_vignettes()

## Code Coverage----
## Set the code coverage service ("codecov" or "coveralls")
usethis::use_coverage()

# Create a summary readme for the testthat subdirectory
covrpage::covrpage()

## CI ----
## Use this part of the script if you need to set up a CI
## service for your application
##
## (You'll need GitHub there)
usethis::use_github()

# GitHub Actions
usethis::use_github_action()
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_release()
usethis::use_github_action_check_standard()
usethis::use_github_action_check_full()
# Add action for PR
usethis::use_github_action_pr_commands()

# Travis CI
usethis::use_travis()
usethis::use_travis_badge()

# AppVeyor
usethis::use_appveyor()
usethis::use_appveyor_badge()

# Circle CI
usethis::use_circleci()
usethis::use_circleci_badge()

# Jenkins
usethis::use_jenkins()

# GitLab CI
usethis::use_gitlab_ci()

# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

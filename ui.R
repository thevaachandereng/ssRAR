#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinythemes)
library(shiny)
library(blockRAR)
library(ggplot2)
library(dplyr)

fluidPage(theme = shinytheme("cerulean"),
          radioButtons("test", "Test Objective", c("Superiority" = "sup", "Non-Inferiority" = "non-inf"), 
                      selected = "Superiority"),
          numericInput(inputId = "p_control", 
                      label = "Response Rate for the Control Group (pC)", 
                      value = 0.5, min = 0, max = 1),
          numericInput(inputId = "p_treatment", 
                      label = "Response Rate for the Treatment Group (pT)", 
                      value = 0.5, min = 0, max = 1),
          numericInput(inputId = "block_number", 
                       label = "Number of Block(s) (k)", 
                       value = 2, min = 1, max = 20),
          numericInput(inputId = "type1_error", label = withMathJax("Type I error,  $\\alpha$ (one-sided):"), 
                       value = 0.05, min = 0.01, max = 0.20, step = 0.005),
          numericInput(inputId = "power", label = withMathJax("Power,  $1 - \\beta$:"), 
                       value = 0.9, min = 0.8, max = 1, step = 0.005),
          uiOutput("mcmc")
)

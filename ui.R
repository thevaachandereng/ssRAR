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
          numericInput(inputId = "p_control", 
                      label = "Response Rate for the Control Group (pC)", 
                      value = 0.5, min = 0, max = 1),
          numericInput(inputId = "p_treatment", 
                      label = "Response Rate for the Treatment Group (pT)", 
                      value = 0.5, min = 0, max = 1),
          numericInput(inputId = "block_number", 
                       label = "Number of Block(s) (k)", 
                       value = 2, min = 1, max = 20),
          uiOutput("conf_int"),
          numericInput(inputId = "type1_error", label = "Sample Size for each Trial", 
                       value = 100, min = 2, max = 100000, step = 1),
          uiOutput("block_number"),
          numericInput(inputId = "simulation", label = "Number of Trials", 
                       value = 100, min = 20, max = 10000, step = 1),
          uiOutput("mcmc")
)

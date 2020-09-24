#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

function(input, output){
  
  output$conf_int <- renderUI({
    if(input$method == "Frequentist"){
      sliderInput(inputId = "conf_int", 
                  label = "Confidence interval", 
                  value = 0.95, min = 0, max = 1)
    }
  })
  output$mcmc <- renderUI({
    if(input$method == "Bayesian"){
      numericInput(inputId = "number_mcmc", label = "Number of Posterior Samples Drawn", 
                   value = 10000, min = 20, max = 10000, step = 1)
    }
  })
  output$drift <- renderUI({
    sliderInput(inputId = "drift", 
                label = "Drift Parameter", 
                value = 0, min = max(-input$p_control,-input$p_treatment), 
                max = min(1-input$p_control,1-input$p_treamtnet))
  })
  output$block_number <- renderUI({
    numericInput(inputId = "block_number", label = "Block Number", 
                 value = 1, min = 1, max = floor(input$N_total/2), step = 1)
  })
  
  output$hist <- renderPlot({
    if(input$method == "Frequentist"){
      binomialfreq(p_control    = input$p_control, 
                   p_treatment  = input$p_treatment, 
                   N_total      = input$N_total, 
                   block_number = input$block_number,  
                   drift        = 0, 
                   simulation   = input$simulation, 
                   conf_int     = input$conf_int,
                   alternative  = "greater",
                   replace      = TRUE, 
                   early_stop   = FALSE)
    } else {
      binomialbayes(p_control          = input$p_control, 
                    p_treatment        = input$p_treatment, 
                    N_total            = input$N_total, 
                    block_number       = input$block_number,
                    drift              = 0.10,
                    simulation         = input$simulation,
                    a0                 = 0.5,
                    b0                 = 0.5, 
                    number_mcmc        = input$number_mcmc, 
                    prob_accept_ha     = 0.95,
                    early_success_prob = 1,
                    futility_prob      = 0,
                    alternative        = "greater")
    }
  })
}

#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict Income from Education "),
    sidebarLayout(
        sidebarPanel(
            sliderInput("slideredu", "Education", 5, 20, value = 10),
            checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
            submitButton("Submit")
        ),
        mainPanel(
            plotOutput("plot1"),
            textOutput("pred1"),
            plotOutput("plot2"),
            textOutput("pred2")
        )
    )
))

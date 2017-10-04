#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
    library(car)
    library(ggplot2)
    model1 <- lm(income ~ education, data = Prestige)
    model2 <- lm(log(income) ~ education, data = Prestige)
    
    model1pred <- reactive({
        eduInput <- input$slideredu
        predict(model1, newdata = data.frame(education =eduInput))
    })
    
    model2pred <- reactive({
        eduInput <- input$slideredu
        predict(model2, newdata = data.frame(education =eduInput ))
    })
    
    output$plot1 <- renderPlot({
        if(input$showModel1){
        eduInput <- input$slideredu
            ggplot(Prestige,aes(education,income))+geom_point(aes(color=prestige))+ggtitle("Plot of income against education")+geom_abline(intercept=model1$coefficients[1], slope=model1$coefficients[2])+geom_point(aes(eduInput,model1pred()),colour="red")
        }
            })
    output$plot2 <- renderPlot({
    if(input$showModel2){
            eduInput <- input$slideredu
            ggplot(Prestige,aes(education,log(income)))+geom_point(aes(color=prestige))+ggtitle("Plot of log(income) against education")+geom_abline(intercept=model2$coefficients[1], slope=model2$coefficients[2])+geom_point(aes(eduInput,model2pred()),colour="red")
        } 
            })
    
    output$pred1 <- renderText({
        if(input$showModel1){
        paste("Predicted income from model 1=",model1pred())
        }
    })
    
    output$pred2 <- renderText({
        if(input$showModel2){
        paste("Predicted income from model 2=",exp(model2pred()))
        }
    })
})
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
faithful$waiting2 <- ifelse(faithful$waiting -75 > 0, faithful$waiting - 75, 0)
faithful$waiting3 <- ifelse(faithful$waiting -55 > 0, faithful$waiting - 55, 0)
model1 <- lm(eruptions ~ waiting, data = faithful)
model2 <- lm(eruptions ~ waiting + waiting2, data = faithful)
model3 <- lm(eruptions ~ waiting + waiting3, data = faithful)

    model1pred <- reactive({
        waitInput <- input$sliderwait
        predict(model1, newdata = data.frame(waiting=waitInput))
    })
    model2pred <- reactive({
        waitInput <- input$sliderwait
        predict(model2, newdata = data.frame(waiting=waitInput,
                                             waiting2 = ifelse(waitInput -75 > 0, waitInput - 75, 0)))
    })
    model3pred <- reactive({
        waitInput <- input$sliderwait
        predict(model3, newdata = data.frame(waiting=waitInput,
                                                 waiting3 = ifelse(waitInput -55 > 0, waitInput - 55, 0)))
    })

    
  
    
    output$plot1 <- renderPlot({
        waitInput <- input$sliderwait
        
        plot(faithful$waiting, faithful$eruptions, xlab = "Waiting Time", ylab="Eruption Time",
             bty="n", pch=16, xlim=c(40,100), ylim = c(1.5,5)) 
        
        
            if(input$showModel1){
            abline(model1, col="red", lwd=2)}
            
            if(input$showModel2){
                model2lines <- predict(model2, newdata=data.frame(waiting=0:100, waiting2 = ifelse(0:100 - 75 > 0, 0:100 - 75,0)))
                lines(0:100, model2lines, col="blue", lwd=2)}
         
            if(input$showModel3){
             model3lines <- predict(model3, newdata=data.frame(waiting=0:100, waiting3 = ifelse(0:100 - 55 > 0, 0:100 - 55,0)))
             lines(0:100, model3lines, col="dark green", lwd=2)}
        
        
            legend(25, 250, c("Model 1 Prediction, the average", "Model 2 Prediction, for longer waits (>75 sec)", "Model 3 Prediction, for shorter waits (<55 sec)"))
            points(waitInput, model1pred(), col="red", pch=16, cex=2)
            points(waitInput, model2pred(), col="blue", pch=16, cex=2)
            points(waitInput, model3pred(), col="dark green", pch=16, cex=2)
        })
        
       
        
        output$pred1 <- renderText({
            model1pred()
        })
        
        output$pred2 <- renderText({
            model2pred()
        })
        output$pred3 <- renderText({
            model3pred()
        })
}) 
        

      
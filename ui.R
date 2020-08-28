#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Predict eruption time of the old Faithful Geyser based on the waiting time"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderwait",
                        "How long did you wait (in seconds)?",
                        min = 40,
                        max = 100,
                        value = 50),
        checkboxInput("showModel1", "showModel1", value = TRUE ),
        checkboxInput("showModel2", "showModel2", value = TRUE ),
        checkboxInput("showModel3", "showModel3", value = TRUE )  
            ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("plot1"),
            h4("Predicted eruption time (in seconds) from Model 1:"),
            textOutput("pred1"),
            h4("Predicted eruption time (in seconds) from Model 2:"),
            textOutput("pred2"),
            h4("Predicted eruption time (in seconds) from Model 3:"),
            textOutput("pred3")
        )
    )
))

## https://meijdena.shinyapps.io/oldfaithfull/
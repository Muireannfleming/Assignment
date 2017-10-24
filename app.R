library(shiny)

# Define UI for application that draws a histogram
ui<-fluidPage(
  
  
  # Application title
  titlePanel("Assessment 1"),
  
  # Generate sample size 
        numericInput(inputId = "n", "Sample Size:",  min = 1, max = 500,value=50),
        sliderInput(inputId = "Mean", "Mean:", min=1, max=100, value=30, step=5),
        sliderInput(inputId = "SD", "Standard Deviatiom:", min=1, max=100, value=30, step=5),
        plotOutput(outputId = "hist")
        )
# Generate distribution plot

  server <- 
    function(input, output){
      output$hist<- renderPlot({
        hist(rnorm(input$n, input$Mean, input$SD)) 
      }) 
  }

# Run the application 
shinyApp(ui = ui, server = server)



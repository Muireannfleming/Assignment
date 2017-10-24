#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

if (interactive()) {

# Define UI for data upload app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Uploading Files"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      #  Input: Select a file
      fileInput("file1", "Choose CSV File",
                multiple = TRUE,
                accept = c("text/csv","text/comma-separated-values,text/plain",".csv")),
                tags$hr(),
      checkboxInput("header","Header", TRUE)
                ,
  
  selectInput("var", "Variable:", c("patient_id" = "patient_id", "age" = "age", "height" = "height", "weight" = "weight",  "bmi" = "bmi")),
              radioButtons("cols", "choose colour:", c("Red" = "red", "Purple" = "purple", "Yellow" = "yellow", "Green" = "green"))
     
                           ),
              # Main panel for displaying outputs ----
      mainPanel(
        tableOutput("data"),
        plotOutput("box")
    
      )))

# Define server logic to read selected file ----

server <- function(input, output) {
  output$data <- renderTable({
    infile = input$file1
    if (is.null(infile))
        return(NULL)
    data <-read.csv(infile$datapath, header = input$header)

         
  }
)
  
output$box <- renderPlot ({
  (req(input$file1))
  infile = input$file1
  data <-read.csv(infile$datapath, header=input$header)
               var = input$var
               col = input$cols
               boxplot(data[,var], col = col, main=paste("Selected Variable", var))

})
}

}
  
# Run the app ----
shinyApp(ui = ui, server = server)



  
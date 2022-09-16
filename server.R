
# Libraries
library(shiny)
library(shinythemes)
library(data.table)
library(xlsx)
library(DT)

# Get Data
akd <- read.xlsx("akd.xlsx", sheetIndex = 1)

colnames(akd) <- c("date", "location", "fish", "kg", "price", "boat_count", 
                   "fishnet_b_count", "cycle", "paragat", "p_b_count", "fishnet", 
                   "both_p_f", "total_price")


server <- function(input, output, session) {
  
  # display 10 rows initially
  
  output$contents <- renderPrint({
    if (input$submitbutton>0) { 
      isolate("Veri Eklendi.") 
    } else {
      return("Veri Eklemeye Hazir.")
    }
  })
  
  
  
  datasetInput <- reactive({  
    new_row <- data.frame(
      date             = as.character(input$date),
      location         = input$location,
      fish             = input$fish,
      kg               = input$kg,
      price            = input$price,
      boat_count       = input$boat_count,
      fishnet_b_count  = input$fishnet_b_count,
      cycle            = input$cycle,
      paragat          = input$paragat,
      p_b_count        = input$p_b_count,
      fishnet          = input$fishnet,
      both_p_f         = input$both_p_f,
      total_price      = input$kg*input$price
    )
    akd <- rbind(new_row, akd)
    write.xlsx(akd, "akd.xlsx",col.names = TRUE, row.names = FALSE)
    
    output <- new_row
    output
  })
  output$table <- DT::renderDataTable(
    DT::datatable(data = akd, 
                  options = list(pageLength = 10), 
                  style = "bootstrap"))
  
  akd <- read.xlsx("akd.xlsx", sheetIndex = 1)
  
  
  output$new_row <- renderTable({
    if (input$submitbutton>0) { 
      isolate(datasetInput())
    } 
  })
  
  
}
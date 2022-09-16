
# Libraries
library(shiny)
library(shinythemes)
library(data.table)
library(xlsx)
library(DT)

# Get Data
akd <- readRDS("akd.RDS")

colnames(akd) <- c("date", "location", "fish", "kg", "price", "boat_count", 
                   "fishnet_b_count", "cycle", "paragat", "p_b_count", "fishnet", 
                   "both_p_f", "total_price")

####################################
# User interface                   #
####################################
ui <- fluidPage(
  theme = shinytheme("darkly"),
  titlePanel("AKD Veri Giris Sistemi"),
  sidebarLayout(
    sidebarPanel(width = 2,
                 dateInput("date", "Tarih:", language = "tr"),
                 selectInput("location", "Yer:", choices = c("Gocek", "Calis")),
                 selectInput("fish", "Balik Turu:", choices = c("akya", "palamut")),
                 numericInput("kg", "Tutulan Balik Miktari(kg):", NULL),
                 numericInput("price", "Kilogram Fiyati:", NULL),
                 numericInput("boat_count", "Ava Cikan T.Sayisi:", NULL),
                 
                 numericInput("fishnet_b_count", "Olta A.T.S:", NULL),
                 numericInput("cycle", "Posta Sayisi:", NULL),
                 numericInput("paragat", "Paragat Atan T.Sayisi:", NULL),
                 numericInput("p_b_count", "Paragat ve Birakma:", NULL),
                 numericInput("fishnet", "Olta Sayisi:", NULL),
                 numericInput("both_p_f", "Hem Paragat Hem Olta:", NULL),
                 
                 actionButton("submitbutton", "Ekle")
                 
    ),
    mainPanel(
      DT::dataTableOutput('table', width = "100%"),
      tags$label(h3('Sonuc')), # Status/Output Text Box
      verbatimTextOutput('contents'),
      tags$label(h4('Kaydedilen Veri')),
      tableOutput('new_row') 
    )
  )
)

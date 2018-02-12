library(shiny)
library(DT)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "prevoz",
                  label = "Izberi prevozno sredstvo",
                  choices = list("Avto", "Avtobus", "Letalo", "Drugo"))),
    mainPanel(
      plotOutput("napovedprevoz"))
  ))
  
)
library(shiny)
library(DT)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dohodek",
                  label = "Izberi dohodkovni razred",
                  choices = list("1. kvartil", "2. kvartil", "3. kvartil", "4. kvartil"))),
    mainPanel(
      plotOutput("napoveddohodek"))
  ))
  
)


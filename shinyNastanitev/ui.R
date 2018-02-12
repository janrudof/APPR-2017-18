library(shiny)
library(DT)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "nastanitev",
                  label = "Izberi nastanitveni objekt",
                  choices = list("Hoteli", "Kampi", "Pri znancih", "Lastna \nbivalisca", "Ostalo"))),
    mainPanel(
      plotOutput("napovednastanitev"))
  ))
  
)


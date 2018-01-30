library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("Število potovanj v posamezno državo"),
  selectInput(inputId = "celina",
              label = "Izberi območje",
              choices = list("Svet", "Evropa")),
  sliderInput(inputId = "num",
              label = "Izberi leto",
              value = 2006, min = 2006, max = 2016),
  plotOutput("zemljevid")
  
))

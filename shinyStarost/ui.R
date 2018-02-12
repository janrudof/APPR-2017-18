library(shiny)
library(DT)

shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "starost",
                             label = "Izberi starostno skupino",
                             choices = list("15-24", "25-44", "45-64", "65 +"))),
    mainPanel(
      plotOutput("napovedstarost"))
  )
  
))


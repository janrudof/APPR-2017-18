library(shiny)
library(DT)

shinyUI(fluidPage(
  titlePanel("Napovedi potovanj glede na starostno obdobje"),
  selectInput(inputId = "starost",
              label = "Izberi starostno skupino",
              choices = list("15-24", "25-44", "45-64", "65 +")),
  plotOutput("napovedstarost")
))


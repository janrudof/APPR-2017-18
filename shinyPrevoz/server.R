
library(shiny)


shinyServer(function(input, output) {
   
  output$napovedprevoz <- renderPlot({
    tabela4.preciscena <- tabela4.zdruzena %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)", VRSTA_PREVOZA == input$prevoz) 
    tabela4.preciscena$DESTINACIJA <- NULL
    tabela4.preciscena$VRSTA_MERITVE <- NULL
    tabela4.preciscena$VRSTA_PREVOZA <- NULL
    
    prevoz <- lm(data = tabela4.preciscena, SKUPAJ ~ I(LETO^2) + LETO)
    
    
    model4 <- ggplot(tabela4.preciscena) +
      aes(x = LETO, y = SKUPAJ) +
      labs(title = "Graf napovedi potovanj glede na prevozno sredstvo", x= "Leto", y = "Število potovanj (v 1000)") +
      geom_point(size = 3)+
      geom_smooth(method = "lm", formula = y ~ I(x^2) + x, fullrange = TRUE, se = TRUE, size = 2) +
      theme_bw()
    
    novi.podatki4 <- data.frame(LETO = seq(2016, 2020, 1))
    napoved4 <- novi.podatki4 %>% mutate(SKUPAJ = predict(prevoz, .))
    
    
    model4 + geom_point(data = napoved4, aes(x=LETO, y=SKUPAJ), color = "red", size=3) +
      scale_x_continuous(breaks = seq(2006, 2020, 2)) +
      theme(plot.title = element_text(lineheight=.10, face="bold", hjust = 0.5))
    
    
  })
  
})

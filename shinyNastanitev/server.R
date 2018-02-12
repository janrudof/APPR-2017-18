
library(shiny)

shinyServer(function(input, output) {
   
  output$napovednastanitev <- renderPlot({
    tabela3.preciscena <- tabela3.zdruzena %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)", VRSTA_NASTANITVE == input$nastanitev)
    tabela3.preciscena$DESTINACIJA <- NULL
    tabela3.preciscena$VRSTA_MERITVE <- NULL
    tabela3.preciscena$VRSTA_NASTANITVE <- NULL
    
    nastanitev <- lm(data = tabela3.preciscena, SKUPAJ ~ LETO)
    
    
    model3 <- ggplot(tabela3.preciscena) +
      aes(x = LETO, y = SKUPAJ) +
      labs(title = "Graf napovedi potovanj glede na nastanitev", x = "Leto", y = "Število potovanj (v 1000)") +
      geom_point(size = 3) +
      geom_smooth(method = "lm", formula = y ~ x, fullrange = TRUE, se = TRUE, size=2) +
      theme_bw()
    
    
    novi.podatki3 <- data.frame(LETO = seq(2016, 2020, 1))
   
    napoved3 <- novi.podatki3 %>% mutate(SKUPAJ = predict(nastanitev, .))
    
    model3 + geom_point(data = napoved3, aes(x=LETO, y=SKUPAJ), color = "red", size=3) +
      scale_x_continuous(breaks = seq(2006, 2020, 2)) +
      theme(plot.title = element_text(lineheight=.10, face="bold", hjust = 0.5))
  })
  
})

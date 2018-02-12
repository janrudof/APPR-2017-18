library(shiny)

shinyServer(function(input, output) {
  output$napoveddohodek <- renderPlot({
    tabela2.preciscena <- tabela2.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", DOHODKOVNI_RAZRED == input$dohodek)
    tabela2.preciscena$VRSTA_POTOVANJA <- NULL
    tabela2.preciscena$DOHODKOVNI_RAZRED <- NULL
    
    dohodek <- gam(data = tabela2.preciscena, SKUPAJ ~ s(LETO))
    
    model2 <- ggplot(tabela2.preciscena) + 
      aes(x = LETO, y= SKUPAJ) +
      labs(title = "Graf napovedi potovanj glede na dohodkovni razred", x = "Leto", y = "Število potovanj (v 1000)") +
      geom_point(size = 3)+
      geom_smooth(method = "gam", formula = y ~ s(x), fullrange = TRUE, se = TRUE, size = 2) +
      theme_bw()
    
    
    novi.podatki2 <- data.frame(LETO = seq(2016, 2020, 1))
  
    napoved2 <- novi.podatki2 %>% mutate(SKUPAJ = predict(dohodek, .))
    
    model2 + geom_point(data = napoved2, aes(x=LETO, y=SKUPAJ), color = "red", size= 3) +
      scale_x_continuous(breaks = seq(2006, 2020, 2)) +
      theme(plot.title = element_text(lineheight=.10, face="bold", hjust = 0.5))
    
  })
})

library(shiny)

shinyServer(function(input, output) {
  output$napovedstarost <- renderPlot({
    tabela1.preciscena <- tabela1.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", STAROST != "Starost - SKUPAJ", STAROST == input$starost)
    tabela1.preciscena$VRSTA_POTOVANJA <- NULL
    tabela1.preciscena$STAROST <- NULL
    
    star <- lm(data = tabela1.preciscena, SKUPAJ ~ LETO)
    
    model1 <- ggplot(tabela1.preciscena) + 
      aes(x = LETO, y= SKUPAJ) +
      labs(title = "Graf napovedi potovanj glede na starostno obdobje", x = "Leto", y = "Število potovanj (v 1000)") +
      geom_point(size = 3) +
      geom_smooth(method = "lm", formula = y ~ x, fullrange = TRUE, se = TRUE, size = 2) +
      theme_bw()
   
    novi.podatki1 <- data.frame(LETO = seq(2016, 2020, 1))
    napoved1 <- novi.podatki1 %>% mutate(SKUPAJ = predict(star, .))
    
    model1 + geom_point(data = napoved1, aes(x=LETO, y=SKUPAJ), color = "red", size=3) +
      scale_x_continuous(breaks = seq(2006, 2020, 2)) +
      theme(plot.title = element_text(lineheight=.10, face="bold", hjust = 0.5))
   
  })
})


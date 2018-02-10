library(shiny)

shinyServer(function(input, output) {
  output$napovedstarost <- renderPlot({
    tabela1.preciscena <- tabela1.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", STAROST != "Starost - SKUPAJ", STAROST == input$starost) #še za druge skupine
    tabela1.preciscena$VRSTA_POTOVANJA <- NULL
    tabela1.preciscena$STAROST <- NULL
    
    #izračun modela
    
    star <- gam(data = tabela1.preciscena, SKUPAJ ~ s(LETO))
    
    #izris modela
    
    model1 <- ggplot(tabela1.preciscena) + 
      aes(x = LETO, y= SKUPAJ) +
      labs(x = "Leto", y = "Število potovanj (v 1000)", color = "Starostna skupina") +
      geom_point(size = 3) +
      geom_smooth(method = "gam", formula = y ~ s(x), fullrange = TRUE, se = FALSE, size = 2) +
      theme_bw()
    
    #predikcija
    
    novi.podatki1 <- data.frame(LETO = seq(2016, 2020, 1))
    #predict(star, novi.podatki1)
    napoved1 <- novi.podatki1 %>% mutate(SKUPAJ = predict(star, .))
    
    #izris napovedi
    
    model1 <- model1 + geom_point(data = napoved1, aes(x=LETO, y=SKUPAJ), color = "red", size=3) +
      scale_x_continuous(breaks = seq(2006, 2020, 2))
    model1
  })
})


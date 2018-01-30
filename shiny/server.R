library(shiny)

shinyServer(function(input, output) {
  output$zemljevid <- renderPlot({
    zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                       "ne_110m_admin_0_countries", encoding= "UTF-8") 
    zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)
    
    point <- format_format(big.mark = ".", decimal.mark = ",", scientific = FALSE)
    
    if (input$celina == "Svet"){
      potovanja <- tabela5 %>% filter(LETO == input$num)
    
      ggplot() + aes(x = long, y = lat, group = group,
                    fill = STEVILO_POTOVANJ) +
        geom_polygon(data = potovanja %>% group_by(DRZAVA_POTOVANJA) %>%
                      summarise(STEVILO_POTOVANJ = sum(STEVILO_POTOVANJ)) %>%
                      right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
        guides(fill = guide_colorbar(title = "Število potovanj")) + 
        scale_fill_gradientn(trans = "log", breaks = 10^seq(0, 6, 2), labels = point, colours = heat.colors(15)) +
        coord_cartesian(xlim = c(-170,170), ylim= c(-55, 80)) 
    }
    else if (input$celina == "Evropa"){
      potovanja.evropa <- tabela5 %>% filter(LETO == input$num)
      
      ggplot() + aes(x = long, y = lat, group = group,
                    fill = STEVILO_POTOVANJ) +
        geom_polygon(data = potovanja.evropa %>% group_by(DRZAVA_POTOVANJA) %>%
                      summarise(STEVILO_POTOVANJ = sum(STEVILO_POTOVANJ)) %>%
                      right_join(zemljevid.tabela2, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
        guides(fill = guide_colorbar(title = "Število potovanj")) + 
        scale_fill_gradientn(trans = "log", breaks = 10^seq(0, 6, 2), labels = point, colours = heat.colors(15)) +
        coord_cartesian(xlim = c(-28, 55), ylim = c(33, 73))
  }
  })
})
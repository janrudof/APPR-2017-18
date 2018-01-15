# 3. faza: Vizualizacija podatkov

# ZEMLJEVIDI

zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                   "ne_110m_admin_0_countries", encoding= "UTF-8") 
zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)

potovanja.2016 <- tabela5 %>% filter(LETO == 2012)

graf.potovanja.2016 <- ggplot() + aes(x = long, y = lat, group = group, fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2016 %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "STEVILO POTOVANJ"))
  



#GRAFI




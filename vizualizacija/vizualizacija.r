# 3. faza: Vizualizacija podatkov

# ZEMLJEVIDI

zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                   "ne_110m_admin_0_countries", encoding= "UTF-8") 
zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)


#Potovanja pred krizo  
potovanja.2006 <- tabela5 %>% filter(LETO == 2006)

graf.potovanja.2006 <- ggplot() + aes(x = long, y = lat, group = group, fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2006 %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "STEVILO POTOVANJ"))

#Potovanja med krizo
potovanja.2009 <- tabela5 %>% filter(LETO == 2009)

graf.potovanja.2009 <- ggplot() + aes(x = long, y = lat, group = group, fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2009 %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "STEVILO POTOVANJ"))

#Potovanja po krizi
potovanja.2016 <- tabela5 %>% filter(LETO == 2016)

graf.potovanja.2016 <- ggplot() + aes(x = long, y = lat, group = group, fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2016 %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "STEVILO POTOVANJ"))


#GRAFI

#Potovanja glede na starost
graf1.1 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "15-24", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")
graf1.2 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "25-44", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")
graf1.3 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "45-64", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")
graf1.4 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "65 +", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")

#Potovanja glede na dohodkovni razred
graf2.1 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "1. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.2 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "2. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.3 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "3. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.4 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "4. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")

#Potovanja glede na nastanitveni objekt


#Potovanja glede na prevozno sredstvo

# 3. faza: Vizualizacija podatkov

# ZEMLJEVIDI

zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                   "ne_110m_admin_0_countries", encoding= "UTF-8") 
zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)

point <- format_format(big.mark = ".", decimal.mark = ",", scientific = FALSE)

#Potovanja prebivalcev Slovenije leta 2015
potovanja.2015 <- tabela5 %>% filter(LETO == 2015)

graf.potovanja.2015 <- ggplot() + aes(x = long, y = lat, group = group,
                                      fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2015 %>% group_by(DRZAVA_POTOVANJA) %>%
                 summarise(STEVILO_POTOVANJ = sum(STEVILO_POTOVANJ)) %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "STEVILO POTOVANJ")) + 
  scale_fill_gradient(trans = "log", breaks = 10^seq(0, 6, 2), labels = point)

#GRAFI

#Potovanja glede na starost
tabela1.zdruzena <- tabela1 %>% group_by(LETO, `STAROST`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

graf1.1 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "15-24", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_col()
graf1.2 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "25-44", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")
graf1.3 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "45-64", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")
graf1.4 <- ggplot(tabela1.zdruzena %>% filter(STAROST == "65 +", VRSTA_POTOVANJA =="Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "blue")

#Potovanja glede na dohodkovni razred
tabela2.zdruzena <- tabela2 %>% group_by(LETO, `DOHODKOVNI_RAZRED`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

graf2.1 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "1. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.2 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "2. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.3 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "3. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")
graf2.4 <- ggplot(tabela2.zdruzena %>% filter(DOHODKOVNI_RAZRED == "4. kvartil", VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + aes(x = LETO, y = SKUPAJ) + geom_line(color = "red")

#Potovanja glede na nastanitveni objekt
tabela3.zdruzena <- tabela3 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_NASTANITVE`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))

#Potovanja glede na prevozno sredstvo
tabela4.zdruzena <- tabela4 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_PREVOZA`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))


# 3. faza: Vizualizacija podatkov

# ZEMLJEVIDI

zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                   "ne_110m_admin_0_countries", encoding= "UTF-8") 
zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)

zemljevid.tabela2 <- pretvori.zemljevid(zemljevid.sveta) %>% filter(CONTINENT == "Europe" | SOVEREIGNT %in% c("Turkey", "Cyprus"), long > -30)

point <- format_format(big.mark = ".", decimal.mark = ",", scientific = FALSE)

#Potovanja prebivalcev Slovenije leta 2015 po svetu
potovanja.2015 <- tabela5 %>% filter(LETO == 2015)

graf.potovanja.2015 <- ggplot() + aes(x = long, y = lat, group = group,
                                      fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.2015 %>% group_by(DRZAVA_POTOVANJA) %>%
                 summarise(STEVILO_POTOVANJ = sum(STEVILO_POTOVANJ)) %>%
                 right_join(zemljevid.tabela, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "Število potovanj")) + 
  scale_fill_gradientn(trans = "log", breaks = 10^seq(0, 6, 2), labels = point, colours = heat.colors(15)) +
  coord_cartesian(xlim = c(-170,170), ylim= c(-55, 80)) +
  ggtitle("Potovanja leta 2015 po svetu")

#Potovanja prebivalcev Slovenije leta 2015 po Evropi
potovanja.evropa.2015 <- tabela5 %>% filter(LETO == 2015)

graf.potovanja.evropa.2015 <- ggplot() + aes(x = long, y = lat, group = group,
                                            fill = STEVILO_POTOVANJ) +
  geom_polygon(data = potovanja.evropa.2015 %>% group_by(DRZAVA_POTOVANJA) %>%
                 summarise(STEVILO_POTOVANJ = sum(STEVILO_POTOVANJ)) %>%
                 right_join(zemljevid.tabela2, by = c("DRZAVA_POTOVANJA" = "NAME_LONG")), color = "black") +
  guides(fill = guide_colorbar(title = "Število potovanj")) + 
  scale_fill_gradientn(trans = "log", breaks = 10^seq(0, 6, 2), labels = point, colours = heat.colors(15)) +
  coord_cartesian(xlim = c(-28, 55), ylim = c(33, 73)) +
  ggtitle("Potovanja leta 2015 po Evropi")


#GRAFI


#Potovanja glede na starost
tabela1.zdruzena <- tabela1 %>% group_by(LETO, `STAROST`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

graf1 <- ggplot(tabela1.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", STAROST != "Starost - SKUPAJ")) + 
  aes(x = LETO, y= SKUPAJ, col = STAROST) +
  labs(title = "Potovanja glede na starostno skupino", x = "Leto", y = "Število potovanj (v 1000)", color = "Starostna skupina") +
  geom_line(size = 2) +
  theme_bw()

#Potovanja glede na dohodkovni razred
tabela2.zdruzena <- tabela2 %>% group_by(LETO, `DOHODKOVNI_RAZRED`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

graf2 <- ggplot(tabela2.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje")) + 
  aes(x = LETO, y= SKUPAJ, col = DOHODKOVNI_RAZRED) +
  labs(title = "Potovanja glede na dohodkovni razred", x = "Leto", y = "Število potovanj (v 1000)", color = "Dohodkovni razred") +
  geom_line(size =2)+
  theme_bw()


#Potovanja glede na nastanitveni objekt
tabela3.zdruzena <- tabela3 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_NASTANITVE`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))


graf3.1 <- ggplot(tabela3.zdruzena %>% filter(LETO == 2007, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_NASTANITVE, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na vrsto \nnastanitve leta 2007") +
  ylab("Število nastanitev (v 1000)") +
  xlab("Vrsta nastanitve") +
  theme_bw()



graf3.2 <- ggplot(tabela3.zdruzena %>% filter(LETO == 2009, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_NASTANITVE, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na vrsto \nnastanitve leta 2009") +
  ylab("Število nastanitev (v 1000)") +
  xlab("Vrsta nastanitve") +
  theme_bw()



graf3.3 <- ggplot(tabela3.zdruzena %>% filter(LETO == 2016, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_NASTANITVE, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na vrsto \nnastanitve leta 2016") +
  ylab("Število nastanitev (v 1000)") +
  xlab("Vrsta nastanitve") +
  theme_bw()


skupek.grafov3 <- ggarrange(graf3.1, graf3.2, graf3.3, ncol = 2, nrow=2)

#Potovanja glede na prevozno sredstvo
tabela4.zdruzena <- tabela4 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_PREVOZA`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))

graf4.1 <- ggplot(tabela4.zdruzena %>% filter(LETO == 2007, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_PREVOZA, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na prevozno \nsredstvo leta 2007") +
  ylab("Število prevozov (v 1000)") +
  xlab("Prevozno sredstvo") +
  theme_bw()


graf4.2 <- ggplot(tabela4.zdruzena %>% filter(LETO == 2009, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_PREVOZA, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na prevozno \nsredstvo leta 2009") +
  ylab("Število prevozov (v 1000)") +
  xlab("Prevozno sredstvo") +
  theme_bw()


graf4.3 <- ggplot(tabela4.zdruzena %>% filter(LETO == 2016, DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)")) +
  aes(x= VRSTA_PREVOZA, y = SKUPAJ) +
  geom_col(fill = "blue") +
  ggtitle("Potovanja glede na prevozno \nsredstvo leta 2016") +
  ylab("Število prevozov (v 1000)") +
  xlab("Prevozno sredstvo") +
  theme_bw()

skupek.grafov4 <- ggarrange(graf4.1, graf4.2, graf4.3, ncol = 2, nrow=2, align = "hv")

#BDP Slovenije za pomoč pri interpretiranju ostalih podatkov

graf6 <- ggplot(tabela6) + aes(x = LETO, y = BDP_v_milijonih) +
  geom_col(fill = "blue", width = 0.5) +
  ggtitle("BDP Slovenije") + 
  ylab("BDP v milijonih evrov") +
  xlab("Leto") +
  scale_x_continuous(breaks = seq(2006, 2016, 1)) +
  theme_bw()

#Povprečni izdatki za prevoz in nastanitev


skupna.tabela3 <- spread(tabela3.zdruzena, VRSTA_NASTANITVE, SKUPAJ)  
skupna.tabela3 <- skupna.tabela3 %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Povprecni izdatki na turista na prenocitev (EUR)")
skupna.tabela3$VRSTA_MERITVE <- NULL
skupna.tabela4 <- spread(tabela4.zdruzena, VRSTA_PREVOZA, SKUPAJ)  
skupna.tabela4 <- skupna.tabela4 %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Povprecni izdatki na turista na prenocitev (EUR)")
skupna.tabela4$VRSTA_MERITVE <- NULL
skupna.tabela <- left_join(skupna.tabela3, skupna.tabela4, by = c("LETO", "DESTINACIJA"))
skupaj <- gather(skupna.tabela, "Hoteli", "Kampi", "Lastna \nbivalisca", "Ostalo", "Pri znancih", "Avto", "Avtobus", "Drugo", "Letalo", key = "VRSTA_MERITVE", value="SKUPAJ")
skupaj <- skupaj %>% drop_na()
skupaj$SKUPAJ <- skupaj$SKUPAJ / 4
skupaj$DESTINACIJA <- NULL
skupaj$VRSTA_MERITVE <- gsub("Ostalo", "Ostale nastanitve", skupaj$VRSTA_MERITVE)
skupaj$VRSTA_MERITVE <- gsub("Drugo", "Druge vrste prevoza", skupaj$VRSTA_MERITVE)

graf.skupaj <- ggplot(skupaj) +
  aes(x=LETO, y=SKUPAJ, col=VRSTA_MERITVE) +
  labs(title = "Povprečni izdatki glede na nastanitev in prevoz", x= "Leto", y= "Povprečni izdatki na turista na prenočitev (EUR)", col = NULL) +
  geom_path(size = 2) +
  theme_bw()

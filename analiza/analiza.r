# 4. faza: Analiza podatkov

#...VSE  BOM UPORABIL V SHINY ZA BOLJŠO PREGLEDNOST!...


#NAPOVEDI POTOVANJ GLEDE NA STAROSTNE SKUPINE

tabela1.preciscena <- tabela1.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", STAROST != "Starost - SKUPAJ", STAROST == "15-24") #še za druge skupine
tabela1.preciscena$VRSTA_POTOVANJA <- NULL
tabela1.preciscena$STAROST <- NULL

#izračun modela

star <- lm(data = tabela1.preciscena, SKUPAJ ~ LETO)

#izris modela

model1 <- ggplot(tabela1.preciscena) + 
  aes(x = LETO, y= SKUPAJ) +
  labs(title = "Napoved potovanj glede na starostno skupino", x = "Leto", y = "Število potovanj (v 1000)", color = "Starostna skupina") +
  geom_point(size = 3) +
  geom_smooth(method = "lm", formula = y ~ x, fullrange = TRUE, se = FALSE, size = 2) +
  theme_bw()

#predikcija

novi.podatki1 <- data.frame(LETO = seq(2016, 2020, 1))
#predict(star, novi.podatki1)
napoved1 <- novi.podatki1 %>% mutate(SKUPAJ = predict(star, .))

#izris napovedi

model1 <- model1 + geom_point(data = napoved1, aes(x=LETO, y=SKUPAJ), color = "red", size=3) +
  scale_x_continuous(breaks = seq(2006, 2020, 2)) 



#NAPOVEDI POTOVANJ GLEDE NA DOHODKOVNI RAZRED

tabela2.preciscena <- tabela2.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", DOHODKOVNI_RAZRED == "1. kvartil") #še za druge skupine
tabela2.preciscena$VRSTA_POTOVANJA <- NULL
tabela2.preciscena$DOHODKOVNI_RAZRED <- NULL

#izračun modela

dohodek <- gam(data = tabela2.preciscena, SKUPAJ ~ s(LETO))

#izris modela

model2 <- ggplot(tabela2.preciscena) + 
  aes(x = LETO, y= SKUPAJ) +
  labs(title = "Napoved potovanj glede na dohodkovni razred", x = "Leto", y = "Število potovanj (v 1000)") +
  geom_point()+
  geom_smooth(method = "gam", formula = y ~ s(x), fullrange = TRUE, se = FALSE) +
  theme_bw()

#predikcija

novi.podatki2 <- data.frame(LETO = seq(2016, 2020, 1))
#predict(dohodek, novi.podatki2)
napoved2 <- novi.podatki2 %>% mutate(SKUPAJ = predict(dohodek, .))

#izris napovedi

model2 <- model2 + geom_point(data = napoved2, aes(x=LETO, y=SKUPAJ), color = "red", size=2) +
  scale_x_continuous(breaks = seq(2006, 2020, 2)) 

#NAPOVEDI POTOVANJ GLEDE NA NASTANITEV
tabela3.preciscena <- tabela3.zdruzena %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)", VRSTA_NASTANITVE == "Hoteli") #še ostale možnosti
tabela3.preciscena$DESTINACIJA <- NULL
tabela3.preciscena$VRSTA_MERITVE <- NULL
tabela3.preciscena$VRSTA_NASTANITVE <- NULL

#izračun modela

nastanitev <- gam(data = tabela3.preciscena, SKUPAJ ~ s(LETO))

#izris modela
model3 <- ggplot(tabela3.preciscena) +
  aes(x = LETO, y = SKUPAJ) +
  labs(title= "Napoved stevila potovanj glede na nastanitev", x = "Leto", y = "Stevilo potovanj (v 1000)") +
  geom_point(size = 2) +
  geom_smooth(method = "gam", formula = y ~ s(x), fullrange = TRUE, se = FALSE) +
  theme_bw()
#predikcija

novi.podatki3 <- data.frame(LETO = seq(2016, 2020, 1))
#predict(nastanitev, novi.podatki3)
napoved3 <- novi.podatki3 %>% mutate(SKUPAJ = predict(nastanitev, .))

#izris napovedi

model3 <- model3 + geom_point(data = napoved3, aes(x=LETO, y=SKUPAJ), color = "red", size=2) +
  scale_x_continuous(breaks = seq(2006, 2020, 2))

#NAPOVEDI POTOVANJ GLEDE NA PREVOZ
tabela4.preciscena <- tabela4.zdruzena %>% filter(DESTINACIJA == "Tujina", VRSTA_MERITVE == "Potovanja (v 1000)", VRSTA_PREVOZA == "Avto") #še ostale možnosti
tabela4.preciscena$DESTINACIJA <- NULL
tabela4.preciscena$VRSTA_MERITVE <- NULL
tabela4.preciscena$VRSTA_PREVOZA <- NULL

#izračun modela

prevoz <- lm(data = tabela4.preciscena, SKUPAJ ~ I(LETO^2) + LETO)

#izris modela
model4 <- ggplot(tabela4.preciscena) +
  aes(x = LETO, y = SKUPAJ) +
  labs(title = "Napovedi stevila potovanj glede na prevoz", x= "Leto", y = "Stevilo potovanj (v 1000)") +
  geom_point(size = 2)+
  geom_smooth(method = "lm", formula = y ~ I(x^2) + x, fullrange = TRUE, se = FALSE) +
  theme_bw()

#predikcija

novi.podatki4 <- data.frame(LETO = seq(2016, 2020, 1))
#predict(prevoz, novi.podatki4)
napoved4 <- novi.podatki4 %>% mutate(SKUPAJ = predict(prevoz, .))

#izris napovedi

model4 <- model4 + geom_point(data = napoved4, aes(x=LETO, y=SKUPAJ), color = "red", size=2) +
  scale_x_continuous(breaks = seq(2006, 2020, 2))




# 4. faza: Analiza podatkov


#NAPOVEDI POTOVANJ GLEDE NA STAROSTNE SKUPINE

tabela1.preciscena <- tabela1.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", STAROST != "Starost - SKUPAJ", STAROST == "15-24") #še za druge skupine
tabela1.preciscena$VRSTA_POTOVANJA <- NULL
tabela1.preciscena$STAROST <- NULL

#izračun modela

star <- gam(data = tabela1.preciscena, SKUPAJ ~ s(LETO))

#izris modela


model1 <- ggplot(tabela1.preciscena) + 
  aes(x = LETO, y= SKUPAJ) +
  labs(title = "Potovanja glede na starostno skupino", x = "Leto", y = "Število potovanj (v 1000)", color = "Starostna skupina") +
  geom_point() +
  geom_smooth(method = "gam", formula = y ~ s(x)) +
  theme_bw()

#predikcija

novi.podatki1 <- data.frame(LETO = seq(2016, 2020, 1))
#predict(star, novi.podatki1)
napoved1 <- novi.podatki1 %>% mutate(SKUPAJ = predict(star, .))

#izris napovedi

model1 <- model1 + geom_point(data = napoved1, aes(x=LETO, y=SKUPAJ), color = "red", size=2) +
  scale_x_continuous(breaks = seq(2006, 2020, 2)) 

#...VSE  BOM UPORABIL V SHINY ZA BOLJŠO PREGLEDNOST!...

#NAPOVEDI POTOVANJ GLEDE NA DOHODKOVNI RAZRED

tabela2.preciscena <- tabela2.zdruzena %>% filter(VRSTA_POTOVANJA == "Sli na zasebno potovanje", DOHODKOVNI_RAZRED == "2. kvartil") #še za druge skupine
tabela2.preciscena$VRSTA_POTOVANJA <- NULL
tabela2.preciscena$DOHODKOVNI_RAZRED <- NULL

#izračun modela

dohodek <- gam(data = tabela2.preciscena, SKUPAJ ~ s(LETO))

#izris modela

model2 <- ggplot(tabela2.preciscena) + 
  aes(x = LETO, y= SKUPAJ) +
  labs(title = "Potovanja glede na dohodkovni razredo", x = "Leto", y = "Število potovanj (v 1000)") +
  geom_point()+
  geom_smooth(method = "gam", formula = y ~ s(x)) +
  theme_bw()

#predikcija

novi.podatki2 <- data.frame(LETO = seq(2016, 2020, 1))
predict(dohodek, novi.podatki2)
napoved2 <- novi.podatki2 %>% mutate(SKUPAJ = predict(dohodek, .))

#izris napovedi

model2 <- model2 + geom_point(data = napoved2, aes(x=LETO, y=SKUPAJ), color = "red", size=2) +
  scale_x_continuous(breaks = seq(2006, 2020, 2)) 


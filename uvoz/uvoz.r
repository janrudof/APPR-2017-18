# 2. faza: Uvoz podatkov

#Tabela 1: Prebivalci Slovenije po udeleženosti na potovanjih po starosti
uvozi.tabela1 <- function(){
  stolpci1 <- c("STAROST", "VRSTA_POTOVANJA", "CETRTLETJE", "MERITEV")
  tabela1 <- read_csv2("podatki/STAROST.csv", 
                       locale = locale(encoding = "cp1250"), 
                       col_names=stolpci1,
                       skip = 2,
                       n_max = 455)
  tabela1 <- tabela1[c(3,1,2,4)]
  tabela1 <- tabela1 %>% fill(2:3)
  tabela1$MERITEV <- tabela1$MERITEV %>% parse_number()
  tabela1 <- tabela1 %>% fill(1:4) %>% drop_na(1)
  tabela1$MERITEV <- parse_integer(tabela1$MERITEV)
  tabela1 <- tabela1 %>% arrange(CETRTLETJE)
  tabela1$VRSTA_POTOVANJA <- gsub(".li na zasebno potovanje", "Sli na zasebno potovanje", tabela1$VRSTA_POTOVANJA)
  tabela1 <- tabela1 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela1 <- tabela1[c(5,1,2,3,4)]
  return(tabela1)
}
tabela1 <- uvozi.tabela1()

tabela1.zdruzena <- tabela1 %>% group_by(LETO, `STAROST`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

#Tabela 2: Prebivalci Slovenije po udeleženosti na potovanjih po mesečnem dohodku
uvozi.tabela2 <- function(){
  stolpci2 <- c("DOHODKOVNI_RAZRED", "VRSTA_POTOVANJA", "CETRTLETJE", "MERITEV")
  tabela2 <- read_csv2("podatki/NETO_DOHODEK.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci2,
                       skip = 2,
                       n_max = 455)
  tabela2 <- tabela2[c(3,1,2,4)]
  tabela2 <- tabela2 %>% fill(2:3)
  tabela2$MERITEV <- tabela2$MERITEV %>% parse_number()
  tabela2 <- tabela2 %>% fill(2:4) %>% drop_na(1)
  tabela2$MERITEV <- parse_integer(tabela2$MERITEV)
  tabela2 <- tabela2 %>% arrange(CETRTLETJE)
  tabela2 <- tabela2 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela2 <- tabela2[c(5,1,2,3,4)]
  tabela2$VRSTA_POTOVANJA <- gsub(".li na zasebno potovanje", "Sli na zasebno potovanje", tabela2$VRSTA_POTOVANJA)
  return(tabela2)
}
tabela2 <- uvozi.tabela2()

tabela2.zdruzena <- tabela2 %>% group_by(LETO, `DOHODKOVNI_RAZRED`, `VRSTA_POTOVANJA`) %>%
  summarise(SKUPAJ = sum(MERITEV))

#Tabela 3: Zasebna potovanja po destinaciji in nastanitvenem objektu
uvozi.tabela3 <- function(){
  stolpci3 <- c("DESTINACIJA", "VRSTA_NASTANITVE", "VRSTA_MERITVE", "CETRTLETJE", "MERITEV")
  tabela3 <- read_csv2("podatki/NASTANITEV.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci3,
                       skip = 2,
                       n_max = 1094,
                       na=c(""," ", "-","N"))
  tabela3 <- tabela3 %>% fill(1:3)
  tabela3$MERITEV <- tabela3$MERITEV %>% parse_number()
  tabela3 <- tabela3[c(4,1,2,3,5)]
  tabela3 <- tabela3 %>% fill(1:5) %>% drop_na(1)
  tabela3 <- tabela3 %>% arrange(CETRTLETJE)
  tabela3 <- tabela3 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela3 <- tabela3[c(6,1,2,3,4,5)]
  return(tabela3)
}
tabela3 <- uvozi.tabela3()

tabela3.stevilo <- tabela3 %>% filter(VRSTA_MERITVE %in% c("Potovanja (v 1000)",
                                                           "Prenočitve (v 1000)"))

tabela3.zdruzena <- tabela3 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_NASTANITVE`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))

#Tabela 4: Zasebna potovanja po destinaciji in prevoznem sredstvu
uvozi.tabela4 <- function(){
  stolpci4 <- c("DESTINACIJA", "VRSTA_PREVOZA", "VRSTA_MERITVE", "CETRTLETJE", "MERITEV")
  tabela4 <- read_csv2("podatki/PREVOZNO_SREDSTVO.csv",
                       locale = locale(encoding= "cp1250"),
                       col_names = stolpci4, 
                       skip = 2,
                       n_max = 1452,
                       na = c("", " ", "-", "N"))
  tabela4 <- tabela4 %>% fill(1:3)
  tabela4 <- tabela4 %>% drop_na(1:5)
  tabela4 <- tabela4 %>% arrange(CETRTLETJE)
  tabela4 <- tabela4 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela4$MERITEV <- tabela4$MERITEV %>% parse_number()
  tabela4 <- tabela4[c(6,4,1,2,3,5)]
  return(tabela4)
}
tabela4 <- uvozi.tabela4()

tabela4.zdruzena <- tabela4 %>% group_by(LETO, `DESTINACIJA`, `VRSTA_PREVOZA`, `VRSTA_MERITVE`) %>%
  summarise(SKUPAJ = sum(MERITEV))



#Tabela 5: Države potovanja

uvozi.tabela5 <- function(){
  stolpci5 <- c("DRZAVA_POTOVANJA", "KRATICA", "1995","1996", "1997", "1998", "1999", "2000", "2001", "2002","2003","2004","2005","2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","SPREMEMBA")
  
  tabela5 <- read_xlsx("podatki/DRZAVE_POTOVANJA2.xlsx",
                       col_names = stolpci5,
                       skip= 7,
                       n_max= 159,
                       na = c("", " ", "-", "N"))
  tabela5$SPREMEMBA <- NULL
  tabela5$`1995` <- NULL
  tabela5$`1996`<- NULL
  tabela5$`1997`<- NULL
  tabela5$`1998`<- NULL
  tabela5$`1999`<- NULL
  tabela5$`2000`<- NULL
  tabela5$`2001`<- NULL
  tabela5$`2002`<- NULL
  tabela5$`2003`<- NULL
  tabela5$`2004`<- NULL
  tabela5$`2005`<- NULL
  tabela5 <- gather(tabela5, "2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016", key = "LETO", value = "STEVILO_POTOVANJ" )
  tabela5 <- tabela5[c(3,1,2,4)]
  tabela5 <- tabela5 %>% drop_na(1:4)
  tabela5$LETO <- tabela5$LETO %>% parse_integer()
  return(tabela5)
}

tabela5 <- uvozi.tabela5()



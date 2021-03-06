# 2. faza: Uvoz podatkov

#Tabela 1: Prebivalci Slovenije po udeleženosti na potovanjih po starosti
uvozi.tabela1 <- function(){
  stolpci1 <- c("STAROST", "VRSTA_POTOVANJA", "CETRTLETJE", "MERITEV")
  tabela1 <- read_csv2("podatki/STAROST.csv", 
                       locale = locale(encoding = "cp1250"), 
                       col_names=stolpci1,
                       skip = 2,
                       n_max = 455)
  tabela1 <- tabela1 %>% fill(1:2)
  tabela1 <- tabela1 %>% drop_na()
  tabela1 <- tabela1 %>% arrange(CETRTLETJE)
  tabela1 <- tabela1 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela1$MERITEV <- parse_number(tabela1$MERITEV)
  tabela1$LETO <- parse_integer(tabela1$LETO)
  tabela1$VRSTA_POTOVANJA <- gsub(".li na zasebno potovanje", "Sli na zasebno potovanje", tabela1$VRSTA_POTOVANJA)
  tabela1$VRSTA_POTOVANJA <- gsub(".li na turisti.no potovanje .zasebno in.ali poslovno.", "Sli na turisticno potovanje (zasebno in/ali poslovno)", tabela1$VRSTA_POTOVANJA)
  tabela1 <- tabela1[c(5,3,1,2,4)]
  return(tabela1)
}
tabela1 <- uvozi.tabela1()



#Tabela 2: Prebivalci Slovenije po udeleženosti na potovanjih po mesečnem dohodku
uvozi.tabela2 <- function(){
  stolpci2 <- c("DOHODKOVNI_RAZRED", "VRSTA_POTOVANJA", "CETRTLETJE", "MERITEV")
  tabela2 <- read_csv2("podatki/NETO_DOHODEK.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci2,
                       skip = 2,
                       n_max = 455, 
                       na=c(""," ", "-","N"))
  tabela2 <- tabela2 %>% fill(1:2)
  tabela2 <- tabela2 %>% drop_na()
  tabela2 <- tabela2 %>% arrange(CETRTLETJE)
  tabela2 <- tabela2 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela2$VRSTA_POTOVANJA <- gsub(".li na zasebno potovanje", "Sli na zasebno potovanje", tabela2$VRSTA_POTOVANJA)
  tabela2$VRSTA_POTOVANJA <- gsub(".li na turisti.no potovanje .zasebno in.ali poslovno.", "Sli na turisticno potovanje (zasebno in/ali poslovno)", tabela2$VRSTA_POTOVANJA)
  tabela2$MERITEV <- parse_number(tabela2$MERITEV)
  tabela2$LETO <- parse_integer(tabela2$LETO)
  tabela2 <- tabela2[c(5,3,1,2,4)]
  return(tabela2)
}
tabela2 <- uvozi.tabela2()



#Tabela 3: Zasebna potovanja po destinaciji in nastanitvenem objektu
uvozi.tabela3 <- function(){
  stolpci3 <- c("DESTINACIJA", "VRSTA_NASTANITVE", "VRSTA_MERITVE", "CETRTLETJE", "MERITEV")
  tabela3 <- read_csv2("podatki/NASTANITEV.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci3,
                       skip = 2,
                       n_max = 2174,
                       na=c(""," ", "-","N"))
  tabela3 <- tabela3 %>% fill(1:3)
  tabela3 <- tabela3 %>% drop_na()
  tabela3 <- tabela3 %>% arrange(CETRTLETJE)
  tabela3 <- tabela3 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela3$MERITEV <- tabela3$MERITEV %>% parse_number()
  tabela3$LETO <- tabela3$LETO %>% parse_integer()
  tabela3$VRSTA_NASTANITVE <- tabela3$VRSTA_NASTANITVE %>% parse_character()
  tabela3$VRSTA_NASTANITVE <- gsub("Hoteli in podobni objekti", "Hoteli", tabela3$VRSTA_NASTANITVE)
  tabela3$VRSTA_NASTANITVE <- gsub("Druge najete nastanitvene zmogljivosti", "Ostalo", tabela3$VRSTA_NASTANITVE)
  tabela3$VRSTA_NASTANITVE <- gsub("Pri sorodnikih ali prijateljih", "Pri znancih", tabela3$VRSTA_NASTANITVE)
  tabela3$VRSTA_NASTANITVE <- gsub("Druge nenajete nastanitvene zmogljivosti", "Ostalo", tabela3$VRSTA_NASTANITVE)
  tabela3$VRSTA_NASTANITVE <- gsub("Lastno po.itni.ko bivali..e", "Lastna \nbivalisca" , tabela3$VRSTA_NASTANITVE)
  tabela3$VRSTA_MERITVE <- gsub("Preno.itve .v 1000.", "Prenocitve (v 1000)", tabela3$VRSTA_MERITVE)
  tabela3$VRSTA_MERITVE <- gsub("Povpre.no .tevilo preno.itev", "Povprecno stevilo prenocitev", tabela3$VRSTA_MERITVE)
  tabela3$VRSTA_MERITVE <- gsub("Povpre.ni izdatki na turista na preno.itev .EUR.", "Povprecni izdatki na turista na prenocitev (EUR)", tabela3$VRSTA_MERITVE)
  tabela3 <- tabela3[c(6,4,1,2,3,5)]
  return(tabela3)
}
tabela3 <- uvozi.tabela3()

#Tabela3.1: Število zasebnih potovanj glede na nastanitveni objekt v 1000
tabela3.skupaj <- tabela3 %>% filter(VRSTA_MERITVE == "Potovanja (v 1000)")
tabela3.skupaj$VRSTA_MERITVE <- NULL

#Tabela3.2: Povprečni izdatki glede na turista na prenočitev v EUR glede na nastanitveni objekt
tabela3.povprecja.izdatki <- tabela3 %>% filter(VRSTA_MERITVE == "Povprecni izdatki na turista na prenocitev (EUR)")
tabela3.povprecja.izdatki$VRSTA_MERITVE <- NULL 
#tabela3.povprecja.prenocitve <- tabela3 %>% filter(VRSTA_MERITVE == "Povprecno stevilo prenocitev")

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
  tabela4 <- tabela4 %>% drop_na()
  tabela4 <- tabela4 %>% arrange(CETRTLETJE)
  tabela4 <- tabela4 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela4$MERITEV <- tabela4$MERITEV %>% parse_number()
  tabela4$LETO <- tabela4$LETO %>% parse_integer()
  tabela4$VRSTA_PREVOZA <- gsub("Osebno cestno motorno vozilo","Avto",tabela4$VRSTA_PREVOZA)
  tabela4$VRSTA_MERITVE <- gsub("Preno.itve .v 1000.", "Prenocitve (v 1000)", tabela4$VRSTA_MERITVE)
  tabela4$VRSTA_MERITVE <- gsub("Povpre.no .tevilo preno.itev", "Povprecno stevilo prenocitev", tabela4$VRSTA_MERITVE)
  tabela4$VRSTA_MERITVE <- gsub("Povpre.ni izdatki na turista na preno.itev .EUR.", "Povprecni izdatki na turista na prenocitev (EUR)", tabela4$VRSTA_MERITVE)
  tabela4 <- tabela4[c(6,4,1,2,3,5)]
  return(tabela4)
}
tabela4 <- uvozi.tabela4()

#Tabela4.1: Število potovanj glede na prevozno sredstvo v 1000
tabela4.skupaj <- tabela4 %>% filter(VRSTA_MERITVE == "Potovanja (v 1000)")
tabela4.skupaj$VRSTA_MERITVE <- NULL

#Tabela4.2: Povprečni izdatki glede na turista na prenočitev v EUR glede na prevozno sredstvo
tabela4.povprecja.izdatki <- tabela4 %>% filter(VRSTA_MERITVE == "Povprecni izdatki na turista na prenocitev (EUR)")
tabela4.povprecja.izdatki$VRSTA_MERITVE <- NULL



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
  tabela5$DRZAVA_POTOVANJA <- gsub("Hong Kong, China", "China", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Korea, Republic of","Republic of Korea", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Mauritius", "Mauritania", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Moldova, Republic of", "Moldova", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Tanzania, United Republic of", "Tanzania", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("The Former Yugoslav Republic of Macedonia", "Macedonia", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("United States of America", "United States", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Iran, Islamic Republic of", "Iran", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Macao, China", "China", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Venezuela, Bolivarian Republic of", "Venezuela", tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Dominica" , "Dominican Republic" , tabela5$DRZAVA_POTOVANJA)
  tabela5$DRZAVA_POTOVANJA <- gsub("Bolivia, Plurinational State of" , "Bolivia" , tabela5$DRZAVA_POTOVANJA)
  return(tabela5)
}

tabela5 <- uvozi.tabela5()

#Tabela 6: BDP Slovenije
uvozi.tabela6 <- function(){
  tabela6 <- readHTMLTable("podatki/BDP_Slovenija.html", which = 1, as.data.frame = TRUE)
  colnames(tabela6) <- c("DRZAVA", 2006:2017)
  tabela6 <- gather(tabela6, "2006","2007","2008","2009","2010","2011","2012","2013","2014","2015","2016","2017", key = "LETO", value = "BDP_v_milijonih")
  tabela6$LETO <- tabela6$LETO %>% parse_integer()
  tabela6$BDP_v_milijonih <- tabela6$BDP_v_milijonih %>% parse_number()
  tabela6 <- tabela6 %>% drop_na()
  tabela6 <- tabela6[c(2,1,3)]
  return(tabela6)
}

tabela6 <- uvozi.tabela6()


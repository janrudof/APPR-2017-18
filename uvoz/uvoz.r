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
  tabela1 <- tabela1 %>% mutate(LETO = CETRTLETJE %>% strapplyc("^([0-9]+)") %>%
                                  unlist() %>% parse_number(),
                                CETRTLETJE = CETRTLETJE %>% strapplyc("([0-9])$") %>%
                                  unlist() %>% parse_number())
  tabela1 <- tabela1[c(5,1,2,3,4)]
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
  return(tabela2)
}
tabela2 <- uvozi.tabela2()
View(tabela2)

#Tabela 3: Zasebna potovanja po destinaciji in nastanitvenem objektu
uvozi.tabela3 <- function(){
  stolpci3 <- c("DESTINACIJA", "VRSTA_NASTANITVE", "VRSTA_MERITVE", "CETRTLETJE", "MERITEV")
  tabela3 <- read_csv2("podatki/NASTANITEV.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci5,
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

#Tabela 5: Najbolj obiskane evrpske države in celine
uvozi.tabela5 <- function(){
  stolpci5 <- c("VRSTA_POTOVANJA", "DRZAVA_POTOVANJA", "VRSTA_MERITVE", "LETO", "MERITVE")
  tabela5 <- read_csv2("podatki/DRZAVA_POTOVANJA.csv",
                       locale = locale(encoding= "cp1250"),
                       col_names= stolpci5,
                       skip = 2,
                       n_max = 1054,
                       na = c("", " ", "-", "N"))
  tabela5 <- tabela5 %>% fill(1:4)
  tabela5 <- tabela5 %>% arrange(LETO)
  tabela5 <- tabela5 %>% drop_na(1:5)
  tabela5$MERITVE <- tabela5$MERITVE %>% parse_number()
  tabela5 <- tabela5[c(4,1,2,3,5)]
  return(tabela5)
}
tabela5 <- uvozi.tabela5()
View(tabela5)






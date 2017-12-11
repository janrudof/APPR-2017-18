# 2. faza: Uvoz podatkov

#Tabela 1: Prebivalci Slovenije po udeleženosti na potovanjih po starosti
uvozi.tabela1 <- function(){
  stolpci1 <- c("STAROST", "VRSTA POTOVANJA", "CETRTLETJE", "MERITEV")
  tabela1 <- read_csv2("STAROST.csv", 
                       locale = locale(encoding = "cp1250"), 
                       col_names=stolpci1,
                       skip = 2,
                       n_max = 455)
  tabela1 <- tabela1[c(3,1,2,4)]
  tabela1 <- tabela1 %>% fill(2:3)
  tabela1 <- tabela1[-c(1,2,47,92,93,138,183,184,229,274,275,320,365,366,411), ]
}
tabela1 <- uvozi.tabela1()
View(tabela1)

#Tabela 2: Prebivalci Slovenije po udeleženosti na potovanjih po mesečnem dohodku
uvozi.tabela2 <- function(){
  stolpci2 <- c("DOHODKOVNI RAZRED", "VRSTA POTOVANJA", "CETRTLETJE", "MERITVE")
  tabela2 <- read_csv2("NETO DOHODEK.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci2,
                       skip = 2,
                       n_max = 455)
  tabela2 <- tabela2[c(3,1,2,4)]
  tabela2 <- tabela2 %>% fill(2:3)
  tabela2 <- tabela2[-c(1,2,47,92,93,138,183,184,229,274,275,320,365,366,411), ]
}
tabela2 <- uvozi.tabela2()
View(tabela2)

#Tabela 5: Zasebna potovanja po destinaciji in nastanitvenem objektu
uvozi.tabela5 <- function(){
  stolpci5 <- c("DESTINACIJA", "VRSTA NASTANITVE", "VRSTA MERITVE", "CETRTLETJE", "MERITEV")
  tabela5 <- read_csv2("NASTANITEV.csv",
                       locale = locale(encoding = "cp1250"),
                       col_names = stolpci5,
                       skip = 2,
                       n_max = 1094,
                       na=c(""," ", "-","N"))
  tabela5 <- tabela5 %>% fill(1:3)
  tabela5 <- tabela5[c(4,1,2,3,5)]
}
tabela5 <- uvozi.tabela5()
View(tabela5)





#Pomoč s primerom:

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

# Funkcija, ki uvozi občine iz Wikipedije
uvozi.obcine <- function() {
  link <- "http://sl.wikipedia.org/wiki/Seznam_ob%C4%8Din_v_Sloveniji"
  stran <- html_session(link) %>% read_html()
  tabela <- stran %>% html_nodes(xpath="//table[@class='wikitable sortable']") %>%
    .[[1]] %>% html_table(dec = ",")
  for (i in 1:ncol(tabela)) {
    if (is.character(tabela[[i]])) {
      Encoding(tabela[[i]]) <- "UTF-8"
    }
  }
  colnames(tabela) <- c("obcina", "povrsina", "prebivalci", "gostota", "naselja",
                        "ustanovitev", "pokrajina", "regija", "odcepitev")
  tabela$obcina <- gsub("Slovenskih", "Slov.", tabela$obcina)
  tabela$obcina[tabela$obcina == "Kanal ob Soči"] <- "Kanal"
  tabela$obcina[tabela$obcina == "Loški potok"] <- "Loški Potok"
  for (col in c("povrsina", "prebivalci", "gostota", "naselja", "ustanovitev")) {
    tabela[[col]] <- parse_number(tabela[[col]], na = "-", locale = sl)
  }
  for (col in c("obcina", "pokrajina", "regija")) {
    tabela[[col]] <- factor(tabela[[col]])
  }
  return(tabela)
}

# Funkcija, ki uvozi podatke iz datoteke druzine.csv
uvozi.druzine <- function(obcine) {
  data <- read_csv2("podatki/druzine.csv", col_names = c("obcina", 1:4),
                    locale = locale(encoding = "Windows-1250"))
  data$obcina <- data$obcina %>% strapplyc("^([^/]*)") %>% unlist() %>%
    strapplyc("([^ ]+)") %>% sapply(paste, collapse = " ") %>% unlist()
  data$obcina[data$obcina == "Sveti Jurij"] <- "Sveti Jurij ob Ščavnici"
  data <- data %>% melt(id.vars = "obcina", variable.name = "velikost.druzine",
                        value.name = "stevilo.druzin")
  data$velikost.druzine <- parse_number(data$velikost.druzine)
  data$obcina <- factor(data$obcina, levels = obcine)
  return(data)
}

# Zapišimo podatke v razpredelnico obcine
obcine <- uvozi.obcine()

# Zapišimo podatke v razpredelnico druzine.
druzine <- uvozi.druzine(levels(obcine$obcina))

# Če bi imeli več funkcij za uvoz in nekaterih npr. še ne bi
# potrebovali v 3. fazi, bi bilo smiselno funkcije dati v svojo
# datoteko, tukaj pa bi klicali tiste, ki jih potrebujemo v
# 2. fazi. Seveda bi morali ustrezno datoteko uvoziti v prihodnjih
# fazah.

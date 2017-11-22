# Analiza podatkov s programom R, 2017/18

Avtor: Jan Rudof

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza potovanj Slovencev

Pri projektu bom analiziral potovanja Slovencev v letih 2006 do 2016. Osredotočil se bom na glavne faktorje, kot so: število ljudi, ki se odloči za potovanje, finance namenjene potovanju 
in struktura izdatkov, število dni potovanja, odločitev za potovanje glede na neto dohodek, odločitev za potovanje glede na starost, nastanitev ter vrsto potovanja. 
Zanimala me bo predvsem razlika v strukturi potovanj v predkriznem, kriznem in v današnjem času.

### Zasnova tabel

#### Tabela 1: Prebivalci Slovenije po udeleženosti na potovanjih po starosti (v 1000)
Stolpci: leto, vrsta potovanja(zasebno/poslovna), starost-skupaj, 12-24, 25-44, 45-64, 65+
#### Tabela 2: Prebivalci Slovenije po udeleženosti na potovanjih po mesečnem neto dohodku (v 1000)
Stolpci: leto,vrsta potovanja(zasebna/poslovna), skupaj, 1.kvartil, 2.kvartil, 3.kvartil, 4.kvartil, ni znano
#### Tabela 3: Struktura izdatkov prebivalcev Slovenije na potovanjih (izdatki so dani kot povprečni izdatki na turista na prenočitev (EUR))
Stolpci: leto, vrsta potovanja(zasebno/poslovno), destinacija(Slovenija/tujina), izdatki-skupaj, izdatki za prevoz, izdatki za nastanitev, izdatki za hrano in pijačo, izdatki za druge aktivnosti
#### Tabela 4: Zasebna potovanja po državi potovanja
Stolpci: leto, država, BDP države, BDP države per capita, potovanja(v 1000), prenočitve(v 1000), povprečno število prenočitev
#### Tabela 5: Zasebna potovanja po destinaciji in nastanitvenem objektu
Stolpci: leto, destinacija(Slovenija/tujina), nastavitveni objekt, potovanja(v 1000), prenočitve(v 1000), povprečni izdatki na turista na prenočitev(EUR)



### Viri podatkov

- http://pxweb.stat.si/pxweb/Database/Ekonomsko/21_gostinstvo_turizem/06_potovanja/10_21698_udelezenost_letno/10_21698_udelezenost_letno.asp (CSV)
- http://pxweb.stat.si/pxweb/Database/Ekonomsko/21_gostinstvo_turizem/06_potovanja/20_21700_razlogi_neodhod_letno/20_21700_razlogi_neodhod_letno.asp (CSV)
- http://pxweb.stat.si/pxweb/Database/Ekonomsko/21_gostinstvo_turizem/06_potovanja/30_21702_znacilnosti_letno/30_21702_znacilnosti_letno.asp (CSV)
- https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal)_per_capita (HTML)
- https://en.wikipedia.org/wiki/List_of_countries_by_GDP_(nominal) (HTML)


## Program

Glavni program in poročilo se nahajata v datoteki `projekt.Rmd`. Ko ga prevedemo,
se izvedejo programi, ki ustrezajo drugi, tretji in četrti fazi projekta:

* obdelava, uvoz in čiščenje podatkov: `uvoz/uvoz.r`
* analiza in vizualizacija podatkov: `vizualizacija/vizualizacija.r`
* napredna analiza podatkov: `analiza/analiza.r`

Vnaprej pripravljene funkcije se nahajajo v datotekah v mapi `lib/`. Podatkovni
viri so v mapi `podatki/`. Zemljevidi v obliki SHP, ki jih program pobere, se
shranijo v mapo `../zemljevidi/` (torej izven mape projekta).

## Potrebni paketi za R

Za zagon tega vzorca je potrebno namestiti sledeče pakete za R:

* `knitr` - za izdelovanje poročila
* `rmarkdown` - za prevajanje poročila v obliki RMarkdown
* `shiny` - za prikaz spletnega vmesnika
* `DT` - za prikaz interaktivne tabele
* `maptools` - za uvoz zemljevidov
* `sp` - za delo z zemljevidi
* `digest` - za zgoščevalne funkcije (uporabljajo se za shranjevanje zemljevidov)
* `readr` - za branje podatkov
* `rvest` - za pobiranje spletnih strani
* `reshape2` - za preoblikovanje podatkov v obliko *tidy data*
* `dplyr` - za delo s podatki
* `gsubfn` - za delo z nizi (čiščenje podatkov)
* `ggplot2` - za izrisovanje grafov
* `extrafont` - za pravilen prikaz šumnikov (neobvezno)

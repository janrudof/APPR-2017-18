# Analiza podatkov s programom R, 2017/18

Avtor: Jan Rudof

Repozitorij z gradivi pri predmetu APPR v študijskem letu 2017/18

## Analiza potovanj prebivalcev Slovenije

Pri projektu bom analiziral potovanja Slovencev v letih 2006 do 2016. Osredotočil se bom na glavne faktorje, kot so: število ljudi, ki se odloči za potovanje, finance namenjene potovanju in struktura izdatkov, odločitev za potovanje glede na neto dohodek, odločitev za potovanje glede na starost, nastanitev ter vrsto potovanja. Zanimala me bo predvsem razlika v strukturi potovanj v predkriznem, kriznem in v današnjem (lahko rečem pokriznem) času, prav tako pa bom skušal napovedati trende za prihodnost. 

### Zasnova tabel

#### Tabela 1: Prebivalci Slovenije po udeleženosti na potovanjih po starosti
Stolpci: LETO, ČETRTLETJE, STAROST, VRSTA POTOVANJA, MERITEV

#### Tabela 2: Prebivalci Slovenije po udeleženosti na potovanjih po mesečnem neto dohodku
Stolpci: LETO, ČETRTLETJE, DOHODKOVNI RAZRED, VRSTA POTOVANJA, MERITEV

#### Tabela 3: Struktura izdatkov prebivalcev Slovenije na potovanjih 
Stolpci: LETO, ČETRTLETJE, DESTINACIJA, VRSTA NASTANITVE, VRSTA MERITVE, MERITEV

#### Tabela 4: Zasebna potovanja po državi potovanja
Stolpci: LETO, ČETRTLETJE, DESTINACIJA, VRSTA PREVOZA, VRSTA MERITVE, MERITEV

#### Tabela 5: Zasebna potovanja po destinaciji in nastanitvenem objektu
Stolpci: LETO, DRŽAVA POTOVANJA, KRATICA, ŠTEVILO POTOVANJ

#### Tabela 6: BDP Slovenije
Stolpci: LETO, DRŽAVA, BDP

### Viri podatkov

Vsi podatkovni viri so v mapi [podatki](https://github.com/janrudof/APPR-2017-18/tree/master/podatki).

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

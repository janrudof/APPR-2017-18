# 3. faza: Vizualizacija podatkov

# ZEMLJEVIDI

zemljevid.sveta <- uvozi.zemljevid("http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_countries.zip",
                                   "ne_110m_admin_0_countries", encoding= "UTF-8") 
zemljevid.tabela <- pretvori.zemljevid(zemljevid.sveta)

#plot(zemljevid.sveta, main="Svet", xlab="Longitude", ylab="Latitude",xlim=c(-20,200), ylim=c(-50,100))


#GRAFI




## Trabajo Bioestadística con R 

install.packages("R2HTML",dep=TRUE)
install.packages("car",dep=TRUE)
install.packages("e1071",dep=TRUE)
install.packages("Hmisc",dep=TRUE)
install.packages("ez",dep=TRUE)
install.packages("plyr",dep=TRUE)
install.packages("ggplot2",dep=TRUE)
install.packages("prob",dep=TRUE)
install.packages("devtools",dep=TRUE)
library(devtools)
install_github("asalber/rkTeaching_es")

# Proyecto - Capitulo 3
setwd("/Users/Diego/Downloads/rkTeaching_es-master/data")
list.files()
load("hipertension.RData")
colnames(hipertension)
# 1
cortes <- seq(from=25, to=65, by=10)
intervalos <- cut(hipertension$EDAD, breaks=cortes)
table(intervalos)

#2
boxplot(hipertension$PAD_INI, hipertension$PAD_FIN, hipertension$PAS_INI, hipertension$PAS_FIN)
# mayor dispersión en PAS_FIN
# atipicos en PAD_INI & PAS_INI

#3
pas_ini_si <- subset(hipertension, hipertension$TAB_INI=="si")
pas_ini_no <- subset(hipertension, hipertension$TAB_INI=="no")
hist(pas_ini_si$PAS_INI, ylim=c(0,20), xlim=c(90,210), col='red')
par(new=TRUE)
hist(pas_ini_no$PAS_INI, ylim=c(0,20), xlim=c(90,210), col='green')
# las presiones arteriales son mayores en el grupo de fumadores

#4
PAD_EVOLUCION <- hipertension$PAD_FIN-hipertension$PAD_INI
PAS_EVOLUCION <- hipertension$PAS_FIN-hipertension$PAS_INI
boxplot(PAD_EVOLUCION, PAS_EVOLUCION)

#5
PAS <- cbind(PAS_EVOLUCION, hipertension$FARMACO)
colnames(PAS) <- c("EVOLUCION", "FARMACO")
PAS_Plac <- subset(PAS, PAS[,2]==1)
PAS_IECA <- subset(PAS, PAS[,2]==2)
PAS_Anta <- subset(PAS, PAS[,2]==3)
mean(PAS_Plac)
sd(PAS_Plac)
sd(PAS_Plac)/abs(mean(PAS_Plac))

mean(PAS_IECA)
sd(PAS_IECA)
sd(PAS_IECA)/abs(mean(PAS_IECA))

mean(PAS_Anta)
sd(PAS_Anta)
sd(PAS_Anta)/abs(mean(PAS_Anta))

# En promedio disminuye más con el tratamiento de Placebo
# En el grupo de Placebo
# 




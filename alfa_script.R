##########################################
#####     Algoritmo de seleccion     #####
##########################################

install.packages('aod', dependencies = TRUE)
ls("package:aod")
library(dplyr)
library(aod)

mydata <- mtcars 
# read.csv("http://www.ats.ucla.edu/stat/data/binary.csv")
head(mydata)

summary(mydata)

alfa <- function(var, datos){
    library(dplyr)
    pos <- which(colnames(datos)!=var)
    var <- which(colnames(datos)==var)
    tab <- c()
    res <- sapply(pos, function(i){
        glm(datos[[var]] ~ datos[[i]], data=datos, family="binomial")$aic})
    tab <- tbl_df(data.frame(variable=colnames(datos)[pos], aic=res)) %>% arrange(desc(aic))
    return(tab)
}

alfa("vs", mydata)

library(foreign)
ls("package")



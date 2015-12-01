##########################################
#####     Algoritmo de seleccion     #####
##########################################

install.packages('aod', dependencies = TRUE)
ls("package:aod")
library(dplyr)
library(aod)

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
library(dplyr)
ls("package:foreign")

info <- tbl_df(read.spss("data_modelo.sav", to.data.frame = TRUE))
info <- info %>% filter(VAR_DEP %in% c("BUENO", "MALO"))
info <- info %>% mutate(VAR=ifelse(VAR_DEP=="BUENO",0,1))

vec <- as.vector(which(unlist(lapply(info, class))=="numeric"))

vec2 <- sapply(vec, function(i){
    min(info[[i]])==max(info[[i]])
})

vec2 <- vec[!vec2]
vec3 <- vec2[!is.na(vec2)]

info1 <- info %>% select(vec3)

resul <- alfa("VAR", info1)

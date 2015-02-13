### Curso - R Avanzado ###

list.files()

# -> data.table nueva estructura de datos

install.packages('data.table', dependencies=TRUE)
library('data.table')
ls("package:data.table")

d0 <- data.frame(A=1:26, B=101:126, C=letters)
d01 <- data.table(d0)
class(d01)
str(d01) # las librer??as de data.frame trabajan sin problema con data.table

d01[suma:=A+B]
d01[C==c("m","n")]
d01[suma>=150 & C=="z"]
d01[suma>=150 | C=="z"]

library(devtools)
install_github("hadley/haven")
install_github("wrathematics/Rdym")
install_github("robjhyndman/MEFM-package")
install_github("opencpu/gitstats")
install_github("opencpu/stocks")
install_github("agstudy/rsqlserver, args='--no-multiarch")

pckgs <- c('data.table', 'sqldf', 'dplyr', 'plyr', 'stringr', 'ggplot2', 'reshape2')
pckg <- c('tseries', 'TTR', 'quantmod')
lapply(seq_along(pckg), function(i){install.packages(pckg[[i]], dependencies=TRUE)})
lapply(pckgs, FUN=library, character.only=TRUE)


# Cargar datos
read.csv(file="poblacion.csv", header=TRUE)
m01 <- fread("enero.txt")
m02 <- fread("febrero.txt")
p01 <- fread("productos.txt")

# data.table

m01[,.N,by=OFICINA]
m01[,.N,by=SEGMENTO]
m01[,.N,by=PRODUCTO]

m01[,.(SUMA = sum(SALDO)), by=OFICINA]
m01[,.(SUMA = sum(SALDO)), by=SEGMENTO]
m01[,.(SUMA = sum(SALDO)), by=PRODUCTO]

setkey(m01, IDENTIFICACION)
setkey(m02, IDENTIFICACION)
tables()
m03 <- m01[m02]
colnames(m01)
dim(m01)


# sql
library(sqldf)
sqldf("SELECT OFICINA, COUNT(*) from m01 GROUP BY OFICINA")
#sqldf("SELECT OFICINA, COUNT(*) from m01 WHERE OFICINA LIKE 'CENTRO' GROUP BY OFICINA")
#sqldf("SELECT OFICINA, COUNT(*) from m01 WHERE OFICINA IN ('CENTRO','SUR') GROUP BY OFICINA")
#sqldf("SELECT OFICINA, COUNT(*) from m01 WHERE OFICINA NOT IN ('CENTRO','SUR') GROUP BY OFICINA")
#sqldf("SELECT OFICINA, COUNT(*) AS FRQ from m01 WHERE OFICINA IN ('CENTRO','SUR') GROUP BY OFICINA ORDER BY FRQ")
sqldf("SELECT SEGMENTO, COUNT(*) AS FRQ from m01 GROUP BY SEGMENTO")
sqldf("SELECT PRODUCTO, COUNT(*) AS FRQ from m01 GROUP BY PRODUCTO")

sqldf("SELECT OFICINA, SUM(SALDO) AS SUMA from m01 GROUP BY OFICINA")
sqldf("SELECT SEGMENTO, SUM(SALDO) AS SUMA from m01 GROUP BY SEGMENTO")
sqldf("SELECT PRODUCTO, SUM(SALDO) AS SUMA from m01 GROUP BY PRODUCTO")

sqldf("SELECT m01.SALDO - m02.SALDO AS DIFF
      from m01 INNER JOIN m02 ON m01.IDENTIFICACION = m02.IDENTIFICACION")

sqldf("SELECT m01.PRODUCTO, m01.SALDO - m02.SALDO AS DIFF
      from m01 INNER JOIN m02 ON m01.IDENTIFICACION = m02.IDENTIFICACION
      GROUP BY m01.PRODUCTO")








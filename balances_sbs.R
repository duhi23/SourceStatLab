
## Descargar archivos desde internet

library(RCurl)
library(XML)


balance_sbs <- function(cod_inst, cod_mes, cod_anio){
    base_url <- paste('http://www.sbs.gob.ec/practg/pk_cons_bdd.p_bal_entdd_finnc?vp_cod_tip_instt=3&vp_cod_instt=',
                      cod_inst,'&vp_anio=', cod_anio, '&vp_mes=', cod_mes, '&vp_cod_tip_catlg=14')
    table_url <- readHTMLTable(base_url)
    tbl_sbs <- table_url[[3]]
    inst <- as.character(tbl_sbs$V2[1])
    fec <- as.character(tbl_sbs$V2[2])
    cat(paste('Usted ha consultado el balance de: ', inst, ' a la fecha ', fec))
    tbl <- data.frame(CODIGO=as.double(as.character(tbl_sbs$V1[-c(1:3)])),
                      CUENTA=as.character(tbl_sbs$V2[-c(1:3)]),
                      SALDO=as.character(tbl_sbs$V3[-c(1:3)]))
    return(tbl)
}

blc_0114 <- balance_sbs(1028,01,2014)
blc_0214 <- balance_sbs(1028,02,2014)
blc_0314 <- balance_sbs(1028,03,2014)



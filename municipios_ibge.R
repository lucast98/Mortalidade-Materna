data_cidades <- read.csv('C:/Users/lucas/Downloads/PIPAE/codigos_municipios.csv', sep=";", encoding = "UTF-8")

data_mortalidade_materna2 <- data_mortalidade_materna[!is.na(data_mortalidade_materna$id_municipio_ocorrencia),]

data_mortalidade_materna2 <- data_mortalidade_materna2[!is.na(data_mortalidade_materna2$id_municipio_residencia),]

data_mortalidade_materna2[,'municipio_ocorrencia'] = NA
data_mortalidade_materna2[,'municipio_residencia'] = NA
for (j in 1:5570) {
  print(j)
  for (i in 1:23515) {
    if(data_mortalidade_materna2$id_municipio_ocorrencia[i] == data_cidades$X.U.FEFF.Código.Município.Completo[j]){
      data_mortalidade_materna2$municipio_ocorrencia[i] <- data_cidades$Nome_Município[j]
    }
    if(data_mortalidade_materna2$id_municipio_residencia[i] == data_cidades$X.U.FEFF.Código.Município.Completo[j]){
      data_mortalidade_materna2$municipio_residencia[i] <- data_cidades$Nome_Município[j]
    }
  }
}

con<-file('data_mortalidade_materna.csv',encoding="UTF-8")
write.csv(data_mortalidade_materna2, file=con, row.names = FALSE)
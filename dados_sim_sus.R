install.packages("basedosdados")
library("basedosdados")

# Defina o seu projeto no Google Cloud
set_billing_id("basedosdados-343422")

# Para carregar o dado direto no R
query <- bdplyr("br_ms_sim.dicionario")
df <- bd_collect(query)

path <- file.path(tempdir(), "mortalidade_materna2.csv")
bare_query <- "SELECT ano, sigla_uf, 
case tipo_obito 
when '1' then 'Fetal'
else 'Nao-Fetal' 
end as tipo_obito, 
data_obito, data_nascimento, 
case raca_cor
when '0' then ''
when '1' then 'Branca'
when '2' then 'Preta'
when '3' then 'Amarela'
when '4' then 'Parda'
when '5' then 'Ind?gena'
else null
end as raca_cor,
case estado_civil
when '1' then 'Solteiro(a)'
when '2' then 'Casado(a)'
when '3' then 'Vi?vo(a)'
when '4' then 'Separado(a)'
when '5' then 'Uni?o consensual'
else null
end as estado_civil,
case escolaridade
when '1' then 'Nenhuma'
when '2' then '1 a 3 anos'
when '3' then '4 a 7 anos'
when '4' then '8 a 11 anos'
when '5' then '12 anos ou mais'
when '8' then '9 a 11 anos'
else null
end as escolaridade,
id_municipio_residencia, 
case local_ocorrencia
when '1' then 'Hospital'
when '2' then 'Outro estabelecimento de sa?de'
when '3' then 'Domic?lio'
when '4' then 'Via p?blica'
when '5' then 'Outros'
else null
end as local_ocorrencia,
id_municipio_ocorrencia, 
case gravidez
when '1' then '?nica'
when '2' then 'Dupla'
when '3' then 'Tripla ou mais'
else null
end as gravidez,
case gestacao
when '1' then 'Menos de 22 semanas'
when '2' then '22 a 27 semanas'
when '3' then '28 a 31 semanas'
when '4' then '32 a 36 semanas'
when '5' then '37 a 41 semanas'
when '6' then '42 semanas ou mais'
when '7' then '28 semanas ou mais'
when '8' then '28 a 36 semanas'
when 'A' then '21 a 27 semanas'
else null
end as gestacao,
case parto
when '1' then 'Vaginal'
when '2' then 'Ces?reo'
else null
end as parto,
case obito_parto 
when '1' then 'Antes'
when '2' then 'Durante'
when '3' then 'Depois'
else null
end as obito_parto,
case morte_parto 
when '1' then 'Antes'
when '2' then 'Durante'
when '3' then 'Depois'
else null
end as morte_parto,
case obito_gravidez
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as obito_gravidez,
case obito_puerperio
when '1' then '0 a 42 dias'
when '2' then '43 dias a 1 ano'
when '3' then 'N?o'
else null
end as obito_puerperio,
case assistencia_medica
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as assistencia_medica, 
case exame 
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as exame, 
case cirurgia
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as cirurgia,
case necropsia
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as necropsia,
case circunstancia_obito
when '1' then 'Acidente'
when '2' then 'Suic?dio'
when '3' then 'Homic?dio'
when '4' then 'Outro'
else null
end as circunstancia_obito,
case acidente_trabalho
when '1' then 'Sim'
when '2' then 'N?o'
else null
end as acidente_trabalho,
case fonte
when '1' then 'Boletim de ocorr?ncia'
when '2' then 'Hospital'
when '3' then 'Fam?lia'
when '4' then 'Outro'
else null
end as fonte,
case atestante
when '1' then 'Sim'
when '2' then 'Substituto'
when '3' then 'IML'
when '4' then 'SVO'
when '5' then 'Outro'
else null
end as atestante,
data_atestado,
case tipo_pos
when 'N' then 'N?o'
when 'S' then 'Sim'
else null
end as tipo_pos,
case fonte_investigacao
when '1' then 'Comit? de mortalidade materna e/ou infantil'
when '2' then 'Visita familiar / entrevista fam?lia'
when '3' then 'Estabelecimento de sa?de / prontu?rio'
when '4' then 'Relacionamento com outros bancos de dados'
when '5' then 'SVO'
when '6' then 'IML'
when '7' then 'Outra fonte'
when '8' then 'M?ltiplas fontes'
else null
end as fonte_investigacao,
case tipo_obito_ocorrencia
when '1' then 'Durante a gesta??o'
when '2' then 'Durante o abortamento'
when '3' then 'Ap?s abortamento'
when '4' then 'No parto ou at? 1 hora ap?s o parto'
when '5' then 'No puerp?rio (at? 42 dias do t?rmino da gesta??o)'
when '6' then 'Entre o 43? dia e at? um ano ap?s o t?rmino da gesta??o'
when '7' then 'Investiga??o nao identificou o momento do ?bito'
when '8' then 'Mais de 1 ano ap?s o parto'
when '9' then 'Outras'
else null
end as tipo_obito_ocorrencia,
case tipo_morte_ocorrencia
when '1' then 'Na gravidez'
when '2' then 'No parto'
when '3' then 'No aborto'
when '4' then 'At? 42 dias ap?s o parto'
when '5' then 'De 43 dias at? 1 ano ap?s o parto'
when '8' then 'N?o ocorreu nestes per?odos'
else null
end as tipo_morte_ocorrencia,
causa_materna, 
case status_do_epidem
when '0' then 'N?o'
when '1' then 'Sim'
else null
end as status_do_epidem,
case status_do_nova
when '0' then 'N?o'
when '1' then 'Sim'
else null
end as status_do_nova,
semanas_gestacao,
case status_codificadora
when '0' then 'N?o'
when '1' then 'Sim'
else null
end as status_codificadora,
case codificado
when 'N' then 'N?o'
when 'S' then 'Sim'
else null
end as codificado,
case tipo_resgate_informacao
when '1' then 'N?o acrescentou nem corrigiu informa??o'
when '2' then 'Sim, permitiu o resgate de novas informa??es'
when '3' then 'Sim, permitiu a corre??o de alguma das causas informadas originalmente'
else null
end as tipo_resgate_informacao,
case tipo_nivel_investigador
when 'E' then 'Estadual'
when 'R' then 'Regional'
when 'M' then 'Municipal'
else null
end as tipo_nivel_investigador
FROM `basedosdados.br_ms_sim.microdados`
where sexo = '2';"
download(query = bare_query, path = path)
# or download the entire table

data <- read.csv(
  file = 'C:/Users/lucas/Downloads/PIPAE/mortalidade_materna.csv',
  encoding="UTF-8")
head(data)

data_mortalidade_materna <- data[
    data$tipo_obito_ocorrencia %in% c('Durante a gesta??o', 'Durante o abortamento', 
                                      'Ap?s abortamento',
                                      'No parto ou at? 1 hora ap?s o parto',
                                      'No puerp?rio (at? 42 dias do t?rmino da gesta??o)') | 
    data$tipo_morte_ocorrencia %in% c('Na gravidez', 'No parto', 'No aborto',
                                      'At? 42 dias ap?s o parto'), ]

unique(data$obito_parto)


#########################

unique(data$tipo_morte_ocorrencia)
data2 <- data[, c("raca_cor", "tipo_morte_ocorrencia")] 

library(mltools)
library(data.table)

data2$tipo_morte_ocorrencia <- as.factor(data2$tipo_morte_ocorrencia)
tipo_morte_onehot <- one_hot(as.data.table(data2$tipo_morte_ocorrencia))

data2$raca_cor <- as.factor(data2$raca_cor)
raca_cor_onehot <- one_hot(as.data.table(data2$raca_cor))



library(config)
library(ggplot2)
library(tikzDevice)

# BUSCA DO ARQUIVO DE CONFIGURAÇÃO MAIS ATUAL
str1 = "config"
str3 = ".yml"
for (i in 1:10) {
  str2.try = i
  str.try = paste(str1,str2.try,str3,sep="")
  if (file.exists(str.try)) {
    str = str.try
    cat(str)
  }
#  else {
#    break
#  }
}

config <- config::get(file = str)

planejado <- config$planejado
realizado <- config$realizado
esforcos <- config$esforcos

l.planejado <- length(planejado)
l.realizado <- length(realizado)
l.esforcos <- length(esforcos)

if (sum(esforcos) != 1) {
  cat("MENSAGEM DE ERRO: A SOMA DO VETOR DE esforcos DEVE SER IGUAL A 1")
}

if (l.realizado + l.esforcos != l.planejado) {
  cat("MENSAGEM DE ERRO: A SOMA DO TAMANHO VETOR realizado COM O VETOR esforcos DEVE SER IGUAL AO TAMANHO DO
      VETOR planejado. RECONFIGURE O ARQUIVO config.yml")
}

concluido <- tail(realizado, n = 1)
falta <- 100 - concluido
estimado <- esforcos * falta
estimado <- cumsum(estimado)
estimado <- estimado + concluido

x.planejado <- 0 : (l.planejado - 1)
x.realizado <- 0 : (l.realizado - 1)
x.estimado <- l.realizado : (l.planejado - 1)

eficiencia.realizada <- realizado * 100/ planejado[0 : (l.realizado)]
eficiencia.estimada <- estimado * 100/ planejado[(l.realizado + 1) :l.planejado]

df.planejado <- data.frame(x = x.planejado, y = planejado)
df.realizado <- data.frame(x = x.realizado, y = realizado)
df.estimado <- data.frame(x = x.estimado, y = estimado)
df.eficiencia.realizada <- data.frame(x = x.realizado , y = eficiencia.realizada)
df.eficiencia.estimada <- data.frame(x = x.estimado , y = eficiencia.estimada)

colors <- c("Planejado" = "blue", "Realizado" = "green","Estimado" = "seagreen4")
fills <- c("Eficiencia Realizada"="gray40","Eficiencia Estimada"="gray75")

a <- ggplot() +
  geom_bar(data = df.eficiencia.realizada, aes(x = x, y = y, fill="Eficiencia Realizada"),stat="identity") +
  geom_bar(data = df.eficiencia.estimada, aes(x = x, y = y, fill="Eficiencia Estimada"),stat="identity") +
  geom_line(data = df.estimado, aes(x = x, y = y, color = "Estimado"),stat="identity", size = 1.5) +
  geom_line(data = df.realizado, aes(x = x, y = y, color = "Realizado"),stat="identity", size = 1.5) +
  geom_line(data = df.planejado, aes(x = x, y = y, color = "Planejado"),stat="identity", size = 1.5) +
    xlab("Data") + ylab("Porcentagem") + labs(title="Acompanhamento do Projeto") + labs(color="Legenda") +
  scale_color_manual(values = colors) + theme(plot.title = element_text(size=18)) +
  theme(plot.title = element_text(hjust = 0.5)) + labs(fill = "Eficiencia") + scale_fill_manual(values = fills)
a

#a <- a + xlab("Data") + ylab("Porcentagem") + labs(title="Acompanhamento do Projeto") + labs(color="Legenda") +
#  scale_color_manual(values = colors) + labs(fill = "Eficiencia") + scale_fill_manual(values = fills) +
#  scale_x_continuous(labels = datas, breaks = 0:meses)  +
#  theme(plot.title = element_text(hjust = 0.5)) + theme(plot.title = element_text(size=18))
# a

#ggsave("./output/graph.png", width = 10, height = 10)
# tikz('./output/graph.tex', width = 10, height = 10)
#a
#dev.off()

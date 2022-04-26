library(config)
library(ggplot2)
library(tikzDevice)

config <- config::get()

meses = config$meses
planejado = config$planejado
replanejado = config$replanejado
realizado = config$realizado
estimado = config$estimado
datas = config$datas

l.planejado <- length(planejado)
l.replanejado <- length(replanejado)
l.realizado <- length(realizado)
l.estimado <- length(estimado)

d <- l.planejado + l.replanejado - meses - 1
plan <- c(planejado,replanejado[(1 + d) : l.replanejado])
d2 <- l.realizado + l.estimado - meses - 1
exec <- c(realizado,estimado[(1 + d2) : l.estimado])
eficiencias <- exec * 100 / plan
eficiencia.realizada <- eficiencias[2:l.realizado]
eficiencia.estimada <- eficiencias[(l.realizado + 1):(meses+1)]
join <- c(eficiencias,planejado,replanejado,realizado,estimado)
max.join <- max(join[2:length(join)])

x.planejado <- 0 : (l.planejado - 1)
x.replanejado <- (meses - l.replanejado + 1) : meses
x.realizado <- 0 : (l.realizado - 1)
x.estimado <- (meses - l.estimado + 1)  : meses

df.planejado <- data.frame(x = x.planejado, y = planejado)
df.replanejado <- data.frame(x = x.replanejado, y = replanejado)
df.realizado <- data.frame(x = x.realizado, y = realizado)
df.estimado <- data.frame(x = x.estimado, y = estimado)
df.eficiencia.realizada <- data.frame(x = 1:(l.realizado-1) , y = eficiencia.realizada)
df.eficiencia.estimada <- data.frame(x = l.realizado:meses , y = eficiencia.estimada)

colors <- c("Planejado" = "blue", "Replanejado" = "dodgerblue4", "Realizado" = "green","Estimado" = "seagreen4")
fills <- c("Eficiência Realizada"="gray75","Eficiência Estimada"="gray40")

a <- ggplot() +
  geom_bar(data = df.eficiencia.realizada, aes(x = x, y = y, fill="Eficiência Realizada"),stat="identity") +
  geom_bar(data = df.eficiencia.estimada, aes(x = x, y = y, fill="Eficiência Estimada"),stat="identity") +
  geom_line(data = df.estimado, aes(x = x, y = y, color = "Estimado"),stat="identity", size = 1.5) +
  geom_line(data = df.realizado, aes(x = x, y = y, color = "Realizado"),stat="identity", size = 1.5) +
  geom_line(data = df.planejado, aes(x = x, y = y, color = "Planejado"),stat="identity", size = 1.5) +
  geom_line(data = df.replanejado, aes(x = x, y = y, color = "Replanejado"),stat="identity", size = 1.5)

a <- a + xlab("Data") + ylab("Porcentagem") + labs(title="Acompanhamento do Projeto") + labs(color="Legenda") +
  scale_color_manual(values = colors) + labs(fill = "Eficiência") + scale_fill_manual(values = fills) +
  scale_x_continuous(labels = datas, breaks = 0:meses) + scale_y_continuous(breaks = seq(0,max.join+10, by=10))
a 

tikz('./resources/graph.tex')
a
dev.off()

library(config, warn.conflicts = FALSE)
library(ggplot2)
library(tikzDevice)

# Generate a .pdf of the graph
pdf(file="./output/Rplots.pdf")

# Search the most recent config file
files = list.files("./")
max = 0
for (i in 1 : length(files) ) {
  # Collect the files
  strg = files[i]
  # Get the first three parts of the file
  config_part = substr(strg, start = 1, stop = 6)
  # Check the file with config name
  if (config_part == "config" & strg != "config.yml") {
    # Get the number part of the file
    numberpart = regmatches(strg, gregexpr("[[:digit:]]+", strg))
    number = as.numeric(unlist(numberpart))
    # Get the max number of the config files
    if (number > max) {
      max = number
    }
  }
}

# Select config file based on max value
if (max == 0) {
  str_base = "config.yml"
  config <- config::get(file = str_base)
} else {
  config <- config::get(file = sprintf("config%s.yml", max))
}

# Get data
planejado <- config$planejado
realizado <- config$realizado
esforcos <- config$esforcos
datas <- config$datas
name <- config$name

# Get vectors lenght
l.planejado <- length(planejado)
l.realizado <- length(realizado)
l.esforcos <- length(esforcos)
l.datas <- length(datas)

# Generate error config messages
if (sum(esforcos) != 1) {
  cat("MENSAGEM DE ERRO: A SOMA DO VETOR DE esforcos DEVE SER IGUAL A 1")
  quit()
}
if (l.realizado + l.esforcos != l.planejado) {
  cat("MENSAGEM DE ERRO: A SOMA DO TAMANHO VETOR realizado COM O VETOR esforcos DEVE SER IGUAL AO TAMANHO DO
      VETOR planejado. RECONFIGURE O ARQUIVO config.yml")
  quit()
}
if (l.planejado != l.datas) {
  cat("MENSAGEM DE ERRO: O TAMANHO DO VETOR datas TEM QUE SER IGUAL AO TAMNHO DO VETOR planejado. RECONFIGURE O ARQUIVO config.yml")
  quit()
}

# Construct estimated vector
concluido <- tail(realizado, n = 1)
falta <- planejado[length(planejado)]   - concluido
estimado <- esforcos * falta
estimado <- cumsum(estimado)
estimado <- estimado + concluido

# Construct x axes
x.planejado <- 0 : (l.planejado - 1)
x.realizado <- 0 : (l.realizado - 1)
x.estimado <- (l.realizado - 1) : (l.planejado - 1)
x.estimado2 <- (l.realizado) : (l.planejado - 1)

# Calculate efficiency  
eficiencia.realizada <- realizado[2 : l.realizado] * 100/ planejado[2 : (l.realizado)]
eficiencia.estimada <- estimado * 100/ planejado[(l.realizado + 1) :l.planejado]

# Construct efficiency axis
x.eficiencia.realizada <- 1 : (l.realizado - 1)

# Construct estimated vector for plotting
estimado <- c(concluido,estimado)

# Construct data frames
df.planejado <- data.frame(x = x.planejado, y = planejado)
df.realizado <- data.frame(x = x.realizado, y = realizado)
df.estimado <- data.frame(x = x.estimado, y = estimado)
df.eficiencia.realizada <- data.frame(x = x.eficiencia.realizada , y = eficiencia.realizada)
df.eficiencia.estimada <- data.frame(x = x.estimado2 , y = eficiencia.estimada)

# Declaration plot colors
colors <- c("Planejado" = "blue", "Realizado" = "green","Estimado" = "seagreen4")
fills <- c("Eficiencia Realizada"="gray40","Eficiencia Estimada"="gray75")

# Generate plot
a <- ggplot() +
  geom_bar(data = df.eficiencia.realizada, aes(x = x, y = y, fill="Eficiencia Realizada"),stat="identity") +
  geom_bar(data = df.eficiencia.estimada, aes(x = x, y = y, fill="Eficiencia Estimada"),stat="identity") +
  geom_line(data = df.estimado, aes(x = x, y = y, color = "Estimado"),stat="identity", size = 1.5) +
  geom_line(data = df.realizado, aes(x = x, y = y, color = "Realizado"),stat="identity", size = 1.5) +
  geom_line(data = df.planejado, aes(x = x, y = y, color = "Planejado"),stat="identity", size = 1.5) +
    xlab("Data") + ylab("Porcentagem") + labs(title=name) + labs(color="Legenda") +
  scale_color_manual(values = colors) + theme(plot.title = element_text(size=18)) +
  theme(plot.title = element_text(hjust = 0.5)) + labs(fill = "Eficiencia") + scale_fill_manual(values = fills) +
  scale_x_continuous(labels = datas, breaks = 0:(l.planejado - 1)) 
a
#todo eu sugiro inserir o nome do projeto no título do gráfico

# Save image plot (PNG)
ggsave("./output/graph.png", width = 10, height = 10)
# Save LaTeX code
tikz('./output/graph.tex', width = 10, height = 10)
a
dev.off()


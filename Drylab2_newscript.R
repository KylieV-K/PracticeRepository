# Cargar la librería ggplot2
library(ggplot2)
library(tidyr)  # Para la función pivot_longer

# Crear un data frame con los datos
datos <- data.frame(
  Replica = rep(1:4, each = 6),
  Concentracion = rep(c("10−4", "10−5", "10−6"), times = 8),
  WT_Pre = c(1.1e5, 5.0e5, 2.0e6,
             5.0e4, 2.0e5, 1.0e6,
             2.3e5, 1.1e5, 2.4e6,
             1.8e5, 9.0e5, 7.0e5),
  MV_Pre = c(2.0e4, 1.0e5, 1.0e6,
             1.0e4, 1.0e5, 1.0e6,
             1.0e4, 2.0e5, 1.0e6,
             2.0e4, 1.0e5, 1.0e6),
  WT_Post = c(1.2e5, 2.0e5, 3.0e6,
              1.9e5, 3.0e5, 1.0e6,
              2.0e5, 9.0e5, 4.0e6,
              8.0e4, 8.0e5, 7.0e6),
  MV_Post = c(0, 0, 0,
              0, 0, 0,
              0, 0, 0,
              0, 0, 0)
)

# Convertir los datos de formato ancho a largo
datos_long <- pivot_longer(datos, 
                           cols = starts_with("WT") | starts_with("MV"),
                           names_to = c("Grupo", "Condicion"),
                           names_sep = "_",
                           values_to = "UFC")

# Filtrar datos para eliminar las condiciones no deseadas
datos_long <- datos_long[datos_long$Condicion == "Pre" | datos_long$Condicion == "Post", ]

# Graficar
ggplot(datos_long, aes(x = interaction(Grupo, Condicion), y = UFC)) +
  geom_boxplot(aes(fill = Condicion)) +
  geom_jitter(shape = 16, position = position_jitter(0.2)) +
  labs(x = "Grupo y Condición", y = "UFC/ml") +
  scale_y_log10() +  # Escala logarítmica para mejor visualización
  theme_bw() +
  scale_fill_manual(values = c("lightblue", "lightgreen")) +
  theme(legend.position = "top")


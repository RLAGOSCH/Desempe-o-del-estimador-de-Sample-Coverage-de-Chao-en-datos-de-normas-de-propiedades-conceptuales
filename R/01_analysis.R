# =====================================================================
# 02_analisis.R
# Figuras del póster
# Discrepancia d = CV_est - CV_referencia
# =====================================================================

rm(list = ls())
library(tidyverse)
library(generalCorr)

# ---------------------------------------------------------------------
# 0. Datos y parámetros
# ---------------------------------------------------------------------
ruta_rds    <- "data/Simulacion.RDS"
dir_figuras <- "figures"
dir.create(dir_figuras, showWarnings = FALSE)

dfSim <- readRDS(ruta_rds) %>%
  mutate(
    Concepto      = factor(Concepto, levels = c("vinegar", "cheek", "mounting", "scope")),
    CV_referencia = CV_real,
    d             = CV_est - CV_referencia
  )

T_graf <- c(5, 10, 20, 50, 100)


# Media de la discrepancia para cada T

dfMedia <- dfSim %>%
  group_by(Concepto, nT) %>%
  summarise(E_d = mean(d), .groups = "drop")


# Correlaciones para cada T

dfCorrelaciones <- dfSim %>%
  group_by(Concepto, nT) %>%
  summarise(
    cor_total   = cor(CV_est, CV_referencia),
    cor_parcial = cor(resid(lm(CV_est ~ Q1)), resid(lm(CV_referencia ~ Q1))),
    .groups = "drop"
  )


# Correlación parcial generalizada (generalCorr::parcorMany)


dfCorrelaciones$cor_parcial_gen <- NA_real_

for (i in seq_len(nrow(dfCorrelaciones))) {
  x   <- dfSim %>% filter(Concepto == dfCorrelaciones$Concepto[i], nT == dfCorrelaciones$nT[i])
  mtx <- cbind(CV_est = x$CV_est, CV_referencia = x$CV_referencia, Q1 = x$Q1)
  out <- as.data.frame(parcorMany(mtx, idep = 1, dig = 6), stringsAsFactors = FALSE)
  fila <- out[out[[2]] == "CV_referencia", , drop = FALSE]
  dfCorrelaciones$cor_parcial_gen[i] <- as.numeric(fila[1, 3])
}



# Figura 1

fig_p1 <- ggplot(dfSim, aes(x = nT, y = d)) +
  geom_point(colour = "grey40", alpha = 0.2, size = 0.6) +
  geom_line(data = media_d_T, aes(y = E_d), colour = "black", linewidth = 0.8) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "red") +
  facet_wrap(vars(Concepto), nrow = 1) +
  labs(x = "T", y = "Discrepancia d (estimada - referencia)") +
  theme_minimal()
fig_p1
ggsave(file.path(dir_figuras, "poster_1_discrepancia_vs_T.pdf"), fig_p1, width = 12, height = 3.5)


# Figura 2

fig_p2 <- dfSim %>%
  filter(nT %in% T_graf) %>%
  mutate(T = factor(nT)) %>%
  ggplot(aes(x = CV_referencia, y = CV_est, colour = T)) +
  geom_point(alpha = 0.3, size = 0.6) +
  geom_abline(intercept = 0, slope = 1, linetype = "dashed", colour = "black") +
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, linewidth = 0.7) +
  scale_colour_viridis_d() +
  facet_wrap(vars(Concepto), nrow = 1) +
  labs(x = "Sample coverage de referencia", y = "Sample coverage estimada", colour = "T") +
  theme_minimal() +
  theme(legend.position = "bottom")
fig_p2
ggsave(file.path(dir_figuras, "poster_2_coverage_estimada_vs_referencia.pdf"), fig_p2, width = 12, height = 3.5)


# Figura 3:

fig_p3 <- dfCorrelaciones %>%
  pivot_longer(c(cor_total, cor_parcial, cor_parcial_gen),
               names_to = "medida", values_to = "cor") %>%
  mutate(medida = factor(medida,
                         levels = c("cor_total", "cor_parcial", "cor_parcial_gen"),
                         labels = c("Total", "Parcial (control: Q1)",
                                    "Parcial generalizada (control: Q1)"))) %>%
  ggplot(aes(x = nT, y = cor, colour = medida, linetype = medida)) +
  geom_line(linewidth = 0.8) +
  geom_hline(yintercept = 0, linetype = "dashed", colour = "grey40") +
  scale_colour_manual(values = c("#D55E00", "#0072B2", "#CC79A7")) +
  scale_linetype_manual(values = c("solid", "solid", "dashed")) +
  facet_wrap(vars(Concepto), nrow = 1) +
  coord_cartesian(ylim = c(-1, 1)) +
  labs(x = "T", y = "Correlación para cada T", colour = NULL, linetype = NULL) +
  theme_minimal() +
  theme(legend.position = "bottom")
fig_p3
ggsave(file.path(dir_figuras, "poster_3_correlacion_dado_T.pdf"), fig_p3, width = 12, height = 3.5)
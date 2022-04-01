# Title:    visualização de Dados
# Author:   Antonio Sergio da Silva
# File:     Fundamentos da Linguagem R
# Project:  League Online Courses SGQ
# Purpose:
# Date:


# INSTALL AND LOAD PACKAGES ###################################################

# Load base packages (modo manual) ---------------------------------------------
# install.packages(" ")
# library()
# require()
#------------------------------------------------------------------------------

# Install pacman ("package manager") (instala se necessário; carrega o pacote)-

if (!require("pacman")) install.packages("pacman")

# pacman must already be installed; then load contributed
# packages (including pacman) with pacman

pacman::p_load(usethis,
               magrittr,
               pacman,
               rio,
               tidyverse,
               lubridate,
               ggmap,
               ISLR,
               ggpubr,
               GGally,
               corrplot,
               MASS)

#------------------------------------------------------------------------------

## ERRO : Margens dos gráficos muito grande para visualização ------------------

# Para corrigir este erro:

## Error in plot.new() : figure margins too large

# (1) Limpe todos os gráficos da área Plots;
# (2) Digite a sequência de comandos abaixo:

graphics.off()
par("mar")
par(mar=c(1,1,1,1))

#Criar subpasta ---------------------------------------------------------------

fs::dir_create("aed")

#------------------------------------------------------------------------------

## Estimativas de localização - definir um valor típico para cada variável.
## Isto é, uma estimativa de onde a maioria dos dados está localizada.
## Uma medida de tendência central.

# VISUALIZAÇÃO DE DADOS #######################################################


# criar um banco de dados -----------------------------------------------------

d_int <- c(1,1,2,2,3,3,3,3,5,5,4,4,3,3,2,2,4,4,4,3)
summary(d_int)

d_int<-as_tibble(d_int)
d_int
#------------------------------------------------------------------------------

# BOXPLOT #####################################################################

# Criar objeto para guardar um box plot

bxp <- ggplot(data = d_int,
              aes( x = value))+
    geom_boxplot(fill="palegreen2",
                 linetype = "dotted",
                 size = 0.1,
                 col ="black")+
    theme_nothing()+
    ylim(-0.7,0.7)

bxp

#------------------------------------------------------------------------------

# HISTOGRAMA ##################################################################

# Criar um objeto para guardar o histograma

htg <- ggplot(data = d_int,
              aes(x = value))+
    geom_histogram(fill="palegreen2",
                   linetype = "dotted",
                   bins = 5,
                   col ="black")+
    theme_nothing()+
    ylim(0,10)

htg

#------------------------------------------------------------------------------

# Combinação de Vários Gráficos na Mesma Página  ##############################

# A função ggarrange() da biblioteca [ggpubr] combine vários gráficos em uma ou
# mais páginas.

ggarrange(bxp,htg,
          labels = c("Boxplot", "Histograma"))

#------------------------------------------------------------------------------

## Carregando uma base de dados ###############################################

sd_met <- import("C:/home/loc_sgq/sd_met.xlsx")

## Box Plot ###################################################################

ggplot(data = sd_met,
       aes(x=grupo,
           y=imc)) +
    geom_boxplot(aes(col=grupo))+
    theme_classic()+
    labs(
        title = "Classificaçãoo dos pacientes pelo IMC",
        subtitle = "jan-jul/2020, ICA, São Paulo, SP",
        y = "IMC (kg/m?)",
        x = "Grupo por estado nutricional",
        caption = "Fonte: Dados fictícios")

#------------------------------------------------------------------------------

## Box plot ###################################################################

ggplot(data = sd_met,
       aes(x=sexo,
           y=imc)) +
    geom_boxplot(aes(fill=sexo))+
    theme_classic()+
    labs(
        title = "Classificação dos pacientes pelo IMC",
        subtitle = "jan-jul/2020, ICA, São Paulo, SP",
        y = "IMC (kg/m?)",
        x = "Grupo por sexo",
        caption = "Dados fictícios")

#------------------------------------------------------------------------------

## Histograma com facetas ######################################################

ggplot(data = sd_met,
       aes(x = imc)) +
    geom_histogram(aes(fill= grupo), bins = 15)+
    facet_grid(grupo~., scales = "free")+
    theme_classic()+
    labs(
        title = "Classificação dos pacientes pelo IMC",
        subtitle = "jan-jul/2020, ICA, S?o Paulo, SP",
        caption = "Dados fictícios")

#------------------------------------------------------------------------------

## Diagrama de dispersão entre duas variáveis #################################

ggplot(data = sd_met,
       aes(x=tgc,
           y=hba1c,
           shape = sexo))+
    geom_point(aes(color = grupo))+
    theme_classic()+
    labs(
        title = "Correlação entre HbA1c e Triglicerídeos",
        subtitle = "jan-jul/2020, ICA, São Paulo, SP",
        y = "HbA1c",
        x = "Triglicerídeos",
        caption = "Dados fictícios")
#------------------------------------------------------------------------------

## Medidas de associação entre duas variáveis #################################

round(cor(sd_met[2:7]), 2)

ggpairs(sd_met, columns = 2:7, ggplot2::aes(colour=grupo))

ggpairs(sd_met, columns = 2:7, ggplot2::aes(colour=sexo))

ggpairs((sd_met[2:7]), lower = list(continuous = "smooth"))

ggcorr((sd_met[2:7]), label=T)

corrplot(cor(sd_met[2:7]), method = "circle")

#------------------------------------------------------------------------------

## ANÁLISE DE AGRUPAMENTOS (CLUSTERS) #########################################

## Escore-z (valor padronizado) -----------------------------------------------

#------------------------------------------------------------------------------

# Escore z => corresponde a diferença entre o xi e a xbar (mean),
# dividida pelo desvio padrão=o (sd) => (xi - xbar)/sd

set.seed(281168)
ex <- sample(1:50, 100, replace = TRUE)
m_ex <- mean(ex)
sd_ex <- sd(ex)
zs <- (ex - m_ex)/sd_ex
summary(ex)
summary(zs)

# O escore z pode ser calculado diretamente pela função scale()

scale(ex)

sc_zs <- scale(ex)[,1]
summary(sc_zs)

#------------------------------------------------------------------------------

# Padronizar os dados da planilha sd_met

standardized_X <- scale(sd_met[2:7])

#------------------------------------------------------------------------------

## K-Means Clustering

set.seed(281168)

km_out_2 <- kmeans(standardized_X, 6, nstart = 20)
km_out_2$cluster
km_out_2$tot.withinss

plot(standardized_X, col=(km_out_2$cluster+1),
     main = "K-Means Clustering com K = 6",
     xlab = "",
     ylab = "",
     pch = 16,
     cex = 0.7)

#------------------------------------------------------------------------------

## K-Means Clustering

set.seed(281168)
x <- matrix(rnorm(50*2), ncol=2)
x[1:25,1]=x[1:25,1]+3
x[1:25,2]=x[1:25,2]-4
km_out <- kmeans(x,2,nstart = 20)
km_out$cluster
km_out$tot.withinss
plot(x, col=(km_out$cluster+1),
     main = "K-Means Clustering Results with K = 2",
     xlab ="",
     ylab = "",
     pch = 1,
     cex = 0.7)
#------------------------------------------------------------------------------

use_git()
use_github()

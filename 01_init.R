############################################################
# RECAP R: tipi di dati e strutture principali
############################################################

### 1) OGGETTI E ASSEGNAZIONE --------------------------------


# In R salviamo valori dentro oggetti con <-
x <- 10
  # è la stessa cosa, ma meno comune
nome <- "Michele"

x
nome


### 2) TIPI DI DATO ATOMICI ----------------------------------

# I tipi atomici principali che incontreremo più spesso sono:
# - logical   -> TRUE / FALSE
# - integer   -> numeri interi con suffisso L
# - double    -> numeri "numeric" standard con decimali
# - character -> testo

logico <- TRUE
intero <- 10L
doppio <- 10.5
testo <- "ciao"

logico
intero
doppio
testo

# class() dà la "classe" dell'oggetto
class(logico)
class(intero)
class(doppio)
class(testo)

# typeof() mostra il tipo interno
typeof(logico)
typeof(intero)
typeof(doppio)
typeof(testo)

# Nota importante:
# in R ciò che spesso chiamiamo "numeric" è in realtà di tipo double
numero1 <- 5
numero2 <- 5L

class(numero1)   # numeric
typeof(numero1)  # double

class(numero2)   # integer
typeof(numero2)  # integer


### 3) FUNZIONI is.* E as.* ----------------------------------

# is.* serve per verificare il tipo
is.numeric(numero1)
is.double(numero1)
is.integer(numero1)
is.character(testo)
is.logical(logico)
is.character(numero1)
# as.* serve per convertire (coercizione)
y <- as.character(numero1)

typeof(y)
typeof(numero1)

as.numeric("12")

as.numeric(testo)
as.logical(1)      # 1 diventa TRUE
as.logical(0)      # 0 diventa FALSE

as.logical(testo)

# Attenzione: non tutto si può convertire bene
as.numeric("ciao") # produce NA con warning


### 4) VETTORI -----------------------------------------------

# Un vettore contiene elementi TUTTI dello stesso tipo
v_num <- c(1, 2, 3, 4)
v_char <- c("a", "b", "c")
v_log <- c(TRUE, FALSE, TRUE)

v_num
v_char
v_log

class(v_num)
typeof(v_num)

# Se mescolo tipi diversi, R forza tutto verso un tipo comune
v_misto <- c(1, 2, "tre", T)
v_misto
class(v_misto)   # character

# Lunghezza del vettore
length(v_num)

# Operazioni vettoriali
v_num + 10
v_num * 2
sum(v_num, na.rm = T)
mean(v_num)

# Selezione per posizione
v_num[1]
v_num[2:3]

# Selezione logica
v_num[v_num >= 2]

which(v_num >= 2)
### 5) VALORI MANCANTI E SPECIALI ----------------------------

v <- c(2, 4, NA, 8)

v
is.na(v)
which(is.na(v))

sum(is.na(v))

sum(v)                  # NA
sum(v, na.rm = TRUE)    # ignora NA

# Altri valori speciali
Inf
-Inf
NaN

1 / 0
0 / 0

is.infinite(1 / 0)
is.nan(0 / 0)


### 6) FACTOR ------------------------------------------------

# I factor servono per variabili categoriche
habitat <- c("bosco", "prato", "bosco", "roccia", "prato")

class(habitat)

habitat_f <- factor(habitat)

habitat_f
class(habitat_f)
levels(habitat_f)
summary(habitat_f)

# Factor ordinato
disturbo <- factor(c("basso", "alto", "medio", "basso"),
                   levels = c("basso", "medio", "alto"),
                   ordered = TRUE)


disturbo
levels(disturbo)

disturbo_n <- factor(c("basso", "alto", "medio", "basso"))
levels(disturbo_n)

### 7) MATRICE -----------------------------------------------

# Una matrice è una struttura bidimensionale
# ma può contenere un solo tipo di dato
mat <- matrix(1:9, nrow = 3, ncol = 3)

mat
class(mat)
typeof(mat)
dim(mat)
nrow(mat)
ncol(mat)

# Selezione [righe, colonne]
mat[1, 2]
mat[2, ]
mat[, 3]

# Somme per righe e colonne
rowSums(mat)
colSums(mat)

# Se metto testo dentro, tutto diventa character
mat_mista <- matrix(c(1, 2, "a", 4), nrow = 2)
mat_mista
typeof(mat_mista)


### 8) DATA FRAME --------------------------------------------

# Un data frame è una tabella:
# - colonne di tipi diversi
# - ogni colonna deve avere stessa lunghezza

df <- data.frame

df
class(df)
str(df)

df_t <- as.data.frame(t(df))
str(df_t)

# Estrazione colonne
df$quota
df
df[["quota"]]
df[, "quota"]

# Estrazione righe/colonne
df[1, ]
df[, 2]
df[, 2, drop = FALSE]   # mantiene struttura tabellare

# Filtrare righe
df[df$quota > 1000, ]


### 9) TIBBLE ------------------------------------------------

# Il tibble è una versione "moderna" del data frame
# usata molto nel tidyverse

library(tibble)

tb <- tibble(
  sito = c("A", "B", "C"),
  quota = c(1200, 1450, 980),
  pascolo = c(TRUE, FALSE, TRUE)
)

tb
class(tb)
str(tb)

# Differenze chiave data.frame vs tibble:
# 1. stampa più pulita
# 2. non semplifica in modo inatteso
# 3. non usa row names come struttura importante
# 4. è più "rigido" e prevedibile

# Data frame: una colonna estratta con [, ] diventa spesso vettore
df[, "quota"]
class(df[, "quota"])

# Tibble: con [, ] rimane tibble
tb[, "quota"]
class(tb[, "quota"])

# Per ottenere il vettore dal tibble uso [[ ]] o $
tb[["quota"]]
class(tb[["quota"]])

# Il tibble non fa partial matching con $
# Questo aiuta a evitare errori silenziosi
tb$quo    # NULL, meglio che indovinare


### 10) LISTE ------------------------------------------------

# Una lista può contenere oggetti di tipo diverso
mia_lista <- list(
  numeri = c(1, 2, 3),
  matrice = matrix(1:4, nrow = 2),
  tabella = df
)

mia_lista
class(mia_lista)
length(mia_lista)

# Con [ ] estraggo una sottolista
mia_lista[1]

# Con [[ ]] estraggo il contenuto vero e proprio
mia_lista[[1]]
pippo <- mia_lista[["tabella"]]

class(pippo)
# Posso poi entrare dentro l'oggetto estratto
mia_lista[["tabella"]]$sito


### 11) RIEPILOGO FINALE -------------------------------------

# Strutture principali:
# vector  -> una dimensione, un solo tipo
# matrix  -> due dimensioni, un solo tipo
# data.frame -> due dimensioni, colonne di tipi diversi
# tibble  -> data frame moderno e più prevedibile
# list    -> contenitore generale, molto flessibile

# Funzioni utili da ricordare:
# class()   -> classe
# typeof()  -> tipo interno
# str()     -> struttura compatta
# length()  -> lunghezza
# dim()     -> dimensioni
# is.*      -> verifica il tipo
# as.*      -> converte il tipo

### 12) MINI CASE STUDY: usare un dataset reale ---------------

# Dopo aver visto oggetti e strutture "da manuale",
# applichiamo gli stessi concetti a un dataset già esistente in R

data(iris)

# Guardiamo il dataset
iris

# Che tipo di oggetto è?
class(iris)
str(iris)
dim(iris)

# Ogni colonna del data frame è un vettore
iris$Sepal.Length
class(iris$Sepal.Length)
typeof(iris$Sepal.Length)

iris$Species
class(iris$Species)
typeof(iris$Species)
levels(iris$Species)

# Estraggo solo alcune colonne
iris[, c("Species", "Petal.Length")]

# Filtro le righe con petali lunghi
iris_petali_lunghi <- iris[iris$Petal.Length > 5, ]

# Quante osservazioni ho selezionato?
nrow(iris_petali_lunghi)

# A quali specie appartengono?
table(iris_petali_lunghi$Species)

# Media della lunghezza del petalo nelle tre specie
mean(iris$Petal.Length[iris$Species == "setosa"])
mean(iris$Petal.Length[iris$Species == "versicolor"])
mean(iris$Petal.Length[iris$Species == "virginica"])

# Piccola visualizzazione finale in base R
boxplot(Petal.Length ~ Species, data = iris,
        main = "Petal length nelle tre specie di iris",
        ylab = "Petal Length")

#clase 1 R#
install.packages("readxl")
library(readxl)
help(read_excel)
plantulas1 <- read_excel("sample.xlsx",sheet=13,col_names=TRUE)
str(plantulas1)
?str
plantulas2 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE)
str(plantulas2)
plantulas3 <- read_excel("sample.xlsx",sheet="Plantulas",col_names=TRUE,range=cell_cols("A:E"))
str(plantulas3)

#metodos
View(plantulas1)
View(plantulas2)
View(plantulas3)
?View
head(plantulas1, n=5)
?head
tail(plantulas1, n=5)
?tail
nrow(plantulas2)
?nrow
dim(plantulas2)
?dim

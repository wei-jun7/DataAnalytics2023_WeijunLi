wine_data <- read.table("https://archive.ics.uci.edu/ml/machinelearning-databases/wine/wine.data", sep = ",")
# Header row is not available in the data, therefore, we need toadd the variable names
head(wine_data)

nrow(wine_data) # there are 178 rows

colnames(wine_data) <- c("Cvs", "Alcohol",
                         "Malic_Acid", "Ash", "Alkalinity_of_Ash",
                         "Magnesium", "Total_Phenols", "Flavanoids", "NonFlavanoid_Phenols",
                         "Proanthocyanins", "Color_Intensity", "Hue", "OD280/OD315_of_Diluted_Wine",
                         "Proline")
head(wine_data) # Now you can see the header names.
help("heatmap") # Read the heatmap() function Documentation in RStudio.
heatmap(cor(wine_data),Rowv = NA, Colv = NA) 
help(factor)
cultivar_classes <- factor(wine_data$Cvs)
cultivar_classes

Help(prcomp)
wine_data_PCA <- prcomp(scale(wine_data[,-1]))

summary(wine_data_PCA)
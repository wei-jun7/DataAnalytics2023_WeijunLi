install.packages('MASS')
data(Boston, package="MASS")
# Read the documentation of Boston dataset in RStudio to understand the dataset
help(Boston)
# Principal Component Analysis
# the prcomp() fucntion computes the principal components and we have turned on scalling
# Read the documentation for prcompt() function in RStudio
help(prcomp)
pca_out <- prcomp(Boston,scale. = T)
# pca_out shows the loadings that used.
pca_out
plot(pca_out)
# plotting using the biplot()
# Read the documentation for biplot() function in RStudio
help(biplot)
biplot(pca_out, scale = 0)
boston_pc <- pca_out$x
boston_pc
# boston_pc has the Principal Components having the same number of rows in the original dataset
head(boston_pc)
summary(boston_pc)


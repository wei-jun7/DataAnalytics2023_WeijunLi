# ISLR Package (ISRL 7th Eidtion Textbook )
# KMeans example with Iris dataset
# KMeans is an Unsupervised technique 
library(ISLR)
head(iris)
str(iris)
# visually inspecting the three factors: Species clusters with a plot
plot1 <- ggplot(iris, aes(Petal.Length,Petal.Width, color=Species))
print(plot1 + geom_point(size=3))

# set seed for the random numbers
set.seed(101)
# Read the documentation for KMeans in R-Studio
help("kmeans")

irisClusters <- kmeans(iris[,1:4], 3, nstart = 20) # nstart is the number of random start
print(irisClusters)
table(irisClusters$cluster,iris$Species)
# plotting the clusters
library(cluster)
help("clusplot")
clusplot(iris,irisClusters$cluster, color = TRUE, shade = TRUE, labels = 0, lines = 0)


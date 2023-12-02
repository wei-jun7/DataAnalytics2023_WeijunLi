install.packages("MetaPCA")
library(MetaPCA)
#Spellman, 1998 Yeast cell cycle data set
#Consider each synchronization method as a separate data
data(Spellman) 
pc <- list(alpha=prcomp(t(Spellman$alpha))$x, cdc15=prcomp(t(Spellman$cdc15))$x,
			cdc28=prcomp(t(Spellman$cdc28))$x, elu=prcomp(t(Spellman$elu))$x)
#There are currently 4 meta-pca methods. Run either one of following four.
metaPC <- MetaPCA(Spellman, method="Eigen", doPreprocess=FALSE)
plot
metaPC <- MetaPCA(Spellman, method="RobustAngle", doPreprocess=FALSE)
metaPC <- MetaPCA(Spellman, method="SparseAngle", doPreprocess=FALSE)
#Comparing between usual pca and meta-pca
#The first lows are four data sets based on usual PCA, and 
#the second rows are by MetaPCA
#We're looking for a cyclic pattern.
par(mfrow=c(2,4), cex=1, mar=c(0.2,0.2,0.2,0.2))
for(i in 1:4) {
		plot(pc[[i]][,1], pc[[i]][,2], type="n", xlab="", ylab="", xaxt="n", yaxt="n")
		text(pc[[i]][,1], pc[[i]][,2], 1:nrow(pc[[i]]), cex=1.5)
		lines(pc[[i]][,1], pc[[i]][,2])
}
for(i in 1:4) {
		plot(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2], type="n", xlab="", ylab="", xaxt="n", yaxt="n")
		text(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2], 1:nrow(metaPC$x[[i]]$coord), cex=1.5)
		lines(metaPC$x[[i]]$coord[,1], metaPC$x[[i]]$coord[,2])
}

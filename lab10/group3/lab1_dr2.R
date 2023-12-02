#4 prostate cancer data which have three classes: normal, primary, metastasis
data(prostate)
#There are currently 4 meta-pca methods. Run either one of following four.
metaPC <- MetaPCA(prostate, method="Eigen", doPreprocess=FALSE, .scale=TRUE)
metaPC <- MetaPCA(prostate, method="Angle", doPreprocess=FALSE)
metaPC <- MetaPCA(prostate, method="RobustAngle", doPreprocess=FALSE)
metaPC <- MetaPCA(prostate, method="SparseAngle", doPreprocess=FALSE,iter=100)
#Plotting 4 data in the same space!
coord <- foreach(dd=iter(metaPC$x), .combine=rbind) %do% dd$coord
PlotPC2D(coord[,1:2], drawEllipse=F, dataset.name="Prostate", .class.order=c("Metastasis","Primary","Normal"), 
			.class.color=c('red','#838383','blue'), .annotation=T, newPlot=T,
			.class2=rep(names(metaPC$x), times=sapply(metaPC$x,function(x)nrow(x$coord))), 
			.class2.order=names(metaPC$x), .points.size=1)

#In the case of "SparseAngle" method, the top contributing genes for all studies can be determined
#For instance, top 20 genes in 1st PC and their coefficients
metaPC$v[order(abs(metaPC$v[,1]), decreasing=TRUE),1][1:20] 


# load Golub AML/ALL data
data(golub)
# extract class labels
golubY <- golub[,1]
# extract gene expression from first 10 genes
golubX <- as.matrix(golub[,2:11])
ratio <- 2/3
set.seed(111)
learnind <- sample(length(golubY), size=floor(ratio*length(golubY)))
fdaresult <- fdaCMA(X=golubX, y=golubY, learnind=learnind, comp = 1, plot = TRUE)

show(fdaresult)
ftable(fdaresult)
plot(fdaresult)
# multiclass example:
data(khan)
# class labels
khanY <- khan[,1]
# extract gene expression from first 10 genes
khanX <- as.matrix(khan[,2:11])
set.seed(111)
learnind <- sample(length(khanY), size=floor(ratio*length(khanY)))
fdaresult <- fdaCMA(X=khanX, y=khanY, learnind=learnind, comp = 2, plot = TRUE)
show(fdaresult)
ftable(fdaresult)
plot(fdaresult)

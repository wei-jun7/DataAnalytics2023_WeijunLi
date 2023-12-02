library(fpc)
cbi1<-clusterboot(iris[,-5],B=100, distances=(class(iris[,-5])=="dist"),
            bootmethod="boot",
            bscompare=TRUE, 
            multipleboot=FALSE,
            jittertuning=0.05, noisetuning=c(0.05,4),
            subtuning=floor(nrow(iris)/2),
            clustermethod=kmeansCBI,noisemethod=FALSE,count=TRUE,
            showplots=FALSE,dissolution=0.5, krange=5,
            recover=0.75,seed=NULL)

print(cbi1) 

plot(cbi1)
# vary params


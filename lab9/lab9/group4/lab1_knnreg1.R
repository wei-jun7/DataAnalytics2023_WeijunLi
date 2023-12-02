data(PAC);
pac.knn<- knn.reg(PAC$X, y=PAC$y, k=3);
pac.knn.VR<- knn.reg(PAC$X, y=PAC$y, k=3, algorith="VR");
 
plot(PAC$y, pac.knn$pred, xlab="y", ylab=expression(hat(y)))
points(PAC$y, pac.knn.VR$pred, col=2, pch=3)

# try different algorithms, k.

#perform knn regression
# http://archive.ics.uci.edu/ml/datasets/Student+Performance
# http://archive.ics.uci.edu/ml/datasets/NoisyOffice
# http://archive.ics.uci.edu/ml/datasets/Bike+Sharing+Dataset

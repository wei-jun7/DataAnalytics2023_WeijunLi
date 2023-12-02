cv.folds <- function(n,folds=3)
 ## randomly split the n samples into folds
 {
  split(sample(n),rep(1:folds,length=length(y)))
 }
Write a function cv.ksvm <- function(x,y,folds=3,...) which returns a vector ypred of predicted decision score for all points by k-fold cross-validation.
Compute the various performance of the SVM by 5-fold cross-validation. Alter- natively, the ksvm function can automatically compute the k-fold cross-validation accuracy:
svp <- ksvm(x,y,type="C-svc",kernel=’vanilladot’,C=1,scaled=c(),cross=5)
print(cross(svp))


# read data in
aba<-read.csv(“abalone.csv")
naba<-dim(aba)[1]
#90% to train
sampling.rate=0.9
#remainder to test
num.test.set.labels=naba*(1.-sampling.rate)
#construct a random set of training indices (training)
training <-sample(1:naba,sampling.rate*naba, replace=FALSE)
#build the training set (train)
train<-subset(aba[training,],select=c("Sex","Length","Diameter","Height","Whole.weight","Shucked.weight","Viscera.weight","Shell.weight"))
#construct the remaining test indices (testing)
testing<-setdiff(1:naba,training)
#define the test set
test<-subset(aba[testing,],select=c("Sex","Length","Diameter","Height","Whole.weight","Shucked.weight","Viscera.weight","Shell.weight"))
#construct labels for another variable (Rings) in the training set
crings<-aba$Rings[training]
#construct true labels the other variable in the test set
true.labels<-aba$Rings[testing]
#run the classifier, can change k
classif<-knn(train,test,crings,k=5)
#view the classifier
classif
#looks at attributes
attributes(.Last.value)

#now do bayes.

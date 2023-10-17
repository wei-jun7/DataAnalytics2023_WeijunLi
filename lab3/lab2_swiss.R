data(swiss)
sclass <- kmeans(swiss[2:7], 3) 
table(sclass$cluster, swiss[,2])    
# 
library(e1071)
m <- naiveBayes(swiss[2:7], swiss[,2])    
table(predict(m, iswiss[2:7], swiss[,2])


library(kknn)
data(ionosphere)
# class is categorical var.
i2<-ionosphere[,-1]
i2<-i2[,-1]
# class is categorical var.
library(MASS)
ifit <- lda(class ~ ., data=i2, na.action="na.omit", CV=TRUE)
summary(ifit)

ctable <- table(i2$class, ifit$class)
diag(prop.table(ctable, 1))
# total percent correct
sum(diag(prop.table(ctable)))


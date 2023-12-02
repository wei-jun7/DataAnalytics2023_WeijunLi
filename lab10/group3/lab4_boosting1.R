require(ggplot2)        # or load package first
data(diamonds)
head(diamonds)          # look at the data!
#
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
ggplot(diamonds, aes(clarity)) + geom_bar() + facet_wrap(~ cut)
ggplot(diamonds) + geom_histogram(aes(x=price)) + geom_vline(xintercept=12000)
ggplot(diamonds, aes(clarity)) + geom_freqpoly(aes(group = cut, colour = cut))

diamonds$Expensive <- ifelse(diamonds$price >= 12000,1,0)
head(diamonds)

diamonds$price<-NULL
require(glmnet)         # or load package first
x<-model.matrix(~., diamonds[,-ncol(diamonds)])
y<-as.matrix(diamonds$Expensive)
mglmnet<-glmnet(x=x,y=y,family="binomial")
plot(mglmnet)

set.seed(51559)
sample(1:10)
require(rpart)
mTree<-rpart(Expensive~.,data=diamonds)
plot(mTree)
text(mTree)

require(boot)
mean(diamonds$carat)
ds(diamonds$carat)
boot.mean<-function(x,i)
{
        mean(x[i])
}
boot(data=diamonds$carat, statistic=boot.mean,R=120)

#### Estimation of homogeneous mixed models with different assumed link functions,
#### a quadratic mean trajectory for the latent process and correlated random 
#### intercept and slope (the random quadratic slope was removed as it did not 
#### improve the fit of the data).
#### --- comparison of linear, Beta and 3 different splines link functions ---
data(data_Jointlcmm)
# linear link function
m10<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1,
data=data_Jointlcmm,link="linear")
summary(m10)
# Beta link function
m11<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1,
data=data_Jointlcmm,link="beta")
summary(m11)
plot.linkfunction(m11,bty="l")
# I-splines with 3 equidistant nodes
m12<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1,
data=data_Jointlcmm,link="3-equi-splines")
summary(m12)
# I-splines with 5 nodes at quantiles
m13<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1,
data=data_Jointlcmm,link="5-quant-splines")
summary(m13)
# I-splines with 5 nodes, and interior nodes entered manually
m14<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1,
data=data_Jointlcmm,link="5-manual-splines",intnodes=c(10,20,25))
summary(m14)
plot.linkfunction(m14,bty="l")


# Thresholds
# Especially for the threshold link function, we recommend to estimate models 
# with increasing complexity and use estimates of previous ones to specify 
# plausible initial values (we remind that estimation of models with threshold
# link function involves a computationally demanding numerical integration 
# -here of size 3)
m15<-lcmm(Ydep2~Time+I(Time^2),random=~Time,subject='ID',ng=1
,data=data_Jointlcmm,link="thresholds",maxiter=100,
B=c(-0.8379, -0.1103,  0.3832,  0.3788 , 0.4524, -7.3180,  0.5917,  0.7364,  0.6530,
 0.4038,  0.4290,  0.6099,  0.6014 , 0.5354 , 0.5029 , 0.5463,  0.5310 , 0.5352,
 0.6498,  0.6653,  0.5851,  0.6525,  0.6701 , 0.6670 , 0.6767 , 0.7394 , 0.7426,
 0.7153,  0.7702,  0.6421))
summary(m15)
plot.linkfunction(m15,bty="l")

#### Plot of estimated different link functions:
#### (applicable for models that only differ in the "link function" used. 
#### Otherwise, the latent process scale is different and a rescaling is necessary)
transfo <- data.frame(marker=m10$estimlink[,1],linear=m10$estimlink[,2],
beta=m11$estimlink[,2],spl_3e=m12$estimlink[,2],spl_5q=m13$estimlink[,2],
spl_5m=m14$estimlink[,2])
dev.new()
plot(transfo[,1]~transfo[,2],xlim=c(-10,5),col=1,type='l',xlab="latent process",
ylab="marker",bty="l")
par(new=TRUE)
plot(transfo[,1]~transfo[,3],xlim=c(-10,5),col=2,type='l',xlab="",ylab="",bty="l")
par(new=TRUE)
plot(transfo[,1]~transfo[,4],xlim=c(-10,5),col=3,type='l',xlab="",ylab="",bty="l")
par(new=TRUE)
plot(transfo[,1]~transfo[,5],xlim=c(-10,5),col=4,type='l',xlab="",ylab="",bty="l")
par(new=TRUE)
plot(m15$estimlink[,1]~m15$estimlink[,2],xlim=c(-10,5),col=5,type='l'
,xlab="",ylab="",bty="l")
legend(x="bottomright",legend=c(colnames(transfo[,2:5]),"thresholds"),
col=1:5,lty=1,inset=.02,bty="n")


#### Estimation of 2-latent class mixed models with different assumed link 
#### functions with individual and class specific linear trend
#### for illustration, only default initial values where used but other
#### sets of initial values should also be tried to ensure convergence 
#### towards the golbal maximum
# Linear link function
m20<-lcmm(Ydep2~Time,random=~Time,subject='ID',mixture=~Time,ng=2,idiag=TRUE,
data=data_Jointlcmm,link="linear")
summary(m20)
postprob(m20)
# Beta link function
m21<-lcmm(Ydep2~Time,random=~Time,subject='ID',mixture=~Time,ng=2,idiag=TRUE,
data=data_Jointlcmm,link="beta")
summary(m21)
postprob(m21)
# I-splines link function (and 5 nodes at quantiles)
m22<-lcmm(Ydep2~Time,random=~Time,subject='ID',mixture=~Time,ng=2,idiag=TRUE,
data=data_Jointlcmm,link="5-quant-splines")
summary(m22)
postprob(m22)

data <- data_Jointlcmm[data_Jointlcmm$ID==193,]
plot(predict(m22,var.time="Time",newdata=data,bty="l"))


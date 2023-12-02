library(e1071) 
m1 <- matrix( c( 
0,    0,    0,    1,    1,    2,     1, 2,    3,    2,    3, 3, 0, 1,2,3, 
0, 1, 2, 3, 
1,    2,    3,    2,    3,    3,     0, 0,    0,    1, 1, 2, 4, 4,4,4,    0, 
1, 2, 3, 
1,    1,    1,    1,    1,    1,    -1,-1,  -1,-1,-1,-1, 1 ,1,1,1,     1, 
1,-1,-1 
), ncol = 3 ) 

Y = m1[,3] 
X = m1[,1:2] 

df = data.frame( X , Y ) 

par(mfcol=c(4,2)) 
for( cost in c( 1e-3 ,1e-2 ,1e-1, 1e0,  1e+1, 1e+2 ,1e+3)) { 
#cost <- 1 
model.svm <- svm( Y ~ . , data = df ,  type = "C-classification" , kernel = 
"linear", cost = cost, 
                         scale =FALSE ) 
#print(model.svm$SV) 

plot(x=0,ylim=c(0,5), xlim=c(0,3),main= paste( "cost: ",cost, "#SV: ", 
nrow(model.svm$SV) )) 
points(m1[m1[,3]>0,1], m1[m1[,3]>0,2], pch=3, col="green") 
points(m1[m1[,3]<0,1], m1[m1[,3]<0,2], pch=4, col="blue") 
points(model.svm$SV[,1],model.svm$SV[,2], pch=18 , col = "red") 
}

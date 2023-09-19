EPI_data_Path <- "C:/Users/LiWeiJun/Desktop/data anaylst/lab/2010EPI_data.csv"

#EPI_data <- read.csv(EPI_data_Path)
EPI_data <- read.csv(EPI_data_Path, header = TRUE, skip = 1)
#print(EPI_data$EPI)
#or
#EPI_data <- read.xlsx(”<path>/2010EPI_data.xlsx")
# Note: replace default data frame name – cannot start with numbers!
View(EPI_data)
#
attach(EPI_data) 	# sets the ‘default’ object
fix(EPI_data) 	# launches a simple data editor
ecdf_function<- ecdf(EPI_data$WATER_H)

#EPI_data$EPI 			# prints out values EPI_data$EPI
tf <- is.na(EPI_data$WATER_H) # records True values if the value is NA
water <- WATER_H[!tf] # filters out NA values, new array
tf1<- is.na(EPI_data$High_Population_Density)
HPD <- High_Population_Density[!tf1]
#Try to find the value for the 
ecdf_function<- ecdf(EPI_data$WATER_H)
plot(ecdf_function, main="ECDF Plot")
qqnorm(HPD)
qqline(HPD)
#for the Water_H values
summary(water)
fivenum(water)
stem(water)
hist(water)
hist(water, seq(30.,95.,1.0),prob=TRUE)
lines(density(water,na.rm=TRUE,bw = "SJ"))
rug(water)
plot(ecdf(water), do.points=FALSE, verticals=TRUE) 
par(pty="s") 
qqnorm(water)
qqline(water)
x<- seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

#for the High_polutation Density values
summary(HPD)
fivenum(HPD)
stem(HPD)
hist(HPD)
hist(HPD, seq(30.,95.,1.0),prob=TRUE)
lines(density(HPD,na.rm=TRUE,bw = "SJ"))
rug(HPD)

plot(ecdf(HPD), do.points=FALSE, verticals=TRUE) 
par(pty="s") 
qqnorm(HPD)
qqline(HPD)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

boxplot(water,HPD)
qqplot(water,HPD)


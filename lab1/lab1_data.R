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
#EPI_data$EPI 			# prints out values EPI_data$EPI
tf <- is.na(EPI_data$EPI) # records True values if the value is NA
E <- EPI[!tf] # filters out NA values, new array

GRUMP_data_Path <- "lab1/GPW3_GRUMP_SummaryInformation_2010.csv"
#other data
GRUMP_data <- read.csv(GRUMP_data_Path)

summary(EPI)
fivenum(EPi)
stem(EPI)
hist(EPI)
hist(EPI, seq(30.,95.,1.0),prob=TRUE)
lines(density(EPI,na.rm=TRUE,bw = "SJ"))
rug(EPI)
hist(EPI, seq(30.,95.,1.0),prob=TRUE,lines=density(EPI,na.rm=TRUE,bw = 1),rug(EPI))
plot(ecdf(EPI), do.points=FALSE, verticals=TRUE) 
par(pty="s") 
qqnorm(EPI); qqline(EPI)
x<- seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)


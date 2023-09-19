epi_data_path <- "C:/Users/LiWeiJun/Desktop/data anaylst/lab/lab1/2010EPI_data.csv"
epi_data <- read.csv(epi_data_path, header = TRUE, skip = 1)
#Landlock
EPILand<-EPI[!Landlock]
Eland <- EPILand[!is.na(EPILand)]
#
hist(ELand)
hist(ELand, seq(30., 95., 1.0), prob=TRUE)
#No_surface_water
epi_no_surface_water<- EPI[!epi_no_surface_water]
ENSW <- epi_no_surface_water[!is.na(epi_no_surface_water)]
hist(ENSW)
hist(ENSW, seq(30., 95., 1.0), prob=TRUE)
#Desert
epi_desert<- EPI[!epi_desert]
ED <- epi_desert[!is.na(epi_desert)]
hist(ED)
hist(ED, seq(30., 95., 1.0), prob=TRUE)
#High_Population_Density
epi_high_population_density<- EPI[!epi_high_population_density]
EHDP <- epi_high_population_density[!is.na(epi_high_population_density)]
hist(EHDP)
hist(EHDP, seq(30., 95., 1.0), prob=TRUE)
#EPI_South_Asia
epi_south_asia<- EPI[GEO_subregion=="South Asia"]
geo_south_asia<- EPI[EPI_regions=="South Asia"]
#repeat exercise 1
summary(ENSW)
fivenum(ENSW)
stem(ENSW)
hist(ENSW)
hist(ENSW, seq(30.,95.,1.0),prob=TRUE)
lines(density(ENSW,na.rm=TRUE,bw = "SJ"))
rug(ENSW)
plot(ecdf(ENSW), do.points=FALSE, verticals=TRUE) 
par(pty="s") 
qqnorm(ENSW)
qqline(ENSW)
x<- seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

summary(ED)
fivenum(ED)
stem(ED)
hist(EF)
hist(ED, seq(30.,95.,1.0),prob=TRUE)
lines(density(ED,na.rm=TRUE,bw = "SJ"))
rug(ED)
plot(ecdf(ED), do.points=FALSE, verticals=TRUE) 
par(pty="s") 
qqnorm(ED)
qqline(ED)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

summary(EHDP)
fivenum(EHDP)
stem(EHDP)
hist(EHDP)
hist(EHDP, seq(30.,95.,1.0),prob=TRUE)
lines(density(EHDP,na.rm=TRUE,bw = "SJ"))
rug(EHDP)
plot(ecdf(EHDP), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(EHDP)
qqline(EHDP)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)



#read theGPW3
GPW3_Path = "C:/Users/LiWeiJun/Desktop/data anaylst/lab/lab1/GPW3_GRUMP_SummaryInformation_2010.csv"
GPW3<- read.csv(GPW3_Path, header = TRUE, skip = 1)

View(GPW3)
attach(GPW3) 	# sets the ‘default’ object
fix(GPW3) 	# launches a simple data editor
#explore the data
summary(GPW3)

#explore ,plots ,histograms, distributions,  the data for the x3707

data_x3705<- GPW3$X3705

summary(data_x3705)
fivenum(data_x3705)
stem(data_x3705)
hist(data_x3705)
hist(data_x3705, seq(30.,95.,1.0),prob=TRUE)
lines(density(data_x3705,na.rm=TRUE,bw = "SJ"))
rug(data_x3705)
plot(ecdf(data_x3705), do.points=FALSE, verticals=TRUE)
par(pty="s")
qqnorm(data_x3705)
qqline(data_x3705)
x <- seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

#filtering test case
y <- X3705[!X0.2]
y_value <- y[!is.na(y)]
hist(y_value)
hist(y_value, seq(30.,95.,1.0),prob=TRUE)
summary(y)


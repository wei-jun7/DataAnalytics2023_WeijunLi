#exercise 1
epi_data_path = "part2\2010EPI_data.csv"
epi_data = read.csv(epi_data_path, header = TRUE, skip = 1)

attach(epi_data)
help("qqnorm")
plot(ecdf(EPI), do.points=FALSE, verticals=TRUE)
par(pty ="s")
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t
dsn")
x <- seq(30,95,1)
x2<- seq(30,96,2)
qqplot(qt(ppoints(250),df=5),x, xlab = "Q-Q plot")
qqline(x)
#exercise 2
plot(mtcars$wt,mtcars$mpg)
library(ggplot2)
qplot(mtcars$wt,mtcars$mpg)
qplot(wt,mpg,data = mtcars)
ggplot(mtcars, aes(w=wt,y=mpg))+geom_point()
plot(pressure$temperature, pressure$pressure, type ="l")
points(pressure$temperature, pressure$pressure)

lines(pressure$temperature, pressure$pressure/2,col ="red")
points(pressure$temperature, pressure$pressure/2,col ="blue")
qplot(pressure$temperature, pressure$pressure, geom = "line")
qplot(temperature, pressur,data =pressure, geom = "line")
ggplot(pressure, aes(x= temperature, y=pressure))+geom_line()+geom_point()
ggplot(pressure, aes(x= temperature, y=pressure))+geom_line()+geom_point()

#creating Bar graphs
barplot(BOD$demand,names.arg =BOD$time)
table(mtcars$cyl)
barplot(table(mtcars$cyl))
qplot(mtcars$cyl)
qplot(factor(mtcars$cyl))
qplot(factor(mtcars$cyl), data = mtcars)
ggplot(mtcars,aes(x=factor(cyl)))+geom_bar()

#creating histograms
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 10)
hist(mtcars$mpg, breaks = 5)
hist(mtcars$mpg, breaks = 12)
qplot(mpg, data = mtcars, binwidth = 4)
ggplot(mtcars, aes(x=mpg))+geom_histogram(binwidth = 4)
ggplot(mtcars, aes(x=mpg))+geom_histogram(binwidth = 5)
#creating box-plot
plot(ToothGrowth$supp, ToothGrowth$len)
boxplot(len ~ supp,data ToothGrowth)
qplot(ToothGrowth$supp, ToothGrowth$len, geom = "boxplot")
qplot(supp,len, data = ToothGrowth, geom = "boxplot")
ggplot(ToothGrowth, aes(x=supp, y=len))+geom_boxplot()
qplot(interaction(ToothGrowth$supp, ToothGrowth$does),ToothGrowth$len, geom = "boxplot")
qplot(interaction(supp,dose),len,data=ToothGrowth, geom = "boxplot")
ggplot(ToothGrowth, aes(interation(supp,dose),len))+geom_boxplot()


day <- c('Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun')
temp <- c(28,30.5,32,31.2,29.3,27.9,26.4)
snowed <- c('T','T','F','F','T','T','F')
help('data.frame')
RPI_Weather_Week <- data.frame(day, temp, snowed)

RPI_Weather_Week
head(RPI_Weather_Week)

str(RPI_Weather_Week)

summary(RPI_Weather_Week)

empty.DateFrame <- data.frame()
v1 <- 1:10

v2 <- letters[1:10]
df <- data.frame(col.name.1=v1, col.name.2=v2)

write.csv(df, file='save_df1.csv')
df2 <- read.csv(file='save_df1.csv')
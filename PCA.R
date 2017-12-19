# Clean worksplace
## cleaning tool......rm(list = ls())
rm(list = ls())

getwd()
setwd("C:/Users/InsunHand/OneDrive/108 DM Project")

# Load data and understand the dataset
myData <- read.csv("C:/Users/InsunHand/OneDrive/108 DM Project/data/ABT04_SQLView.csv", header = TRUE, fileEncoding="UTF-8-BOM")
summary(myData)
variable.names(myData)
data.frame(myData)
str(myData)

# Subset dataframe to leave only numerical attributes.
## Remove ID column of FltKey
## Remove FL_NUM as it is categorical variable represented in number.
## Remove pivoted columns of Delay time by Cause.

non_num <-names(myData) %in% 
  c('FL_DATE',	'ORIGIN',	'DEST',	'ARR_TIME_BLK',	'OriginDate',	'CARRIER_DELAY',	'WEATHER_DELAY',	'NAS_DELAY',	'SECURITY_DELAY',	'LATE_AIRCRAFT_DELAY')
myNumData <- myData[!non_num]

# Taking only predictor variables with temporal and weather effects for PCA
myPredictors <- c("YEAR","QUARTER","MONTH","DAY_OF_MONTH","DAY_OF_WEEK",'ARR_HR',	'DEP_HR', 'Temperature',	'Dewpoint',	'Humidity',	'Pressure',	'Visibility',	'WindSpeed_kmh',	'GustSpeed',	'Precip',	'HeatIndex')

df_myPreds <- subset(myNumData, select = myPredictors)

myPCs <- prcomp(df_myPreds, scale = T)

## Identify useful measures.
names(myPCs)
print(myPCs$center)
print(myPCs$center)
print(myPCs$scale)
print(myPCs$sdev)
dim(myPCs)
dim(myPCs$x)

myPCs$rotation

# biplot  
biplot(myPCs, scale =0)


myStD <- myPCs$sdev

## Variance for our priciple components
myPCVar <- myStD^2
PRINT(myPCVar)
sum(myPCVar)
Pro_myPCvar <- myPCVar/sum(myPCVar)

## Proportion of my explained variance
print(Pro_myPCvar)


## Scree Plot
plot(Pro_myPCvar, xlab = "Principle Components", ylab = "Proportion of Variance Explained", type = "b")

#cumulative scree plot
plot(cumsum(Pro_myPCvar), xlab = "Principal Component", ylab = "Cumulative Proportion of Variance Explained", type = "b")



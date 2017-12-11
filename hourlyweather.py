# Python code(Web scraping) to acquire Hourly Weather Data
# Python 3 

import bs4 as bs
import urllib.request
import pandas as pd
import numpy as np
import csv

headers = ['Date', 'Time(EST)', 'Temp', 'Windchill', 'DewPoint', 'Humidity', 'Pressure', 'Visibility', 'WindDir', 'WindSpeed', 'GustSpeed', 'Precip', 'Events', 'Conditions']
# Empty list created to hold all hourly data that will be obtained in a dataframe  for each day.
myDFs = []

for vYear in range(2016, 2017):
    for vMonth in range(11, 13):
        for vDay in range(1, 32):
            # go to the next month, if it is a leap year and greater than the 29th or if it is not a leap year
            # and greater than the 28th
            if vYear % 4 == 0:
                if vMonth == 2 and vDay > 29:
                    break
            else:
                if vMonth == 2 and vDay > 28:
                    break
            # go to the next month, if it is april, june, september or november and greater than the 30th
            if vMonth in [4, 6, 9, 11] and vDay > 30:
                break

            # defining the date string to export and go to the next day using the url
            theDate = str(vYear) + "/" + str(vMonth) + "/" + str(vDay)
            
            # Change Airport Location
            theAirport = "KSFO"

            theurl = "https://www.wunderground.com/history/airport/KSFO/" + theDate + "/DailyHistory.html"
            dfs = pd.read_html(theurl)
            
            # Hourly weather data table is the 4th table in the page. Define the dataframe to scrape.
            table4 = dfs[4]     
            
            # Define Column Length
            cLen = len(table4['Temp.'])
            
            # Create a list of repeated date to append as a new column to the dataframe.
            datelist = [theDate]
            myDateList = datelist * cLen
            #print(myDateList)
            
            ## Add a Date column to the data frame.
            dateDF = pd.DataFrame([myDateList])
            dateDFt = dateDF.transpose()
            
            # To check transposed DFt
            ##print(dateDFt.head())               
            
            # Join 2 dataframes
            myDF = dateDFt.join(table4)
            
            # Append a dataframe object yeilded from above process to the list.
            myDFs.append(myDF)
            
            # Concatenate dataframes in the list and merge into one dataframe.
            outputDF = pd.concat(myDFs)            

# Write a csv file.                    
outputDF.to_csv("hourly_weather_SFO_1112_2016.csv")    
      
     




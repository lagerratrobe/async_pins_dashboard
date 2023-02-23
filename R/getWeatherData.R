library(dplyr)
library(lubridate)

# setup - Pull all weather data in from Github
getWeatherData <- function() {
  df <- readRDS(url("https://github.com/lagerratrobe/weather_station/raw/main/Data/station_obs.RDS"))
  # Convert obsTimeLocal to proper Posix time object
  df <- mutate(df,
               obsTimeLocal = lubridate::parse_date_time(
                 obsTimeLocal,
                 "Ymd HMS",
                 tz = "UTC",
                 truncated = 0,
                 quiet = FALSE,
                 exact = FALSE) -> df)
  return(df)
} 

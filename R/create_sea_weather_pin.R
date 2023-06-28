# create_sea_weather_pin
library(dplyr)
library(lubridate)
library(pins)
source("R/async_weather_utils.R")

# Pull weather data in from Github and filter to SEA station
live_data <- getSeattleWeather()

# Create the pin and write data to it
# Connect to a pin board on Connect
board <- board_connect(auth = "envvar")

current_time <- as.character(lubridate::now())

# Write data to server
pins::pin_write(board,
                live_data,
                name = "Seattle_Weather_Data",
                type = "rds",
                versioned = TRUE,
                metadata = list("load_time" = current_time))

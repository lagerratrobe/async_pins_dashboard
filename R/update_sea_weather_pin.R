# update_sea_weather_pin.R

# Runs every 15 minutes and checks to see if there is "new" weather data.  Does this 
# by comparing the record counts between the "live" data and "pinned" data.

library(pins)
library(dplyr)
library(lubridate)
source("pins_update/async_weather_utils.R")

# Pull the "live" data 
live_data <- getSeattleWeather()

# Pull the Pinned data
board <- getBoard()
pinned_data <- pin_read(board, name = "randre/Seattle_Weather_Data")

# Create a timestamp
current_time <- as.character(lubridate::now())

# Check to see if there are new records, if there are, refresh the pinned_data with live_data
if ( nrow(live_data) > nrow(pinned_data) ) {
  updateBoard(board = board, df = live_data, time_now = current_time)
  sprintf("Updated randre/Seattle_Weather_Data Pins at %s", current_time)
} else {
  sprintf("There was no new data at %s", current_time)
}

# Get the pin versions
pin_versions(board, "randre/Seattle_Weather_Data")


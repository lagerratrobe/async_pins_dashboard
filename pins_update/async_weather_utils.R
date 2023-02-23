# async_weather_utils.R

# helper functions for updating pins, etc.

library(dplyr)
library(lubridate)

# Returns weather obs for KWASEATT2743 station
getSeattleWeather <- function() {
  df <- readRDS(url("https://github.com/lagerratrobe/weather_station/raw/main/Data/station_obs.RDS"))
  # Convert obsTimeLocal to proper Posix time object
  df <- mutate(df,
               obsTimeLocal = lubridate::parse_date_time(
                 obsTimeLocal,
                 "Ymd HMS",
                 tz = "UTC",
                 truncated = 0,
                 quiet = FALSE,
                 exact = FALSE)
  )
  df <- filter(df, stationID == "KWASEATT2743")
  return(df)
} 

# Returns board object tied to Seattle_Weather_Data pins 
getBoard <- function() {
  board_connect(
    auth = c("envvar"),
    account = "randre",
    name = "Seattle_Weather_Data",
    versioned = TRUE,
    use_cache_on_failure = FALSE)
}

# Writes a new version of Seattle weather data to Pin set
updateBoard <- function(
    board = NULL,
    df = NULL,
    time_now = NULL
    ) {
  pin_write(board = board,
            x = df,
            name = "randre/Seattle_Weather_Data",
            type = "rds",
            versioned = TRUE,
            metadata = list("load_time" = time_now))
}

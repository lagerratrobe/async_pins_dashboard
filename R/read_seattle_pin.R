# read_seattle_pin.R

library(pins)

board <- board_connect(auth = "envvar")
seattle_data_pin <- pin_read(board, "randre/Seattle_Weather_Data")

seattle_data_pin <- pin_read(board, name = "randre/Seattle_Weather_Data")
pin_versions(board, "randre/Seattle_Weather_Data")

# To delete an old version
pin_version_delete(board, name =  "randre/Seattle_Weather_Data", version = 16)


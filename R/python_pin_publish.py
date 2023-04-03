import pins
from pins import board_rsconnect

CONNECT_API_KEY="maEPTwJIfaazQGawZlM5bqbbpfgaTEUY"
CONNECT_SERVER="http://posit2:3939/__api__"

# Create a board on posit2
board = board_rsconnect(server_url = CONNECT_SERVER, 
                        api_key = CONNECT_API_KEY
                       )

from pins.data import mtcars
board.pin_write(mtcars, "randre/mtcars", type="csv")


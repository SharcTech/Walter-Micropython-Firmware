import sys
import select
import time
from machine import UART, Pin

WALTER_MODEM_PIN_RX = 14
WALTER_MODEM_PIN_TX = 48
WALTER_MODEM_PIN_RTS = 21
WALTER_MODEM_PIN_CTS = 47
WALTER_MODEM_PIN_RESET = 45

ModemSerial = UART(2, 115200, rx=WALTER_MODEM_PIN_RX, tx=WALTER_MODEM_PIN_TX, rts=WALTER_MODEM_PIN_RTS, cts=WALTER_MODEM_PIN_CTS)

def _modem_reset():
    reset_pin = Pin(WALTER_MODEM_PIN_RESET, Pin.OUT)
    reset_pin.value(0)
    time.sleep(1)
    reset_pin.value(1)


def setup():
    Pin(WALTER_MODEM_PIN_RX, Pin.IN)
    Pin(WALTER_MODEM_PIN_TX, Pin.IN)
    Pin(WALTER_MODEM_PIN_CTS, Pin.IN)
    Pin(WALTER_MODEM_PIN_RTS, Pin.OUT)
    Pin(WALTER_MODEM_PIN_RESET, Pin.OUT)

    ModemSerial.init(
        115200,
        bits=8,
        parity=None,
        stop=1,
        rx=WALTER_MODEM_PIN_RX,
        tx=WALTER_MODEM_PIN_TX,
        rts=WALTER_MODEM_PIN_RTS,
        cts=WALTER_MODEM_PIN_CTS)

    _modem_reset()


setup()

ModemSerial.write('ATI\r\n')
response = b''
while ModemSerial.any():
    response += ModemSerial.read(1)
print(response.decode().strip())

while 1:
    time.sleep(0.1)

    while sys.stdin in select.select([sys.stdin], [], [], 0)[0]:
        ch = sys.stdin.read(1)
        ModemSerial.write(ch)
        print(">{}".format(ch))

    while ModemSerial.any():
        ch = ModemSerial.read(1)
        print("<{}".format(ch))


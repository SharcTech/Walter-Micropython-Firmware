import uasyncio
import struct
import ubinascii
import esp32
import network
import src.walter as walter
import src._walter as _walter

modem = None

async def setup():

    rsp = await modem.check_comm()
    rsp = await modem.get_sim_state()

    return True


async def loop():
    await uasyncio.sleep(.5)

    return True


async def main():
    if not await setup():
        return

    while True:
        if not await loop():
            break



modem = walter.Modem()
modem.begin(main)
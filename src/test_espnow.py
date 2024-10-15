import network
import espnow
import utime as time

# _esp_now_peer = b'\x34\x7d\xf6\xb5\x6f\xa3'
_esp_now_peer = b'\xff\xff\xff\xff\xff\xff'

sta = network.WLAN(network.STA_IF)
sta.active(True)
sta.disconnect()
sta.config(channel=8)
now = espnow.ESPNow()
now.active(True)
now.add_peer(_esp_now_peer)


while True:
  host, msg = now.recv(0)
  if msg:
    print(f'espnow: received {msg} from {host}')
    try:
      segments = msg.decode('utf-8').split("|")
      now.send(_esp_now_peer, "ACK {}={}".format(segments[0], segments[1]))
    except:
      pass

  # now.send(_esp_now_peer, "hello from WALTER")
  time.sleep_ms(10)

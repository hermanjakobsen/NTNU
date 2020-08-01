
import time
from socket import *

host = "192.168.1.11"
port = 12000

address = (host, port)

timeout = 1 # Seconds

clientSocket = socket(AF_INET, SOCK_DGRAM)
clientSocket.settimeout(timeout)

ptime = 0  

# Ping for 10 times
while ptime < 10:
    ptime += 1
    data = "Ping " + str(ptime) + " "

    try:

        sentTime = time.time()
        data += str(sentTime)
        clientSocket.sendto(data.encode(), address)

        response = clientSocket.recv(1024)
        receivedTime = time.time()

        roundTripTime = receivedTime - sentTime

        print(response.decode())
        print(roundTripTime)

    except:
        print("Request timed out.")
        continue

clientSocket.close()







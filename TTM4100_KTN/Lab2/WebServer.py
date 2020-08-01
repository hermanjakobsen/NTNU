from socket import *

from socket import socket
from typing import Union

serverSocket: Union[socket, SocketType] = socket(AF_INET, SOCK_STREAM)

serverPort = 12000

serverSocket.bind(('', serverPort))
serverSocket.listen(1)

while True:
    print("Ready to serve...")
    connectionSocket, addr = serverSocket.accept()
    try:
        message = connectionSocket.recv(1024)

        filepath = message.split()[1]
        f = open(filepath[1:])
        outputData = f.read()

        headerResponse = "HTTP/1.1 200 OK\r\n\r\n"
        connectionSocket.send(headerResponse.encode())

        response = outputData + "\r\n"
        connectionSocket.send(response.encode())

        connectionSocket.close()
    except(IOError, IndexError):
        headerResponse = "HTTP/1.1 404 Not Found\r\n\r\n"
        connectionSocket.send(headerResponse.encode())

        connectionSocket.send("<html><head></head><body><h1>404 Not Found"
                              "</h1></body></html>\r\n".encode())

        connectionSocket.close()

# This will never be reached
serverSocket.close()
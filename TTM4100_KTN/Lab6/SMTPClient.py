
from socket import *
import argparse as ap
import getpass as gp

#Get sender_email and recipient_email as arguments to the program
parser = ap.ArgumentParser(description='A test SMTP client without authentication')
parser.add_argument('-f', '--from', dest='fromMail', required=True, metavar='<sender_email>')
parser.add_argument('-t', '--to', dest='toMail', required=True, metavar='<recipient_email>')

args = parser.parse_args()
fromMail = args.fromMail #Sender's email address
toMail = args.toMail #Recipient's email address

# Message to send
msg = "\r\n I love computer networks!"
endmsg = "\r\n.\r\n"

recipient = "sjur@mail.com"
sender = "herman@mail.com"

# Address
mailserver = 'localhost'
serverPort = 12001 # Match with setup in Fake SMTP Server

# Create socket called clientSocket and establish a TCP connection
# (use the appropriate port) with mailserver
clientSocket = socket(AF_INET, SOCK_STREAM)
clientSocket.connect((mailserver, serverPort))

recv = clientSocket.recv(1024)
print recv
if recv[:3] != '220':
	print '220 reply not received from server.'

# Send HELO command and print server response.
# Can use EHLO instead since HELO is obsolete, but the latter can still be used
heloCommand = 'EHLO Hey\r\n'
clientSocket.send(heloCommand.encode()) #Python 3
recv1 = clientSocket.recv(1024)
print recv1
if recv1[:3] != '250':
	print '250 reply not received from server.'

# Send MAIL FROM command and print server response.
mailFromCommand = 'MAIL FROM:' + sender + '\r\n'
clientSocket.send(mailFromCommand.encode())
recv2 = clientSocket.recv(1024)
print recv2
if recv2[:3] != '250':
	print '250 reply not received from server.'

# Send RCPT TO command and print server response.
rcptToCommand = 'RCPT TO:' + recipient + '\r\n'
clientSocket.send(rcptToCommand.encode())
recv3 = clientSocket.recv(1024)
print recv3
if recv3[:3] != '250':
	print '250 reply not received from server.'

# Send DATA command and print server response.
dataCommand = 'DATA\r\n'
clientSocket.send(dataCommand.encode())
recv4 = clientSocket.recv(1024)
print recv4
if recv4[:3] != '354':
	print '354 reply not received from server.'

# Send message data.
clientSocket.send(msg.encode())

# Message ends with a single period.
clientSocket.send(endmsg.encode())
recv5 = clientSocket.recv(1024)
print recv5
if recv5[:3] != '250':
	print '250 reply not received from server.'

# Send QUIT command and get server response.
quitCommand = 'QUIT\r\n'
clientSocket.send(quitCommand.encode())
recv6 = clientSocket.recv(1024)
print recv6
if recv6[:3] != '221':
	print '221 reply not received from server.'

clientSocket.close()

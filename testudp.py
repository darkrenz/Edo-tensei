import asyncio
import async_timeout
import os
import socket
import# Extract the server IP and ports from the configuration
server = "0.0.0.0"
ports = range(20000, 50001)

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAMasyncio

# Configuration variables
SERVER = '0.0.0.0'
PORT_RANGE = range(20000, 50001)  # inclusive range
OBFUSCATION = 'zi'
UP_SPEED = 1  # Mbps
DOWN_SPEED = 2  # Mbps
RETRY_LIMIT = 3
SOCKS5_HOST = '127.0.0.1'
SOCKS5_PORT = 1080
INSECURE = True
CA_FILE = '/data/user/0/com.zi.zivpn/files/zi.ca.crt'  # Replace with actual file path
RECV_WINDOW_CONN = 196608
RECV_WINDOW = 491520

# Create a UDP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

# Use SOCKS5 proxy if one is specified
if SOCKS5_HOST and SOCKS5_PORT:
    import socks
    socks.set_default_proxy(socks.SOCKS5, SOCKS5_HOST, SOCKS5_PORT)
    socket.socket = socks.socksocket

# Connect to server and obfuscate if necessary
port = None
for p in PORT_RANGE:
    try:
        sock.connect((SERVER, p))
        port = p
        break
    except OSError as e:
        continue

if not port:
    raise Exception(f'Failed to connect to {SERVER} on any port in {PORT_RANGE}')

if OBFUSCATION:
    sock.send(bytes(OBFUSCATION, 'utf-8'))

# Send and receive data
recv_buf_size = min(UP_SPEED * 125000, RECV_WINDOW_CONN // 2)
send_buf_size = min(DOWN_SPEED * 125000, RECV_WINDOW // 2)
retry_count = 0
while retry_count < RETRY_LIMIT:
    # Send data
    send_data = os.urandom(send_buf_size)
    sock.send(send_data)

    # Receive data
    with async_timeout.timeout(1):
        recv_data = await loop.sock_recv(sock, recv_buf_size)
    if recv_data:
        break

    # Retry if timeout occurred
    retry_count += 1

# Close the connection and socket
sock.close()

# Output the received data
print(recv_data)

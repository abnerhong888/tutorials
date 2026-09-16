import socket
import struct


def listen_for_wol(port=9, bind_address="0.0.0.0"):
    # Create a UDP socket
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

    # Allow socket to reuse the address and bind to broadcast packets
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    sock.setsockopt(socket.SOL_SOCKET, socket.SO_BROADCAST, 1)

    # Bind to the target port across all available network interfaces
    sock.bind((bind_address, port))
    print(f"[*] Listening for WoL Magic Packets on port {port}...")

    try:
        while True:
            data, addr = sock.recvfrom(1024)

            # Check if payload is a standard WoL magic packet size (102 bytes)
            if len(data) == 102 and data.startswith(b"\xff" * 6):
                # Extract the 6-byte MAC address from bytes 6-12
                mac_raw = data[6:12]

                # Verify that the MAC address is repeated 16 times
                if data[6:] == mac_raw * 16:
                    # Format MAC address into standard xx:xx:xx:xx:xx:xx string
                    mac_str = ":".join(f"{b:02x}" for b in mac_raw)
                    print(
                        f"[+] Received WoL Magic Packet for MAC: {mac_str} from {addr[0]}:{addr[1]}"
                    )
            else:
                print(
                    f"[-] Received non-WoL UDP packet ({len(data)} bytes) from {addr[0]}:{addr[1]}"
                )

    except KeyboardInterrupt:
        print("\n[*] Shutting down WoL listener.")
    finally:
        sock.close()


if __name__ == "__main__":
    listen_for_wol(port=9)

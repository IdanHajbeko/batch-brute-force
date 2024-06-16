import hashlib
from colorama import init, Fore

init(autoreset=True)

fake_ips = [
    {"ip": "149.37.210.220", "port": 76},
    {"ip": "151.5.45.167", "port": 34},
    {"ip": "124.218.44.253", "port": 23},
    {"ip": "91.29.251.97", "port": 2020},
    {"ip": "51.237.188.40", "port": 4444}
]

password_hashes = {
    "149.37.210.220:76": {
        "username_hash": "53dd9c6005f3cdfc5a69c5c07388016d",
        "password_hash": "c378985d629e99a4e86213db0cd5e70d"
    },
    "151.5.45.167:34": {
        "username_hash": "fe75bd065ff48b91c35fe8ff842f986c",
        "password_hash": "f379eaf3c831b04de153469d1bec345e"
    },
    "124.218.44.253:23": {
        "username_hash": "1c42f9c1ca2f65441465b43cd9339d6c",
        "password_hash": "5ebe2294ecd0e0f08eab7690d2a6ee69"
    },
    "91.29.251.97:2020": {
        "username_hash": "f78f2477e949bee2d12a2c540fb6084f",
        "password_hash": "36388794be2cf5f298978498ff3c64a2"
    },
    "51.237.188.40:4444": {
        "username_hash": "7f9a6871b86f40c330132c4fc42cda59",
        "password_hash": "a9781d0ca6abb43812a28783ccb3bbaa"
    }
}

success_messages = {
    "149.37.210.220:76": "You fucking did it you hacked those mother fucker",
    "151.5.45.167:34": "we did it",
    "124.218.44.253:23": "hacked IP 124.218.44.253, port 23.",
    "91.29.251.97:2020": "Man you're good",
    "51.237.188.40:4444": "took you long enough"
}


def get_hashes(ip, port):
    ip_port_key = f"{ip}:{port}"
    if ip_port_key in password_hashes:
        username_hash = password_hashes[ip_port_key]["username_hash"]
        password_hash = password_hashes[ip_port_key]["password_hash"]

        print(f"{Fore.GREEN}Username Hash: {username_hash}")
        print(f"{Fore.GREEN}Password Hash: {password_hash}")
        if ip_port_key in success_messages:
            print(success_messages[ip_port_key])
    else:
        print(f"{Fore.RED}Invalid IP or port.")



def terminal():
    print("you can enter help")
    while True:
        command = input(f"{Fore.GREEN}Terminal>")
        parts = command.split()

        if command == 'help':
            print(f"{Fore.YELLOW}Available commands:")
            print("help - Show all commands")
            print("recon <IP> - Perform reconnaissance")
            print("get-hashes <IP> <port> - Get hashes")
            print("login <IP> <port> <username> <password> - Attempt login")
            print("back - Return to main menu")
        elif command.startswith('recon'):
            if len(parts) == 2:
                ip = parts[1]
                recon(ip)
            else:
                print(f"{Fore.RED}Invalid command syntax.")
        elif command.startswith('get-hashes'):
            if len(parts) == 3:
                ip = parts[1]
                port = int(parts[2])
                get_hashes(ip, port)
            else:
                print(f"{Fore.RED}Invalid command syntax.")
        elif command.startswith('login'):
            if len(parts) == 5:
                ip = parts[1]
                port = int(parts[2])
                username = parts[3]
                password = parts[4]
                login(ip, port, username, password)
            else:
                print(f"{Fore.RED}Invalid command syntax.")
        elif command == 'back':
            break
        else:
            print(f"{Fore.RED}Invalid command.")


def login(ip, port, username, password):
    ip_port_key = f"{ip}:{port}"
    if ip_port_key in password_hashes:
        stored_username_hash = password_hashes[ip_port_key]["username_hash"]
        stored_password_hash = password_hashes[ip_port_key]["password_hash"]

        user_hash = hashlib.md5(username.encode('utf-8')).hexdigest()
        pass_hash = hashlib.md5(password.encode('utf-8')).hexdigest()

        if user_hash == stored_username_hash and pass_hash == stored_password_hash:
            if ip_port_key in success_messages:
                print(success_messages[ip_port_key])
        else:
            print(f"{Fore.RED}Login failed.")
    else:
        print(f"{Fore.RED}Invalid IP or port.")


def recon(ip):
    for target in fake_ips:
        if target["ip"] == ip:
            port = target["port"]
            print(f"{Fore.GREEN}Scanning {ip}...\nOpen port found: {port}")
            return
    print(f"{Fore.RED}IP not found.")


def show_targets():
    print(f"{Fore.GREEN}List of targets:")
    for target in fake_ips:
        print(target["ip"])


def main():
    print(f"{Fore.GREEN}Welcome to the hacking terminal!")

    while True:
        print(f"{Fore.YELLOW}\nMenu:")
        print("1. Terminal")
        print("2. Targets")
        print("3. Exit")

        choice = input("Enter your choice: ")

        if choice == '1':
            terminal()
        elif choice == '2':
            show_targets()
        elif choice == '3':
            print(f"{Fore.CYAN}Goodbye!")
            break
        else:
            print(f"{Fore.RED}Invalid choice. Please enter 1, 2, or 3.")


if __name__ == "__main__":
    main()

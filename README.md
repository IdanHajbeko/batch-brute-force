# batch brute force and encryption tool
## Description
A basic offline brute force and encryption tool in batch + a simple game to try to brute force
## Table of Contents for the tool
- [Installation](#installation)
- [Usage](#usage)
- [customization](#customization)
- [how it works](#howitworks)

### Installation
1. Clone the repo:
   ```sh
   git clone https://github.com/IdanHajbeko/batch-brute-force.git
Or if you are lazy download it

### Usage
  1. Run the Batch File
  2. You will be prompted to enter a username and password
  - username - admin
  - password - password (Note: You can change these credentials.)
  3. Navigate the Menu
    - After logging in, you'll see a menu with two options:
      - Brute force
      - Encryption
  4. Brute Force Option
    - If you choose to brute force:
       1. Select the hash algorithm you want to use.
       2. Choose a wordlist:
          - The default list is wordlist.txt (containing 209,400 common passwords and usernames).
          - You can customize or add your own lists in the word_lists folder.
    3. Enter the hash you want to decrypt.
    4. Wait for the process to complete (this may take a while(not may it is, it will take a while(now even a while it will take a lot of time))).
  5. Encryption Option
    - If you choose to do Encryption:
       1. Select the hash algorithm you want to use.
       2. Enter the string you want to encrypt.
       3. Your hashed string will be displayed automatically
### Customization
   - The brute force and encryption tool is highly customizable
   - You can customize:
      - The art that is shown in the tool. you can customize it by changing the .txt files that are in the ascii_art directory
      - The code of the tool is also customizable you can change the brute_force.bat
      - The password and username are also customizable. yes, they are useless, and yes you can bypass them easily(compile the script for them to be a little bit effective). to change the password and username hash them into SHA512 and insert them into the hashed_username and hashed_password lines 14, 15
          - You can customize or add your own lists in the word_lists folder.
### howitworks
   
   1. Step one was to hash a string in batch:
      - There is no package or library that implements hash algorithms to batch like most programming languages.
      - But PowerShell has a command to hash strings I used this to execute the PowerShell command through batch.
   2. After that it is time to do the brute force:
      - if you don't know how brute force works I got you:
      - The user gives the script the hash and it's his type(<a href="https://hashes.com/en/tools/hash_identifier">You can get the hash type from here</a>).
      - The script goes through each word in the word list and hash it.
      - Then check if the hashed word from the word list equals the hash the user gave.
      - If it does so that word from the word list is the original string that the user gave him.


***note*** This script is very but very slow it should be never used as a tool for real uses.
# I've also created a game where you can test the brute force 

---
title: Accumulated CTF knowledge and tools
tags:
  - Advanced
  - Lunear's Notebook
  - CTF
createTime: 2025/10/18 20:31:18
permalink: /guides/ctf-second-brain/
contributors:
  - Lunear
---


## Resources

- [Picoctf](https://picoctf.org/): CMU founded CTF training and learning platform great for "learn as you go."
- [HackTheBox](https://www.hackthebox.com/): Best for beginners, offers certified courses and learning paths along with hands-on labs in combination to theory. 
- [CyberChef](https://gchq.github.io/CyberChef/): For Encryption/Decryption and Encode/Decode

## General Knowledge
::::details Terminal
- `grep`
- `strings`
- `|` (pipe)
::::

::::details TCP/IP Protocol

- Most common type of networking protocol that focuses on reliability, achived through 3 way handshake before establishing a network connection and a 4 way handshake terminating the connection.
  - 3-way handshake (establishing):
    - ==SYN flagged packet== is being sent from host machine to target machine/server 
      - "Hello are you available to connect?"
    - ==SYN-ACK flagged packet== is returned from the target machine/server back to the host, acknowledging availability through an extra ACK flag 
      - "Hello, yes! I'm able to connect"
    - ==ACK flagged packet== is sent again from the host machine to the target machine/server, officially estabilishing a connection 
      - "Awesome let's share the formula of koka-kola here"
  - 4-way handshake (terminating):
    - ==FIN flagged packet== is sent from the host to the target machine/server
      - "Yo bro imma dip."
    - ==ACK flagged packet== is sent from the target machine/server back to the host, notifiying the host that the connection is close on its end
      - "Aight bruh I gotchu, lemme send you this last thing."
    - ==FIN flagged packet== is sent from the target machine/server to the host, indicating its finalisation to the connection
      - "Alright, now I'm actually done too."
    - ==ACK flagged packet== is sent from the host machine to the target machine/server, officially closing the connection
      - (Cool, *hangs up the call)
::::

::::details OSI Model & TCP/IP Model
:::warning Under Construction
:::
  - OSI Model is the detailed version of TCP/IP, OSI consists of ==7 layers== while TCP/IP combines some of the layers into one, resulting in ==4 layers==
    - ==Layer 1: Physical==
      - This is the layer of ==hardware==, where physical wires and ports are connected
    - ==Layer 2: Data Link== 
      - This is the layer involving ==switches==, a devices that allows multiple wires to be plugged in to a single source creating a local network. ==MAC addresses== are handled through the switch to ensure that data are sent from the right machine to the right machine, where the switch has a "table" mapping each machine connected to each port to its MAC address.

      :::info MAC addresses are analogous to your SIN, ==unique in each machine==
      :::

    - ==Layer 3: Network==
      - This is the layer involving ==routers==, allows connections of multiple networks be connected into a single-big network. ==IP address== are used in a router to indicate which network the packet is being sent to, which then is processed by the switch to locate the destination machine through MAC address. This transition from layer 3 to layer 2 is done through ==ARP(Address Resolution Protocol)==

      :::info Why IP address? 
      What is the purpose of using IP address if we already have MAC addresses? As mentioned in layer 2, switches are handles MAC addresses by having an ==internal map== that stores the port with the machine being pointed. Now imagine you have the entire world's network connection depending on MAC address, this quickly becomes a problem as adding/removing will have to update the internal map of ==each and every switch==. IP address solves this issue by simply directing the packet from one network to another and leave the MAC address work to a specific switch.
      :::
    - ==Layer 4: Transport==
      - This layer is concerned about how the data is being transported, here is where ==TCP (Transmission Control Protocol) and UDP (User Datagram Protocol)== comes into play. ==TCP prioritises reliability==, whether the packet is successfully delivered (Amazon Prime Pro Max), and ==UDP prioritises speed==, where packets are pass send constantly through the network to everyone. 
    - ==Layer 5: Session==
    - ==Layer 6: Presentation==
    - ==Layer 7: Application==

::::
## Forensics

- ==Base64 encoding:== transforms any binary data (like images or files) into a string of printable ASCII characters
- ==Steganography:== method that hides information in a non-secret file such as an image, or audio. The existence of the hidden message is unobservable to the viewer. Some of the most common techniques used includes LSB (least significant bit).
- ==Network Protocol Analysis:==

:::::collapse accordion

- Tools
  ::::details Image Analysis
    - `zsteg`: Package based on Ruby allows user to check metadata of images and steganography; specifically for `.png` and `.bmp` images. It analyzes images to detect hidden data and extract hidden information on least significant and other steganography techniques.
    - `steghide`: Steganography tool used to hide/reveal hidden data in images/audio files; mostly used with `.jpeg`, `.bmp`, `.wav`, and `.au` files.
    - `identify`: Tool from ImageMagick, used to analyze and display information about image files such as image format, dimensions, file size, medatadata and properties.
    
    ==Skills:==
    - Converting files to `base64` and to an image file
     ```bash
    # -d stands for decode
    cat file.txt | base64 -d > file.jpeg
    ```
  ::::

  :::: details Networking
    - [Wireshark](https://www.wireshark.org/): Tool for network package analysis for `pcap` and `pcapng`files. It breaksdown the networking traffic and displays a wide range of information, including network protocols, destination IP address and target addresses, file uploads, etc... 
  ::::
:::::

## Cryptography

- ==Hash:== Hash encryption generates a unique hashcode for each piece of data. It is often used to check file integrity by comparing the hash value of the package being installed and the original package to prevent potential modifications from unauthorized parties. Given a hashed value, to try to get the original value, we can use wordlist and word maps and try all different combinations to get their hashcode and comparing to the given hashed value. This is called bruteforce attacking/guess and checking.

- ==RSA Encryption:== Asymmetric encryption that involves the encrypted message (C), the original message (M), public key (e, n), and private key (d, n). Where `d` and `e` are prime of the product `n`. 
  - Mathematical relationships are:
    - Encryption C ≡ Mᵉ (mod n)
    - Decryption M ≡ Cᵈ (mod n)
    :::info Note
    `≡` indicates congruence, where under the context of `A ≡ B (mod n)`, 
    it means ==A and B have the same remainder when divided by n.==
    ::: 

    ::::::collapse accordion
    
    - Example Use of RSA
      #### Key Generation (Creating the Padlock and Key)
      ::::info This is the most complex part, done once by the receiver (let's call her Alice).
      ::::
        ::::steps
        - Choose Two Prime Numbers: Alice picks two large, random, and distinct prime numbers, `p` and `q`.
          - Example (using small, manageable numbers): `p = 3`, `q = 11`
        - Calculate the Modulus (n): Multiply `p` and `q` to get `n`. This number will be part of both the public and private keys.
          - `n = p * q = 3 * 11 = 33`
          - `n` is the "padlock" itself. Its length in bits (e.g., 2048, 4096) is what we refer to as the "key size" and determines the security.
        - Calculate Euler's Totient (φ(n)): This is `φ(n) = (p-1) * (q-1)`. It's the number of integers less than `n` that are relatively prime to `n` (i.e., share no common factors with `n`).
          - `φ(n) = (3-1) * (11-1) = 2 * 10 = 20`
        - Choose the Public Exponent (e): Alice picks a number `e` that must be:
          - Less than `φ(n)` (which is 20).
          - A coprime with `φ(n)` (meaning they share no common factors other than 1).
          - Example: `e = 7` (7 and 20 share no common factors).
          :::info The pair (e, n) is the Public Key. Alice can broadcast this to the world. In our example, the public key is (7, 33).
          :::
        - Calculate the Private Exponent (d): This is the magic step. Alice calculates `d`, which is the modular multiplicative inverse of `e mod φ(n)`. In simpler terms, `d` is the number that satisfies this equation:
          - (d * e) mod φ(n) = 1
          - (d * 7) mod 20 = 1
          - After calculating, d = 3 (because 3 * 7 = 21, and 21 mod 20 = 1).
          :::info
          The pair (d, n) is the Private Key. Alice must guard this with her life. In our example, the private key is (3, 33).
          :::
        ::::

        ::::steps
        #### Encryption (Locking the Message)
        :::info Now, someone else (Bob) wants to send Alice a secret message. The message must be a number M less than n. (In real life, text is converted into a large number).
        :::
        - Bob gets Alice's Public Key: `(e, n) = (7, 33)`.
        - He has his message, which is a number `M`. Let's say `M = 4` (for example, representing the letter 'D').
        - He encrypts it using the encryption formula to get the ciphertext `C`:
          -`C = M^e mod n`
          - `C = 4^7 mod 33`
            - Let's calculate: `4^7 = 16,384`
            - `16,384 / 33 = 496.606...` ->` 33 * 496 = 16,368`
            - `16,384 - 16,368 = 16`
            - So, `C = 16`
        - Bob sends the ciphertext C = 16 to Alice.
        ::::

        ::::steps 
        #### Decryption (Unlocking the Message)
        :::info 
        Alice receives the ciphertext C = 16. She uses her Private Key: (d, n) = (3, 33).
        :::
        - She decrypts it using the decryption formula to recover the original message M:
          - `M = C^d mod n`
          - `M = 16^3 mod 33`
            - Let's calculate: `16^3 = 4,096`
            - `4,096 / 33 = 124.121...` -> `33 * 124 = 4,092`
            -` 4,096 - 4,092 = 4`
          - So, `M = 4`
        - Alice has successfully decrypted the secret message 4 that Bob sent.
        ::::
    ::::::

:::::collapse accordion

- Tools
  ::::details Hack-cracking
    - `hashcat`: GPU-accelerated tool for hash-cracking such as SHA1, SHA2-256, MD5, bcrypt.
      ```bash
      hashcat -m (hashtype: 0 = MD5, 100 = SHA1, 1400 = SHA2-256, 3200 = bcrypt) -a 0 (hashed text) (wordlist path)
      ```
  ::::

:::::

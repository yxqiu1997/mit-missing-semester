# Exercise 9: Security and Cryptography

## Entropy

1. Suppose a password is chosen as a concatenation of four lower-case dictionary words, where each word is selected uniformly at random from a dictionary of size 100,000. An example of such a password is `correcthorsebatterystaple`. How many bits of entropy does this have?

    **Answer**
    
    $$possibilities = 100000^4 = 10^{20}$$
    $$entropy = log_210^{20} \approx 66 bits$$

2. Consider an alternative scheme where a password is chosen as a sequence of 8 random alphanumeric characters (including both lower-case and upper-case letters). An example is `rg8Ql34g`. How many bits of entropy does this have?

    **Answer**

    $$possibilities = (26 + 26 + 10)^8 = 62^8$$
    $$entropy = log_262^8 \approx 48 bits$$

3. Which is the stronger password?

    **Answer**

    The first one is stronger whose entropy is higher.

4. Suppose an attacker can try guessing 10,000 passwords per second. On average, how long will it take to break each of the passwords?

    **Answer**

    $$attack\ number = 10000 \times 60 \times 60 \times 24 \times 365 = 31536\times 10^7$$
    $$first\ average = 10^{20}\div (31536\times 10^7) \approx 3\times 10^8\ years$$
    $$second\ average = 62^8\div (31536\times 10^7) \approx 692\ years$$

## Cryptographic hash functions

1. Download a Debian image from a [mirror](https://www.debian.org/CD/http-ftp/) (e.g. [from this Argentinean mirror](http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/). Cross-check the hash (e.g. using the `sha256sum` command) with the hash retrieved from the official Debian site (e.g. [this file](https://cdimage.debian.org/debian-cd/current/amd64/iso-cd/SHA256SUMS) hosted at `debian.org`, if you've downloaded the linked file from the Argentinean mirror).

    **Solution**

    ```bash
    # -O, --remote-name  Save the server response to a file, whose name is the last part of the URL.

    # -L, --location  HTTP request will follow the server redirection.

    # -C, --continue-at <offset>  Continue/Resume a previous file transfer at the given offset.

    curl -O -L -C - http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/debian-mac-11.2.0-amd64-netinst.iso

    curl -O http://debian.xfree.com.ar/debian-cd/current/amd64/iso-cd/SHA256SUMS

    grep -i "debian-mac-11.2.0-amd64-netinst.iso" ./SHA256SUMS | shasum --check
    ```

## Symmetric cryptography

1. Encrypt a file with AES encryption, using
   [OpenSSL](https://www.openssl.org/): `openssl aes-256-cbc -salt -in {input filename} -out {output filename}`. Look at the contents using `cat` or
   `hexdump`. Decrypt it with `openssl aes-256-cbc -d -in {input filename} -out {output filename}` and confirm that the contents match the original using
   `cmp`.

    **Solution**

    ```bash
    echo "secret contents" > secret.txt

    openssl aes-256-cbc -salt -in secret.txt -out secret.enc.txt

    openssl aes-256-cbc -d -in secret.enc.txt -out secret.dec.txt

    # No return if two files are identical.
    cmp secret.txt secret.dec.txt
    ```

## Asymmetric cryptography

1. Set up [SSH keys](https://www.digitalocean.com/community/tutorials/how-to-set-up-ssh-keys--2) on a computer you have access to (not Athena, because Kerberos interacts weirdly with SSH keys). Rather than using RSA keys as in the linked tutorial, use more secure [ED25519 keys](https://wiki.archlinux.org/index.php/SSH_keys#Ed25519). Make sure your private key is encrypted with a passphrase, so it is protected at rest.

    **Solution**

    ```bash
    # -t  Specifies the type of key to create.
    ssh-keygen -t ed25519
    ```

2. [Set up GPG](https://www.digitalocean.com/community/tutorials/how-to-use-gpg-to-encrypt-and-sign-messages)

    **Solution**

    ```bash
    gpg --gen-key

    gpg --output ~/revocation.crt --gen-revoke person@email.com

    chmod 600 ~/revocation.crt
    ```
    
3. Send Anish an encrypted email ([public key](https://keybase.io/anish)).

    **Solution**

    ```bash
    gpg --encrypt --sign --armor -r person@email.com filename
    ```

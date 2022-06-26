# Exercise 1: Course overview + the shell

1. Create a new directory called `missing` under `/tmp`.

   **Solution:**
   ```bash
   # -p: 确保目录存在，不存在的话就新建一个
   mkdir -p /tmp/missing
   ```

2. Look up the `touch` program. The `man` program is your friend.

   **Solution:**
   ```bash
   man touch
   ```

3. Use `touch` to create a new file called `semester` in `missing`.

   **Solution:**
   ```bash
   # 省略cd
   touch semester
   ```

4. Write the following into that file, one line at a time:

   ```bash
   #!/bin/sh
   curl --head --silent https://missing.csail.mit.edu
   ```
   
   **Solution:**
   ```bash
   echo '#!/bin/sh' > semester
   echo 'curl --head --silent https://missing.csail.mit.edu' >> semester
   ```

5. Use `chmod` to make it possible to run the command `./semester` rather than having to type `sh semester`.
  
   **Solution:**
   ```bash
   # Why the shell knows that the file is supposed to be interpreted using? - The file has '#!/bin/sh' at the beginning.
   # read = 4, write = 2, execute = 1
   # Three numbers indicates different permission for the owner, users in group and anyone else.
   # 755 meams rwx r-x r-x
   chmod 755 semester
   ```

6. Use `|` and `>` to write the "last modified" date output by
   `semester` into a file called `last-modified.txt` in your home
   directory.

   **Solution:**

   ```bash
   # -i: ignore case
   # -d'': use the space as delimiter
   # -f2-: cut from the second element (the second '-' is very IMPORTANT!)
   sh semester.sh | grep -i last-modified | cut -d' ' -f2- > last-modified.txt
   ```

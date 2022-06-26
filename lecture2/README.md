# Exercise 2: Shell Tools and Scripting

1. Read [`man ls`](https://www.man7.org/linux/man-pages/man1/ls.1.html) and write an `ls` command that lists files in the following manner:

   - Includes all files, including hidden files
   - Sizes are listed in human readable format (e.g. 454M instead of 454279954)
   - Files are ordered by recency
   - Output is colorized

   A sample output would look like this

   ```bash
   -rw-r--r--   1 user group 1.1M Jan 14 09:53 baz
   drwxr-xr-x   5 user group  160 Jan 14 09:53 .
   -rw-r--r--   1 user group  514 Jan 14 06:42 bar
   -rw-r--r--   1 user group 106M Jan 13 12:12 foo
   drwx------+ 47 user group 1.5K Jan 12 18:08 ..
   ```

   **Solution**
   ```bash
   # -l  (The lowercase letter “ell”.) List files in the long format, as described in the The Long Format subsection below.

   # -a  Include directory entries whose names begin with a dot (‘.’).

   # -t  Sort by descending time modified (most recently modified first).  If two files have the same modification timestamp, sort their names in ascending lexicographical order.  The -r option reverses both of these sort orders.

   # -h  When used with the -l option, use unit suffixes: Byte, Kilobyte, Megabyte, Gigabyte, Terabyte and Petabyte in order to reduce the number of digits to four or fewer using base 2 for sizes.  This option is not defined in IEEE Std 1003.1-2008 (“POSIX.1”).

   # --color=when  Output colored escape sequences based on when, which may be set to either always, auto, or never.
   ```
   ```bash
   ls -lath --color=always
   ```

2. Write bash functions `marco` and `polo` that do the following.
   Whenever you execute `marco` the current working directory should be saved in some manner, then when you execute `polo`, no matter what directory you are in, `polo` should `cd` you back to the directory where you executed `marco`.
   For ease of debugging you can write the code in a file `marco.sh` and (re)load the definitions to your shell by executing `source marco.sh`.

   [**Solution**](2-macro.sh)

3. Say you have a [command](3-command.sh) that fails rarely. In order to debug it you need to capture its output but it can be time consuming to get a failure run. Write a bash script that runs the following script until it fails and captures its standard output and error streams to files and prints everything at the end. Bonus points if you can also report how many runs it took for the script to fail.

   [**Solution**](3-debug.sh)

4. As we covered in the lecture `find`'s `-exec` can be very powerful for performing operations over the files we are searching for.
   However, what if we want to do something with **all** the files, like creating a zip file?
   As you have seen so far commands will take input from both arguments and STDIN.
   When piping commands, we are connecting STDOUT to STDIN, but some commands like `tar` take inputs from arguments.
   To bridge this disconnect there's the [`xargs`](https://www.man7.org/linux/man-pages/man1/xargs.1.html) command which will execute a command using STDIN as arguments.
   For example `ls | xargs rm` will delete the files in the current directory.

   Your task is to write a command that recursively finds all HTML files in the folder and makes a zip with them. Note that your command should work even if the files have spaces (hint: check `-d` flag for `xargs`)

   **Solution**
   ```bash
   # -print0  This primary always evaluates to true.  It prints the pathname of the current file to standard output, followed by an ASCII NUL character (character code 0).

   # -0  Change xargs to expect NUL (``\0'') characters as separators, instead of spaces and newlines.  This is expected to be used in concert with the -print0 function in find(1).

   # -c  Create a new archive containing the specified items.  The long option form is --create.

   # -f file, --file file  Read the archive from or write the archive to the specified file. The filename can be - for standard input or standard output.

   #  -v, --verbose  Produce verbose output.  In create and extract modes, tar will list each file name as it is read from or written to the archive.

   # -z, --gunzip, --gzipb (c mode only) Compress the resulting archive with gzip(1).  
   ```
   ```bash
   find . -type f -name "*.html" -print0 | xargs -0 tar -cvzf archive.tar.gz
   ```

5. (Advanced) Write a command or script to recursively find the most recently modified file in a directory. More generally, can you list all files by recency?

    ```bash
    # -f format  Display information using the specified format.

    # -r reverse

    # -n, --numeric-sort, --sort=numeric  Sort fields numerically by arithmetic value. 

    # %a/%m/%c/%B  The time file was last accessed or modified, of when the inode was last changed, or the birth time of the inode.

    # %N  The name of the file.
    ```
    ```bash
    # Recursively find the most recently modified file in a directory
    find . -type f -print0 | xargs -0 stat -f "%a %N" | sort -rn | head -n 1 | cut -d' ' -f2-
    ```

    ```bash
    # List all files by recency 
    find . -type f -print0 | xargs -0 stat -f "%a %N" | sort -rn | cut -d' ' -f2-
    ```

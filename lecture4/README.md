# Exercise 4: Data Wrangling

1. Take this [short interactive regex tutorial](https://regexone.com/).

2. Find the number of words (in `/usr/share/dict/words`) that     contain at least three `a`s and don't have a `'s` ending. The `tr` program, may help you with case insensitivity. 
   
   2.1 How many words that satisfy the requirement?

    **Solution**
    ```bash
    # [:class:]  Represents all characters belonging to the defined character class.
    # .*?a.*?  Any character, any times before and after a, both no greedy
    # {3}  At least three a characters
    # ([^`][^s])? Exclude 's, no greedy
    ```
    ```bash
    cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | awk "/(.*?a.*?){3}([^'][^s])?/" | wc -l
    ```
    
    OR

    ```bash
    # -i, --ignore-case  Perform case insensitive matching.
    # -c, --count  Only a count of selected lines is written to standard output.
    # -E, --extended-regexp  Interpret pattern as an extended regular expression  
    # ^  Begin of the line
    # $  End of the line 
    # \w  Any non-word character
    ```
    ```bash
    grep -icE "^(\w*?a\w*?){3}([^'][^s])?$" /usr/share/dict/words
    ```

    OR

    ```bash
    # grep -E "^([^a]*a){3}.*$"  Using extended regular expression which matches a non-a string and an a three times. The rest of the sequence can be any characters. 
    ```
    ```bash
    cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep -E "^([^a]*a){3}.*$" | grep -vE "^'s$" | wc -l
    ```

    2.2 What are the three most common last two letters of those words? 

    **Solution**
    ```bash
    # -k field1[,field2], --key=field1[,field2]  Define a restricted sort key that has the starting position field1, and optional ending position field2 of a key field.
    ```
    ```bash
    grep -iE "^(\w*?a\w*?){3}([^'][^s])?$" /usr/share/dict/words | awk '{print substr($0, length()-1)}' | sort | uniq -c | sort -rnk1,1 | head -n 3 | awk '{print $0}'
    ```

    OR 

    ```bash
    # sed -E 's/.*([a-z]{2})$/\1/'  Match strings that end with two characters. Store the last two letters in the first capture group and replace the occurance of the regular expression with them. In other words, for those occurances, preserve the last two letters only.
    ```
    ```bash
    cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep -E "^([^a]*a){3}.*$" | grep -vE "^'s$" | sed -E "s/.*([a-z]{2})$/\1/" | sort | uniq -c | sort -rnk1,1 | head -n 3
    ```

    2.3 How many of those two-letter combinations are there?

    **Solution**
    ```bash
    cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep -E "^([^a]*a){3}.*$" | grep -vE "^'s$" | sed -E "s/.*([a-z]{2})$/\1/" | sort | uniq | wc -l
    ```
   
    2.4 And for a challenge: which combinations do not occur?

    **Solution**
    ```bash
    cat /usr/share/dict/words | tr "[:upper:]" "[:lower:]" | grep -E "^([^a]*a){3}.*$" | grep -vE "^'s$" | sed -E "s/.*([a-z]{2})$/\1/" | sort | uniq > 2-last-two-letters.txt
    ```
    ```bash
    sh 1-get-all-letters.sh 
    ```
    ```bash
    # --changed-group-format --unchanged-group-format  filter
    # %<  Get lines from FILE1
    # %>  Get lines from FILE2
    
    diff --changed-group-format="%<" --unchanged-group-format="" 2-all-letters.txt 2-last-two-letters.txt >> 2-remain-combinations.txt
    ```

3. To do in-place substitution it is quite tempting to do something like `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt`. However this is a bad idea, why? Is this particular to `sed`? Use `man sed` to find out how to accomplish this.

    **Solution**
    ```bash
    # -i extension  Edit files in-place similarly to -I, but treat each file independently from other files.  In particular, line numbers in each file start at 1, the “$” address matches the last line of the current file, and address ranges are limited to the current file. (See Sed Addresses.) The net result is as though each file were edited by a separate sed instance.
    ```
    
    `sed s/REGEX/SUBSTITUTION/ input.txt > input.txt` will return an empty `input.txt`, as the right side of the operator `>` will be performed before the left side. In other words, the regular expression will be applied on a totally empty file, and the command will output it either.

    To do in-place substitution is dangerous as there will be no backup for recover when something goes wrong. This is not particular to `sed`, we can use `-i` to remain independency.

4. Find your average, median, and max system boot time over the last ten boots. Use `journalctl` on Linux and `log show` on macOS, and look for log timestamps near the beginning and end of each boot.
    
    **Solution**
    ```bash
    log show | grep -E "=== system boot:|Previous shutdown cause: 5" > 4-boot-log.txt
    ```
    ```bash
    # xargs -n 2  2 row 1 col -> 1 row 2 col
    # awk '{print $2"-"$1}' | bc  Use the string "-" to concatenate and bc to calculate.
    ```
    ```bash
    cat 4-boot-log.txt | awk '{print $2}' | sed -E "s/.*:(.*)/\1/" | xargs -n 2 | awk '{print $2"-"$1}' | bc | R --slave -e 'x <- scan(file="stdin", quiet=TRUE); summary(x)'
    ```

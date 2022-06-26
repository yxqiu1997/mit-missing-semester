# Exercise 5: Command-line Environment

## Job Control

1. From what we have seen, we can use some `ps aux | grep` commands to get our jobs' pids and then kill them, but there are better ways to do it. Start a `sleep 10000` job in a terminal, background it with `Ctrl-Z` and continue its execution with `bg`. Now use [`pgrep`](https://www.man7.org/linux/man-pages/man1/pgrep.1.html) to find its pid and [`pkill`](http://man7.org/linux/man-pages/man1/pgrep.1.html) to kill it without ever typing the pid itself. (Hint: use the `-af` flags).

    **Solution**
    ```bash
    #- a  Include process ancestors in the match list.  By default, the current pgrep or pkill process and all of its ancestors are excluded (unless -v is used).

    # -f  Match against full argument lists.  The default is to match against process names.
    ```
    ```bash
    # Find the pid
    pgrep sleep

    # Kill it without ever typing th pid itself
    pkill -af sleep
    ```

2. Say you don't want to start a process until another completes, how you would go about it? In this exercise our limiting process will always be `sleep 60 &`. One way to achieve this is to use the [`wait`](http://man7.org/linux/man-pages/man1/wait.1p.html) command. 

    2.1 Try launching the sleep command and having an `ls` wait until the background process finishes.

    **Solution**
    ```bash
    sleep 60 &
    # command1 && command2  The command2 can only be performed after the command1 returns a true(0) value.
    pgrep sleep | wait && ls
    ```

    2.2 However, this strategy will fail if we start in a different bash session, since `wait` only works for child processes. One feature we did not discuss in the notes is that the `kill` command's exit status will be zero on success and nonzero otherwise. `kill -0` does not send a signal but will give a nonzero exit status if the process does not exist.

    Write a bash function called `pidwait` that takes a pid and waits until the given process completes. You should use `sleep` to avoid wasting CPU unnecessarily.

    **Solution**

    [pidwait](pidwait)

    ```bash
    # kill -0  Check if a given pid can be killed.
    # The pidwait function does not depend on the wait command. Hence, it is irrelevant to the session and child processes.
    ```
    ```bash
    source pidwait
    sleep 60 &
    pidwait $(pgrep sleep)
    ```

## Aliases

1. Create an alias `dc` that resolves to `cd` for when you type it wrongly.

    **Solution**
    ```bash
    alias dc="cd"
    ```

2. Run `history | awk '{$1="";print substr($0,2)}' | sort | uniq -c | sort -n | tail -n 10` to get your top 10 most used commands and consider writing shorter aliases for them. Note: this works for Bash; if you're using ZSH, use `history 1` instead of just `history`.

    **Solution**
    ```bash
    alias ll="ls -lah"
    ```

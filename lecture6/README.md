# Exercise 6: Version Control (Git)

1. Clone the [repository for the class website](https://github.com/missing-semester/missing-semester).

    **Solution**
    ```bash
    git clone git@github.com:missing-semester/missing-semester.git
    ```

    1.1 Explore the version history by visualizing it as a graph.

    **Solution**
    ```bash
    cd missing-semester
    git log --all --graph --decorate --oneline
    ```

    1.2 Who was the last person to modify `README.md`? (Hint: use `git log` with an argument)

    **Solution**
    ```bash
    # The last person who modified the file is on the top of the tree graph.
    git log --all --graph --decorate README.md
    ```
  
    1.3 What was the commit message associated with the last modification to the `collections:` line of `_config.yml`? (Hint: use `git blame` and `git show`)

    **Solution**
    ```bash
    git blame _config.yml
    git show a88b4eac  # Redo lectures as a collection
    ```

2. One common mistake when learning Git is to commit large files that should not be managed by Git or adding sensitive information. Try adding a file to a repository, making some commits and then deleting that file from history (you may want to look at [this](https://help.github.com/articles/removing-sensitive-data-from-a-repository/)).

    **Solution**
    ```bash
    brew install git-filter-repo
    echo "first sensitive data" > sensitive.txt
    git add sensitive.txt
    git commit -m 'first commit sensitive.txt'
    echo "second sensitive data" >> sensitive.txt
    git add sensitive.txt
    git commit -m 'second commit sensitive data'
    git log --all --graph --decorate --oneline
    git filter-repo --invert-paths --path ./sensitive.txt
    git log --all --graph --decorate --oneline
    ```
3. Like many command line tools, Git provides a configuration file (or dotfile) called `~/.gitconfig`. Create an alias in `~/.gitconfig` so that when you run `git graph`, you get the output of `git log --all --graph --decorate --oneline`

    **Solution**
    ```bash
    [alias]
    lg = log --all --graph --decorate --oneline
    ```


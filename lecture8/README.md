# Exercise 8: Metaprogramming

1.  Most makefiles provide a target called `clean`. This isn't intended to produce a file called `clean`, but instead to clean up any files that can be re-built by make. Think of it as a way to "undo" all of the build steps. Implement a `clean` target for the `paper.pdf` `Makefile` above. You will have to make the target
 [phony](https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html). You may find the [`git ls-files`](https://git-scm.com/docs/git-ls-files) subcommand useful. A number of other very common make targets are listed [here](https://www.gnu.org/software/make/manual/html_node/Standard-Targets.html#Standard-Targets).

    ```bash
    # A phony target is one that is not really the name of a file; rather it is just a name for a recipe to be executed when you make an explicit request. There are two reasons to use a phony target: to avoid a conflict with a file of the same name, and to improve performance.

    # git-ls-files - Show information about files in the index and the working tree

    # -o --others  Show other (i.e. untracked) files in the output
    ```

    [**Solution**](Makefile)

    ```bash
    # Lines in the Makefile must start with `tab`, otherwise the `make` command will occur a `missing separator` error.
    vi ~/.vimrc
    set ts = 4 sw = 4
    :wq

    # Make plot.py executable
    chmod +x plot.py

    # Install MacTex to execute pdflatex
    brew install --cask mactex

    make

    make clean
    ```

2. Take a look at the various ways to specify version requirements for dependencies in [Rust's build system](https://doc.rust-lang.org/cargo/reference/  specifying-dependencies.html). Most package repositories support similar syntax. For each one (caret, tilde, wildcard, comparison, and multiple), try to come up with a use-case in which that particular kind of requirement makes sense.

    **Solution**
    
    ```bash
    # Caret requirements
    # An update is only allowed without a change in the major version.

    ^1.2.3  :=  >=1.2.3, <2.0.0
    ^1.2    :=  >=1.2.0, <2.0.0
    ^1      :=  >=1.0.0, <2.0.0
    ^0.2.3  :=  >=0.2.3, <0.3.0
    ^0.2    :=  >=0.2.0, <0.3.0
    ^0.0.3  :=  >=0.0.3, <0.0.4
    ^0.0    :=  >=0.0.0, <0.1.0
    ^0      :=  >=0.0.0, <1.0.0
    ```
    
    ```bash
    # Tilde requirements
    # Only patch-level changes are allowed.
    
    ~1.2.3  := >=1.2.3, <1.3.0
    ~1.2    := >=1.2.0, <1.3.0
    ~1      := >=1.0.0, <2.0.0
    ```

    ```bash
    # Wildcard requirements
    # Any update within the range is allowed. 

    *     := >=0.0.0
    1.*   := >=1.0.0, <2.0.0
    1.2.* := >=1.2.0, <1.3.0
    ```

    ```bash
    # Comparison requirements
    # Allow manually specifying a version range or an exact version.

    >= 1.2.0
    > 1
    < 2
    = 1.2.3
    ```

    ```bash
    # Multiple requirements
    # Multiple version requirements can be seperated with a comma, useful in setting an interval for version requirements of dependencies.

    >= 1.2, < 1.5
    ```

3. Git can act as a simple CI system all by itself. In `.git/hooks` inside any git repository, you will find (currently inactive) files that are run as scripts when a particular action happens. Write a [`pre-commit`](https://git-scm.com/docs/ githooks#_pre_commit) hook that runs `make paper.pdf` and refuses the commit if the `make` command fails. This should prevent any commit from having an unbuildable version of the paper.

    [**Solution**](../../../.git/hooks/pre-commit)

4. Set up a simple auto-published page using [GitHub Pages](https://help.github.com/en/actions/automating-your-workflow-with-github-actions). Add a [GitHub Action](https://github.com/features/actions) to the repository to run `shellcheck` on any shell files in that repository (here is [one way to do it](https://github.com/marketplace/actions/shellcheck)). Check that it works!

    [**Solution**](../../../.github/workflows/cs-courses.yml)

    All page themes are listed in this [page](https://pages.github.com/themes/). The configuration file is [here](../../../_config.yml).

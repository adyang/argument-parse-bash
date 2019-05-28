# Argument Parsing in BASH
There are a few ways to parse arguments in bash. The following 2 ways will allow parsing of both short and long options:
  1. Plain BASH
      * Shorter but possibly less robust
  2. GNU getopt
      * Requires GNU getopt from util-linux package (installed on most Linux machines)
      * Might be more robust
      * Some support of optional arguments with some limitations (see argparse-getopt.bats for more information)

## Running the Tests
[bats-core](https://github.com/bats-core/bats-core) is required to run the tests.

On MacOS, install via homebrew:
```console
brew install bats-core
```

In addition, GNU getopt is required to run the argparse script that uses it:
```console
brew install gnu-getopt
echo 'export PATH="/usr/local/opt/gnu-getopt/bin:$PATH"' >> ~/.bashrc
```
Replace `~/.bashrc` with your appropriate shell profile (follow the homebrew instructions).

Run the tests:
```console
bats test/*.bats
```

Or to list the test file before each suite of tests:
```console
for test in test/*.bats; do printf "\n${test}\n"; bats "${test}"; done
```

## References
* [Stackoverflow: More succinct way to parse command line arguments in bash](https://stackoverflow.com/a/33826763)
* [Stackoverflow: Three implementations of getopt(s)](https://stackoverflow.com/a/402410)
* [Github Gist: Standard bash script format](https://gist.github.com/hfossli/4368aa5a577742c3c9f9266ed214aa58)
* [Easy getopt for a BASH script](https://dustymabe.com/2013/05/17/easy-getopt-for-a-bash-script/)
* [Parse options in your bash script with getopt](https://linuxaria.com/howto/parse-options-in-your-bash-script-with-getopt)
* [Stackoverflow: getopt does not parse optional arguments to parameters](https://stackoverflow.com/a/1052750)

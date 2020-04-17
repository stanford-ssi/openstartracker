#!/bin/bash

# we assume that docker has already been installed

docker build -t startracker1 .

# directory of this setup.sh script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

alias dstart='docker run -it -v '$DIR'/:/home startracker1'

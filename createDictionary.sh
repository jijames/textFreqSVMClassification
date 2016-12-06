#!/bin/bash

function usage(){
    echo "$0 is a script to create a dictionary from a folder (and subfolders)"
    echo "USAGE: $0 folder"
    echo "    folder: is the folder containing all the text files to be included in the dictionary"
}

if [ "$#" -ne 1 ]; then
    usage
    exit
fi

# Create a dictionary of all words in a directory recursively
$(find $1 -name '*.txt' -exec cat {} \; | tr -d '[:punct:]' | tr '[:space:]' '[\n*]' | tr '[:upper:]' '[:lower:]' | grep -v "^\s*$" | sort | uniq | awk '{print $1}' | nl | awk '{print $1 " " $2}' > dictionary.dat)

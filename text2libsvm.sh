#!/bin/bash

# $1 is the email data, $2 is the dictionary

function usage(){
    echo "$0 is a script to convert email text to libsvm format."
    echo "USAGE: $0 eMail dictionary [label]"
    echo "    eMail: Raw text file you would like to analize"
    echo "    dictionary: the pre-created dictionary with index value pairs"
    echo "    an optional label you want to give the email (default is 1)"
}

if [ "$#" -lt 2 ]; then
	usage
	exit
fi

if [ "$#" -eq 3 ]; then
   label=$3
else
   label="1"
fi
echo "[I] Label has been set to $label"

tempText=$(mktemp)
keyReplace=$(mktemp)
#echo "[I] Temp file created at $keyReplace"

#process incoming text file
cat $1 | tr -d '[:punct:]' | tr '[:space:]' '[\n*]' | tr '[:upper:]' '[:lower:]' | grep -v "^\s*$" | sort | uniq -c | awk '{print $1 " " $2}' > $tempText

while read line; do
    count=$(echo $line | awk '{print $1}')
    word=$(echo $line | awk '{print $2}')
    key=$(cat $2 | grep -w $word | awk '{print $1}')
    $(echo $key " " $count | awk '{print $1 ":" $2}' >> $keyReplace)
done < $tempText

$(cat $keyReplace | tr '\n' ' ' | sed -e "s/^/$label /" | sed "s/ *$/\n/g" >> text.libsvm)


rm $tempText
rm $keyReplace

#!/bin/bash

#If called with args, use the first one, if not prompt for a word to define
if [ $# -eq 0 ]; then
    read -p "Define => " word
else
    word=$1
fi

#curl request for specific word
response=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$word")

#Output first sentence of the first three definitions
echo "$response" |
    grep -o '"definitions":\[[^]]*' |
    awk -F'"definition":' '{ for(i=2; i<=NF; i++) print $i }' |
    sed 's/^\["//' |
    sed 's/",$//' |
    sed 's/\([^".]*\)\..*/\1"/' |
    sed 's/,"synonyms":.*//' |
    head -n 3

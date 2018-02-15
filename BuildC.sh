#!/bin/bash

#Color Variables
Reset='\033[0m'
Green='\033[32m'
Red='\033[91m'
Blue='\033[34m'

#Compile Failed Flag
FLAG=false

if [ $# -ne 0 ]; then
  echo "Usage: BuildC"
  exit 1
fi

if [ ! -d "src" ]; then
  echo "Error: No src directory!"
  exit 2
fi

echo -e "${Blue}Found $( ls -R | grep -E ^.+\\.c$ | wc -l ) source files.${Reset}"

cd src
for FILE in $( ls -R | grep -E ^.+\.c$ ); do
  echo "Compiling: $FILE"
  gcc -Wall -std=c99 -o $( echo "$FILE" | cut -d'.' -f 1 ) $FILE
  if [ $? -eq 0 ]; then
    echo -e "${Green}Successfully compiled: $FILE${Reset}"
  else
    echo -e "${Red}ERROR: Compilation failed for $FILE${Reset}!"
    FLAG=true
  fi
done

if [ "$FLAG" = true ]; then
  echo -e "${Red}PROJECT BUILD FAILED!${Reset}"
else
  echo -e "${Blue}PROJECT WAS BUILT SUCCESSFULLY!${Reset}"
fi
exit 0

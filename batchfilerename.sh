#!/bin/bash

#Get the input for the Directory name and file name

REQUIRED_FILE_NAME="${1}"

DIRECTORY_NAME="${2}"

#Current Directory

#CURRENT_DIRECTORY=$(pwd)

#Check if any Directory Name is provided or not.

MESSAGE="USAGE : ${0} FILE NAME [DIRECTORY NAME]"

if [[ -z "${DIRECTORY_NAME}" ]]
then
    # echo "DIRECTORY NAME is not provided...So considering the current Directory !!!"
    # FINAL_DIRECTORY="${CURRENT_DIRECTORY}"
    echo "${MESSAGE}"
else
    FINAL_DIRECTORY="${DIRECTORY_NAME}"
fi

#Check if File Name is provided or not.
if [[ -z "${REQUIRED_FILE_NAME}" ]]
then
    echo "${MESSAGE}"
    exit 1
fi

# Display the required File name
echo "Required File Name is $1"

#List the files and store it in a variable.
touch files.txt
ls -p "${FINAL_DIRECTORY}" | grep -v / > files.txt

#NUMBERS
NO_OF_LINES=$(wc -l files.txt | awk '{print $1}')
touch lines.txt
seq 1 "${NO_OF_LINES}" > lines.txt

#Loop through each file in FILES and change the name with the required file name

paste -d@ files.txt lines.txt | while IFS="@" read -r file_name line_no
do
    if [[ "${file_name}" != "${0}" ]]
    then
    mv "${FINAL_DIRECTORY}/${file_name}" "${FINAL_DIRECTORY}/${REQUIRED_FILE_NAME}${line_no}"
    fi
done


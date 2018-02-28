#!/bin/bash

declare -i TOSHIFT=0
while getopts :i:o: option
do
  case "${option}"
  in
    i) INPUT=${OPTARG} TOSHIFT+=2;;
    o) OUTPUT=${OPTARG} TOSHIFT+=2;;
  esac
done
TOSHIFT=${TOSHIFT} #Parse to int
shift ${TOSHIFT} #Shift the

if ! [ -d "${INPUT}" ]; then
  echo ${INPUT}
  if ! [ -z "${INPUT}"]; then
    echo "Input folder was provided but doesn't exist. Ending script!"
    exit 1
  else
    echo "No input folder was given"
  fi
fi

if ! [ -d "${OUTPUT}" ]; then
  echo "No output folder located. Creating one..."
  mkdir -p "${OUTPUT}";
fi

FILEPATHS=()
for I in "$@"
do
  if [ -f "${INPUT}${I}" ]; then
    FILEPATHS+=("${INPUT}${I}")
  else
    echo "${INPUT}${I} is not a file path"
  fi
done

echo "There were ${#FILEPATHS[@]} files found."

if [ "${#FILEPATHS[@]}" -eq "0" ]; then
  echo "No files were found. Ending script!"
  exit 2
fi

echo "Input location: ${INPUT}."
echo "Output location: ${OUTPUT}"
for FILEPATH in ${FILEPATHS}
do
  tools/FastQC/fastqc -o ${OUTPUT} -t 8 --noextract ${FILEPATH}
done

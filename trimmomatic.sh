#!/bin/bash

declare -i TOSHIFT=0
while getopts :i:o:p:u:f:r: option
do
  case "${option}"
  in
    i) INPUT=${OPTARG} TOSHIFT+=2;;
    o) OUTPUT=${OPTARG} TOSHIFT+=2;;
    p) PAIR=${OPTARG} TOSHIFT+=2;;
    u) UNPAIR=${OPTARG} TOSHIFT+=2;;
    f) FORWARD=${OPTARG} TOSHIFT+=2;;
    r) REVERSE=${OPTARG} TOSHIFT+=2;;
  esac
done

if ! [ -d "${INPUT}" ]; then
  if ! [ -z "${INPUT}" ]; then
    echo "Input folder was provided but doesn't exist. Ending script!"
    exit 1
  else
    echo "No input folder was given."
  fi
fi

if ! [ -d "${OUTPUT}" ]; then
  if ! [ -z "${OUTPUT}" ]; then
    echo "Output folder was provided but doesn't exist. Creating it..."
    mkdir -p "${OUTPUT}"
  else
    echo "No output folder was given."
  fi
fi

mkdir -p "${OUTPUT}${PAIR}"
mkdir -p "${OUTPUT}${UNPAIR}"

echo "${OUTPUT} ${INPUT}"
echo "${PAIR} ${UNPAIR}"
echo "${FORWARD} ${REVERSE}"

java -jar tools/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 "${INPUT}${FORWARD}" "${INPUT}${REVERSE}" "${OUTPUT}${PAIR}${FORWARD}" "${OUTPUT}${UNPAIR}${FORWARD}" "${OUTPUT}${PAIR}${REVERSE}" "${OUTPUT}${UNPAIR}${REVERSE}" ILLUMINACLIP:tools/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
#java -jar tools/Trimmomatic-0.36/trimmomatic-0.36.jar PE -phred33 data/filtered_ZFG-15-11_8_13143_GAGTGG_L001_R1_001.fastq data/filtered_ZFG-15-11_8_13143_GAGTGG_L001_R2_001.fastq output_longipes_paired_forward.fastq output_longipes_unpaired_forward.fastq output_longipes_paired_reverse.fastq output_longipes_unpaired_reverse.fastq ILLUMINACLIP:tools/Trimmomatic-0.36/adapters/TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#!/bin/bash

declare -i TOSHIFT=0

for argu in "$@"; do
  shift 1
  case "$argu" in
    --input) shift 1 | INPUT="$1";;
    --qcfolder) shift 1 | QC_OUTPUT="$1";;
    --trimfolder) shift 1 | TRIM_OUTPUT="$1";;
    --reverseflag) shift 1 | REVERSE_FLAG="$1";;
    --files) shift 1 | FILES="$1";;
  esac
done

echo "${INPUT}, ${QC_OUTPUT}, ${TRIM_OUTPUT}, ${REVERSE_FLAG}, ${FILES}"

if ! [ -d "${INPUT}" ]; then
  if ! [ -z "${INPUT}"]; then
    echo "Input folder was provided but doesn't exist. Ending script!"
    exit 1
  else
    echo "No input folder was given"
  fi
fi

if ! [ -d "${QC_OUTPUT}" ]; then
  echo "No quality control output folder located. Creating one..."
  mkdir -p "${QC_OUTPUT}";
fi

if ! [ -d "${TRIM_OUTPUT}" ]; then
  echo "No trim output folder located. Creating one..."
  mkdir -p "${TRIM_OUTPUT}";
fi

if ! [ -d "${TRIM_OUTPUT}${QC_INPUT}" ]; then
  echo "No quality control output folder located. Creating one..."
  mkdir -p "${TRIM_OUTPUT}${QC_INPUT}";
fi

for file in files; do
  echo $file
done

echo "Quality Control: Starting..."
#bash qualitycontrol.sh -i ${INPUT} -o ${QC_OUTPUT} C_longipes_forward.fastq C_longipes${REVERSE_FLAG}.fastq
echo "Quality Control: Done."
echo ""
echo "Trimming reads: Starting..."
#bash trimmomatic.sh -i data/ -o trimming/ -p trimmed/ -u removed/ -f C_longipes_forward.fastq  -r C_longipes_reverse.fastq
echo "Trimming reads: Done."
echo ""
echo "Quality Control: Starting..."
#bash qualitycontrol.sh -i trimming/trimmed/ -o trimming/qualitycontrol C_longipes_forward.fastq C_longipes_reverse.fastq
echo "Quality Control: Done."
echo ""

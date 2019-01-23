#!/bin/bash
# The purpose of this script is to perform the merge command using bedtools on multiple files
# This command attempts to merge features based on a defined distance between one feature to another

# Setting
folder=$1 # the first ARGV is the path of the folder on which to act
base='.bed' # the suffix of the bed files
gap=500000 # gap in bp for the merge command
output_path=$folder/"merged"/ # where to put the output
###

## Varify input variables
if [ $# -eq 0 ]
  then
    echo "No arguments supplied :( please specify input folder"
	echo "e.g. sh ./merge_bed_batch.sh ./input_beds/"
  else

echo "Run initiated"

## Create the ouput folder
mkdir $output_path

## Parse input folder and invoke the merge command
N=$(ls $folder | wc -l)
ii=1;
while [ $ii -le $N ]; do
	file=$(ls $folder | head -n $ii | tail -n 1)
	sample=$(basename $file $base)
	
	# act only on the definded file types
	if [  ${file: -4} == $base ]; then 
	
	echo $extension
	echo "Merging bed: "$sample
	bedtools merge -i $folder$file -d 500000 > $output_path$file
	
	fi
	
	ii=$((ii + 1))

done 

echo "Done!"

fi 

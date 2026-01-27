#!/bin/bash


if [ ! -d "emfold_cm" ]; then  
  mkdir "emfold_cm"
fi

for pdb_file in AF2_431/*.pdb; do   
  filename=$(basename -- "$pdb_file")
  filename_no_ext="${filename%.*}"

  python pdb_to_cm.py "$pdb_file" "cm_431/$filename_no_ext.cm" -t 7  
done


echo -e "File Name\tX" > result.xlsx

for cm_file in cm_431/*.cm; do
  filename=$(basename -- "$cm_file")
  filename_no_ext="${filename%.*}"

  m=$(wc -l < "$cm_file")
  n=$(awk '{z = $1 - $2;if (z < 0) z = -z;if (z > 5) n++;} END {print n;}' "$cm_file")
  x=$(awk -v n="$n" -v m="$m" 'BEGIN { print n / m }')
  echo "m为:$m"
  echo "n为:$n"
  echo "x为:$x"
  
  echo -e "$filename_no_ext\t$x" >> result_esm.xlsx
done

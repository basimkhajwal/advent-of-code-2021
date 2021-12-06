#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day05.txt}
useDiag=${2:-1}

m=1000
res=()

while read -r x1 y1 x2 y2; do
  if [[ $x1 -eq $x2 ]]; then
    ymin=$(( y1 < y2 ? y1 : y2 ))
    ymax=$(( y1 < y2 ? y2 : y1 ))
    for (( i=x1*m+ymin; i<=x1*m+ymax; i++ )); do
      res[i]=$((${res[i]:-0}+1))
    done
  elif [[ $y1 -eq $y2 ]]; then
    xmin=$(( x1 < x2 ? x1 : x2 ))
    xmax=$(( x1 < x2 ? x2 : x1 ))
    for (( i=xmin*m+y1; i<=xmax*m+y1; i+=m )); do
      res[i]=$((${res[i]:-0}+1))
    done
  fi
done < <(sed -E 's/(.*),(.*) -> (.*),(.*)/\1 \2 \3 \4/g' $file)

tot=0
for v in ${res[@]}; do
  (( tot += v > 1 ? 1 : 0 ))
done
echo $tot
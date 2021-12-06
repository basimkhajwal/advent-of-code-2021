#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day05.txt}
useDiag=${2:-1}

m=1000
res=()

while read -r x1 y1 x2 y2; do
  sx=$(( (x2 > x1) - (x2 < x1) ))
  sy=$(( (y2 > y1) - (y2 < y1) ))
  if (( sx == 0 || sy == 0 || useDiag == 1 )); then
    x=x1 y=y1
    while (( x != x2+sx || y != y2+sy )); do
      i=$((x*m+y))
      res[i]=$((${res[i]:-0}+1))
      (( x+=sx, y+=sy ))
    done
  fi
done < <(sed -E 's/(.*),(.*) -> (.*),(.*)/\1 \2 \3 \4/g' $file)

tot=0
for v in ${res[@]}; do (( tot += v > 1 )) ; done
echo $tot
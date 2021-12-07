#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day06.txt}
D=${2:-80}

fish=( 0 0 0 0 0 0 0 0 0 )
for f in $(tr "," " " < $file); do (( ++fish[f] )); done

for (( d=1; d<=D; d++ )); do
  z=${fish[0]}
  for (( i=1; i<${#fish[@]}; i++ )); do
    fish[$((i-1))]=${fish[i]}
  done
  (( fish[6] += z ))
  fish[8]=$z
done

t=0
for f in ${fish[@]}; do (( t += f )); done
echo $t
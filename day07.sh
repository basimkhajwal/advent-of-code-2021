#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day07.txt}
xs=( $(tr "," "\n" < $file | sort -n) ) 
n=${#xs[@]}

function part1Dist {
  h=$1 t=0
  for x in ${xs[@]}; do (( t += x < h ? h-x : x-h )); done
  echo $t
}

function part2Dist {
  h=$1 t=0
  for x in ${xs[@]}; do
    d=$(( x < h ? h-x : x-h ))
    (( t += d * (d + 1) / 2 ))
  done
  echo $t
}


mode=xs[$((n/2))]
mean=0
for x in ${xs[@]}; do (( mean += x )); done
(( mean = mean / n ))

# always the mode
part1Dist $mode

# take the smallest (rounding errors)
part2Dist $mean
part2Dist $((mean-1))
part2Dist $((mean+1))
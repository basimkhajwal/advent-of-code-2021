#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day07.txt}
xs=( $(tr "," "\n" < $file | sort -n) ) 

n=${#xs[@]}
h=xs[$((n/2))]

t=0
for x in ${xs[@]}; do
  (( t += x < h ? h-x : x-h ))
done
echo $t
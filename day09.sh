#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day09.txt}

xs=()
while read -r x; do
  n=${#x}
  for (( i=0; i<n; i++ )); do xs+=( ${x:i:1} ); done
done < $file

tot=0
for (( i=0; i<n; i++ )); do
  for (( j=0; j<n; j++ )); do
    k=$((i*n+j)) v=${xs[k]} s=1
    [[ $j -lt $((n-1)) ]] && (( s = s && xs[k+1] > v ))
    [[ $i -lt $((n-1)) ]] && (( s = s && xs[k+n] > v ))
    [[ $j -gt 0 ]] && (( s = s && xs[k-1] > v ))
    [[ $i -gt 0 ]] && (( s = s && xs[k-n] > v ))
    (( tot += s ? v+1 : 0 ))
  done
done
echo $tot


#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day08.txt}
ans=0
while read -ra xs; do
  for x in ${xs[@]}; do
    l=${#x}
    (( ans += l == 2 || l == 3 || l == 4 || l == 7 ? 1 : 0 ))
  done
done < <(sed -E "s/.*\|(.*)/\1/" $file)
echo $ans
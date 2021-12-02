#! /bin/bash

set -euf -o pipefail

file="${1:-./input/day01.txt}"

function countIncreasing {
  local prev=-1
  local count=0
  while read -r line; do
    count=$(( prev != -1 && line > prev ? count + 1 : count ))
    prev=$line
  done
  echo $count
}

function threeSums {
  local a=-1 b=-1 c=-1 i=0
  while read -r line; do 
    a=$b; b=$c; c=$line
    [[ $((++i)) -gt 2 ]] && echo $((a+b+c))
  done
}

countIncreasing < $file
threeSums < $file | countIncreasing
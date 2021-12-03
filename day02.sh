#! /bin/bash

set -euf -o pipefail

file="${1:-./input/day02.txt}"

function part1 {
  local h=0 v=0
  while IFS=" " read -r d x; do
    [[ $d = forward ]] && h=$((h+x))
    [[ $d = down ]] && v=$((v+x))
    [[ $d = up ]] && v=$((v-x))
  done
  echo $((h*v))
}

function part2 {
  local h=0 v=0 a=0
  while IFS=" " read -r d x; do
    [[ $d = forward ]] && h=$((h+x)) && v=$((v+a*x))
    [[ $d = down ]] && a=$((a+x))
    [[ $d = up ]] && a=$((a-x))
  done < $file
  echo $((h*v))
}

part1 < $file
part2 < $file
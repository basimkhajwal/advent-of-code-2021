#! /bin/bash

set -euf -o pipefail

file="${1:-./input/day03.txt}"
fst=$(head -1 $file)

function bin2dec {
  res=0
  for (( i=0; i<${#1}; i++ )); do
    res=$((res*2+${1:i:1}))
  done
  echo $res
}

function findNum {
  crit=$1
  rem=()
  while read -r line; do
    rem+=( $line )
  done
  for (( i=0; i<${#fst}; i++ )); do 
    if 
    last=${rem}
    break
  done
}

cnt=()
for (( i=0; i<${#fst}; i++ )); do
  cnt+=( 0 )
done

while read -r line; do
  for (( i=0; i<${#fst}; i++ )); do
    j=$((i+1))
    [[ ${line:$i:1} = "1" ]] && cnt[i]=$((${cnt[$i]}+1))
  done
done < $file

tot=$(wc -l < $file)
echo $tot
a=""
b=""
for (( i=0; i<${#fst}; i++ )); do
  a="$a$((${cnt[$i]} > $tot/2 ? 1 : 0))"
  b="$b$((${cnt[$i]} > $tot/2 ? 0 : 1))"
done
echo $(( $(bin2dec $a) * $(bin2dec $b) ))
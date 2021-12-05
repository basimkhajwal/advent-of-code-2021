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
  local rem=()
  while read -r line; do
    rem+=( $line )
  done < $file
  local last
  for (( i=0; i<${#fst}; i++ )); do 
    local next=()
    local ones=0
    for (( j=0; j<$(( ${#rem[@]} )); j++ )); do
      [[ ${rem[j]:i:1} == 1 ]] && ones=$((ones+1))
    done
    bit=$(( ( (ones * 2 >= ${#rem[@]}) ^ (crit == 1) ) ? 1 : 0 ))
    for (( j=0; j<$(( ${#rem[@]} )); j++ )); do
      last=${rem[$j]}
      [[ ${last:i:1} = $bit ]] && next+=( $last )
    done
    rem=( ${next[@]+"${next[@]}"} )
  done
  [[ ${#rem[@]} = 0 ]] && echo $last || echo ${rem[0]}
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
a=""
b=""
for (( i=0; i<${#fst}; i++ )); do
  a="$a$((${cnt[$i]} > $tot/2 ? 1 : 0))"
  b="$b$((${cnt[$i]} > $tot/2 ? 0 : 1))"
done

echo $(( $(bin2dec $a) * $(bin2dec $b) ))
echo $(( $(bin2dec $(findNum 0) ) * $(bin2dec $(findNum 1) ) ))
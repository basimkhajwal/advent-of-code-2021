#! /bin/bash

set -euf -o pipefail

file=${1:-./input/day04.txt}

grids=()
while IFS=" " read -ra xs ; do
  grids+=( ${xs[@]+${xs[@]}} )
done < <(tail -n +2 "$file")

n=$(( ${#grids[@]} / 25 ))
marked=()
for (( i=0; i<n*25; i++ )); do marked+=( 0 ); done

IFS="," items=( $(head -n 1 "$file") )

firstFound=-1 lastFound=-1

won=()
for (( i=0; i<n; i++ )); do won+=( 0 ); done

for item in ${items[@]}; do
  for (( g=0; g<n; g++ )); do
    [[ ${won[g]} == 1 ]] && continue
    changed=0
    for (( i=g*25; i<g*25+25; i++ )); do
      [[ ${grids[i]} -eq $item ]] && marked[i]=1 changed=1
    done
    [[ $changed == 0 ]] && continue
    found=0
    for (( i=0; i<5; i++ )); do
      r=1 c=1
      for (( j=0; j<5; j++ )); do
        [[ ${marked[$(( g*25+i*5+j ))]} -eq 0 ]] && r=0
        [[ ${marked[$(( g*25+j*5+i ))]} -eq 0 ]] && c=0
      done
      (( found |= r || c ))
    done
    if [[ $(( found && !won[g] )) == 1 ]]; then
      total=0
      for (( i=g*25; i<g*25+25; i++ )); do
        (( total += (1-${marked[i]})*${grids[i]} ))
      done
      lastFound=$((total * item))
      firstFound=$(( firstFound == -1 ? lastFound : firstFound ))
      won[g]=1
    fi
  done
done

echo $firstFound
echo $lastFound


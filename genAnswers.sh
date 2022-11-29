#!/bin/bash

cat imdb.csv | ./csv2tab > imdb.tsv

#Ans-1
awk -F'\t' '$1>8.5 {print}' imdb.tsv > ans1.tsv

#Ans-2
awk -F'\t' '{print $4}' imdb.tsv | sort | uniq > genrelist
while IFS= read -r line; do value=$(grep -ic $line imdb.tsv) ; echo "$value" ; done < genrelist > genreSums.txt

#Ans-3
while IFS= read -r genre;do grep -i "$genre" imdb.tsv | awk -F'\t' -v sum=0 'sum+=$1{} END{print sum}'; done <genrelist >rating.txt

while IFS= read -r genre;do grep -i "$genre" imdb.tsv | awk -F'\t' -v sum=0 'sum+=$5{} END{print sum}'; done <genrelist >duration.txt

mapfile -t ratings < rating.txt
mapfile -t durations < duration.txt
mapfile -t nums < genreSums.txt
for i in {0..16}; do echo "scale=2; ${ratings[i]}/${nums[i]}" | bc ;done > avgRatings.txt
for i in {0..16}; do echo "scale=2; ${durations[i]}/${nums[i]}" | bc ;done > avgDurations.txt

#For_cleanly_saving_answer: 2 & 3
mapfile -t avgR < avgRatings.txt
mapfile -t avgD < avgDurations.txt
mapfile -t genre < genrelist

echo "genre|noOfMovies|avgRatings|avgDurations" > ans2_3.txt
for i in {0..16}; do echo "${genre[i]}|${nums[i]}|${avgR[i]}|${avgD[i]}";done >> ans2_3.txt
#Ans-4
cat imdb.tsv | awk -F'\t' '$1>8 && $5<150 && ($4 ~ /Crime/ || $4 ~ /Comedy/ || $4 ~ /Adventure/){print}' > ans4.txt

#Ans-5
awk -F'\t' '$6 ~ /Tim Robbins/ {print}' imdb.tsv > ans5.txt

#Removing_extra_files
rm avgRatings.txt avgDurations.txt rating.txt duration.txt genreSums.txt

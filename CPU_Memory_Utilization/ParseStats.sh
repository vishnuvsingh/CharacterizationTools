#!/bin/bash

timeout 60s docker stats >> ContainerStats
sleep 65

cat ContainerStats | sed -E 's/\ (\ )+/,/g' > ContainerStats.csv
cat ContainerStats | sed -E 's/\ (\ )+/,/g' > ContainerStats.csv
cat ContainerStats.csv | sed -E 's/BLOCK I\/O/BLOCK I, BLOCK O/g' > TMP_Stats.csv
cat TMP_Stats.csv | sed -E 's/NET I\/O/NETWORK I, NETWORK O/g' > TMPX_Stats.csv
cat TMPX_Stats.csv | sed -E 's/MEM USAGE \/ LIMIT/MEMORY (Bytes), MEM LIMIT/g' > TMP_Stats.csv
cat TMP_Stats.csv | sed -E 's/\//,/g' > ContainerStats.csv

echo "ContainerStats.csv is done"

rm -f TMP_Stats.csv TMPX_Stats.csv

python3 Parser.py > ContainerDistributions
echo "Called Parser.py"
cat ContainerDistributions | sed -E 's/\ /,/g' > Container_Distributions.csv
rm ContainerDistributions
rm ContainerStats
# rm ContainerStats.csv

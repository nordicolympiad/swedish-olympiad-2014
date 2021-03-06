#!/bin/bash

# Set the problem name to generate correct file names
PROBLEMNAME="trevligatal"

# Set this if you want to generate answers.
SOLVER=sol

# 1. Create subdirectories and set them to "min"
#    grading mode.

subfolders=(g0 g1 g2 g3 g4 g5 g6 g7 g8 g9)
for i in ${subfolders[@]}
do
    if [ ! -d $i ]
    then
        mkdir $i
    fi
    if [ ! -f $i/testdata.yaml ]
    then
        touch $i/testdata.yaml
        echo "grader_flags: min" > $i/testdata.yaml
    fi
done

# small data sets
small=(0 1)

# length, seed
for i in ${small[@]}
do
    # one line here per file in test group
    echo "6 1$i" | python gen.py > g$i/$PROBLEMNAME.g$i.1.in
    echo "3 2$i" | python gen.py > g$i/$PROBLEMNAME.g$i.2.in
    echo "5 3$i" | python gen.py > g$i/$PROBLEMNAME.g$i.3.in
    echo "6 4$i" | python gen.py > g$i/$PROBLEMNAME.g$i.4.in
done

# medium data sets
medium=(2 3)

for i in ${medium[@]}
do
    # one line here per file in test group
    echo "16 1$i" | python gen.py > g$i/$PROBLEMNAME.g$i.1.in
    echo "13 2$i" | python gen.py > g$i/$PROBLEMNAME.g$i.2.in
    echo "20 3$i" | python gen.py > g$i/$PROBLEMNAME.g$i.3.in
    echo "19 4$i" | python gen.py > g$i/$PROBLEMNAME.g$i.4.in
done

# large data sets
large=(4 5)

for i in ${large[@]}
do
    # one line here per file in test group
    echo "822 1$i" | python gen.py > g$i/$PROBLEMNAME.g$i.1.in
    echo "205 2$i" | python gen.py > g$i/$PROBLEMNAME.g$i.2.in
    echo "1000 3$i" | python gen.py > g$i/$PROBLEMNAME.g$i.3.in
    echo "678 4$i" | python gen.py > g$i/$PROBLEMNAME.g$i.4.in
done

# xlarge data sets
xlarge=(6 7 8 9)

for i in ${xlarge[@]}
do
    # one line here per file in test group
    echo "16923 1$i" | python gen.py > g$i/$PROBLEMNAME.g$i.1.in
    echo "92952 2$i" | python gen.py > g$i/$PROBLEMNAME.g$i.2.in
    echo "100000 3$i" | python gen.py > g$i/$PROBLEMNAME.g$i.3.in
    echo "32949 4$i" | python gen.py > g$i/$PROBLEMNAME.g$i.4.in
    cat trevligatal_overflow  > g$i/$PROBLEMNAME.g$i.5.in
done

# generate solutions for all files
if [[ ! -z $SOLVER ]]
then
    for i in ${subfolders[@]}
    do
        for f in $i/*.in
        do
            ./$SOLVER < $f > ${f%???}.ans
        done
    done
fi

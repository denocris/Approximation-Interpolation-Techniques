#!/bin/bash
#PBS -l nodes=1:ppn=20
#PBS -l walltime=300
#PBS -q reserved3

cd P2.9_seed/Exercises/Day3/Exercise5/Input/Taylor0/src

./tester.c

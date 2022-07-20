#!/usr/bin/env bash

#SBATCH --job-name=benchmark
#SBATCH --output=benchmark.log
#SBATCH --ntasks-per-node=20
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH -p long-40core

module load diffexp/1.0

snakemake --cores 20 -s snakefile-benchmark 

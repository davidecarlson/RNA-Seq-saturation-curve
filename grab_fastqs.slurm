#!/usr/bin/env bash

#SBATCH --job-name=sra
#SBATCH --output=sra.log
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=1
#SBATCH --time=24:00:00
#SBATCH -p long-40core

module load hts/1.0
module load gnu-parallel/6.0

cd fastqs 

cat accessions.txt | parallel --jobs 25 --verbose "fastq-dump --accession {} --split-files --gzip --outdir ./"

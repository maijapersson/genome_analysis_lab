#!/bin/bash -l
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 16:00:00
#SBATCH -J genome_assembly
#SBATCH --mail-type=ALL
#SBATCH --mail-user Maija.Persson.0100@student.uu.se
# Load modules
module load bioinfo-tools
module load canu/2.0
# Your commands
canu -p assembly -d analyses/01_genome_assembly/ genomeSize=3m -pacbio data/raw_data/DNA_raw_data/ERR2028*

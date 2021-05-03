#!/bin/bash -l
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J counting
#SBATCH --mail-type=ALL
#SBATCH --mail-user maija.persson.0100@student.uu.se

module load bioinfo-tools
module load htseq/0.12.4
module load samtools

samtools index $1  
PREFIX=${1%%.sorted*}

htseq-count -f bam -t CDS -i ID -s reverse -r pos $1 analyses/04_mapping_counting/annotation_wo_ns.gff > analyses/04_mapping_counting/$PREFIX_continuous_counting_cds.txt

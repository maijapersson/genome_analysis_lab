#!/bin/bash -l
#SBATCH -A g2021012
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 07:00:00
#SBATCH -J mapping
#SBATCH --mail-type=ALL
#SBATCH --mail-user maija.persson.0100@student.uu.se

module load bioinfo-tools
module load bwa/0.7.17
module load samtools

PAIRED_READ=data/raw_data/RNA_trimmed_reads_p1
bwa index -p assembly_index analyses/01_genome_assembly/assembly.contigs.fasta
cd $PAIRED_READ

for file in *.gz
do
	PREFIX=${file%%_*}
	echo "processing $PREFIX"
	echo "${PREFIX}_P2.trim.fastq.gz"
	bwa mem ../../../assembly_index $file ../RNA_trimmed_reads/${PREFIX}_P2.trim.fastq.gz -t 2 | samtools view -b - > ../../../analyses/04_mapping_counting/$PREFIX$        
	samtools sort ../../../analyses/04_mapping_counting/$PREFIX.bam -o ../../../analyses/04_mapping_counting/$PREFIX.sorted.bam
done

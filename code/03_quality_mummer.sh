mummer -b -c -mum data/raw_data/reference analyses/01_genome_assembly/assembly.contigs.fasta > analyses/01_genome_assembly/quality_quast/mummer.mums
mummerplot -R data/raw_data/reference -Q analyses/01_genome_assembly/assembly.contigs.fasta --png -p mummer analyses/01_genome_assembly/quality_quast/mummer.mums

#!/bin/bash
module load star
index="/work/LAS/mhufford-lab/arnstrm/newNAM/analyses/f-rnaseq/index/B73.v4"
GFF="/work/LAS/mhufford-lab/arnstrm/newNAM/analyses/f-rnaseq/index/GCA_000005005.6_B73_RefGen_v4_genomic.gff"
base=$(basename $(pwd))
read1=$1
read2=$(echo $read1 |sed 's/_R1.fq.gz/_R2.fq.gz/g')
out=$(basename ${read1%%.*} | sed 's/_R1.fq.gz/_/g')

STAR \
--genomeDir $index \
--runThreadN 36 \
--sjdbFileChrStartEnd SJ.all \
--runMode alignReads \
--readFilesIn $read1 $read2 \
--readFilesCommand zcat \
--outFileNamePrefix ${out}_round-2 \
--outBAMsortingThreadN 4 \
--limitBAMsortRAM 40000000000 \
--outSAMtype BAM SortedByCoordinate

module load fastqc
fastqc $read1
fastqc $read2

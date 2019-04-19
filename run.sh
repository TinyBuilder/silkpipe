#!/bin/bash
# retrieve the sra file
prefetch $1
mkdir $1

# dump the fastq files from the sra
parallel-fastq-dump -s $1 -O $1 --defline-seq '@$sn[_$rn]/$ri' --split-3 --skip-technical --clip --dumpbase --read-filter pass --threads 20 
rm $HOME/ncbi/public/sra/*

# create some helper temp files
reformat.sh in=$1/$1_pass_1.fastq in2=$1/$1_pass_2.fastq out=$1/rna.fa fastawrap=0
translate6frames.sh in=$1/$1_pass_1.fastq in2=$1/$1_pass_2.fastq out=$1/prot.fa.gz fastawrap=0

# filter the reads using the hmm profiles
for profile in *.hmm
do
profname=$(echo $profile | cut -f1 -d'.')
hmmsearch -o $1/$profname.report -A $1/$profname.aln --tblout $1/$profname.txt $profile $1/prot.fa.gz
grep -v "^#" $1/$profname.txt | awk '{print $1}' | awk -F '_' '{print $1}' | awk -F '/' '{print$1}' > $1/$profname.tmp
done
sort $1/*.tmp | uniq > $1/matches
grep -A 3 -f $1/matches $1/$1_pass_1.fastq | grep -v "^--" > $1/1_seeds.fq &
grep -A 3 -f $1/matches $1/$1_pass_2.fastq | grep -v "^--" > $1/2_seeds.fq &
paste - - < $1/rna.fa | grep -v -f $1/matches | tr '\t' '\n' | pigz > $1/unmatched.fa.gz
wait
rm $1/$1*

# assemble the seeds
Trinity --seqType fq --max_memory 200G --left "$1/1_seeds.fq" --right "$1/2_seeds.fq" --CPU 32 --SS_lib_type FR --no_bowtie --no_normalize_reads --full_cleanup --output "trinity_$1"

# extend the assmblies
if tadpole.sh in=trinity_$1.Trinity.fasta out=$1/extended.fa extra=$1/unmatched.fa.gz extendleft=10000 extendright=10000 ibb=f mode=extend fastawrap=0
then
echo 'Extended'
else
rm -rf trinity_$1
tadpole.sh in=$1/1_seeds.fq in2=$1/2_seeds.fq extra=$1/unmatched.fa.gz out=$1/extended.fa extendleft=10000 extendright=10000 ibb=f fastawrap=0
fi
rm trinity_$1*
rm $1/*seeds.fq
rm $1/unmatched.fa.gz

# run blast on the results
blastx -query $1/extended.fa -db /data/ncbi/db/nr -out $1/nr_matches.json -task blastx-fast -num_threads 32 -evalue 0.0001 -outfmt 15

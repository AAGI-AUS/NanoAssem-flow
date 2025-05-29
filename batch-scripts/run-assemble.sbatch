#!/bin/bash --login

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=64GB #requirements may be high in case user downloads large images
#SBATCH --partition=work
#SBATCH --time=1-00:00:00
#SBATCH --account=pawsey1142
#SBATCH --mail-type=ALL
#SBATCH --export=NONE

module load nextflow/23.10.0
module load singularity/4.1.0

# IMPORTANT: singularity cache dir needs to be specified in order to download image when running pante2 default
export NXF_SINGULARITY_CACHEDIR="./work"
mkdir -p singularity_tmpdir
export SINGULARITY_TMPDIR=$PWD/singularity_tmpdir

export PAWSEY_PROJECT='pawsey1142'

nextflow run ./main.nf -profile pawsey_setonix,singularity -resume \
	--tool assemble \
	--inputdir '/scratch/y95/kgagalova/data-backup/all_data_cleanedup/*{duplex.fastq,simplex.corrected.fasta}.gz' \
	--outputdir results \
        --genome_size '1.2g'

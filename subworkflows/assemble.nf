//
// Assembly module here
//
//

// Call module
include { FLYE } from '../modules/nf-core/flye/main.nf'

workflow ASSEMBLY {

    take:
    reads // tuple[meta, [fastq, fasta]]
    genome_size

    main:
    joined_reads = reads
        .map { meta, fastq, fasta -> 
            [meta, [fastq, fasta]]
        }
    //joined_reads.view()
    FLYE(joined_reads, 
	'--nano-hq',
	genome_size)

    emit:
    assembly = FLYE.out.fasta
}

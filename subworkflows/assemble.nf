//
// Assembly module here
//
//

// Call module
include { FLYE } from '../modules/nf-core/flye/main.nf'

workflow ASSEMBLY {

    take:
    reads // tuple[meta, [fastq, fasta]]

    main:
    joined_reads = reads
        .map { meta, fastq, fasta -> 
            [meta, [fastq, fasta]]
        }
    joined_reads.view()
    FLYE(joined_reads, '--nano-hq')

    emit:
    assembly = FLYE.out.fasta
}

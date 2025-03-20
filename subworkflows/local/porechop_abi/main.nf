//
// Test module example here
//
// Current main problem(s) with the script:
// - Name still has .fastq
//
// Quotation important for inputs with "*"!!
//
// TEST/ contains fastq.gz files that need QC:
// GM24385_1_Sub1000.fastq.gz
// GM24385_1_Sub1000B.fastq.gz

// Call module

include { PORECHOP_ABI_MOD } from '../../../modules/local/software/porechop_abi/main.nf'
//call trim/qc separate or call another subworkflow?

// Includes sub-workflow
workflow PORECHOP_ABI {

    //Input
    take:
    fastq // Now tuple val(name), path(fastq)
    
    //Main
    main:
    porechop_abi_trimmed = Channel.empty()
    PORECHOP_ABI_MOD(fastq).porechop_abi_trimmed.set{porechop_abi_trimmed}
    
    //Output
    emit:
    porechop_abi_trimmed
}
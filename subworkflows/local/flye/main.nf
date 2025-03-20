//
// Test module example here
//
// Current main problem(s) with the script:
// - 
//
// Quotation important for inputs with "*"!!
//
// TEST/ contains fastq.gz files that need assembly:
// 

// Call module
include { FLYE_ASSEMBLE_MOD } from '../../../modules/local/software/flye/main.nf'

// Includes sub-workflow
workflow FLYE_ASSEMBLE {

    //Input
    take:
    fastq // Now tuple val(name), path(fastq)
    
    //Main
    main:
    flyeassembled = Channel.empty()
    FLYE_ASSEMBLE_MOD(fastq).set{flyeassembled}
    
    //Output
    emit:
    flyeassembled
}

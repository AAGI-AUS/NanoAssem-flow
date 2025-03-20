//
// Test module example here
//
// Current main problem(s) with the script:
// - 
//
// Quotation important for inputs with "*"!!
//
// TEST/ contains fastq.gz files that need QC:
// GM24385_1_Sub1000.fastq.gz
// GM24385_1_Sub1000B.fastq.gz

// Call module
include { FALCO_QC_MOD } from '../../../modules/local/software/falco/main.nf'

// Includes sub-workflow
workflow FALCO_QC {

    //Input
    take:
    fastq // Now tuple val(name), path(fastq)
    
    //Main
    main:
    falcoreport = Channel.empty()
    FALCO_QC_MOD( fastq ).falcoreport.set{falcoreport}
    
    //Output
    emit:
    falcoreport 
}

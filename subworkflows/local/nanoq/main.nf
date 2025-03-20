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

switch (params.qc_tool) {
    case ["qc_nanoq"]:
        include { NANOQ_QC_MOD } from '../../../modules/local/software/nanoq/main_qc.nf'
        break;
    case ["filter_nanoq"]:
		//Filter tools: nanoq/falco
        include { FALCO_QC_MOD } from '../../../modules/local/software/falco/main.nf'
        include { NANOQ_FILTER_MOD } from '../../../modules/local/software/nanoq/main_filter.nf'
		break;
}

// Includes sub-workflow
workflow NANOQ_QC {

    //Input
    take:
    fastq // Now tuple val(name), path(fastq)
    
    //Main
    main:
    nanoqreport = Channel.empty()
    NANOQ_QC_MOD(fastq).nanoqreport.set{nanoqreport}
    
    //Output
    emit:
    nanoqreport 
}

workflow NANOQ_FILTER {

    //Input
    take:
    fastq // Now tuple val(name), path(fastq)
    
    //Main
    main:
    falcoreport = Channel.empty()
    NANOQ_FILTER_MOD(fastq)
    filter_out = NANOQ_FILTER_MOD.out.nanoqfilter.map { path ->
                def name = "${path.simpleName}"
                tuple(name, path)
                }
    FALCO_QC_MOD(filter_out).falcoreport.set{falcoreport} //QC of filtered reads
    
    //Output
    emit:
    falcoreport
}

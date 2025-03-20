//
// Test module example here
//
// Current main problem(s) with the script:
// - Name still has .fastq
//
// 
// Quotation important for inputs with "*"!!
//
// TEST/ contains fastq.gz files that need QC:
// GM24385_1_Sub1000.fastq.gz
// GM24385_1_Sub1000B.fastq.gz

include { NANOQ_QC } from '../subworkflows/local/nanoq/main.nf'
include { FALCO_QC } from '../subworkflows/local/falco/main.nf'

// Includes workflow
workflow QC_WORKFLOW {
    if (params.inputdir) {
        ch_input = Channel.fromPath(params.inputdir, checkIfExists: true)
    } 
    else {
        exit 1, "Input files empty"
    }
    
    
    //ch_input.view() //shows content of directory

    fastq = ch_input.map { path ->
                def name = "${path.simpleName}"
                tuple(name, path)
                }
    fastq.view() 

    if (params.tool == "falco") {
        FALCO_QC(fastq)
    }
    else {
        // params.tool == "nanoq"?
        NANOQ_QC(fastq)
    }
    
}
// Call the workflow
workflow{
    QC_WORKFLOW()
}
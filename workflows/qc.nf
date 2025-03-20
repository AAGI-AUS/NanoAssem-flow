// QC filtering trimming module
// Author: Shota Morikawa shota.morikawa@postgrad.curtin.edu.au
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

//Switch statement for this?
include { FALCO_QC }           from '../subworkflows/local/falco/main.nf'
include { NANOQ_QC }           from '../subworkflows/local/nanoq/main.nf'
include { NANOQ_FILTER }       from '../subworkflows/local/nanoq/main.nf'
include { PORECHOP_ABI }       from '../subworkflows/local/porechop_abi/main.nf'


if (params.inputdir) { ch_input = Channel.fromPath(params.inputdir, checkIfExists: true) } else { exit 1, "Input files empty" }
// In this case baseName removes only the extension, keeps names with "."
fastq = ch_input.map { path -> def name = "${path.baseName}" 
                      tuple(name, path)
                     }

// Includes workflow
workflow QC_WORKFLOW { 
    
    fastq.view() 

    qc_input = params.qc_tool
    println(qc_input)

    if (qc_input == "qc_falco") {
        FALCO_QC(fastq)
    } else if (qc_input == "qc_nanoq") {
        NANOQ_QC(fastq)
    } else if (qc_input == "filter_nanoq") {
        NANOQ_FILTER(fastq)
    } else if (qc_input == "trim_porechop_abi") {
        PORECHOP_ABI(fastq)
    }
    
}
// Call the workflow
//workflow{
//    QC_WORKFLOW()
//}

// QC filtering trimming module
// Author: Shota Morikawa shota.morikawa@postgrad.curtin.edu.au
//
// Test module example here
//
// 
//

include { FLYE_ASSEMBLE } from '../subworkflows/local/flye/main.nf'
if (params.inputdir) { fastq = channel.fromFilePairs(params.inputdir, flat: true, checkIfExists: true) } else { exit 1, "Input files empty" }


workflow ASSEMBLE_WORKFLOW {
    
    //ch_input.view() //shows content of directory

    
    fastq.view() 
    

    FLYE_ASSEMBLE(fastq)

    
}

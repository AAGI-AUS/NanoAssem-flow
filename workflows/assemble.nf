// Assembling module
// Author: Shota Morikawa shota.morikawa@postgrad.curtin.edu.au
//

include { ASSEMBLY } from '../subworkflows/assemble'
//if (params.inputdir) { fastq = channel.fromFilePairs(params.inputdir, flat: true, checkIfExists: true) } else { exit 1, "Input files empty" }


workflow ASSEMBLE_READS {
    
    reads_ch = channel
        .fromFilePairs(params.inputdir, size: 2, flat: true)
        .map { prefix, fastq, fasta -> 
            def meta = [id: prefix]
            [meta, fastq, fasta]
        }
    
    ASSEMBLY(reads_ch)
   
}

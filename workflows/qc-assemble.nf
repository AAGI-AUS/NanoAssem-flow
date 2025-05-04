#!/usr/bin/env nextflow

nextflow.enable.dsl = 2

include { QC } from '../subworkflows/qc'
include { ASSEMBLY } from '../subworkflows/assembly'

workflow {

    // Define input channels
    reads_ch = channel.fromPath(params.input_reads)
        .map { file -> 
            def meta = [id: file.baseName]
            [meta, file]
        }
        .view { meta, file -> "Processing: $meta.id" }
    
    // Run QC subworkflow
    QC(reads_ch)
    
    // Run Assembly subworkflow
    //ASSEMBLY(QC.out.filtered_reads)
}

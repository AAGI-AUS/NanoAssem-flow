#!/usr/bin/env nextflow

//Call DSL2
nextflow.enable.dsl=2

/*  ======================================================================================================
 *  HELP MENU
 *  ======================================================================================================
 */

//Input parameters list
params.help = null
params.tool = null

//--------------------------------------------------------------------------------------------------------
// Validation - validation from nf-core for input results

include { validateParameters; paramsHelp; paramsSummaryLog; fromSamplesheet } from 'plugin/nf-validation'

if (params.help) {
   log.info paramsHelp("nextflow run ...")
   exit 0
}

// Validate input parameters
validateParameters()

// Print summary of supplied parameters
log.info paramsSummaryLog(workflow)

//--------------------------------------------------------------------------------------------------------

// Include the ASSEMBLY workflow
include { ASSEMBLE_READS } from './workflows/assemble'

// Main workflow
workflow {
    if (params.tool == "assemble") {
        // Call the ASSEMBLY workflow
        ASSEMBLE_READS()
    }
    else {
        println("Please provide the correct input options")
    }
}

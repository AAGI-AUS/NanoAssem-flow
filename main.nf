#!/usr/bin/env nextflow

//Call DSL2
nextflow.enable.dsl=2

/*  ======================================================================================================
 *  HELP MENU
 *  ======================================================================================================
 */
//ver = manifest.version


//Input parameters list
params.help = null
params.tool = null

//params.fastq_dir = "input"

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

// This part calls the workflows
workflow_input = params.tool
switch (workflow_input) {
    case ["qc"]:
		//Filter tools: nanoq/falco
        include { QC_WORKFLOW } from './workflows/qc.nf'
		break;
	case ["assemble"]:
		//Filter tools: nanoq/falco
        include { ASSEMBLE_WORKFLOW } from './workflows/assemble.nf'
		break;
}


// Main workflow used to select from themes and tools
workflow {

	/*
	* WORKFLOW THEME #:
	* NANOQ - nanopore read quality control and filtering
	* FALCO - high-speed FastQC emulation for quality control
	* PORECHOP_ABI - nanopore sequencing adapter removal without prior sequence input
	*/
	if (params.tool == "qc") {
		//Test command: nextflow run main.nf --tool qc --qc_tool [qc_nanoq/qc_falco/filter_nanoq/trim_porechop_abi] --inputdir "../../bifo2/bifo/TEST/*fastq.gz"
		QC_WORKFLOW()
	}
	if (params.tool == "assemble"){
		//Test command: nextflow run main.nf --tool assemble --inputdir "../../bifo2/bifo/TEST2/*fastq.gz"
		ASSEMBLE_WORKFLOW()
	}
	//tool = qc-assemble
	
	else {
	
		println("Please provide the correct input options")

	}		 
}

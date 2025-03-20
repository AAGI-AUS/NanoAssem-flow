//
// Test module example here
//

process NANOQ_FILTER_MOD {

    tag "Filtering running for ${name}"

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ? 
        'https://depot.galaxyproject.org/singularity/nanoq:0.10.0--h031d066_1':
        null }"
    
    input:
    tuple val(name), path(fastq) 
    
    // Expected output - use emit to use the output in subworkflows/workflows
    output:
    path "${name}_filtered.fastq.gz", emit: nanoqfilter 
    
    // Script that produces results 
    script:
    def arg_minlen = params.minlen ? "-l '${params.minlen}'" : ""
    def arg_minqual = params.minqual ? "-q '${params.minqual}'" : ""    
    def arg_maxlen = params.maxlen ? "-m '${params.maxlen}'" : ""
    def arg_maxqual = params.maxqual ? "-w '${params.maxqual}'" : ""

    """
    nanoq -i ${fastq} ${arg_minlen} ${arg_minqual} ${arg_maxlen} ${arg_maxqual} > ${name}_filtered.fastq.gz 
    """
}

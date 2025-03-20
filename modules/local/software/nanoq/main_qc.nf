//
// Nanoq - DOI: 10.21105/joss.02991
//

// Includes processes
process NANOQ_QC_MOD {

    tag "QC calculated for ${name}"

    container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        "https://depot.galaxyproject.org/singularity/nanoq:0.10.0--h031d066_1":
        null }"

    input:
    tuple val(name), path(fastq) 
    
    output:
    path "${name}_report.json", emit: nanoqreport 
    
    script:
    """
    nanoq -i ${fastq} --json -s > ${name}_report.json

    cat <<-VERSIONS > versions.yml
    "${task.process}":
	 nanoq: \$(nanoq --version | cut -d" " -2 2>&1)
    VERSIONS
    """


}

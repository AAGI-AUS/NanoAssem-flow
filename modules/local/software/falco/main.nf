//
// Falco - DOI 10.12688/f1000research.21142.2
//

// Includes processes
process FALCO_QC_MOD {

    tag "Falco running for ${name}"
   
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/falco:1.2.2--hdcf5f25_0':
        null }"
    
    input:
    tuple val(name), path(fastq) 
    
    output:
    path "${name}", emit: falcoreport 
    
    // Script that produces results 
    script:
    """
    falco ${fastq} --outdir ${name}
   
    cat <<-VERSIONS > versions.yml
    "${task.process}":
         falco: \$(falco --version | cut -d" " -2 2>&1)
    VERSIONS
    """
}

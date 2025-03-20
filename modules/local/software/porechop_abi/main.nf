//
// Porechop - DOI 10.1093/bioadv/vbac085
//

process PORECHOP_ABI_MOD {

    tag "Porechop running for ${name}"

    container "${workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        "https://depot.galaxyproject.org/singularity/porechop_abi:0.5.0--py39hdf45acc_3":
        null }"

    // Input values
    input:
    tuple val(name), path(fastq) 
    
    // Expected output - use emit to use the output in subworkflows/workflows
    output:
    path "${name}_trimmed.fastq.gz", emit: porechop_abi_trimmed
    
    // Script that produces results 
    script:
    """
    porechop_abi -abi -t ${task.cpus} -i ${fastq} -o ${name}_trimmed.fastq.gz 

    cat <<-VERSIONS > versions.yml
    "${task.process}":
         porechop_abi: \$(nanoq --version 2>&1)
    VERSIONS
    """
}

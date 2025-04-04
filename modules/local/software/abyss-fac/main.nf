//
// ABySS - DOI doi:10.1101/gr.214346.116
//

process ABYSS_FAC_MOD {
    label 'small_task'

    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/abyss:2.3.10--hf316886_1' :
        'biocontainers/abyss:2.3.10--hf316886_1' }"

    input:
    tuple val(meta), path(fasta)

    output:
    tuple val(meta), path("${prefix}.tsv"), emit: stats

    script:
    def arg_genome_AB = params.genome_size_AB ? "-G '${params.genome_size_AB}'" : ""
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    abyss-fac ${arg_genome_AB} ${fasta} > '${prefix}.tsv'
    
    cat <<-VERSIONS > versions.yml
    "${task.process}":
         abyss-fac: \$(abyss-fac --version)
    VERSIONS
    """
}
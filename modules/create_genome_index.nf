process create_genome_index {

    container "quay.io/biocontainers/bowtie2:2.5.1--py38he00c5e5_2"

    publishDir path: "${params.outputdir}/create_index", mode: 'copy'

    input:
        path(genome)

    output:
        path("${genome_basename}_index"), emit: index
    
    script:
        genome_basename = file(genome).baseName
        """
        bowtie2-build ${genome} ${genome_basename}_index
        """
}
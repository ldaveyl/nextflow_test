process SUBSET_GENOME {

    container "quay.io/biocontainers/samtools:1.17--hd87286a_1"

    publishDir path: "${params.outputdir}/SUBSET_GENOME", mode: 'copy'

    input:
        tuple path(assembly), path(genome)

    output:
        tuple path("${assembly}"), path("${genome_basename}_subset.fa"), emit: assembly_genome

    script:
        genome_basename = file(genome).baseName
        """
        sort -k1,1 ${assembly} | awk -F "\t" '\$8 == "Primary Assembly" || \$8 == "non-nuclear" {print \$7}' > subset_ids.txt
        samtools faidx ${genome} -r subset_ids.txt -o ${genome_basename}_subset.fa
        """
}
process subset_genome {

    container "quay.io/biocontainers/samtools:1.3.1--h0cf4675_11"

    publishDir path: "${params.outputdir}/subset_genome", mode: 'copy'

    input:
        tuple path(assembly), path(genome)

    output:
        path("${genome_basename}_subset.fa"), emit: genome_subset

    script:
        genome_basename = file(genome).baseName
        """
        sort -k1,1V ${assembly} | awk -F "\t" '\$8 == "Primary Assembly" || \$8 == "non-nuclear" {print \$7}' > subset_ids.txt
        samtools faidx ${genome} -r subset_ids.txt -o ${genome_basename}_subset.fa
        """
}
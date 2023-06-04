process REFSEQ_TO_UCSC {

    container "quay.io/biocontainers/wget:1.20.1"

    publishDir path: "${params.outputdir}/REFSEQ_TO_UCSC", mode: 'copy'

    input:
        tuple path(assembly), path(genome)

    output:
        path("${genome_basename}_alignment.fa"), emit: genome
    
    script:
        genome_basename = file(genome).baseName
        """
        awk -v FS="\t" 'NR==FNR {header[">"\$7] = ">"\$10; next} \$0 ~ "^>" {sub(\$0, header[\$0]); print}1' ${assembly} ${genome} > ${genome_basename}_alignment.fa
        """
}
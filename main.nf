#!/usr/bin/env nextflow

// cd /home/eldavey/Documents/nextflowtest/workdir/ && nextflow /home/eldavey/Documents/nextflowtest/pipeline/main.nf -stub-run

nextflow.enable.dsl=2

include { download_data } from "./modules/download_data.nf"
include { subset_genome } from "./modules/subset_genome.nf"

workflow {

    // Create input parameter channel. Provide id for each parameter.
    Channel
        .fromList([
            ["assembly", params.assembly],
            ["genome", params.genome]
        ])

    // Download data and unzip if necessary
    | download_data 
    
    // Sort output from download_data alphabetically using id: first element is assembly, the second is genome
    // This step is necessary for subset_genome to be able to parse output
    | toSortedList({ a, b -> a[0] <=> b[0] })

    // Remove ids from input
    | map { it -> [it[0][1], it[1][1]]}
    
    // Select entries in the genome FASTA file, belonging to the Primary Assembly or Mitochondrial chromosome
    | subset_genome
}
#!/usr/bin/env nextflow

// cd /home/eldavey/Documents/nextflowtest/workdir/ && nextflow /home/eldavey/Documents/nextflowtest/pipeline/main.nf -resume

nextflow.enable.dsl=2

include { CREATE_GENOME_INDEX } from './workflows/create_genome_index.nf'

workflow {

    // Check input path parameters to see if they exist
    checkPathParamList = [
        params.genome, 
        params.assembly,
        params.outputdir,
        params.sra_samples
    ]
    for (param in checkPathParamList) { if (param) { file(param, checkIfExists: true) } }

    // Create genome index
    if (!params.genome_index) {
        CREATE_GENOME_INDEX()
            .set { ch_genome_index }
    } else {
        ch_genome_index = Channel.fromPath(params.genome_index)
    }

    // Create channel for SRA data download
    // Channel
    //     .fromPath(params.sra_samples)
    //     .splitText()

    // | view
    // | download_sra


}
#!/usr/bin/env nextflow

// cd /home/eldavey/Documents/nextflowtest/workdir/ && nextflow /home/eldavey/Documents/nextflowtest/pipeline/main.nf -stub-run

nextflow.enable.dsl=2

include { download_data } from "./modules/download_data.nf"

workflow {

    // Get input parameters
    Channel
        .fromList([params.genome, params.assembly])
        .set { f }

    // Download data
    download_data(f)

    // download_data.out.view()
}
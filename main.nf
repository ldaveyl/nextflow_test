#!/usr/bin/env nextflow

nextflow.enable.dsl=2

include { download_data } from "./modules/download_data.nf"

workflow {

    download_data(params.gene_annotation)

}

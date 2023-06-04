include { DOWNLOAD_DATA } from "../modules/download_data.nf"
include { SUBSET_GENOME } from "../modules/subset_genome.nf"
include { REFSEQ_TO_UCSC } from "../modules/refseq_to_ucsc_headers.nf"
// include { CREATE_GENOME_INDEX } from "../modules/create_genome_index.nf"

workflow CREATE_GENOME_INDEX {

    // Input genome and assembly, and provide id for sorting.
    Channel
        .fromList([
            ["assembly", params.assembly],
            ["genome", params.genome]
        ])

    // Download data and unzip if necessary
    | DOWNLOAD_DATA 
    
    // Sort output from download_data alphabetically using id: first element is assembly, the second is genome
    // This step is necessary for subset_genome to be able to parse output
    | toSortedList({ a, b -> a[0] <=> b[0] })

    // Remove ids from input
    | map { it -> [it[0][1], it[1][1]] }
    
    // Select entries in the genome FASTA file, belonging to the Primary Assembly or Mitochondrial chromosome
    | SUBSET_GENOME

    // Replace RefSeq-style fasta headers with UCSC-style headers
    | REFSEQ_TO_UCSC

    // Create genome index
    // | CREATE_GENOME_INDEX

}
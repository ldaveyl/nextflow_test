process DOWNLOAD_DATA {

    container "quay.io/biocontainers/wget:1.20.1"

    tag "${filetype}"

    publishDir path: "${params.outputdir}/DOWNLOAD_DATA", mode: 'copy'
        
    input:
        tuple val(filetype), val(file)

    output:
        tuple val(filetype), path("*"), emit: filetype_file

    script:
        ext = file(file).extension
        """
        wget -q ${file}

        if [[ ${ext} == 'gz' ]]; then
            gunzip *.gz
        fi
        """ 
}
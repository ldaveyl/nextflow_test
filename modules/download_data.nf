process download_data {

    tag "${filetype}"

    publishDir path: "${params.outputdir}/download_data", mode: 'copy'
        
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

    stub:
        ext = file(file).extension
        name = file(file).name
        basename = file(file).baseName
        """
        touch ${name}

        if [[ ${ext} == 'gz' ]]; then
            touch ${basename}
            rm ${name}
        fi
        """
}
process download_data {

    publishDir path: "${params.outputdir}/download_data", mode: 'copy'
       
    input:
        val(file)

    output:
        path("*"), emit: file
    
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
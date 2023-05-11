process download_data {
       
    input:
        val(gene_annotation)

    output:
        path("*.gtf"), emit: gtf
        
    script:
        """
        wget -q ${gene_annotation}

        if [[ ${gene_annotation} =~ \\.gz\$ ]]; then
            gzip -d *.gz
        fi
        """ 
}

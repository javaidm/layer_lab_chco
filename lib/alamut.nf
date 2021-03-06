process alamut{
    label 'cpus_32'
    publishDir "${params.outdir}/Annotation/${idSample}/Alamut/", mode: params.publish_dir_mode

    input:
    //tuple idPatient, idSample, file(vcfgz)
    tuple variantCaller, idPatient, idSample, file(vcfgz), file(vcfgzi)

    output:
    file("${idSample}_alamut_annotation.tsv")
        file("${idSample}_unannotated.tsv")
        file("alamut.output")

    script:
    """ 
        cp $vcfgz temp.vcf.gz
        gunzip temp.vcf.gz
        #vcf=\$( echo $vcfgz | sed -e 's/.gz//g')
        alamut.py temp.vcf $idSample
    """ 
}

workflow wf_alamut{

    take: _vcfgz
    
    main:
    alamut(_vcfgz)
}


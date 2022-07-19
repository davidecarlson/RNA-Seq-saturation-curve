rule download_reads:
    output:
        outdir=directory(PROJECT_DIR + "/fastqs/{sample}")
    params:
        accession={sample}
    log:
        PROJECT_DIR + "/logs/{sample}_downloadfq.log"
    shell:
        "fastq-dump --accession {params.accession} --split-files --gzip --outdir {output.outdir} 2> {log}"


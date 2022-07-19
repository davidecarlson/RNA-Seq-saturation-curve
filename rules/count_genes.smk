ANNOTATION="/gpfs/projects/GenomicsCore/indexes/human_gencode_v36/gencode.v36.annotation.gtf"
SOURCE="gencode_v36"
SPECIES="human"

rule deseq2:
    input:
        script="/gpfs/projects/GenomicsCore/benchmark/scripts/runDESeq2.R",
        trans=config['results_loc']+"/"+config['sample_size']+"/salmon/{sample}/quant.sf"
    output:
        config['results_loc']+"/"+config['sample_size']+"/deseq2/{sample}_gene_count.txt"
    params:
        mysample="{sample}",
        size=config['sample_size'],
        indir=config['results_loc']+"/"+config['sample_size']+"/salmon/{sample}",
        gtf=ANNOTATION,
        source=SOURCE
    shell:
        "Rscript {input.script} {input.trans} {output} {params.gtf} {params.source} {params.mysample} {params.size}"

rule deseq2_combined:
    input:
        script="/gpfs/projects/GenomicsCore/benchmark/scripts/runDESeq2.R",
        trans=config['results_loc']+"/"+config['sample_size']+"/salmon/combined/quant.sf"
    output:
        config['results_loc']+"/"+config['sample_size']+"/deseq2/combined_gene_count.txt"
    params:
        mysample="combined",
        size=config['sample_size'],
        indir=config['results_loc']+"/"+config['sample_size']+"/salmon/combined",
        gtf=ANNOTATION,
        source=SOURCE
    shell:
        "Rscript {input.script} {input.trans} {output} {params.gtf} {params.source} {params.mysample} {params.size}"
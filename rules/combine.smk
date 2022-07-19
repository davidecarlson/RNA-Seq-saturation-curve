rule combine_fastqs:
    input:
        fwd=expand(config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_1.fastq.gz", sample=SAMPLES),
        rev=expand(config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_2.fastq.gz", sample=SAMPLES)
    output:
        fwd=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/combined_1.fastq.gz",
        rev=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/combined_2.fastq.gz"
    shell:
        "cat {input.fwd} > {output.fwd}"
        " && cat {input.rev} > {output.rev}"

if config['species'] == "human":
	INDEX="/gpfs/projects/GenomicsCore/indexes/human_gencode_v36/salmon_index"
if config['species'] == "mouse":
	INDEX="/gpfs/projects/GenomicsCore/indexes/mouse_gencode_m25/salmon_index"
if config['species'] == "rat":
	 INDEX="/gpfs/projects/GenomicsCore/indexes/rat_mRatBN7.2/salmon_index"
if config['species'] == "neither":
	INDEX=config['index']

rule salmon_pe_single:
    input:
        fwd=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_1.fastq.gz",
        rev=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_2.fastq.gz",
        index=INDEX
    output:
        quant=directory(config['results_loc']+"/"+config['sample_size']+"/salmon/{sample}")
    threads: int(config['threads'])
    shell:
        "salmon quant -i {input.index} -l A -1 {input.fwd} -2 {input.rev} --validateMappings --threads {threads} --seqBias --gcBias -o {output.quant}"
        
rule salmon_pe_combined:
    input:
        fwd=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/combined_1.fastq.gz",
        rev=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/combined_2.fastq.gz",
        index=INDEX
    output:
        quant=directory(config['results_loc']+"/"+config['sample_size']+"/salmon/combined")
    threads: int(config['threads'])
    shell:
        "salmon quant -i {input.index} -l A -1 {input.fwd} -2 {input.rev} --validateMappings --threads {threads} --seqBias --gcBias -o {output.quant}"



rule sample_reads:
	input:
	    fwd=config['data']+"/{sample}_1.fastq.gz",
	    rev=config['data']+"/{sample}_2.fastq.gz"
	output:
	    fwd=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_1.fastq.gz",
	    rev=config['results_loc']+"/"+config['sample_size']+"/subsampled_reads/{sample}_reads_2.fastq.gz"
	params:
		size=config['sample_size']

	shell:
	    "seqtk sample -s12345 {input.fwd} {params.size} | gzip --stdout > {output.fwd}"
	    " && seqtk sample -s12345 {input.rev} {params.size} | gzip --stdout > {output.rev}"

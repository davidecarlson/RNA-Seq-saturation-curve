import pandas as pd


rule count:
    input:  config['results_loc']+"/"+config['sample_size']+"/salmon/{sample}"
    output: config['results_loc']+"/"+config['sample_size']+"/transcript_counts/{sample}_transcript_count.txt"
    
    params:
        mysample="{sample}",
        size=config['sample_size'],
        counts="/quant.sf"
    
    run:
        table = pd.read_csv(input[0]+params.counts, sep='\t')
        name = params.mysample
        min_reads = table[table['NumReads'] >=10]
        num_trans = len(min_reads)
        results = [name, params.size, str(num_trans)]
        with open(output[0], "w") as out:
            out.write(','.join(results))

rule count_combined:
    input:  config['results_loc']+"/"+config['sample_size']+"/salmon/combined/quant.sf"
    output: config['results_loc']+"/"+config['sample_size']+"/transcript_counts/combined_transcript_count.txt"
    
    params:
        size=config['sample_size'],
    
    run:
        table = pd.read_csv(input[0], sep='\t')
        name = 'combined'
        min_reads = table[table['NumReads'] >=10]
        num_trans = len(min_reads)
        results = [name, params.size, str(num_trans)]
        with open(output[0], "w") as out:
            out.write(','.join(results))
    
    
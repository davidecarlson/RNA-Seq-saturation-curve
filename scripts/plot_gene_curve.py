#!/usr/bin/env python

import glob
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt

gene_counts = glob.glob('results/*/deseq2/*_gene_count.txt')

print(gene_counts)

table = []

for file in gene_counts:
    count = file.split('/')[1]
    name = file.split('/')[3].split('_')[0]
    with open(file, "r") as f:
        data = f.read()
        res_list = data.split(',')
        accession = res_list[0].replace('"','')
        reads = int(res_list[1].replace('"',''))
        genes = int(res_list[2].replace('"',''))
        results = [accession,reads,genes]
    table.append(results) 

#print(table)

df = pd.DataFrame(table, columns = ['accession', 'reads', 'genes'])

print(df)

sns.set(rc={'figure.figsize':(14,6)})
sns.set_style("white")
sns.set_context("paper", font_scale=1.1)

sns.lineplot(data=df, x="reads", y="genes", hue="accession", markers=True)
plt.xlabel("Number of paired end reads per sample")
plt.ylabel("Genes discovered")
plt.legend(bbox_to_anchor=(1.02, 1), loc='upper left', borderaxespad=0, title='Samples')
plt.savefig('gene_saturation_curve.png', bbox_inches='tight')

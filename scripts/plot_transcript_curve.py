#!/usr/bin/env python

import glob
import pandas as pd
import seaborn as sns
from matplotlib import pyplot as plt

trans_counts = glob.glob('results/*/transcript_counts/*_transcript_count.txt')

print(trans_counts)

table = []

for file in trans_counts:
    count = file.split('/')[1]
    name = file.split('/')[3].split('_')[0]
    with open(file, "r") as f:
        data = f.read()
        res_list = data.split(',')
        accession = res_list[0]
        reads = int(res_list[1])
        transcripts = int(res_list[2])
        results = [accession,reads,transcripts]
    table.append(results) 

#print(table)

df = pd.DataFrame(table, columns = ['accession', 'reads', 'transcripts'])

print(df)

sns.set(rc={'figure.figsize':(14,6)})
sns.set_style("white")
sns.set_context("paper", font_scale=1.1)

sns.lineplot(data=df, x="reads", y="transcripts", hue="accession", markers=True)
plt.xlabel("Number of paired end reads per sample")
plt.ylabel("Transcripts discovered")
plt.legend(bbox_to_anchor=(1.02, 1), loc='upper left', borderaxespad=0, title='Samples')
plt.savefig('transcript_saturation_curve.png', bbox_inches='tight')

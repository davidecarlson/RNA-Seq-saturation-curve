library(stringr)
library(readr)
library(assertr)
library(tximport)
library(GenomicFeatures)
library(AnnotationDbi)
library(DESeq2)


# get arguments for input and output directories
args <- commandArgs(trailingOnly = TRUE)
print(args)
input <- args[1]
output <- args[2]
gtf <- args[3]
annot_source <- args[4]
name <- args[5]
sample_size <- args[6]

#Make a transcript database object use the gencode35 GTF file. GTF file location specified based on config file
txdb <- makeTxDbFromGFF(gtf, "gtf", annot_source)

#Prepare a tx2gene dataframe to associate transcript names with gene names
k <- keys(txdb, keytype="TXNAME")	
tx2gene <- select(txdb, k, "GENEID", "TXNAME")


#get salmon input file
file <- input

#get abundances for each sample while ignoring anything after the "|" in the gene names
txi <- tximport(file, type = "salmon", tx2gene = tx2gene, ignoreAfterBar=TRUE, ignoreTxVersion=FALSE)


# filter rows where total counts are less than 10
keep <- rowSums(txi$counts) >= 10

# get the number of genes with at least 10 reads across all samples
num_genes <- length(keep[keep=="TRUE"])

results <- c(name, sample_size, num_genes)

print(results)
# save results to csv file
# transpose to get the proper format
write.table(t(results),file=output, sep=",", row.names=FALSE, col.names=FALSE)

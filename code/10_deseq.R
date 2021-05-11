#Path to HTSeq files
directory <- "analyses/04_mapping_counting/htseq"

#grep files
sampleFiles <- grep("counting",list.files(directory),value=TRUE)

#Label the conditions for each respective file
sampleCondition <- c("continuous","continuous","batch","batch","continuous","continuous","continuous","batch","batch","continuous")

#Create data frame
sampleTable <- data.frame(sampleName = sampleFiles, fileName = sampleFiles, condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

#Load library DESeq2
library("DESeq2")
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable, directory = directory, design= ~ condition)
dds <- DESeq(ddsHTSeq)
res <- results(dds)

#Shrinking
resLFC <- lfcShrink(dds, coef="condition_continuous_vs_batch", type="apeglm")

#Plot both result with and without shrinking
plotMA(res, ylim=c(-2,2))
plotMA(resLFC, ylim=c(-2,2))

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
png("ma_plot.png")
plotMA(res, ylim=c(-2,2))
dev.off()

png("ma_plot_shrink.png")
plotMA(resLFC, ylim=c(-2,2))
dev.off()

#Creating report
library(ReportingTools)
report <- HTMLReport(shortName = 'DiffExp_analysis_with_DESeq2_gene_name', title = 'Differential expression analysis on continous vs batch cultures with gene names', reportDirectory = 'analyses/05_diff_exp')
publish(dds, report, pvalueCutoff=0.05, make.plots = TRUE, factor = sampleTable$condition, reportDir = "analyses/05_diff_exp")
finish(report)

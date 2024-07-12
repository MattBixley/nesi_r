# what libraries is R seeing
.libPaths()

# Presence of Biomanager implies other packages and code will work
BiocManager::version()

# load libraries
#library(DESeq2)
library(dplyr)

# read data
fcData <- read.table('data/yeast_counts_all_chr.txt', sep='\t', header=TRUE)
names(fcData)[7:12] = c("WT1", "WT2", "WT3", "MT1", "MT2", "MT3")
fcData |> head()

# basic summary
counts <- fcData[, 7:12]
rownames(counts) = fcData$Geneid
counts |> head()

# Expression Analysis
library(limma)
library(edgeR)
dge = DGEList(counts=counts)
dge = calcNormFactors(dge)
logCPM = cpm(dge, log=TRUE, prior.count=3)

options(width=100)
head(logCPM, 3)

## The beeswarm package is great for making jittered dot plots
library(beeswarm)

# Specify "conditions" (groups: WT and MT)
conds = c("WT","WT","WT","MT","MT","MT")

## Perform t-test for "gene number 6" (because I like that one...)
t.test(logCPM[6,] ~ conds)


# DESeq2
#Fit DESeq model to identify DE transcripts
library(DESeq2)
dds = DESeqDataSetFromMatrix(countData = as.matrix(counts), 
                             colData = data.frame(conds=factor(conds)), 
                             design = formula(~conds))

counts(dds) |> head()
dds = DESeq(dds)
res = DESeq2::results(dds)

# make a nice table
knitr::kable(res[1:6,])


# DESeq2
# RNA-seq experiment with three samples (A, B, and C) and a count matrix like this:

# Example count matrix
count_matrix <- data.frame(
  Gene = c("Gene1", "Gene2", "Gene3"),
  A = c(10, 5, 30),
  B = c(15, 8, 40),
  C = c(20, 12, 35)
)

# Create metadata (sample information)
metadata <- data.frame(
  Sample = c("A", "B", "C"),
  Condition = c("Treatment", "Control", "Treatment")
)

# Load your count matrix and metadata into R
library(DESeq2)

# Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = count_matrix, colData = metadata)

# Estimate size factors and dispersions
dds <- estimateSizeFactors(dds)
dds <- estimateDispersions(dds)

# Fit model
dds <- DESeq(dds)

# Extract results
res <- results(dds)
print(res)


# limma
# Expression dataset with four samples (X, Y, Z, and W) and an expression matrix like this

# Example expression matrix
expression_matrix <- data.frame(
  Gene = c("Gene1", "Gene2", "Gene3"),
  X = c(8, 6, 20),
  Y = c(12, 9, 18),
  Z = c(10, 11, 22),
  W = c(14, 7, 25)
)

# Create design matrix (e.g., treatment vs. control)
design_matrix <- model.matrix(~ Condition, data=metadata)

# Load your expression matrix and design matrix into R
library(limma)

# Normalize and filter genes
normalized_data <- voom(expression_matrix)

# Fit linear model
fit <- lmFit(normalized_data, design=design_matrix)

# Empirical Bayes moderation
fit <- eBayes(fit)

# Extract results
top_genes <- topTable(fit, coef=1, number=10)
print(top_genes)

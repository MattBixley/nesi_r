# nesi_r
example R code for the various NeSI platforms, will eventually turn into a quarto website

### Bioninformatics
`bioinformatics.r`
example script's both slurm and R for running some bioinformatics specific packages and functions based on the R-bundle-bioinformatics modules on Mahuika

From https://genomicsaotearoa.github.io/RNA-seq-workshop/
tests with `limma`, `edgeR` and `DESeq2` which utilises Bioconductor and BiocManager

### Geospatial
as above for Geospatial work which relies heavily on GDAL, proj, sp and other system libraries and R packages
terra needs a version update, blocks raster loading?

### devtools/remotes
R packages key for doing installation from non CRAN spaces, specifically github
`library(devtools)`
`library(remotes)`

### ggplot
`plotting.r`

test code for plotting, making sure RStudio/RStudio Server drivers are compatible with `cairo` ie all the module above. Failure is that the plot window doesn;t open.

##########
Below - use File > New > ...... and create dummy docs, HTML should work PDFs require work, possibly the pandoc module
 
### Markdown
examples and test ability to output to html AND pdf, pdfs will require miktex or other latex engine

### Quarto
qaurto likely similar requirements

### Shiny

### Jupyter Notebooks
maybe ;-)

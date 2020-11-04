FROM quay.io/prete/docker-jupyter:r-base

USER root

# general OS packages
RUN apt-get update -y -qq 

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

## R packages
RUN Rscript -e 'install.packages(c("tidyverse", "rJava", "umap", "ggplot2", "ggfortify", "igraph","devtools", "Rmagic", "lsa", "uwot", "optparse", "Seurat"), dependencies = TRUE)'

RUN Rscript -e 'BiocManager::install(c("SummarizedExperiment", "SingleCellExperiment", "DropletUtils", "LoomExperiment", "Rhdf5lib", "scater", "scran", "RUVSeq", "sva", "MultiAssayExperiment", "batchelor", "edgeR", "DESeq2", "BiocParallel", "SC3", "destiny", "pcaMethods", "zinbwave", "GenomicAlignments", "M3Drop", "switchde", "biomaRt", "Matrix.utils"));'

RUN Rscript -e 'devtools::install_github(c("cellgeni/sceasy", "mojaveazure/loomR", "immunogenomics/harmony", "cole-trapnell-lab/leidenbase", "cole-trapnell-lab/monocle3"));'


# fix permissions
RUN fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library


COPY poststart.sh /poststart/r.sh

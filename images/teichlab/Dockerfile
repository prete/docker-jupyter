FROM quay.io/prete/docker-jupyter:r-4.0.2

USER root

# general OS packages
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
      libhdf5-dev hdf5-tools libigraph0-dev \
      samtools bcftools bedtools parallel 

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# conda packages
COPY environment.yml /tmp/environment.yml
RUN conda env update --file /tmp/environment.yml \
    && /opt/conda/condabin/conda clean --all --yes --quiet
ENV PATH /opt/conda/envs/teichlab/bin:/opt/conda/bin:$PATH

# R packages
RUN Rscript -e 'BiocManager::install(c("edgeR","DESeq2","BiocParallel","scater","scran","SC3","monocle","destiny","pcaMethods","zinbwave","GenomicAlignments","RSAMtools","M3Drop","DropletUtils","switchde","biomaRt","batchelor","Matrix.utils"))'
RUN Rscript -e 'install.packages(c("tidyverse","devtools","Seurat","vcfR","igraph","car","ggpubr","rJava","SoupX")); devtools::install_github("velocyto-team/velocyto.R"); devtools::install_github("im3sanger/dndscv"); devtools::install_github("immunogenomics/harmony"); devtools::install_github("cole-trapnell-lab/leidenbase"); devtools::install_github("cole-trapnell-lab/monocle3")'

# Fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER 

COPY poststart.sh /poststart/teichman.sh


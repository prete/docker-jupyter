ARG tag_name
ARG parent_image="r-full"
ARG registry="quay.io/prete/docker-jupyter"

FROM $registry:$parent_image-$tag_name

USER root

# general OS packages
RUN apt-get update -y -qq && \
    apt-get install -y -qq \
      samtools bcftools bedtools parallel 

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env create  --file /tmp/environment.yml 
#    && /opt/conda/condabin/conda clean --all --yes --quiet
ENV PATH /opt/conda/envs/teichlab/bin:/opt/conda/bin:$PATH

# R packages
RUN Rscript -e 'install.packages(c("vcfR","car","ggpubr","SoupX"));'
RUN Rscript -e 'devtools::install_github(c("velocyto-team/velocyto.R", "im3sanger/dndscv"))'

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# Fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /usr/lib/R/ && \
    fix-permissions /usr/local/lib/R/site-library

RUN echo "teichlab-${tag_name}" >> /sanger/image.info

COPY poststart.sh /poststart/teichlab.sh


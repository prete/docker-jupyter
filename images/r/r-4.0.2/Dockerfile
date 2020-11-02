FROM quay.io/prete/docker-jupyter:base

USER root

# general OS packages
RUN apt-get update -y -qq 

# R dependecies
RUN apt-get install -y -qq --no-install-recommends \
    libgsl0-dev libxml2-dev libboost-all-dev libssl-dev libhdf5-dev unzip curl libudunits2-dev libgdal-dev libgeos-dev libproj-dev \
    build-essential xorg-dev libreadline-dev libc6-dev libclang-8-dev zlib1g-dev libbz2-dev liblzma-dev libcurl4-openssl-dev libcairo2-dev \
    libpango1.0-dev tcl-dev tk-dev openjdk-8-jdk openjdk-8-jre gfortran

# RStudio dependencies
RUN apt-get install -y -qq --no-install-recommends \
    gdebi-core ant   build-essential   clang   cmake   debsigs   dpkg-sig   expect   fakeroot   gnupg1   libacl1-dev   libattr1-dev   libbz2-dev   libcap-dev   libclang-6.0-dev   libclang-dev   libcurl4-openssl-dev   libegl1-mesa   libfuse2   libgl1-mesa-dev   libgtk-3-0   libpam-dev   libpango1.0-dev   libpq-dev   libsqlite3-dev   libssl-dev   libuser1-dev   libxslt1-dev   lsof   ninja-build   patchelf   pkg-config  psmisc  python   rrdtool   software-properties-common   unzip   uuid-dev   wget   zlib1g-dev

# clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install R
# https://cran.r-project.org/bin/linux/ubuntu/README.html
RUN R_VERSION=cran40 && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 && \
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu $(lsb_release -c | awk '{print $2}')-$R_VERSION/" | sudo tee -a /etc/apt/sources.list && \
    add-apt-repository ppa:c2d4u.team/c2d4u4.0+ && \
    apt-get update && apt-get install -yq --no-install-recommends \
        r-base \
        r-base-dev \
    && apt-get clean \
    && rm -rf /tmp/downloaded_packages/ /tmp/*.rds \
    rm -rf /var/lib/apt/lists/*

# install RStudio
RUN RSTUDIO_PKG=rstudio-server-1.3.1093-amd64.deb && \
    cd /tmp && \
    wget -q https://download2.rstudio.org/server/bionic/amd64/${RSTUDIO_PKG} && \
    gdebi /tmp/${RSTUDIO_PKG} && \
    rm /tmp/${RSTUDIO_PKG}

# add RStudio to PATH
ENV PATH="${PATH}:/usr/lib/rstudio-server/bin"

# jupyter-server-proxy and jupyter-rsession-proxy
RUN pip install --no-cache-dir \
        jupyter-server-proxy \
        jupyter-rsession-proxy && \
    jupyter labextension install @jupyterlab/server-proxy

# Use this URL to work with the binary packages available as of October 29, 2020 for Ubuntu 20.04 (Focal)
# https://packagemanager.rstudio.com/client/#/repos/1/overview
RUN echo 'options(repos = c(REPO_NAME = "https://packagemanager.rstudio.com/all/__linux__/focal/356"))' > ~/.Rprofile

# R packages
RUN Rscript -e 'install.packages(c("IRkernel", "tidyverse", "rJava", "umap", "ggplot2", "ggfortify", "igraph", "Rmagic", "BiocManager", "devtools", "lsa", "uwot", "optparse", "Seurat"), dependencies = TRUE)'
RUN Rscript -e 'IRkernel::installspec(prefix="/opt/conda")'
RUN Rscript -e 'BiocManager::install()'

# pip packages
RUN pip --no-cache install --upgrade ipykernel rpy2i

# conda packages
RUN conda install nb_conda_kernels 

# fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER 

COPY poststart.sh /poststart/r.sh

FROM quay.io/prete/docker-jupyter:base

USER root

# general OS packages
RUN apt-get update -y -qq 

# install Julia
ENV JULIA_VERSION=1.5.2
# Install Julia packages in /opt/julia instead of $HOME
ENV JULIA_DEPOT_PATH=/opt/julia
RUN mkdir /opt/julia-${JULIA_VERSION} && \
    cd /tmp && \
    wget --quiet https://julialang-s3.julialang.org/bin/linux/x64/`echo ${JULIA_VERSION} | cut -d. -f 1,2`/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    tar xzf julia-${JULIA_VERSION}-linux-x86_64.tar.gz -C /opt/julia-${JULIA_VERSION} --strip-components=1 && \
    rm /tmp/julia-${JULIA_VERSION}-linux-x86_64.tar.gz && \
    ln -fs /opt/julia-*/bin/julia /usr/local/bin/julia && \
    # show Julia conda dir
    #echo "push!(Libdl.DL_LOAD_PATH, \"$CONDA_DIR/lib\")" >> /etc/julia/juliarc.jl && \
    mkdir $JULIA_DEPOT_PATH && \
    # fix ownership of /opt/julia
    chown $NB_USER $JULIA_DEPOT_PATH && \
    fix-permissions $JULIA_DEPOT_PATH 

USER $NB_UID

RUN julia -e 'import Pkg; Pkg.update()' && \
    julia -e 'import Pkg; Pkg.add("IJulia")' && \
    julia -e 'using IJulia'

USER root

COPY poststart.sh /poststart/julia.sh

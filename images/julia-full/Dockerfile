FROM quay.io/prete/docker-jupyter:julia-base

USER root

# general OS packages
RUN apt-get update -y -qq

COPY install.jl /tmp/install.jl

RUN julia -e "include(\"/tmp/install.jl\");"

RUN fix-permissions "${JULIA_PKGDIR}"

COPY poststart.sh /poststart/julia.sh

ARG tag_name
ARG parent_image="base"
ARG registry="quay.io/prete/docker-jupyter"

FROM ${registry}:${parent_image}-${tag_name}

USER root

# general OS packages
RUN apt-get update -y -qq
# && apt-get install -yq --no-install-recommends \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

# conda packages
COPY environment.yml /tmp/environment.yml
RUN mamba env update --file /tmp/environment.yml

# clean conda cache
RUN  mamba clean --index-cache --tarballs --yes

# fix permissions
RUN fix-permissions $CONDA_DIR

ENV TAG_NAME=${tag_name}
RUN echo "python-${TAG_NAME}" > /sanger/image.info

COPY poststart.sh /poststart/python.sh

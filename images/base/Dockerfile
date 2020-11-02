FROM jupyter/base-notebook

USER root

# general OS packages
RUN apt-get update && apt-get install -yq --no-install-recommends \
    htop vim uzip \
    # sshfs dependencies
    fuse libfuse2 sshfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# jupyter-server-proxy
RUN pip install --no-cache-dir \
        jupyter-server-proxy && \
    jupyter serverextension enable --sys-prefix jupyter_server_proxy

# pip packages
RUN pip --no-cache install --upgrade ipykernel && \
    conda install nb_conda_kernels

# fix permissions
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER 

# rclone
RUN cd /tmp && \
    wget https://downloads.rclone.org/rclone-current-linux-amd64.deb && \
    apt-get install -y /tmp/rclone-current-linux-amd64.deb && \
    rm /tmp/rclone-current-linux-amd64.deb

# give jovyan sudo permissions
RUN sed -i -e "s/Defaults    requiretty.*/ #Defaults    requiretty/g" /etc/sudoers && \
    echo "jovyan ALL= (ALL) NOPASSWD: ALL" >> /etc/sudoers.d/jovyan

# mount-farm script
COPY mount-farm /usr/local/bin/mount-farm
RUN chmod +x /usr/local/bin/mount-farm


COPY poststart.sh /poststart/base.sh
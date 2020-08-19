# Cellular Genetics Informatics JupyterHub Docker Image

[![Docker Repository on Quay](https://quay.io/repository/cellgeni/cellgeni-jupyter/status "Docker Repository on Quay")](https://quay.io/repository/cellgeni/cellgeni-jupyter)

We support a Jupyter Hub server running on Sanger Cloud. Jupyter allows you to run your analysis in multiple environments (R, python, Julia, etc.) and also to create and share notebooks containing your analysis, code, equations and visualizations. We think this is an ideal environment for any kind of downstream analysis. For more details please refer to Jupyter Hub documentation.

## Developer instructions

A Docker image for Cellgeni JupyterHub installation
Based on [docker-stacks](https://github.com/jupyter/docker-stacks) and used with [Zero to JupyterHub with Kubernetes](https://zero-to-jupyterhub.readthedocs.io/en/latest/) and template notebooks for scientific analysis.

This Docker image is used as default for every user of Cellular Genetics Informatics JupyterHub installation. The installation contains R packages from [jupyter/r-notebook](https://github.com/jupyter/docker-stacks/blob/master/r-notebook/Dockerfile) and Python packages [jupyter/scipy-notebook](https://github.com/jupyter/docker-stacks/blob/master/scipy-notebook/Dockerfile).

`/config` folder contains the following configuration files:
- `.condarc` includes settings such as default channels and packages to include in every new environment automatically.
- `.Rprofile` includes settings for using binary repository [1](https://packagemanager.rstudio.com) for R package instalation.

_:warning: both files are overwritten by `poststart.sh` when the instance is launched, users will have to create `.keep-local-conf` on their home folder to prevent this from happening._


### Updating JupyterHub

1. Clone the private repository with [Cellgeni JupyterHub settings](https://gitlab.internal.sanger.ac.uk/cellgeni/kubespray/):
```
git clone  https://gitlab.internal.sanger.ac.uk/cellgeni/kubespray/
cd kubespray/sanger/sites
```
2. Add the new user's Github username to `auth.whitelist.users` or change Docker image at `singleuser.image.tag` in `jupyter-large-config.yaml`.

3. Commit and push your changes so that your colleagues do not override your changes in the following upgrades
```
git add jupyter-large-config.yaml && git commit -m "Add new users" && git push
```
3. Upgrade Jupyter with  
```
helm upgrade jptl jupyterhub/jupyterhub --namespace jptl --version 0.8.0 --values jupyter-large-config.yaml
```
4. Wait until the hub's state switches into `Running`. Monitor through `kubectl get pods -n jptl`.

## User instructions

1. In your browser go to [https://jupyter.cellgeni.sanger.ac.uk](https://jupyter.cellgeni.sanger.ac.uk).
2. Use your Github credentials for authentication. It may take some time to load first time.
3. Now you are ready to run your notebooks!

### Resources

At the moment by default every user is given 50GB (guaranteed) to 200GB (maximum, if available) of RAM and 1 (guaranteed) to 16 (maximum, if available) CPUs. Default storage volume is 100G.

### Important notes

- **JupyterHub environment and storage are not backed up**
- **Keep your notebooks light**. Notebooks over 100MB will give you unexpected errors.


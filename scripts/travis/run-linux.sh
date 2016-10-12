#!/bin/bash

docker run -e CONDA_PY -e ANACONDA_TOKEN \
    -v `pwd`/recipe:/recipe condaforge/linux-anvil /bin/bash -c \
    "conda config --remove channels conda-forge; conda config --add channels openbabel;conda build /recipe; anaconda -t $ANACONDA_TOKEN upload --force /opt/conda/conda-bld/*/*.tar.bz2"

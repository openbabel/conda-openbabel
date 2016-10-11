#!/bin/bash

docker run -e CONDA_PY -e ANACONDA_TOKEN \
    -v `pwd`/recipe:/recipe condaforge/linux-anvil /bin/bash -c \
    "conda config --set anaconda_upload yes; conda config --remove channels conda-forge; conda config --add channels openbabel;conda build /recipe;"

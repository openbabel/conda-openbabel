#!/bin/bash

set -e
mkdir -p conda-bld
docker pull condaforge/linux-anvil
docker run -e CONDA_PY -e ANACONDA_TOKEN -e TRAVIS_BRANCH \
    -v `pwd`/recipe:/recipe \
    -v `pwd`/conda-bld:/opt/conda/conda-bld \
    condaforge/linux-anvil /bin/bash -c \
    "conda config --remove channels conda-forge; conda update --yes conda; conda install --yes conda-build cmake; conda config --add channels openbabel; conda build /recipe;"

ls -lnh conda-bld/*/

# upload only on master
if [ "$TRAVIS_BRANCH" == "master" ]; then
    anaconda -t $ANACONDA_TOKEN upload --force conda-bld/*/*.tar.bz2
fi

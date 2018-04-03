#!/bin/bash

set -e
docker pull condaforge/linux-anvil
docker run -e CONDA_PY -e ANACONDA_TOKEN -e TRAVIS_BRANCH \
    -v `pwd`/recipe:/recipe \
    condaforge/linux-anvil /bin/bash -c "\
    conda config --remove channels conda-forge && \
    conda update --yes conda && \
    conda install --yes conda-build && \
    conda config --add channels openbabel && \
    conda build /recipe && \
    ls -lnh /opt/conda/conda-bld/*/ && \
    if [ \"\$TRAVIS_BRANCH\" == \"master\" ]; then \
      anaconda -t \$ANACONDA_TOKEN upload --force /opt/conda/conda-bld/*/*.tar.bz2; \
    fi;"

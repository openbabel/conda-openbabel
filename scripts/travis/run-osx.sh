#!/bin/bash
wget http://repo.continuum.io/miniconda/Miniconda2-latest-MacOSX-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
conda update --yes conda
conda install --yes conda-build anaconda-client
conda build --python=$CONDA_PY recipe/ -c openbabel

# upload only on master
if [ $TRAVIS_BRANCH == "master" ]; then
  anaconda -t $ANACONDA_TOKEN upload --force $HOME/miniconda/conda-bld/*/*.tar.bz2
fi

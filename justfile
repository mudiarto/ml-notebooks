#!/usr/bin/env just
# see: https://just.systems/man/en/

# require:
# - conda

python_ver := '3.11'
# make sure conda_env is sync with environment.yml
conda_env := 'ml-notebooks'

#
# general
#

# list all recipes
_default:
  @just --list --unsorted --justfile {{justfile()}}

#
# initialization & setup
#

## conda initialization
#conda-init: _check-requirements
#    #!/usr/bin/env bash
#    conda config --add channels conda-forge
#    conda config --add channels pytorch
#    conda config --set channel_priority strict
#    conda config --show-sources

# conda ml-notebooks environment initialization
env-init: _check-requirements
    #!/usr/bin/env bash
    export PIP_REQUIRE_VIRTUALENV=false
    if conda info --envs | grep -q {{conda_env}}; then echo "{{conda_env}} already exists"; else conda env create -n {{conda_env}} -y -f environment.yml ; fi
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    echo do \'conda activate {{conda_env}}\' to activate

# remove conda ml-notebooks environment
env-remove: _check-requirements
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate base
    conda remove -n {{conda_env}} --all

# conda update/refresh dependencies
env-update:
    #!/usr/bin/env bash
    export PIP_REQUIRE_VIRTUALENV=false
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda env update -n {{conda_env}} --file environment.yml --prune
    # Check for CUDA and try installing.
    if ! command -v nvidia-smi &> /dev/null
    then
        echo "CUDA is not available."
    else
        conda install -n {{conda_env}} -c pytorch -c nvidia -c conda-forge pytorch-cuda cuda cudatoolkit -y
        echo "CUDA and PyTorch have been updated."
    fi
    echo do \'conda activate {{conda_env}}\' to activate



#
# mlflow docker
#

# run mlflow in docker
mlflow-run:
    #!/usr/bin/env bash
    mlflow server \
      --backend-store-uri sqlite:///mlflow/data/db.sqlite3 \
      --host 0.0.0.0 \
      --serve-artifacts \
      --artifacts-destination mlflow/mlartifacts

#
# jupyter lab start
#

jupyter:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    # add current directory to jupyter path
    export PYTHONPATH=`pwd`:$PYTHONPATH
    echo $PYTHONPATH
    jupyter lab

#
# marimo notebooks
# NOTE: currently not used much because it prevent 'import *'
#

# edit marimo notebook - by my convention it is named file.mo.py
mo-edit target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    parent=$(dirname "{{target}}")
    filename=$(basename "{{target}}")
    cd notebooks
    mkdir -p "$parent"
    marimo -l debug edit "{{target}}.mo.py"

# run marimo notebook - by my convention it is named file.mo.py
mo-run target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    cd notebooks
    marimo -l debug run {{target}}.mo.py

# list notebooks
mo-list:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    echo "Available notebooks:"
    find "notebooks" -type f -name "*.mo.py" | sed -e 's/^notebooks\///' | sed -e 's/\.mo\.py$//' | sort


_check-requirements:
    #!/usr/bin/env bash
    if ( ! `type conda >/dev/null 2>&1` ) ; then echo "WARNING - conda is not available. Please check README.md for installation" ; exit 1 ; fi

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
    echo do \'conda activate {{conda_env}}\' to activate

#
# mlflow docker
#

# run mlflow in docker
mlflow-run:
    #!/usr/bin/env bash
    docker compose --env-file configs/docker.env up -d --build

# stop mlflow in docker
mlflow-stop:
    #!/usr/bin/env bash
    docker compose --env-file configs/docker.env down

# mlflow docker status
mlflow-status:
    #!/usr/bin/env bash
    docker compose --env-file configs/docker.env stats

#
# developments
#

# edit notebook
nb-edit target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    parent=$(dirname "{{target}}")
    filename=$(basename "{{target}}")
    cd notebooks
    mkdir -p "$parent"
    marimo -l debug edit "{{target}}.py"

# run notebook
nb-run target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    cd notebooks
    marimo -l debug run {{target}}.py

# list notebooks
nb-list:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    echo "Available notebooks:"
    find "notebooks" -type f -name "*.py" | sed -e 's/^notebooks\///' | sed -e 's/\.py$//' | sort


_check-requirements:
    #!/usr/bin/env bash
    if ( ! `type conda >/dev/null 2>&1` ) ; then echo "WARNING - conda is not available. Please check README.md for installation" ; exit 1 ; fi

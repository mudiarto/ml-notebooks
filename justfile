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
    if conda info --envs | grep -q {{conda_env}}; then echo "{{conda_env}} already exists"; else conda create -y -f environment.yml; fi
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    echo current conda environment: $CONDA_DEFAULT_ENV
    conda install python={{python_ver}} pip pytorch marimo matplotlib

# remove conda ml-notebooks environment
env-remove: _check-requirements
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate base
    conda remove -n {{conda_env}} --all

# conda update/refresh dependencies
env-update:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    PIP_REQUIRE_VIRTUALENV=false conda env update --file environment.yml --prune

#
# developments
#

# edit notebook
nb-edit target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    cd notebooks
    marimo edit {{target}}.py

# run notebook
nb-run target:
    #!/usr/bin/env bash
    eval "$(command conda 'shell.bash' 'hook' 2> /dev/null)"
    conda activate {{conda_env}}
    cd notebooks
    marimo run {{target}}.py

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

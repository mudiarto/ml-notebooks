# ml-notebooks
My Machine Learning Notebooks and Experimentation


## Setup

### Install Conda
* see: https://docs.anaconda.com/free/miniconda/
* for mac osx using [command line install](https://docs.anaconda.com/free/miniconda/#quick-command-line-install)
```bash
mkdir -p ~/miniconda3
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh -o ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
```

###  Install [Just](https://github.com/casey/just)
* see: https://github.com/casey/just
* for mac osx using [homebrew](https://brew.sh/)
```bash
brew install just
```

### Run just commands
* `just` to see all commands
* `just conda-init`
* `just env-init`
* `conda activate ml-notebooks`

## Usage

### [Marimo notebook](https://marimo.app/)

* list all notebooks: `just list`
* create/edit notebook: `just edit <notebook-name>`
* run notebook as app: `just run <notebook-name>`

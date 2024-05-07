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

### clone with git lfs
* see: https://git-lfs.github.com/
* for mac osx using [homebrew](https://brew.sh/)
```bash
brew install git-lfs
```
* clone this repo
```bash
git clone git@github.com:mudiarto/ml-notebooks.git
cd ml-notebooks
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


## References, Links

Collection of links found that maybe useful for learning and reference.
Currently not on particular order, will be organized later.

* [Dive into Deep Learning](https://d2l.ai/)
* [Deep Learning for Coders with fastai and PyTorch](https://course.fast.ai/)
* https://karpathy.ai/
* https://colah.github.io/
* https://www.3blue1brown.com/

### NN
* [Transformers Crash Course](https://github.com/syarahmadi/transformers-crash-course)
*

### PyTorch
* [PyTorch playground](https://adityassrana.github.io/blog/tutorials/2020/04/22/PyTorch-Playground.html)
* [Grokking PyTorch](https://github.com/Kaixhin/grokking-pytorch)
* [Effective PyTorch](https://github.com/vahidk/EffectivePyTorch)
* [The Python Magic Behind PyTorch](https://amitness.com/2020/03/python-magic-behind-pytorch)
* [PyTorch StyleGuide](https://github.com/IgorSusmelj/pytorch-styleguide/blob/master/README.md)
* [Pytorch Coding Conventions](https://discuss.pytorch.org/t/pytorch-coding-conventions/42548)
* [Fine Tuning etc](https://spandan-madan.github.io/A-Collection-of-important-tasks-in-pytorch/)
* [PyTorch Beginner](https://github.com/L1aoXingyu/pytorch-beginner) - comment in chinese
* [PyTorch Tutorial](https://github.com/yunjey/pytorch-tutorial) - nice commented out pytorch tutorial
* [PyTorch Tutorial](https://github.com/MorvanZhou/PyTorch-Tutorial) - another nice tutorial
* [PyTorch Dive into Deep Learning - d2l.ai](https://github.com/dsgiitr/d2l-pytorch) - d2l.ai in pytorch

### Python
* [Python is Cool - ChipHuyen](https://github.com/chiphuyen/python-is-cool/blob/master/README.md)
* [Clean Code Python](https://github.com/zedr/clean-code-python)
* [underscore in python](https://dbader.org/blog/meaning-of-underscores-in-python)

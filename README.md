gnemeAnnotation
================
Sylvain Schmitt
April 28, 2022

  - [Installation](#installation)
  - [Usage](#usage)
      - [Locally](#locally)
      - [HPC](#hpc)
  - [Workflow](#workflow)
      - [Transposable elements (TE)](#transposable-elements-te)
      - [Genes](#genes)
      - [Functional annotation](#functional-annotation)

[`singularity` &
`snakemake`](https://github.com/sylvainschmitt/snakemake_singularity)
workflow to annotate genomes.

![Workflow.](dag/dag.svg)

# Installation

  - [x] Python ≥3.5
  - [x] Snakemake ≥5.24.1
  - [x] Golang ≥1.15.2
  - [x] Singularity ≥3.7.3
  - [x] This workflow

<!-- end list -->

``` bash
# Python
sudo apt-get install python3.5
# Snakemake
sudo apt install snakemake`
# Golang
export VERSION=1.15.8 OS=linux ARCH=amd64  # change this as you need
wget -O /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz https://dl.google.com/go/go${VERSION}.${OS}-${ARCH}.tar.gz && \
sudo tar -C /usr/local -xzf /tmp/go${VERSION}.${OS}-${ARCH}.tar.gz
echo 'export GOPATH=${HOME}/go' >> ~/.bashrc && \
echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc && \
source ~/.bashrc
# Singularity
mkdir -p ${GOPATH}/src/github.com/sylabs && \
  cd ${GOPATH}/src/github.com/sylabs && \
  git clone https://github.com/sylabs/singularity.git && \
  cd singularity
git checkout v3.7.3
cd ${GOPATH}/src/github.com/sylabs/singularity && \
  ./mconfig && \
  cd ./builddir && \
  make && \
  sudo make install
# detect Mutations
git clone git@github.com:sylvainschmitt/genomeAnnotation.git
cd genomeAnnotation
```

# Usage

## Locally

``` bash
snakemake -np -j 3 --resources mem_mb=10000 # dry run
snakemake --dag | dot -Tsvg > dag/dag.svg # dag
snakemake --use-singularity -j 3 --resources mem_mb=10000 # run
```

## HPC

``` bash
module load bioinfo/snakemake-5.25.0 # for test on node
snakemake -np # dry run
sbatch job.sh # run
snakemake --dag | dot -Tsvg > dag/dag.svg # dag
```

# Workflow

## Transposable elements (TE)

### [repeat\_masker](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repeat_masker.smk)

  - Tools:
    [RepeatMasker](https://stab.st-andrews.ac.uk/wiki/index.php/Repeatmasker)
  - Singularity: docker://pegi3s/repeat\_masker

### [repeat\_modeler](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repeat_modeler.smk)

  - Tools:
    [RepeatModeler](https://github.com/Dfam-consortium/RepeatModeler)
  - Singularity: docker://dfam/tetools

## Genes

### [braker\_prot](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/braker_prot.smk)

  - Tools:
    [braker.pl](https://github.com/Gaius-Augustus/BRAKER#running-braker)
  - Singularity: docker://blaxterlab/braker

## Functional annotation

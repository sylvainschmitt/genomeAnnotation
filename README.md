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

<!-- https://www.bioinformatics.uni-muenster.de/publication_data/P.californicus_annotation/repeat_masking.hbi?lang=en -->

## Transposable elements (TE)

<!-- ### [repet](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repet.smk) -->

<!-- * Tools: [REPET](https://urgi.versailles.inra.fr/Tools/REPET) -->

<!-- * Singularity: docker://urgi/docker_vre_aio -->

### [repeat\_modeler](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repeat_modeler.smk)

  - Tools:
    [RepeatModeler](https://github.com/Dfam-consortium/RepeatModeler)
  - Singularity: docker://dfam/tetools

### [repeat\_classifier](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repeat_classifier.smk)

  - Tools:
    [RepeatClassifier](https://github.com/Dfam-consortium/RepeatModeler)
  - Singularity: docker://dfam/tetools

### [te\_class\_denovo](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/te_class_denovo.smk)

  - Tools:
    [TEclass](https://www.compgen.uni-muenster.de/tools/teclass/index.hbi?lang=en)
  - Singularity: docker://hatimalmutairi/teclass-2.1.3b

### [te\_class\_repbase](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/te_class_repbase.smk)

  - Tools:
    [TEclass](https://www.compgen.uni-muenster.de/tools/teclass/index.hbi?lang=en)
  - Singularity: docker://hatimalmutairi/teclass-2.1.3b
  - Base: [RepBase](https://www.girinst.org/server/RepBase/index.php)

### [join\_repeats](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/join_repeats.smk)

  - Tools: `cat`

### [repeat\_masker](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/repeat_masker.smk)

  - Tools:
    [RepeatMasker](https://stab.st-andrews.ac.uk/wiki/index.php/Repeatmasker)
  - Singularity: docker://pegi3s/repeat\_masker

## Genes

### [braker\_prot](https://github.com/sylvainschmitt/genomeAnnotation/blob/main/rules/braker_prot.smk)

  - Tools:
    [braker.pl](https://github.com/Gaius-Augustus/BRAKER#running-braker)
  - Singularity: docker://blaxterlab/braker

## Functional annotation

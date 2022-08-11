# pipeline
git clone --recursive https://github.com/guigolab/FA-nf
mv FA-nf FAangela
cd FAangela

# environment
module load bioinfo/Nextflow-v20.01.0
module load system/singularity-3.7.3

# data
mkdir data
cp ../genomeAnnotation/results/genes/braker/Dgu_HS1_HYBRID_SCAFFOLD/braker.gtf data/
cp ../genomeAnnotation/data/Dgu_HS1_HYBRID_SCAFFOLD.fa data/

# containres

## sigtarp
cd containers/sigtarp
mkdir external
cd external
wget https://services.healthtech.dtu.dk/download/ca217434-eb47-4e55-8247-06d1f2f9db5b/signalp-5.0b.Linux.tar.gz
gunzip signalp-5.0b.Linux.tar.gz
tar -xvf signalp-5.0b.Linux.tar 
rm signalp-5.0b.Linux.tar
wget https://services.healthtech.dtu.dk/download/15b431bb-d9a5-4bd3-b2d9-d4003bcc000c/targetp-2.0.Linux.tar.gz
gunzip targetp-2.0.Linux.tar.gz
tar -xvf targetp-2.0.Linux.tar 
rm targetp-2.0.Linux.tar
cd ..
sudo docker build .
sudo docker tag 635affd8810f sigtarp
sudo singularity build sigtarp.sif docker-daemon://sigtarp:latest

# iprscan
cd containers/interproscan
mkdir external
cd external
wget https://services.healthtech.dtu.dk/download/1c312037-ea6a-48de-b7d8-945d0e18c328/signalp-4.1g.Linux.tar.gz
wget https://services.healthtech.dtu.dk/download/5bf2de7b-5ff7-4cee-9eb8-a0686c0e6122/tmhmm-2.0c.Linux.tar.gz
# dl from https://software.sbc.su.se/cgi-bin/request.cgi?project=phobius
cd ..
sudo docker build -t iprscan:5.54-87.0 -f Dockerfile .
sudo singularity build iprscan-5.54-87.0.sif docker-daemon://iprscan:5.54-87.0

# prep nextflow.config
# comment all queue
# replace l.52: container="/work/sschmitt/FAangela/containers/sigtarp/sigtarp.sif"
# replace l.67: container="/work/sschmitt/FAangela/containers/interproscan/iprscan-5.54-87.0.sif"
# add text from https://github.com/nf-core/configs/blob/master/conf/genotoul.config at the end

# prep param.config
# replace l.4: proteinFile = "${baseDir}/data/Dgu_HS1_HYBRID_SCAFFOLD.fa"
# replace l.6: gffFile = "${baseDir}/data/braker.gtf"
# replace l.8: debug = "false"
# replace l.30: dbPath = "/work/sschmitt/FAangela/nfs/db"
# replace l.83: email = "sylvain.m.schmitt@gmail.com"

# dataset
export NXF_HOME=~/.nextflow
nextflow run -bg download.nf --config params.download.config &> download.logfile

# run debug
nextflow run -bg main.nf --config params.config &> logfile

# full run


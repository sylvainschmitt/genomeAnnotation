singularity pull docker://hamiltonjp/braker2:a765b80
singularity shell braker2_a765b80.sif
mkdir augustus
cp -r $AUGUSTUS_BIN_PATH/../config/ augustus/
exit
rm braker2_a765b80.sif
module load bioinfo/GeneMark-v4.69
cp /usr/local/bioinfo/src/GeneMark/gm_key ~/.gm_key

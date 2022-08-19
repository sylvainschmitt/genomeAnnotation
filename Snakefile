import pandas as pd

configfile: "config/config.yml"

genomes = (
    pd.read_csv(config["sample_file"], sep="\t")
    .set_index("genome", drop=False)
    .sort_index()
)

def get_protDB(wildcards):
   return "data/" + genomes.loc[wildcards.genome]["protDB"]
       
rule all:
    input:
        # expand("results/te/RepeatMasker/{genome}/{genome}.fa.tbl", genome=genomes["genome"]), # TE summary
        # expand("results/genes/braker/{genome}/braker.gtf", genome=genomes["genome"]), # genes
        expand("results/annotation/trinotate/{genome}/trinotate_annotation_report.txt", genome=genomes["genome"]) # annotation

# Rules #

## TE ##
include: "rules/repeat_modeler.smk"
include: "rules/repeat_classifier.smk"
include: "rules/te_class_repbase.smk"
include: "rules/te_class_denovo.smk"
include: "rules/join_repeats.smk"
include: "rules/repeat_masker.smk"

## Genes ##
include: "rules/genemark.smk"
include: "rules/prothint.smk"
include: "rules/braker.smk"
# barker will produce a braker.gtf that we may want to convert to gff3 with tools within docker images (GeneMark and braker itself may have it)

## Annotation ##
include: "rules/prep_trsc.smk"
include: "rules/bedtools_getfasta.smk"
#include: "rules/transdecoder.smk"
include: "rules/trinotate_db.smk"
#include: "rules/tmhmm.smk"
include: "rules/hmmscan.smk"
include: "rules/blastp.smk"
include: "rules/blastx.smk"
#include: "rules/rnammer.smk"
include: "rules/rename_fasta_headers.smk"
include: "rules/signalp.smk"
include: "rules/rename_gff.smk"
include: "rules/trinotate_load.smk"
include: "rules/trinotate_report.smk"

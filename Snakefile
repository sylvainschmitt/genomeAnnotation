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
        expand("results/te/RepeatMasker/{genome}/{genome}.fa.masked", genome=genomes["genome"]), # TE RepeatMasker
        expand("results/te/RepeatModeler/{genome}/{genome}-families.fa", genome=genomes["genome"]) # TE RepeatModeler2

# Rules #

## TE ##
include: "rules/repeat_masker.smk"
include: "rules/repeat_modeler.smk"

## Genes ##
include: "rules/braker_prots.smk"

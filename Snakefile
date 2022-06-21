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
        expand("results/genes/braker/{genome}", genome=genomes["genome"]) # genes

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

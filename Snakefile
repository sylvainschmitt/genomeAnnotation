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
        expand("results/braker/{genome}", genome=genomes["genome"])

# Rules #
include: "rules/repeat_masker.smk"
include: "rules/braker_prots.smk"

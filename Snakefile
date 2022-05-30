configfile: "config/config.angela.yml"

rule all:
    input:
        expand("results/braker/{genome}", genome=config["genome"])

# Rules #
include: "rules/repeat_masker.smk"
include: "rules/braker_prots.smk"

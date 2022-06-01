rule repeat_masker:
    input:
        "data/{genome}.fa"
    output:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked"
    log:
        "results/logs/repeat_masker_{genome}.log"
    benchmark:
        "results/benchmarks/repeat_masker_{genome}.benchmark.txt"
    singularity:
        "docker://pegi3s/repeat_masker"
    threads: 8
    params:
        species=lambda wildcards: genomes.loc[wildcards.genome]["species"],
        dir=lambda wildcards: "results/te/RepeatMasker/" + wildcards.genome
    shell:
        "RepeatMasker -species {params.species} -s {input} -pa {threads} -dir {params.dir} -html -gff -small"
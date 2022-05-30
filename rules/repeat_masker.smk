rule repeat_masker:
    input:
        "data/{genome}.fa"
    output:
        "results/genome/{genome}_softmasked.fa"
    log:
        "results/logs/repeat_masker_{genome}.log"
    benchmark:
        "results/benchmarks/repeat_masker_{genome}.benchmark.txt"
    singularity:
        "docker://pegi3s/repeat_masker"
    threads: 8
    params:
        species=lambda wildcards: genomes.loc[wildcards.genome]["species"]
    shell:
        "RepeatMasker -species {params.species} -s {input} -pa {threads}"
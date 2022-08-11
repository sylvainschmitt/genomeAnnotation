rule bedtools_getfasta:
    input:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked",
        "results/annotation/trinotate/{genome}/trsc.gtf"
    output:
        "results/annotation/trinotate/{genome}/trsc.fa"
    log:
        "results/logs/debtools_getfasta_{genome}.log"
    benchmark:
        "results/benchmarks/debtools_getfasta_{genome}.benchmark.txt"
    singularity:
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    threads: 1
    shell:
        "bedtools getfasta -fi {input[0]} -bed {input[1]} > {output}"
        
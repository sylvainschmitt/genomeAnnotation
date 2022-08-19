rule tmhmm:
    input:
        "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep"
    output:
        "results/annotation/tmhmm/{genome}/tmhmm.out"
    log:
        "results/logs/tmhmm_{genome}.log"
    benchmark:
        "results/benchmarks/tmhmm_{genome}.benchmark.txt"
    singularity:
        "docker://crhisllane/tmhmm:latest"
    threads: 1
    shell:
        "tmhmm -f {input} > {output}"
        
rule hmmscan:
    input:
        "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep",
        "results/annotation/trinotate/{genome}/db/Pfam-A.hmm.gz"
    output:
        "results/annotation/hmmer/{genome}/TrinotatePFAM.out"
    log:
        "results/logs/hmmscan_{genome}.log"
    benchmark:
        "results/benchmarks/hmmscan_{genome}.benchmark.txt"
    singularity:
        "docker://dockerbiotools/hmmer:latest"
    threads: 10
    shell:
        "hmmscan --cpu {threads} --domtblout {output} {input[1]} {input[0]} > {log}"
        
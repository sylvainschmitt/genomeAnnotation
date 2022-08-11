rule blastx:
    input:
        "results/annotation/trinotate/{genome}/trsc.fa",
        "results/annotation/trinotate/{genome}/db/uniprot_sprot.pep"
    output:
        "results/annotation/blastx/{genome}/blastx.outfmt6"
    log:
        "results/logs/blastx_{genome}.log"
    benchmark:
        "results/benchmarks/blastx_{genome}.benchmark.txt"
    singularity:
        "docker://ncbi/blast"
    threads: 10
    shell:
        "blastx -db {input[1]} -query {input[0]} -num_threads {threads} -max_target_seqs 1 -outfmt 6 > {output}"
        
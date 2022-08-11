rule blastp:
    input:
        "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep",
        "results/annotation/trinotate/{genome}/db/uniprot_sprot.pep"
    output:
        "results/annotation/blastp/{genome}/blastp.outfmt6"
    log:
        "results/logs/blastp_{genome}.log"
    benchmark:
        "results/benchmarks/blastp_{genome}.benchmark.txt"
    singularity:
        "docker://ncbi/blast"
    threads: 10
    shell:
        "blastp -db {input[1]} -query {input[0]} -num_threads {threads} -max_target_seqs 1 -outfmt 6 > {output}"
        
rule rnammer:
    input:
        "results/annotation/trinotate/{genome}/trsc.fa"
    output:
        "results/annotation/rnammer/{genome}/trsc.fa.rnammer.gff"
    log:
        "results/logs/rnammer_{genome}.log"
    benchmark:
        "results/benchmarks/rnammer_{genome}.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    params:
        wd="results/annotation/rnammer/{genome}/"
    shell:
        "cp {input} {params.wd} ; "
        "cd {params.wd} ; "
        "/usr/local/bin/RnammerTranscriptome.pl --transcriptome trsc.fa "
        "--path_to_rnammer /usr/local/bioinfo/src/RNAmmer/rnammer-1.2/rnammer"
        
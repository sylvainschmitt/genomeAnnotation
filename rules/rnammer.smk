rule rnammer:
    input:
        "results/annotation/trinotate/{genome}/trsc.fa"
    output:
        "results/annotation/rnammer/{genome}/tsc.fa.rnammer.gff"
    log:
        "results/logs/rnammer_{genome}.log"
    benchmark:
        "results/benchmarks/rnammer_{genome}.benchmark.txt"
    singularity:
        "docker://quay.io/biocontainer/trinotate"
    threads: 1
    shell:
        "module load bioinfo/rnammer-1.2 ; "
        "$TRINOTATE_HOME/util/rnammer_support/RnammerTranscriptome.pl ---transcriptome {input} "
        "--path_to_rnammer /usr/local/bioinfo/src/RNAmmer/rnammer-1.2/rnammer"
        
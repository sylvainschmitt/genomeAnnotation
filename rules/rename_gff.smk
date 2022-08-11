rule rename_gff:
    input:
        signalp_gff = "results/annotation/signalp/{genome}/signalp.out",
        ids = "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep.ids"
    output:
        signalp_renamed_gff = "results/annotation/signalp/{genome}/signalp.renamed.out"
    log:
        "results/logs/rename_gff_{genome}.log"
    benchmark:
        "results/benchmarks/rename_gff_{genome}.benchmark.txt"
    threads: 1
    script:
        "../scripts/rename_gff.R"
        
rule signalp:
    input:
        "results/annotation/signalp/{genome}/trsc.fa.transdecoder.pep.renamed"
    output:
        "results/annotation/signalp/{genome}/signalp.out"
    log:
        "results/logs/signalp_{genome}.log"
    benchmark:
        "results/benchmarks/signalp_{genome}.benchmark.txt"
    singularity:
        "/home/sschmitt/work/singularity/iprscan.sif"
    threads: 1
    shell:
        "signalp -f short -n {output} {input}"
        
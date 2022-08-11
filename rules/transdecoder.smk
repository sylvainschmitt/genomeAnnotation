rule transdecoder:
    input:
        "results/annotation/trinotate/{genome}/trsc.fa",
        "results/annotation/trinotate/{genome}/trsc.fa.gene_trans_map"
    output:
        "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep"
    log:
        "results/logs/transdecoder_{genome}.log"
    benchmark:
        "results/benchmarks/transdecoder_{genome}.benchmark.txt"
    singularity:
        "oras://registry.forgemia.inra.fr/gafl/singularity/transdecoder/transdecoder:latest"
    threads: 1
    params:
        dir="results/annotation/transdecoder/{genome}"
    shell:
        "TransDecoder.LongOrfs -t {input[0]} --gene_trans_map {input[1]} -S -O {params.dir} ; "
        "cd {params.dir}"
        "TransDecoder.Predict -t {input[0]} -O {output} "
        
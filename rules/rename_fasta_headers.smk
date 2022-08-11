rule rename_fasta_headers:
    input:
        transdecoder_results = "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep"
    output:
        renamed_transdecoder ="results/annotation/signalp/{genome}/trsc.fa.transdecoder.pep.renamed",
        ids = "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep.ids"
    log:
        "results/logs/rename_fasta_headers_{genome}.log"
    benchmark:
        "results/benchmarks/rename_fasta_headers_{genome}.benchmark.txt"
    threads: 1
    script:
        "../scripts/rename_fasta_headers.py"
        
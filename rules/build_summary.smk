rule build_summary:
    input:
        "results/te/RepeatMasker/{genome}/{genome}.out"
    output:
        "results/te/RepeatMasker/{genome}/{genome}.tbl"
    log:
        "results/logs/build_summary_{genome}.log"
    benchmark:
        "results/benchmarks/build_summary_{genome}.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    threads: 8
    params:
        genome=lambda wildcards: wildcards.genome,
        dir=lambda wildcards: "results/te/RepeatMasker/" + wildcards.genome
    shell:
        "cd {params.dir} ; "
        "perl buildSummary.pl {params.genome}.out > {params.genome}.tbl"

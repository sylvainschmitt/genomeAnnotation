rule maker_opts:
    output:
        expand("results/{library}/{library}_{strand}_fastqc.{ext}", strand=["1", "2"], ext=["html", "zip"], allow_missing=True)
    log:
        "results/logs/maker_opts_{genome}.log"
    benchmark:
        "results/benchmarks/maker_opts_{genome}.benchmark.txt"
    singularity:
        "docker://cgwyx/maker"
    shell:
        "maker -CTL"
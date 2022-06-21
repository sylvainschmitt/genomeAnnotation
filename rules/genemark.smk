rule genemark:
    input:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked",
        get_protDB
    output:
        "results/genes/GeneMark/{genome}/output/genemark.gtf"
    log:
        "results/logs/genemark_{genome}.log"
    benchmark:
        "results/benchmarks/genemark_{genome}.benchmark.txt"
    singularity:
        "docker://blaxterlab/braker"
    threads: 8
    params:
        genome=lambda wildcards: wildcards.genome,
        dir=lambda wildcards: "results/genes/GeneMark/" + wildcards.genome
    shell:
        "cp {input} {params.dir} ; "
        "cd {params.dir} ; "
        "$GENEMARK_PATH/gmes_petap.pl --ES --cores {threads} --sequence {params.genome}.fa.masked"
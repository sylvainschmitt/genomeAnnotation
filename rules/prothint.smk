rule prothint:
    input:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked",
        get_protDB,
        "results/genes/GeneMark/{genome}/genemark.gtf"
    output:
        "results/genes/ProtHint/{genome}/prothint_augustus.gff"
    log:
        "results/logs/prothint_{genome}.log"
    benchmark:
        "results/benchmarks/prothint_{genome}.benchmark.txt"
    singularity:
        "docker://hamiltonjp/braker2:a765b80"
    threads: 8
    params:
        dir=lambda wildcards: "results/genes/ProtHint/" + wildcards.genome
    shell:
        "$PROTHINT_PATH/prothint.py {input[0]} {input[1]} --geneMarkGtf {input[2]} --workdir {params.dir}"
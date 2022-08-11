rule trinotate_report:
    input:
        "results/annotation/trinotate/{genome}/trsc.sqlite"
    output:
        "results/annotation/trinotate/{genome}/trinotate_annotation_report.txt"
    log:
        "results/logs/trinotate_report_{genome}.log"
    benchmark:
        "results/benchmarks/trinotate_report_{genome}.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        'Trinotate {input} report > {output} 2> {log}'
        
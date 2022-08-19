rule trinotate_go:
    input:
        "results/annotation/trinotate/{genome}/trinotate_annotation_report.txt"
    output:
        "results/annotation/trinotate/{genome}/trinotate_go_annotations.txt"
    log:
        "results/logs/trinotate_go_{genome}.log"
    benchmark:
        "results/benchmarks/trinotate_go_{genome}.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        "extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls {input} -G --include_ancestral_term > {output}"
        
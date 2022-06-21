rule repeat_masker:
    input:
        "data/{genome}.fa",
        "results/te/JoinRepeats/{genome}/all_repeats_lib.fa"
    output:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked",
        "results/te/RepeatMasker/{genome}/{genome}.fa.out",
        "results/te/RepeatMasker/{genome}/{genome}.fa.tbl"
    log:
        "results/logs/repeat_masker_{genome}.log"
    benchmark:
        "results/benchmarks/repeat_masker_{genome}.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    threads: 8
    params:
        genome=lambda wildcards: wildcards.genome,
        dir=lambda wildcards: "results/te/RepeatMasker/" + wildcards.genome
    shell:
        "cp {input} {params.dir} ; "
        "cd {params.dir} ; "
        "RepeatMasker -s -xsmall -a -gff -pa {threads} -u -lib  all_repeats_lib.fa {params.genome}.fa"
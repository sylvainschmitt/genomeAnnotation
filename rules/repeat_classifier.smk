rule repeat_classifier:
    input:
        "results/te/RepeatModeler/{genome}/consensi.fa"
    output:
        "results/te/RepeatClassifier/{genome}/consensi.fa.classified"
    log:
        "results/logs/repeat_classifier_{genome}.log"
    benchmark:
        "results/benchmarks/repeat_classifierr_{genome}.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    params:
        dir=lambda wildcards: "results/te/RepeatClassifier/" + wildcards.genome
    shell:
        "cp {input} {params.dir} ; "
        "cd {params.dir} ; "
        "RepeatClassifier -consensi consensi.fa"
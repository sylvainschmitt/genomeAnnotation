rule te_class_denovo:
    input:
        "results/te/RepeatClassifier/{genome}/consensi.fa.classified"
    output:
        "results/te/TEclass/{genome}/consensi.fa.classified.lib"
    log:
        "results/logs/te_class_denovo_{genome}.log"
    benchmark:
        "results/benchmarks/te_class_denovo_{genome}.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    params:
        dir=lambda wildcards: "results/te/TEclass/" + wildcards.genome
    shell:
        "cp {input} {params.dir} ; "
        "cd {params.dir} ; "
        "TEclassTest consensi.fa.classified  > {log} ; "
        "dir=$(ls | grep consensi.fa.classified_) ; "
        "cp $dir/consensi.fa.classified.lib ."
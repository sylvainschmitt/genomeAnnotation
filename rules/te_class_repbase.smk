rule te_class_repbase:
    input:
        "data/repbase_viridiplantae.fa"
    output:
        "results/te/RepBase/repbase_viridiplantae.fa.lib"
    log:
        "results/logs/te_class_repbase.log"
    benchmark:
        "results/benchmarks/te_class_repbase.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    params:
        dir="results/te/RepBase/"
    shell:
        "cp {input} {params.dir} ; "
        "cd {params.dir} ; "
        "TEclassTest repbase_viridiplantae.fa > {log} ; "
        "dir=$(ls | grep repbase_viridiplantae.fa_) ; "
        "cp $dir/repbase_viridiplantae.fa.lib ."
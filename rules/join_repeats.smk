rule join_repeats:
    input:
        "results/te/RepBase/repbase_viridiplantae.fa.lib",
        "results/te/TEclass/{genome}/consensi.fa.classified.lib"
    output:
        "results/te/JoinRepeats/{genome}/all_repeats_lib.fa"
    log:
        "results/logs/join_repeats_{genome}.log"
    benchmark:
        "results/benchmarks/join_repeats_{genome}.benchmark.txt"
    shell:
        "cat {input} > {output}"
        
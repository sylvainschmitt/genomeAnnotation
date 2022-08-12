rule prep_trsc:
    input:
        "results/genes/braker/{genome}/braker.gtf"
    output:
        "results/annotation/trinotate/{genome}/trsc.gtf",
        "results/annotation/trinotate/{genome}/trsc.fa.gene_trans_map"
    log:
        "results/logs/prep_trsc_{genome}.log"
    benchmark:
        "results/benchmarks/prep_trsc_{genome}.benchmark.txt"
    singularity:
        "oras://registry.forgemia.inra.fr/gafl/singularity/bedtools/bedtools:latest"
    threads: 1
    shell:
        "cat {input} | awk \'{{if($3 == \"transcript\") {{print}}}}\' > {output[0]} ; "
        "cat {output[0]} | awk \'{{if($3 == \"transcript\") {{print$9\"\\t\"$9}}}}\' | awk \'{{gsub(/.t[0-9]/,\"\",$2);print}}\' > {output[1]}"
        
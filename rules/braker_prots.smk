rule braker_prot:
    input:
        "results/genome/{genome}_softmasked.fa",
        get_protDB
    output:
        directory("results/braker/{genome}")
    log:
        "results/logs/braker_prot_{genome}.log"
    benchmark:
        "results/benchmarks/braker_prot_{genome}.benchmark.txt"
    singularity:
        "docker://blaxterlab/braker"
    threads: 8
    params:
        species=lambda wildcards: genomes.loc[wildcards.genome]["species"]
    shell:
        "braker.pl --genome={input[0]} --prot_seq={input[1]} --epmode --ab_initio --cores={threads} --softmasking --species='{params.species}' --makehub -workingdir={output}"
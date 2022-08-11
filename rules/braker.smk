rule braker:
    input:
        "results/te/RepeatMasker/{genome}/{genome}.fa.masked",
        "results/genes/ProtHint/{genome}/prothint_augustus.gff"
    output:
        "results/genes/braker/{genome}/braker.gtf"
    log:
        "results/logs/braker_{genome}.log"
    benchmark:
        "results/benchmarks/braker_{genome}.benchmark.txt"
    singularity:
        "docker://hamiltonjp/braker2:a765b80"
    threads: 8
    params:
        species=lambda wildcards: genomes.loc[wildcards.genome]["species"]
    shell:
        "braker.pl --cores={threads} --species='{params.species}' --workingdir={output} --genome={input[0]} --hints={input[1]} --softmasking"
        
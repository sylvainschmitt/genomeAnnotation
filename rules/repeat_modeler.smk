rule repeat_modeler:
    input:
        "data/{genome}.fa"
    output:
        "results/te/RepeatModeler/{genome}/{genome}-families.fa",
        "results/te/RepeatModeler/{genome}/{genome}-families.stk"
    log:
        "results/logs/repeat_modeler_{genome}.log"
    benchmark:
        "results/benchmarks/repeat_modeler_{genome}.benchmark.txt"
    singularity:
        "docker://dfam/tetools"
    threads: 8
    params:
        species=lambda wildcards: re.sub(' ', '_', genomes.loc[wildcards.genome]["species"]),
        dir=lambda wildcards: "results/te/RepeatModeler/" + wildcards.genome
    shell:
        "cp {input} {params.dir} ;"
        "cd {params.dir} ; "
        "BuildDatabase -name {params.species}  $genome ; "
        "RepeatModeler -database {params.species} -pa {threads} -LTRStruct > run.out"
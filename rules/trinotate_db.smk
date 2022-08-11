rule trinotate_db:
    output:
        "results/annotation/trinotate/{genome}/db/trsc.sqlite",
        "results/annotation/trinotate/{genome}/db/uniprot_sprot.pep",
        "results/annotation/trinotate/{genome}/db/Pfam-A.hmm.gz"
    log:
        "results/logs/trinotate_db_{genome}.log"
    benchmark:
        "results/benchmarks/trinotate_db_{genome}.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    params:
        wd="results/annotation/trinotate/{genome}/db/"
    shell:
        'cd {params.wd} ; '
        '/usr/local/bin/Build_Trinotate_Boilerplate_SQLite_db.pl trsc ; '
        'makeblastdb -in uniprot_sprot.pep -dbtype prot ; '
        'gunzip Pfam-A.hmm.gz ; '
        'hmmpress Pfam-A.hmm'
        
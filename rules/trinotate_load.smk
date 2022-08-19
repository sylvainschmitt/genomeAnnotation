rule trinotate_load:
    input:
        fasta = "results/annotation/trinotate/{genome}/trsc.fa",
        gene_trans_map = "results/annotation/trinotate/{genome}/trsc.fa.gene_trans_map",
        transdecoder = "results/annotation/transdecoder/{genome}/trsc.fa.transdecoder.pep",
        blastx = "results/annotation/blastx/{genome}/blastx.outfmt6",
        blastp = "results/annotation/blastp/{genome}/blastp.outfmt6",
        signalp = "results/annotation/signalp/{genome}/signalp.renamed.out",
        tmhmm = "results/annotation/tmhmm/{genome}/tmhmm.out", 
        hmmer = "results/annotation/hmmer/{genome}/TrinotatePFAM.out",
        rnammer = "results/annotation/rnammer/{genome}/trsc.fa.rnammer.gff",
        db = "results/annotation/trinotate/{genome}/db/trsc.sqlite"
    output:
        "results/annotation/trinotate/{genome}/trsc.sqlite"
    log:
        "results/logs/trinotate_load_{genome}.log"
    benchmark:
        "results/benchmarks/trinotate_load_{genome}.benchmark.txt"
    singularity:
        "docker://ss93/trinotate-3.2.1"
    threads: 1
    shell:
        'cp {input.db} {output} ; '
        'Trinotate {output} init --gene_trans_map {input.gene_trans_map} '
        '--transcript_fasta {input.fasta} --transdecoder_pep {input.transdecoder} ; '
        'Trinotate {output} LOAD_swissprot_blastx {input.blastx} ; '
        'Trinotate {output} LOAD_swissprot_blastp {input.blastp} ; '
        'Trinotate {output} LOAD_pfam {input.hmmer} ; '
        'Trinotate {output} LOAD_tmhmm {input.tmhmm} ; '
        'Trinotate {output} LOAD_signalp {input.signalp} ; '
        'Trinotate {output} LOAD_rnammer {input.rnammer}'
        
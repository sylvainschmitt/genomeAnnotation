configfile: "config/config.yml"

rule all:
    input:
        "results/mutations.tsv",
        "results/multiqc_report.html",
        "results/report.html"

# Rules #

## Reference ##
include: "rules/cp_reference.smk"
include: "rules/bwa_index.smk"
include: "rules/samtools_faidx.smk"

## Reads ##
include: "rules/trimmomatic.smk"
include: "rules/fastqc.smk"

## Alignments ##
# include: "rules/bwa_mem.smk"
include: "rules/samtools_view.smk"
include: "rules/samtools_sort.smk"
include: "rules/samtools_index.smk"
include: "rules/gatk_markduplicates.smk"
include: "rules/samtools_view_md.smk"
include: "rules/samtools_index_md.smk"
include: "rules/samtools_stats.smk"
include: "rules/mosdepth_regions.smk"
include: "rules/circos_cov.smk"

## Mutations ##
include: "rules/strelka2.smk"
include: "rules/strelka2tsv.smk"
include: "rules/strelka2sql.smk"
include: "rules/filter_mutations.smk"

## Cross validation ##
include: "rules/mutations2bed.smk"
include: "rules/bedtools_getfasta.smk"
include: "rules/blat.smk"
include: "rules/psl2pos.smk"
include: "rules/cross_validate.smk"

## Annotations ##
include: "rules/te.smk"
include: "rules/genes.smk"
include: "rules/spectra.smk"
include: "rules/join_all.smk"

## Reports ##
include: "rules/multiqc.smk"
include: "rules/report.smk"

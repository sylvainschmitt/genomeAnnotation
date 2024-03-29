#!/usr/bin/env Rscript
# from https://github.com/sarahinwood/trinotate-pipeline/blob/master/trinotate_pipeline/src/rename_gff.R

log_file <- file(snakemake@log[[1]], open = "wt")
sink(log_file, append = TRUE, type = "message")
sink(log_file, append = TRUE)

library(data.table)
library(rtracklayer)

# snakemake files
signalp_gff <- snakemake@input[["signalp_gff"]]
ids <- snakemake@input[["ids"]]
signalp_renamed_gff <- snakemake@output[["signalp_renamed_gff"]]

# read id csv
pepids <- fread(ids)
setkey(pepids, "pepid")

# import the original signalp gff and convert to data.table
sp_gff <- import.gff2(signalp_gff)
sp_dt <- data.table(data.frame(sp_gff))

# rename using id csv
merged_results <- merge(sp_dt,
                        pepids,
                        by.x = "seqnames",
                        by.y = "pepid",
                        all.x = TRUE)
merged_results[, seqnames := NULL]

# convert to gff-like format
setnames(merged_results, "id", "seqname")
colorder <- c("seqname", "source", "type", "start", "end", "score")
output_dt <- merged_results[,colorder, with=FALSE]
output_dt[,strand:="."]
output_dt[,phase:="."]
output_dt[,signal:="YES"]

# write output
fwrite(x=output_dt, file = signalp_renamed_gff, sep = "\t", col.names = FALSE)

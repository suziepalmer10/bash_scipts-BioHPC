import os
import snakemake.io
import glob

wd_path = "/archive/PCDC/PCDC_Core/shared/koh.data.20220610/batch1/F22FTSUSAT0053_MOUjmsaM/soapnuke/clean/"

dirs, files, = glob_wildcards(wd_path + "{dir}/{file}_1.fq.gz")

rule all:
    input: expand(wd_path + "{dir}/{file}.tsv", zip, dir=dirs, file=files)

rule metaphlan4:
    input:
        R1= wd_path + "{dir}/{file}_1.fq.gz",
        R2= wd_path + "{dir}/{file}_2.fq.gz"
    output:
        "{file}.tsv"
    threads: 8
    conda:
        "/work/PCDC/s180020/mpa.yml"
    shell:
        """
        metaphlan {input.R1},{input.R2} --input_type fastq --bowtie2out {wildcards.file}_bowtie2out.bz2 -o {output}
        """

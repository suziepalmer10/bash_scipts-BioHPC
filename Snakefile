import os

wd_path = "/work/PCDC/s180020/Candida_data/"

SAMPLES = [i.replace('_1.fq.gz','') for i in os.listdir(wd_path) if i.endswith('_1.fq.gz')]

rule all:
    input:
        expand("metaphlan4/{sample}.tsv", sample = SAMPLES)


rule metaphlan4:
    input:
        R1= wd_path + "{sample}_1.fq.gz",
        R2= wd_path + "{sample}_2.fq.gz"
    output:
        "metaphlan4/{sample}.tsv"
    threads: 8
    conda: "/work/PCDC/s180020/mpa.yml"
    shell:
        """
        mkdir -p metaphlan4
        metaphlan {input.R1},{input.R2} --input_type fastq --bowtie2out metaphlan4/{wildcards.sample}_bowtie2out.bz2 -o metaphlan4/{wildcards.sample}.tsv
        """

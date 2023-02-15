rule metaphlan4:
    input:
        R1="{sample}/{sample}_1.fq.gz",
        R2="{sample}/{sample}_2.fq.gz"
    output:
        "metaphlan4/{sample}.tsv"
    threads: 8
    conda: "biobakery.yaml"
    shell:
        """
        mkdir -p metaphlan4
        metaphlan {input.R1},{input.R2} --input_type fastq --bowtie2out metaphlan4/{wildcards.sample}_bowtie2out.bz2 -o metaphlan4/{wildcards.sample}.tsv

STRAINS, = glob_wildcards("data/{sample}.fastq")

rule all:
    input:
        expand("results/{sample}/plannotate.done", sample=STRAINS),
        expand("results/{sample}/reference.aln", sample=STRAINS)

rule filter:
    input:
        nanopore="data/{sample}.fastq",
    output:
        "results/{sample}.filt.fastq"
    params:
        max=5000
    shell:
        """
        filtlong -t 500000 {input.nanopore} > {output}
        """

rule medaka_polish:
    input:
        nanopore="results/{sample}.filt.fastq",
        reference="data/reference.fasta"
    output:
        "results/{sample}/consensus.fasta"
    params:
        model="r941_min_sup_g507",
        outdir="results/{sample}"
    shell:
        """
        medaka_consensus -m {params.model} -d {input.reference} -i {input.nanopore} -o {params.outdir}
        """

rule rename_fasta:
    input: "results/{sample}/consensus.fasta"
    output: touch("results/{sample}/rename.done")
    params:
        fasta="results/{sample}/consensus.fasta",
        name="{sample}"
    shell: "sed -i 's/reference/{params.name}/' {params.fasta}"

rule align:
    input:
        corrected="results/{sample}/consensus.fasta",
        reference="data/reference.fasta",
        rename="results/{sample}/rename.done"
    output:
        "results/{sample}/reference.aln"
    params:
        model="r941_min_sup_g507",
        outdir="results/{sample}"
    shell:
        """
        cat {input.reference} > tmp.fas
        echo -e "\n" >> tmp.fas
        cat {input.corrected} >> tmp.fas
        mafft tmp.fas > {output}
        """

rule annotate:
    input:
        fasta="results/{sample}/consensus.fasta"
    output:
        touch("results/{sample}/plannotate.done")
    params:
        outdir="results/{sample}"
    shell:
        """
        plannotate batch -i {input} --html --output {params.outdir} --file_name pLasmid
        """

rule clean:
    input:
        fasta="results/{sample}/consensus.fasta"
    output:
        touch("results/{sample}/clean.done")
    params:
        outdir="data/{sample}"
    shell:
        """
        rm data/*mmi
        rm data/*fai
        """

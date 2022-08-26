# clone-correct
Corrects plasmid sequences for unconfirmed clones using nanopore sequence and annotates

(1) install `conda`, see here https://docs.conda.io/en/latest/miniconda.html

(2) install mamba:
```
conda install -c conda-forge mamba
```

(3) install `snakemake`:
```
mamba install -c bioconda snakemake
```

(4) install `medaka`
```
mamba install -c bioconda medaka
```

(5) install mafft:
```
mamba install -c bioconda mafft
```

(6) install plannotate:
```
mamba install -c bioconda plannotate
```

(7) First invoke dry-run of snakemake and then invoke snakemake with reports:
```
snakemake -np
```
```
snakemake --report report.html -p -j 2
```

# clone-correct
Corrects plasmid sequences for unconfirmed clones using nanopore sequence and annotates

First clone the repo, amke sure you're in a sensible directory:
git clone https://github.com/osilander/clone-correct.git

Open the data directory and replace the fastq file with fastq file(s) of your own. These need to be named with the suffix `.fastq`; the prefix will be used to name the result folders. Replace the reference `.fasta` file with the reference file that you wish to correct. This sequence can have any name, and is used to create an alignment of the new corrected (polished) sequence.

The output of this should be an annotated `.gbk` file with the sequence and annotations of the corrected clone and an interactive `.html` file containing a plasmid map.

(1) install `conda`, see here https://docs.conda.io/en/latest/miniconda.html

(2) install mamba:
```
conda install -c conda-forge mamba
```

(3) install `snakemake`:
```
mamba install -c bioconda snakemake
```
(4) Create a new environment for the analysis:
```
conda create -n medaka
conda activate medaka
```

(5) install `medaka`
```
mamba install -c bioconda medaka
```

(6) install mafft:
```
mamba install -c bioconda mafft
```

(7) install plannotate:
```
mamba install -c bioconda plannotate
```

(8) First invoke dry-run of snakemake and then invoke snakemake with reports:
```
snakemake -np
```
```
# two threads (-j 2)
snakemake -p -j 2
```
```
snakemake --report report.html
```

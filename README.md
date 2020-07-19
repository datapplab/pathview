
# pathview R package

[![](https://img.shields.io/badge/release%20version-1.28.1-blue.svg)](https://www.bioconductor.org/packages/pathview)
[![](https://img.shields.io/badge/devel%20version-1.29.1-green.svg)](https://github.com/datapplab/pathview)
[![](https://img.shields.io/badge/BioC%20since-2013-blue.svg)](https://www.bioconductor.org/packages/pathview)
[![](https://img.shields.io/badge/GitHub%20since-2020-green.svg)](https://github.com/datapplab/pathview)

## Overview

Pathview is a leading tool for pathway based data integration and visualization. It maps, integrates and renders a wide variety of biological data on relevant pathway graphs. Pathview has 3 important features: 
* Interpretable graphs with publication quality: KEGG view for easy interpretation and Graphviz view for better graphical control. 
* Strong data integration capacity. It works with: 1) all data mappable to pathways, 2) 30 of molecular ID types (genes/protein, compound/metabolite), 3) 5000+ species, 4) various data attributes and formats. 
* Simple and powerful: fully automated and error-resistant, seamlessly integrates with a wide range of pathway and gene set (enrichment) analysis tools.


## Citation

Please cite the Pathview paper when using this open-source  package. This will help the project and our team:

Luo W, Brouwer C. Pathview: an R/Biocondutor package for pathway-based data integration and visualization. Bioinformatics, 2013, 29(14):1830-1831, <a href=https://doi.org/10.1093/bioinformatics/btt285>doi: 10.1093/bioinformatics/btt285</a>

## Installation

``` r
# install from BioConductor (within R)
if(!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("pathview")

# Or the development version from GitHub:
# install.packages("devtools")
devtools::install_github("datapplab/pathview")
```

## Quick start with demo data (R code)

``` r
library(pathview)
data(gse16873.d)
pv.out <- pathview(gene.data = gse16873.d[, 1], pathway.id = "04110",
species = "hsa", out.suffix = "gse16873")
```

## More information

Please check the <a href=https://bioconductor.org/packages/pathview/>BioC page</a> for tutorials and extra documentations. 

Also see the <a href=https://pathview.uncc.edu/>Pathview Web server</a> for interactive GUI with example graphics.

Thank you for your interest.


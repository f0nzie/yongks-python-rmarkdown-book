--- 
title: "Python Bookdown"
author: "Yong Keh Soon"
date: "2020-10-30"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
url: 'https\://github.com/f0nzie/yongks-python-rmarkdown-book'
github-repo: f0nzie/yongks-python-rmarkdown-book
description: "This is a python cookbook, written using RMarkdown Notebook. It is made possible by using reticulate R library as the bridge between R and Python."
---

# Introduction {-}




## Main sections of the book {-}

* Fundamentals
* numpy
* pandas
* Visualization
* sklearn
* Natural Language Processing
* Web scrapping
* Finance




## Python environment {-}
You may need to create a Python environment that covers all packages and dependencies for building this book. Once you have Anaconda3 installed in your computer, creating the Python environment is very easy. Go to your tterminal and run:

```
conda create env -f environment.yml
```

Anaconda will read the file listing the core dependencies, and install them following the package version specified. This is what is inside `environment.yml`:

```
name: python_book
channels:
  - anaconda
  - conda-forge
  - defaults
dependencies:
  - python=3.7
  - beautifulsoup4=4.9.3
  - matplotlib=3.3.1
  - nltk=3.5
  - numpy=1.19.1
  - pandas=1.1.3
  - pandas-datareader=0.9.0
  - pip=20.2.4
  - requests=2.24.0
  - scikit-learn=0.23.2
  - seaborn=0.11.0
  - urllib3=1.25.11
  - pip:
    - cufflinks
    - h5py==2.10.0
    - nlpia==0.5.2
    - plotnine==0.7
    - plydata==0.4.2
    - yfinance==0.1.55
prefix: /home/msfz751/anaconda3/envs/python_book
```



## Automating the builds with a `Makefile` {-}


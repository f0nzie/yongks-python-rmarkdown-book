---
title: "Python Bookdown"
author: "Yong Keh Soon"
date: "2020-12-27"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
colorlinks: yes
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
url: 'https\://github.com/f0nzie/yongks-python-rmarkdown-book'
github-repo: f0nzie/yongks-python-rmarkdown-book
description: "This is a python cookbook, written using RMarkdown Notebook. It is made possible by using reticulate R library as the bridge between R and Python."
---



# Introduction {-}

*Following text added by Alfonso R. Reyes*

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

```bash
conda env create -f environment.yml
```

Anaconda will read the file listing the core dependencies, and install them following the package version specified. This is what is inside `environment.yml`:

```python
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


### Rules for building the book {-}
Here are couple of rules from the `Makefile`:

```makefile
# knit the book and then open it in the browser
.PHONY: gitbook1 gitbook2
gitbook1: build_book1 open_book

gitbook2: build_book2 open_book

# use rstudio pandoc
# this rule sets the PANDOC environment variable from the shell
build_book1:
	export RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc";\
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'

# use rstudio pandoc
# this rule sets the environment variable from R using multilines
build_book2:
	Rscript -e "\
	Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio/bin/pandoc');\
	bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
```

## Clean up the bookdown project folder {-}
With these two rules I occasionally tidy up and clean up from intermediate files the bookdown project folder:

```makefile
.PHONY: clean
clean: tidy
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.tex -not -name 'preamble.tex' -delete
		$(RM) -rf $(BOOKDOWN_FILES_DIRS)
		$(RM) -rf $(DEFAULT_PUBLISH_BOOK_DIRS)
		if [ -d ${PUBLISH_BOOK_DIR} ]; then rm -rf ${PUBLISH_BOOK_DIR};fi
		if [ -d ${CHECKPOINTS} ]; then rm -rf ${CHECKPOINTS};fi


# delete unwanted files and folders in bookdown folder
.PHONY: tidy
tidy:
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.md -not -name 'README.md' -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*-book.html -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.png -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.log -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.rds -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.ckpt -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.nb.html -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name _main.Rmd -delete
		find $(OUTPUT_DIR) -maxdepth 1 -name now.json -delete		
```

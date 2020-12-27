# BUILD

[toc]

## Introduction

### What is so special about this book?

1. A Python tutorial written in Rmarkdown

1. Uses GNU Python `virtualenv` and `conda`

1. Each `RMD` file calls `R/init_python ` to build the book chapters from a Python environment with 

    ```
    source("R/init_python.R")
    ```

1. It calls `before-each-chapter.R`

1. Python environment can be created with Conda or `virtualenv`. Rules in Makefile.

1. Conda environment can be created with `Anaconda3` or `Miniconda3`


1. Book can be rendered from the command line with Makefile

1. Book will open with Firefox after rendering. Makefile

1. Book can be built with new bookdown `bs4_book` format

1. Book can also be built as PDF from Makefile

1. Latex files (`after_body.tex`, `before_body.tex`, and `preamble.tex`) to build the PDF.

1. Output includes block to build with new format `bs4_book`

    ```
    bookdown::bs4_book:
      config:
          fontsettings:
          theme: Sepia
          family: sans
          size: 2
      theme:
        highlight: tango
        # primary: "#982a31"
        primary: "#3c99ca"
        fg: "#2b2121"
        bg: "#ffffff"
      repo: https://github.com//f0nzie/yongks-python-rmarkdown-book
    ```

1. Includes data files under `./data` and images under `img`

1. Output to `public` folder

1. **Makefile** rule to push `git` repository and subtree to `gh-pages`



## Building the book

### As gitbook

```
make git_book
```

### As bs4_book

```
make bs4_book
```



### As PDF

```
make pdf
```



## Makefile

### Environment rules

*   `conda_create`: 

*   `conda_remove`

*   `conda_activate`

*   `conda_deactivate`:

*   `which_conda_env`: tells us if we are in a `conda` environment or under the `base` environment

*   `info`: shows information about the environment

    



### `conda_info`

```
.PHONY: info
info:
	@echo "OS is:" $(OSFLAG)
	@echo "Bookdown publication folder:" $(PUBLISH_BOOK_DIR)
	@echo "Has Conda?:" ${HAS_CONDA}
	@echo "Conda Base  Dir:" ${CONDA_BASE_DIR}
	@echo "Environment Dir:" ${MY_ENV_DIR}
	@echo "Conda environment:" ${CONDA_ENV_NAME}
	@echo "Does Environment *${CONDA_ENV_NAME}* exist?" ${HAS_ENVIRONMENT}
	@echo "Active Conda environment:" ${CONDA_DEFAULT_ENV}
```



## Repository

### GitHub `oilgains`

*   ssh: `git@github-oilgains:f0nzie/yongks-python-rmarkdown-book.git`









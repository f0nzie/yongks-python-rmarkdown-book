# Makefile written by Alfonso R. Reyes
SHELL := /bin/bash
CONDA_ENV_NAME = python_book
BOOKDOWN_FILES_DIRS = python_bookdown_files _bookdown_files
OUTPUT_DIR = .
PUBLISH_BOOK_DIR = public
DEFAULT_PUBLISH_BOOK_DIRS = _book docs ${PUBLISH_BOOK_DIR}
PYTHON_ENV_DIR = 
START_NOTEBOOK = 
LIBRARY = 
FIGURE_DIR = 
CHECKPOINTS = .ipynb_checkpoints
# Detect operating system. Sort of tricky for Windows because of MSYS, cygwin, MGWIN
OSFLAG :=
ifeq ($(OS), Windows_NT)
    OSFLAG = WINDOWS
else
    UNAME_S := $(shell uname -s)
    ifeq ($(UNAME_S), Linux)
        OSFLAG = LINUX
    endif
    ifeq ($(UNAME_S), Darwin)
        OSFLAG = OSX
    endif
endif
# conda exists?
ifeq (,$(shell which conda))
    HAS_CONDA=False
else
    HAS_CONDA=True
    ENV_DIR=$(shell conda info --base)
    MY_ENV_DIR=$(ENV_DIR)/envs/$(CONDA_ENV_NAME)
    CONDA_ACTIVATE=source $$(conda info --base)/etc/profile.d/conda.sh ; conda activate ; conda activate
endif
# conda environment exists?
ifeq (True,$(HAS_CONDA))
ifneq ("$(wildcard $(MY_ENV_DIR))","")
	HAS_ENVIRONMENT=True	
else
	HAS_ENVIRONMENT=False
endif
endif


.PHONY: pyenv
pyenv:
	if [ -d ${PYTHON_ENV_DIR} ]; then rm -rf ${PYTHON_ENV_DIR};fi ;\
	~/anaconda3/bin/conda config --set auto_activate_base false ;\
	python --version ;\
	# sudo apt-get install -y python3-venv ;\
	/usr/bin/python3 -m virtualenv pyenv --python=python3.7 ;\
	source pyenv/bin/activate ;\
	python -V ;\
	pip install -U pip ;\
	pip install -Ur requirements.txt ;\
	jupyter-notebook ${START_NOTEBOOK}



# create a conda environment from specs file
# https://stackoverflow.com/a/60247404/5270873
conda_create_old:
ifeq (True,$(HAS_CONDA))
ifneq ("$(wildcard $(MY_ENV_DIR))","") # check if the directory is there
	@echo ">>> Found $(CONDA_ENV_NAME) environment in $(MY_ENV_DIR). Skipping installation..."
else
	@echo ">>> Detected conda, but $(CONDA_ENV_NAME) is missing in $(ENV_DIR). Installing ..."
	conda env create -f environment.yml -n $(CONDA_ENV_NAME)
endif
else
	@echo ">>> Install conda first."
	exit
endif

conda_create:
ifeq (True,$(HAS_ENVIRONMENT))	
	@echo ">>> Found $(CONDA_ENV_NAME) environment in $(MY_ENV_DIR)"
	@echo "Skipping installation..."
else
	@echo ">> Detected conda, but *$(CONDA_ENV_NAME)* is missing in $(ENV_DIR)"
	@echo "Installing ...\n"
	source ${HOME}/${CONDA_TYPE}/etc/profile.d/conda.sh ;\
	conda env create -f environment.yml -n $(CONDA_ENV_NAME)
endif

# activate conda only if environment exists
conda_activate:
ifeq (True,$(HAS_CONDA))
ifneq ("$(wildcard $(MY_ENV_DIR))","") 
	conda activate $(CONDA_ENV_NAME)
else
	@echo ">>> Detected conda, but $(CONDA_ENV_NAME) is missing in $(ENV_DIR). Install conda first ..."
endif
else
	@echo ">>> Install conda first."
	exit
endif

conda_deactivate:
	source ${HOME}/${CONDA_TYPE}/etc/profile.d/conda.sh ;\
	conda deactivate

which_conda_env:
	@echo ${CONDA_DEFAULT_ENV} at ${CONDA_PREFIX}



# knit the book and then open it in the browser
.PHONY: gitbook1 gitbook2
gitbook1: build_book1 open_book

gitbook2: build_book2 open_book

# use rstudio pandoc
# this rule sets the PANDOC environment variable from the shell
build_book1:
	export RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc";\
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::gitbook")'

# render book using bootstrap
bs4book_render:
	export RSTUDIO_PANDOC="/usr/lib/rstudio/bin/pandoc";\
	Rscript -e 'bookdown::render_book("index.Rmd", "bookdown::bs4_book")'


# use rstudio pandoc
# this rule sets the environment variable from R using multilines
build_book2:
	Rscript -e "\
	Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio/bin/pandoc');\
	bookdown::render_book('index.Rmd', 'bookdown::gitbook')"
	
pdf:
	Rscript -e "\
	Sys.setenv(RSTUDIO_PANDOC='/usr/lib/rstudio/bin/pandoc');\
	bookdown::render_book('index.Rmd', 'bookdown::pdf_book')"	

open_book:
ifeq ($(OSFLAG), OSX)
    @open -a firefox  $(PUBLISH_BOOK_DIR)/index.html
endif
ifeq ($(OSFLAG), LINUX)
	@firefox  $(PUBLISH_BOOK_DIR)/index.html
endif
ifeq ($(OSFLAG), WINDOWS)
	@"C:\Program Files\Mozilla Firefox\firefox" $(PUBLISH_BOOK_DIR)/index.html
endif


bs4_book: conda_activate bs4book_render open_book conda_deactivate

git_book: conda_activate gitbook_render open_book conda_deactivate


.PHONY: push
push:
	git push
	git subtree push --prefix public origin gh-pages


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
		

# provide some essential info about the tikz files
.PHONY: info
info:
	@echo "OS is:" $(OSFLAG)
	@echo "Publication folder:" $(PUBLISH_BOOK_DIR)
	@echo "Has Conda?:" ${HAS_CONDA}
	@echo ${ENV_DIR}
	@echo ${MY_ENV_DIR}
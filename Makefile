# Makefile written by Alfonso R. Reyes
SHELL := /bin/bash
BOOKDOWN_FILES_DIRS = plotnine_files _bookdown_files
OUTPUT_DIR = .
PUBLISH_BOOK_DIR = public
DEFAULT_PUBLISH_BOOK_DIRS = _book docs ${PUBLISH_BOOK_DIR}
PYTHON_ENV_DIR = pyenv
START_NOTEBOOK = 
FIGURE_DIR = figure
LIBRARY = renv/library
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


renv/library: renv.lock
	Rscript --vanilla -e 'if (!requireNamespace("renv")) install.packages("renv"); renv::restore()'
	touch $@

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



.PHONY: clean
clean: tidy
		find $(OUTPUT_DIR) -maxdepth 1 -name \*.tex -delete
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
		

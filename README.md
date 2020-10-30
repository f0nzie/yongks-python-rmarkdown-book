


## Build the book
### R installation
I built this book with `R-3.6.3` in a **Debian-10** Linux operating system.

### Anaconda
The Anaconda version I used was the July version of 2020.

### Build the gitbook
From a terminal, run:

    make gitbook1

or 

    make gitbook2


Both do the same thing: building the Rmarkdown book. I left the two options available for the reader to get familiar with `Makefile` and how to set environment variables from the shell, or set it from within R.

If the book builds successfully, it should open your browser with the main page of the book. This is all handled by `make` and the commands in `Makefile`.


## Optional after building the book
If you make changes to the Rmarkdown documents, you may want to tidy up or totally clean from auxiliary and files that were generated during the knitting process. The are two rules in the `Makefile`: `tidy` and `clean `.

### Tidy up the folder
This deletes the auxiliary files that were created during the book building process.

    make tidy

### Clean up the folder
Does `make tidy` plus deletes the publication folder, to start over fresh.

    make clean



## Original README
This is a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for how to compile this example into HTML. You may generate a copy of the book in `bookdown::pdf_book` format by calling `bookdown::render_book('index.Rmd', 'bookdown::pdf_book')`. More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.

You can find the preview of this example at https://bookdown.org/yihui/bookdown-demo/.


library(reticulate)

pick_env   <- "python_book"
conda_bin <- "/data/home-ext/miniconda3/bin/conda"    # older conda bin
conda_bin <- "~/anaconda3/bin/conda"
conda_bin_opt <- "/opt/conda/bin/conda"

conda <- ifelse(file.exists(conda_bin_opt), conda_bin_opt, conda_bin)

use_condaenv(pick_env, conda = conda, required = TRUE)


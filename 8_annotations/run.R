library(here)
library(plumber)

base_dir <- here::here("8_annotations")
root <- pr(file.path(base_dir, "plumber.R"))
root

root %>%
  pr_run(port = httpuv::randomPort(min = 4000, max = 7000, n = 100))

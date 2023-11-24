library(here)
library(plumber)

base_dir <- here::here("1_quickstart")
root <- pr(file.path(base_dir, "plumber.R"))
root

root %>% pr_run()

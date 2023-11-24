library(here)
library(plumber)

base_dir <- here::here("2_routing_input")
root <- pr(file.path(base_dir, "plumber.R"))
root

root %>% pr_run()

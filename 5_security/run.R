library(here)
library(plumber)

base_dir <- here::here("3_rendering_output")
root <- pr(file.path(base_dir, "plumber.R"))
root

root %>%
  pr_hook("exit", function(){
    print("Bye bye!")
  }) %>%
  pr_run()
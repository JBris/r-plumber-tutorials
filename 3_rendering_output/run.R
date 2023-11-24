library(here)
library(plumber)

base_dir <- here::here("3_rendering_output")
root <- pr(file.path(base_dir, "plumber.R"))
root

root %>%
  pr_get("/simple", function() stop("I'm an error!")) %>%
  pr_set_error(function(req, res, err){
    res$status <- 500
    list(error = "An error occurred. Please contact your administrator.")
  }) %>%
  pr_run()

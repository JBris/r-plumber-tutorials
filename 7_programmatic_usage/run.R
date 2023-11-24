library(here)
library(plumber)

users <- pr(here("7_programmatic_usage", "users.R"))

pr() %>%
  pr_hook("preroute", function(req) {
    cat("Routing a request for", req$PATH_INFO, "...\n")
  }) %>%
  pr_hooks(list(
    preserialize = function(req, value) {
      print("About to serialize this value:")
      print(value)

      # Must return the value since we took one in. Here we're not choosing
      # to mutate it, but we could.
      value
    },
    postserialize = function(res) {
      print("We serialized the value as:")
      print(res$body)
    }
  )) %>%
  pr_filter("myFilter", function(req){
    req$filtered <- TRUE
    forward()
  }) %>%
  pr_get("/html", function(req, res){
    "<html><h1>Programmatic Plumber!</h1></html>"
  }, serializer = plumber::serializer_html()) %>%
  pr_get("/filter", function(req){
    paste("Am I filtered?", req$filtered)
  }) %>%
  pr_post("/submit", function(req, res){
    "bye"
  }) %>%
  pr_mount("/users", users) %>%
  pr_run()


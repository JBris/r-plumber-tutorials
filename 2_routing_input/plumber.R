#* Return "hello world"
#* @get /hello
function(){
  "hello world"
}

#* Log some information about the incoming request
#* @filter logger
function(req){
  cat(as.character(Sys.time()), "-",
      req$REQUEST_METHOD, req$PATH_INFO, "-",
      req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}

#* @filter setuser
function(req){
  un <- req$cookies$user
  # Make req$username available to endpoints
  req$username <- un
  
  plumber::forward()
}

#* @filter checkAuth
function(req, res){
  if (is.null(req$username)){
    plumber::forward()
    # res$status <- 401 # Unauthorized
    # return(list(error="Authentication required"))
  } else {
    plumber::forward()
  }
}

users <- data.frame(
  uid=c(12,13),
  username=c("kim", "john")
)

#* Lookup a user
#* @get /users/<id>
function(id){
  user <- subset(users, uid %in% id)
  user
}

#* @get /type/<id>
function(id){
  list(
    id = id,
    type = typeof(id)
  )
}

#* @get /next/<id:int>
function(id){
  next_val <- id + 1
  next_val
}

#* @get /
search <- function(q="", pretty=0){
  paste0("The q parameter is '", q, "'. ",
         "The pretty parameter is '", pretty, "'.")
}

#* @post /user
function(req, id, name) {
  list(
    id = id,
    name = name,
    body = req$body,
    raw = req$bodyRaw
  )
}

#* Return the value of a custom header
#* @get /header
function(req){
  list(
    val = req$HTTP_CUSTOMHEADER
  )
}
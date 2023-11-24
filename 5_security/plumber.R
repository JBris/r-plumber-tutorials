#* This is an example of an UNSAFE endpoint which
#* is vulnerable to a DOS attack.
#* @get /unsafe-img
#* @serializer png
function(pts=10) {
  # An example of an UNSAFE endpoint.
  plot(1:pts)
}

#* This is an example of an safe endpoint which
#* checks user input to avoid a DOS attack
#* @get /safe-img
#* @serializer png
function(pts=10) {
  if (pts > 1000 & pts > 0){
    stop("pts must be between 1 and 1,000")
  }
  
  plot(1:pts)
}

#* This is an example of an UNSAFE endpoint which
#* does not sanitize user input
#* @get /unsafe-file
function(file) {
  
  # An example of an UNSAFE endpoint.
  path <- file.path("./datasets", file)
  readLines(path)
}

#* This is an example of an endpoint which
#* checks user input.
#* @get /safe-file
function(file) {
  # Strip all "non-word" characters from user input
  sanitizedFile <- gsub("\\W", "", file)
  
  path <- file.path("./datasets", sanitizedFile)
  readLines(path)
}

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

#* @preempt cors
#* @get /sub
cors_disabled <- function(a, b){
  as.numeric(a) - as.numeric(b)
}
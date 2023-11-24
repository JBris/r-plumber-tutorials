#* Get letters after a given letter
#* @get /boxed
function(letter="A"){
  LETTERS[LETTERS > letter]
}

#* Get letters after a given letter
#* @serializer unboxedJSON
#* @get /unboxed
function(letter="A"){
  LETTERS[LETTERS > letter]
}

#* Example of customizing graphical output
#* @serializer png list(width = 400, height = 500)
#* @get /
function(){
  plot(1:10)
}

#* Endpoint that bypasses serialization
#* @get /bypass-serialization
function(res){
  res$body <- "Literal text here!"
  
  res
}

#* @serializer contentType list(type="application/pdf")
#* @get /pdf
function(){
  tmp <- tempfile()
  pdf(tmp)
  plot(1:10, type="b")
  text(4, 8, "PDF from plumber!")
  text(6, 2, paste("The time is", Sys.time()))
  dev.off()
  
  readBin(tmp, "raw", n=file.info(tmp)$size)
}

#* Example of throwing an error
#* @get /simple
function(){
  stop("I'm an error!")
}

#* Generate a friendly error
#* @get /friendly
function(res){
  msg <- "Your request did not include a required parameter."
  res$status <- 400 # Bad request
  list(error=jsonlite::unbox(msg))
}

#* @put /preferences
function(res, capital){
  if (missing(capital)){
    stop("You must specify a value for the 'capital' preference.")
  }
  res$setCookie("capitalize", capital)
}

#* @get /letter
function(req) {
  capitalize <- req$cookies$capitalize
  
  # Default to lower-case unless user preference is capitalized
  alphabet <- letters
  
  # The capitalize cookie will initially be empty (NULL)
  if (!is.null(capitalize) && capitalize == "1"){
    alphabet <- LETTERS
  }
  
  list(
    letter = sample(alphabet, 1)
  )
}

#* @get /sessionCounter
function(req){
  count <- 0
  if (!is.null(req$session$counter)){
    count <- as.numeric(req$session$counter)
  }
  req$session$counter <- count + 1
  return(paste0("This is visit #", count))
}
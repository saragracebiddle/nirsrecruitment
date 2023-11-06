#' Wrap a call to a shiny function with a namespace and call the argument
#'
#' @param groupid id for the namespace
#' @param inputid id for the input
#' @param call function call
#' @param args list of other arguments
#'
#' @return shiny function
#' @export
wrap_input <- function(groupid, inputid, call, args){
  do.call(call, NS(groupid, inputid), args)
}

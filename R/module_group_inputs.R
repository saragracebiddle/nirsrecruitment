#' Create a group of inputs
#'
#' @param id namespace id
#' @param inputs tribble
#'
#' @return tagList
#' @export
groupInputs <- function(id, inputs){

  wrapped <- purrr::pmap(inputs, wrap_input, groupid = id)

  # wrap all the inputs in tagList and return
  do.call("tagList", wrapped)
}

#' Server Logic for a Group of Inputs
#'
#' @details
#' input an R6 object that has field names that match the
#' names of the inputs. When the trigger is triggered,
#' inputs will be saved by setting the matching R6 fields to the
#' input values.
#'
#'
#' @param id namespace id
#' @param names names of input values in the group, should match
#' the names of `inputs` to `groupInputs` in order to capture
#' all input values, otherwise something will be missed
#'
#' @return list of values
#' @export
groupInputsServer <- function(id, names){
  moduleServer(id, function(input, output, session){
    reactive({
      vals = lapply(names, function(n) input[[n]])
      names(vals) <- names

      vals
    })
  })
}

#' Select a Patient Module Input
#'
#' @param inputId namespace id
#'
#' @return none
#' @export
selectPatient <- function(inputId){
    selectInput(inputId, label = "Patient",
              choices = NULL)
}

#' Select a Patient Module Server Logic
#'
#' @param id namespace id
#'
#' @return none
#' @export
selectPatientServer <- function(id){
  moduleServer(id, function(input, output, session){

    ##TODO observers for when to update the select list for choices




  })
}

#' Select Person UI
#'
#' @param id namespaceid
#' @param label label to display
#'
#' @return tagList
#' @export
selectPerson <- function(id, label){
  selectInput(id,
              label,
              choices = c("Sara Biddle" = "sb",
                            "Sydney Hackwell" = "sh",
                            "Katie Banenas" = "kb",
                            "Sara Watson" = "sw",
                            "Sebrina Madden" = "sm"))
}

#' Select Patient's Oncologist
#'
#' @param id namespaceid
#'
#' @return none
#' @export
selectOncologist <- function(id){
selectInput(id,
                "Oncologist",
                choices = c("Edenfield" = "edenfield",
                            "Elder" = "elder",
                            "Jorgensen" = "jorgensen",
                            "Puls" = "puls",
                            "Stephenson" = "stephenson"
                            ))

}

#' Select Patients Diagnosis
#'
#' @param id namespaceid
#'
#' @return tagList
#' @export
selectDiagnosis <- function(id){
    selectInput(id, "Diagnosis",
                choices = c("Breast Cancer" = "breast",
                            "Gynecological Cancer" = "gyn"))

}

#' Input Reasons Patient Ineligible for Participation
#'
#' @param id namespace id
#'
#' @return tagList
#' @export
ineligibleReasonInput <- function(id){
    selectizeInput(id,
                   "Reason",
                   choices = c("Chemotherapy within last 5 years" = "chemo",
                               "Treatment Plan other than Chemotherapy" = "txplan",
                               "Metastatic Disease" = "mets",
                               "Lab Values" = "labs",
                               "Advanced Cardiovascular Disease" = "acvd"),
                   multiple= T,
                   options = list(create = T))
}

#' Reason Patient Declined Participation
#'
#' @param id namespace id
#'
#' @return tagList
#' @export
declineReasonInput <- function(id){
    selectizeInput(id,
                   "Reason",
                   choices = c("Stress" = "stress",
                               "No Transportation" = "notrans",
                               "Commute Time" = "commute",
                               "Too Busy/Not Enough Time" = "busy"
                               ),
                   multiple = T,
                   options = list(create = T)
  )
}

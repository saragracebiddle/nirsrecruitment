#' Create button with ns id and label
#'
#' @param id namespace id
#' @param label label to show in shiny
#' @param icon optional parameter to pass an icon to the button
#'
#' @return actionButton
#' @export
showBtn <- function(id, label, icon = NULL){
  actionButton(NS(id, "show"), label, icon)
}

#' Create button with ns id and label
#'
#' @param id namespace id
#' @param label label to show in shiny
#'
#' @return actionButton
#' @export
hideBtn <- function(id, label){
  actionButton(NS(id, "hide"), label)
}

#' Wrap tab contents and its action button to hide panel
#'
#' @param id panel name
#' @param contents panel contents
#' @param hidebutton actionButton type hideBtn
#'
#' @return tabPanel
#' @export
wrapPanel <- function(id, contents, hidebutton){
  tabPanel(id,
           contents,
           fluidRow(
             column(width = 10),
             column(width = 2,
                    hidebutton)
           ))
}

#' Module UI for a hidden tabsetPanel that is shown and hidden dynamically
#'
#' @param id namespace id
#' @param panels named list of panels and their contents
#'
#' @return tagList of UI
#' @export
hiddentabPanelUI <- function(id, panels){
  n <- length(panels)

  wrapped <- vector("list", n + 1)
  wrapped[[1]] <- tabPanel("blankTab")

  for (i in seq_along(panels)){
    wrapped[[i+1]] <- wrapPanel(names(panels)[[i]],
                                panels[[i]],
                                hideBtn(NS(id,names(panels)[[i]]), "Close"))
  }

  wrapped$id <- NS(id, "hiddenPanel")
  wrapped$type <- "hidden"
  wrapped$selected <- "blankTab"

  do.call("tabsetPanel", wrapped)
}

#' Hidden TabPanel Server Logic
#'
#' @param id namespace id
#' @param panelnames character vector of names of panels
#'
#' @return none
#' @export
hiddentabPanelServer <- function(id, panelnames){
  moduleServer(id, function(input, output, session){
    hide <- function(panelname){
      observeEvent(input[[paste0(panelname, "-hide")]],{
        updateTabsetPanel(session, "hiddenPanel", selected = "blankTab")
      })
    }

    show <- function(panelname){
      observeEvent(input[[paste0(panelname, "-show")]], {
        substitute(
          updateTabsetPanel(session, "hiddenPanel", selected = sub),
          list(sub = panelname)
        )
      })
    }

    purrr::map(panelnames, function(pn) hide(pn))

    purrr::map(panelnames, function(pn) show(pn))
      })
}

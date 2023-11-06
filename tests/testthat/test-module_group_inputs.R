test_that("groupInputsServer works as expeced", {

  skip()

  Appointment <- R6::R6Class("Appointment")

  inputs <- list(
    "location" = list(call = "textInput",
                      args = list(label = "Location")),
    "type" = list(call = "textInput",
                  args = list(label = "Type"))
  )

  ui <- shiny::fluidPage(
    shiny::actionButton("btn", "Button"),
    shiny::textOutput("show"),
    groupInputs("appointmentgroup",
                inputs)
  )

  server <- function(input, output, session){


    A <- groupInputsServer("appointmentgroup",
                      c("location", "type"))

    text <- eventReactive(input$btn, {
      Reduce(paste, lapply(A(), as.character))
    })

    output$show <- renderText({
      text() })
  }

  app <- shinytest::ShinyDriver$new(
    shiny::shinyApp(ui, server)
  )

  app$setInputs(
    `appointmentgroup-location` = "Appointment Location",
    wait_ = FALSE, values_ = FALSE
  )
  app$setInputs(`appointmentgroup-type` = "Appointment Type",
                wait_ = FALSE, values_ = FALSE)

  app$click("btn")

  out <- app$getValue("show")

  expect_match(out, "Appointment Location Appointment Type")
})

test_that("groupInputs creates expected HTML", {

  inputs <- list(
    "patient_id" = list(call = "selectPatient",
                        args = list()),
    "location" = list(call = "textInput",
                      args = list(label = "Location")),
    "date" = list(call = "dateInput",
                  args = list(label = "Date")),
    "type" = list(call = "textInput",
                  args = list(label = "Type"))
  )

  expect_snapshot(groupInputs("test", inputs))
})

test_that("groupInputsServer gives expected values", {
  testServer(groupInputsServer, args = list(names = c("location", "type")),{
    session$setInputs(location = "L")
    session$setInputs(type = "T")

    vars = session$getReturned()

    expect_equal(vars(), list("location" = "L",
                              "type" = "T"))
  })
})

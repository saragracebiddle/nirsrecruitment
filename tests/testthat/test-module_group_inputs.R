test_that("groupInputsServer works as expeced", {

  skip()

})

test_that("groupInputs creates expected HTML", {

  inputs <- tibble::tribble(
    ~inputid,  ~call, ~args,
    "patient_id", "selectPatient", NA,
    "location", "textInput", list(label= "Location"),
    "date", "dateInput", list(label = "Date"),
    "type", "textInput", list(label = "Type")
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

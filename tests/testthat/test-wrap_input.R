test_that("wrap_input works", {

  expect_equal(
    wrap_input("test", "input", "textInput", list(label = "Label")),
    textInput(inputId = "test-input", label = "Label"))
})

test_that("wrap_input works with purrr::pmap", {

  I <- tibble::tribble(
    ~inputid, ~call, ~args,
    "text", "textInput", list(label = "Label"),
    "select", "selectInput", list(label = "Label",
                                  choices = c("A","B","C")),
    "date", "dateInput", list(label = "Label")
  )

  expect_equal(
    purrr::pmap(I, wrap_input, groupid = "test"),
    list(
      textInput("test-text", "Label"),
      selectInput("test-select", "Label", choices = c("A","B","C")),
      dateInput("test-date", "Label")
    )
  )

})

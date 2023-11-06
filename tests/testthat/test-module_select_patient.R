test_that("selectPatient() creates expected HTML", {
  expect_snapshot(selectPatient("id"))
})

test_that("selectPatient() has correct choices", {
  skip()
})

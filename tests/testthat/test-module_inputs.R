test_that("selectPerson() creates expected HTML", {
  expect_snapshot(selectPerson("id", "label"))
})

test_that("selectOncologist() creates expected HTML", {
  expect_snapshot(selectOncologist("id"))
})

test_that("selectDiagnosis() creates expected HTML",{
  expect_snapshot(selectDiagnosis("id"))
})

test_that("ineligibleReasonInput() creates expected HTML",
          {
            expect_snapshot(ineligibleReasonInput("id"))
          })

test_that("declineReasonInput() creates expected HTML",{
  expect_snapshot(declineReasonInput("id"))
})

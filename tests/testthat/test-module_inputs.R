test_that("selectPerson() creates expected HTML", {
  expect_snapshot(selectPerson("id", "label"))
})

test_that("selectPersonServer returns input", {
  testServer(selectPersonServer, {
    session$setInputs(person = "Sydney Hackwell")
    expect_equal(session$returned(), "Sydney Hackwell")
  })
})


test_that("selectOncologist() creates expected HTML", {
  expect_snapshot(selectOncologist("id"))
})

test_that("selectOncologistServer returns input", {
  testServer(selectOncologistServer, {
    session$setInputs(oncologist = "Puls")
    expect_equal(session$returned(), "Puls")
  })
})

test_that("selectDiagnosis() creates expected HTML",{
  expect_snapshot(selectDiagnosis("id"))
})

test_that("selectDiagnosisServer returns input", {
  testServer(selectDiagnosisServer, {
    session$setInputs(diagnosis = "Breast Cancer")
    expect_equal(session$returned(), "Breast Cancer")
  })
})

test_that("ineligibleReasonInput() creates expected HTML",
          {
            expect_snapshot(ineligibleReasonInput("id"))
          })

test_that("ineligibleReasonServer returns input", {
  testServer(ineligibleReasonServer, {
    session$setInputs(inelReason = "Metastatic Disease")
    expect_equal(session$returned(), "Metastatic Disease")

    session$setInputs(inelReason = c("Metastatic Disease", "Lab Values"))
    expect_equal(session$returned(), c("Metastatic Disease", "Lab Values"))

    session$setInputs(inelReason = c("Metastatic Disease", "Mental Health"))
    expect_equal(session$returned(), c("Metastatic Disease", "Mental Health"))
  })
})

test_that("declineReasonInput() creates expected HTML",{
  expect_snapshot(declineReasonInput("id"))
})

test_that("declineReasonServer returns input", {
  testServer(declineReasonServer, {
    session$setInputs(declineReason = "Stress")
    expect_equal(session$returned(), "Stress")

    session$setInputs(declineReason = c("Stress", "No Transportation"))
    expect_equal(session$returned(), c("Stress", "No Transportation"))

    session$setInputs(declineReason = c("Stress", "Mental Health"))
    expect_equal(session$returned(), c("Stress", "Mental Health"))
  })
}
)

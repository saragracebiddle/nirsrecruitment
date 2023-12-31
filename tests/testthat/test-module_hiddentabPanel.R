test_that("showBtn creates expect HTML", {
  expect_snapshot(showBtn("id", "Label"))
})

test_that("hideBtn creates expected HTML",{
  expect_snapshot(hideBtn("id", "Label"))
})

test_that("wrapPanel creates expected HTML", {
  expect_snapshot(wrapPanel("id", "contents", "btn"))

  expect_snapshot(wrapPanel("id", "contents", hideBtn("id", "Label")))

  expect_snapshot(wrapPanel("id", fluidPage(), hideBtn("id", "Label")))
})


test_that("hiddenTabPanelUI creates expected HTML", {

})

test_that("hiddentabPanelServer works as expected", {

  skip()

  ui <- shiny::fluidPage(
    fluidRow(
    showBtn(NS("test","panel1"), "Show 1"),
    showBtn(NS("test","panel2"), "Show 2")
    ),
    hiddentabPanelUI("test", list("panel1" = shiny::tagList("Panel 1"),
                                  "panel2" = shiny::tagList("Panel 2")))
  )

  server <- function(input, output, session){
    hiddentabPanelServer("test", c("panel1", "panel2"))
  }

  app <- shinytest::ShinyDriver$new(shiny::shinyApp(ui, server))
  expect_equal(app$getValue("test-hiddenPanel"), "blankTab")

  app$click("test-panel1-show")
  expect_equal(app$getValue("test-hiddenPanel"), "panel1")

  app$click("test-panel1-hide")
  expect_equal(app$getValue("test-hiddenPanel"), "blankTab")

  app$click("test-panel2-show")
  expect_equal(app$getValue("test-hiddenPanel"), "panel2")

  app$click("test-panel2-hide")
  expect_equal(app$getValue("test-hiddenPanel"), "blankTab")
})


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
  skip()
  expect_snapshot(
    hiddentabPanelUI("id", list("1" = tagList(),
                                "2" = tagList())
                                   )
    )
})

test_that("hiddentabPanelServer works as expected", {

  skip_on_cran()

  ui <- shiny::fluidPage(
    fluidRow(
    showBtn(NS("test","panel1"), "Show 1"),
    showBtn(NS("test","panel2"), "Show 2")
    ),
    hiddentabPanelUI("test", list("panel1" = shiny::tagList("Panel 1"),
                                  "panel2" = shiny::tagList("Panel 2")))
  )

  server <- function(input, output, session){
    hiddentabPanelServer("test", c("panel1", "panel2"),
                         c("panel1" = NA,"panel2" =  NA),
                         c("panel1" = NA,"panel2" =  NA))
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

test_that("hiddentabPanelUIServer works with triggers", {

  ui <- shiny::fluidPage(
    fluidRow(
      showBtn(NS("test","panel1"), "Show 1"),
      showBtn(NS("test","panel2"), "Show 2")
    ),
    hiddentabPanelUI("test", list("panel1" = shiny::tagList("Panel 1"),
                                  "panel2" = shiny::tagList("Panel 2")))
  )

  server <- function(input, output, session){

    gargoyle::init("hidepanel1", "hidepanel2,
                   showpanel1, showpanel2")

    hiddentabPanelServer("test",
                         c("panel1", "panel2"),
                         c("panel1" = "hidepanel1",
                           "panel2" = "hidepanel2"),
                         c("panel1" = "showpanel1",
                           "panel2" = "showpanel2")
                         )

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

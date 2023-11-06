## enter test data in database

  patient <- data.frame(
    "id" = c(1L,2L,3L),
    "firstname" = c("Jane","Jill","Mary"),
    "lastname" = c("Doe","Smith","Johnson"),
    "mrn" = c(123123123L, 321321321L, 987654321L),
    "id_date" = c(as.character(lubridate::ymd(20231019)),
                  as.character(lubridate::ymd(20231010)),
                  as.character(lubridate::ymd(20231001))
                  ),
    "id_by" = c("Sara Biddle","Sara Biddle","Sara Biddle"),
    "status" = c("pending", "ineligible","declined")
  )
  diagnosis <- data.frame(
    "patient_id" = c(1L, 2L, 3L),
    "dx" = c("Breast Cancer","Breast Cancer", "Gynecological Cancer"),
    "oncologist" = c("Parker","Fletcher","Wilson")
  )
  chemo <- data.frame(
    "patient_id" = c(1L, 3L),
    "chemo_date" = c(lubridate::ymd(20231031), lubridate::ymd(20231008))
  )
  appointment<- data.frame(
    "patient_id" = c(1L, 3L),
    "location" = c("Faris", "Faris"),
    "aptmt_date" = c(lubridate::ymd(20231026), lubridate::ymd(20231003)),
    "aptmt_type" = c("Chemo Teach","Chemo Teach"),
    "notes" = c(NA, NA),
    "time" = c(lubridate::hm("10:00", "12:30"))
  )
  ineligible <- data.frame(
    "patient_id" = c(2L),
    "reason" = c("Metastatic Disease")
  )
  contact <- data.frame(
    "patient_id" = c(3L),
    "contact_by" = c("Katie Banenas"),
    "method" = c("In Person"),
    "contact_date" = lubridate::ymd(20231003)
  )
  declined <- data.frame(
    "patient_id" = c(3L),
    "reason" = c("Stress")
  )

  conn <- DBI::dbConnect(RSQLite::SQLite(),
                         testthat::test_path("fixtures", "testdb.sqlite"))


  DBI::dbAppendTable(conn,
                     "patient",
                     patient)

  DBI::dbAppendTable(conn,
                     "diagnosis",
                     diagnosis)

  DBI::dbAppendTable(conn,
                     "chemo",
                     chemo)

  DBI::dbAppendTable(conn,
                     "appointment",
                     appointment)

  DBI::dbAppendTable(conn,
                     "ineligible",
                     ineligible)

  DBI::dbAppendTable(conn,
                     "contact",
                     contact)

  DBI::dbAppendTable(conn,
                     "declined",
                     declined)


  DBI::dbDisconnect(conn)


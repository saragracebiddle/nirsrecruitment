con <- DBI::dbConnect(RSQLite::SQLite(), "tests/testthat/fixtures/testdb.sqlite")

statements = c(
  "CREATE TABLE patient( id INTEGER PRIMARY KEY
, firstname TEXT
, lastname TEXT
, mrn INTEGER NOT NULL UNIQUE
, id_date TEXT CHECK (LIKE '____-__-__')
, id_by TEXT
, status TEXT DEFAULT 'pending'
);",
"CREATE TABLE diagnosis( patient_id FOREIGN KEY REFERENCES patient(id)
, dx TEXT
, oncologist TEXT
, PRIMARY KEY (patient_id)
);",
"CREATE TABLE chemo( patient_id FOREIGN KEY REFERENCES patient(id)
, chemo_date TEXT CHECK (LIKE '____-__-__')
, PRIMARY KEY (patient_id)
);",
"CREATE TABLE appointment( patient_id FOREIGN KEY REFERENCES patient(id)
, location TEXT
, aptmt_date TEXT CHECK (LIKE '____-__-__')
, aptmt_type TEXT
, notes TEXT
, time TEXT
, PRIMARY KEY (patient_id, aptmt_date)
);",
"CREATE TABLE ineligible( patient_id FOREIGN KEY REFERENCES patient(id)
, reason TEXT
, PRIMARY KEY (patient_id, reason)
);",
"CREATE TABLE contact( patient_id FOREIGN KEY REFERENCES patient(id)
, contact_by TEXT
, method TEXT
, contact_date TEXT CHECK (LIKE '____-__-__')
, PRIMARY KEY (patient_id, contact_date)
);",
"CREATE TABLE declined(
patient_id FOREIGN KEY REFERENCES patient(id)
, reason TEXT
, PRIMARY KEY (patient_id, reason)
);",
"CREATE TRIGGER ineligiblestatus
AFTER INSERT ON ineligible
BEGIN
    UPDATE patient SET status = 'ineligible' WHERE id = NEW.patient_id
END;",
"CREATE TRIGGER declinestatus
AFTER INSERT ON delined
BEGIN
    UPDATE patient SET status = 'declined' WHERE id = NEW.patient_id
END;",
"CREATE VIEW declinedinfo AS
SELECT patient.firstname
, patient.lastname
, patient.mrn
, declined.reason
FROM patient
RIGHT JOIN declined
ON patient.id = declined.patient_id;",
"CREATE VIEW ineligibleinfo AS
SELECT patient.firstname
, patient.lastname
, patient.mrn
, ineligible.reason
FROM patient
RIGHT JOIN ineligible
ON patient.id = ineligible.patient_id;",
"CREATE VIEW diagnosiscounts AS
SELECT count(dx)
FROM diagnosis
GROUP BY dx;",
"CREATE VIEW oncologistcounts AS
SELECT count(oncologist)
FROM diagnosis
GROUP BY oncologist;",
"CREATE VIEW upcomingappointments AS
SELECT patient.firstname
, patient.lastname
, patient.mrn
, appointment.location
, appointment.aptmt_date
, appointment.aptmt_type
, appointment.notes
, appointment.time
FROM patient
RIGHT JOIN appointment
ON patient.id = appointment.patient_id
WHERE patient.status = 'pending';",
"CREATE VIEW declinereasons AS
SELECT patient.firstname
, patient.lastname
, patient.mrn
, decline.reason
FROM patient
RIGHT JOIN declined
ON patient.id = declined.patient_id;",
"CREATE VIEW contactinfo AS
SELECT patient.firstname
, patient.lastname
, patient.id_date
, contact.contact_date
, contact.method
, contact.contact_by
, julianday(contact.contact_date) - julianday(patient.id_day) AS timetocontact
FROM patient
RIGHT JOIN contact
ON patient.id = contact.patient_id;"

)

lapply(statements, DBI::dbExecute, conn = con)

DBI::dbDisconnect(con)


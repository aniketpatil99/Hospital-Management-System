-- Count total number of patients
SELECT COUNT(*) AS TotalPatients FROM Patients;

-- Find the number of patients by gender
SELECT Gender, COUNT(*) AS Count FROM Patients GROUP BY Gender;

-- Find the oldest patient
SELECT FirstName, LastName, DateOfBirth FROM Patients ORDER BY DateOfBirth ASC LIMIT 1;

-- List patients with no medical history
SELECT PatientID, FirstName, LastName FROM Patients WHERE MedicalHistory = 'No significant history';

-- Count total number of doctors
SELECT COUNT(*) AS TotalDoctors FROM Doctors;

-- Find the number of doctors by specialization
SELECT Specialization, COUNT(*) AS Count FROM Doctors GROUP BY Specialization;

-- List doctors available in the morning
SELECT DoctorID, FirstName, LastName FROM Doctors WHERE Availability LIKE '%AM%';

-- Count total number of appointments
SELECT COUNT(*) AS TotalAppointments FROM Appointments;

-- Find the most common appointment purpose
SELECT Purpose, COUNT(*) AS Count FROM Appointments GROUP BY Purpose ORDER BY Count DESC LIMIT 1;

-- List all appointments for a specific patient (e.g., PatientID 1)
SELECT * FROM Appointments WHERE PatientID = 1;

-- Count total number of medical records
SELECT COUNT(*) AS TotalRecords FROM MedicalRecords;

-- Find the most common diagnosis
SELECT Diagnosis, COUNT(*) AS Count FROM MedicalRecords GROUP BY Diagnosis ORDER BY Count DESC LIMIT 1;

-- List all medical records for a specific patient (e.g., PatientID 1)
SELECT * FROM MedicalRecords WHERE PatientID = 1;

-- Find the number of appointments handled by each doctor
SELECT d.DoctorID, d.FirstName, d.LastName, COUNT(a.AppointmentID) AS AppointmentsHandled FROM Doctors d LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID GROUP BY d.DoctorID, d.FirstName, d.LastName;

-- Find patients with the most appointments
SELECT p.PatientID, p.FirstName, p.LastName, COUNT(a.AppointmentID) AS TotalAppointments FROM Patients p LEFT JOIN Appointments a ON p.PatientID = a.PatientID GROUP BY p.PatientID, p.FirstName, p.LastName ORDER BY TotalAppointments DESC LIMIT 1;

-- Find doctors with no appointments
SELECT d.DoctorID, d.FirstName, d.LastName FROM Doctors d LEFT JOIN Appointments a ON d.DoctorID = a.DoctorID WHERE a.AppointmentID IS NULL;

-- Find total appointments by month
SELECT DATE_FORMAT(AppointmentDate, '%Y-%m') AS Month, COUNT(*) AS TotalAppointments FROM Appointments GROUP BY DATE_FORMAT(AppointmentDate, '%Y-%m') ORDER BY Month;

-- Find patients with a specific diagnosis (e.g., 'Flu')
SELECT DISTINCT p.PatientID, p.FirstName, p.LastName FROM Patients p JOIN MedicalRecords m ON p.PatientID = m.PatientID WHERE m.Diagnosis = 'Flu';

-- Find average appointments per doctor
SELECT AVG(AppointmentsHandled) AS AvgAppointments FROM (SELECT COUNT(*) AS AppointmentsHandled FROM Appointments GROUP BY DoctorID) SubQuery;

-- Find most common medical history note
SELECT MedicalHistory, COUNT(*) AS Count FROM Patients GROUP BY MedicalHistory ORDER BY Count DESC LIMIT 1;

-- Find top 3 diagnoses across all records
SELECT Diagnosis, COUNT(*) AS Count FROM MedicalRecords GROUP BY Diagnosis ORDER BY Count DESC LIMIT 3;

-- List patients and doctors for all appointments in the past month
SELECT p.FirstName AS PatientFirstName, p.LastName AS PatientLastName, d.FirstName AS DoctorFirstName, d.LastName AS DoctorLastName, a.AppointmentDate FROM Appointments a JOIN Patients p ON a.PatientID = p.PatientID JOIN Doctors d ON a.DoctorID = d.DoctorID WHERE a.AppointmentDate > NOW() - INTERVAL 1 MONTH;

-- Find all treatments provided by a specific doctor (e.g., DoctorID 1)
SELECT * FROM MedicalRecords WHERE DoctorID = 1;

-- List the top 5 doctors by number of appointments handled
SELECT d.FirstName, d.LastName, COUNT(a.AppointmentID) AS TotalAppointments FROM Doctors d JOIN Appointments a ON d.DoctorID = a.DoctorID GROUP BY d.DoctorID ORDER BY TotalAppointments DESC LIMIT 5;

-- List appointments and associated medical records
SELECT a.AppointmentID, a.PatientID, a.DoctorID, m.RecordID, m.Diagnosis FROM Appointments a LEFT JOIN MedicalRecords m ON a.PatientID = m.PatientID;

-- Count patients who have had more than 3 appointments
SELECT COUNT(*) AS Total FROM (SELECT PatientID FROM Appointments GROUP BY PatientID HAVING COUNT(*) > 3) SubQuery;

-- Find the doctor with the highest number of medical records
SELECT d.FirstName, d.LastName, COUNT(m.RecordID) AS TotalRecords FROM Doctors d JOIN MedicalRecords m ON d.DoctorID = m.DoctorID GROUP BY d.DoctorID ORDER BY TotalRecords DESC LIMIT 1;

-- Find the average treatment length (words) for all medical records
SELECT AVG(LENGTH(Treatment) - LENGTH(REPLACE(Treatment, ' ', '')) + 1) AS AvgWords FROM MedicalRecords;
-- 1
ALTER TABLE Coach CHANGE dailySalary hourlySalary DECIMAL(10,2);
ALTER TABLE Participant CHANGE dailySalary hourlySalary DECIMAL(10,2);
UPDATE Coach SET hourlySalary=hourlySalary/4;
UPDATE Participant SET hourlySalary=hourlySalary/4;

-- 2
ALTER TABLE CoachInShow ADD COLUMN arrival TIME, ADD COLUMN departure TIME;
ALTER TABLE ContenderInShow ADD COLUMN arrival TIME, ADD COLUMN departure TIME;

-- 3
UPDATE CoachInShow C Natural JOIN `Show` S  SET arrival=DATE_SUB( S.startTime, INTERVAL 1 HOUR),
departure=DATE_ADD( S.endTime, INTERVAL 1 HOUR);

UPDATE ContenderInShow C Natural JOIN `Show` S  SET arrival=DATE_SUB( S.startTime, INTERVAL 1 HOUR),
departure=DATE_ADD( S.endTime, INTERVAL 1 HOUR);

SELECT * from CoachInShow natural join `Show`;
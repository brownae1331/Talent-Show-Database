-- Total Female Daily Salary


select avg(dailySalary)
from Participant
where gender LIKE 'F';

-- Coaching Report
Select C.name, C.surname, count(Co.idContender)
from Coach C left join Contender Co ON C.idCoach=Co.idCoach
Group BY C.idCoach,C.name,C.surname;

-- Coach Montly Attendance Report
Select C.name, C.surname, month(date), count(Co.idShow)
from Coach C  join CoachInShow Co ON C.idCoach=Co.idCoach  JOIN `Show` S ON S.idShow=Co.idShow
Group BY C.idCoach,C.name,C.surname,month(date);


-- Most Expensive Contender
select C.stageName
from Contender C, Participant P
where  C.idContender=P.idContender
group by C.stageName,C.idContender
having sum(P.dailySalary)>=ALL
(select sum(P.dailySalary)
from Contender C, Participant P
where  C.idContender=P.idContender
group by C.idContender);

-- March Payment Report
(SELECT C.name, C.surname,CAST(count(S.idShow) AS CHAR CHARACTER SET utf8) Attended ,C.dailySalary,ROUND(count(S.idShow)*C.dailySalary,2) TotalPay
FROM (CoachInShow CS NATURAL JOIN  (SELECT * FROM `Show` WHERE MONTH(date)=2) S) RIGHT JOIN Coach C ON C.idCoach=CS.idCoach 
GROUP BY C.idCoach,C.name,C.surname) 
UNION(
SELECT P.name, P.surname,count(S.idShow) Attended ,P.dailySalary,ROUND(count(S.idShow)*P.dailySalary,2) TotalPay
FROM (ContenderInShow CS NATURAL JOIN  (SELECT * FROM `Show` WHERE MONTH(date)=2) S) RIGHT JOIN (Participant P NATURAL JOIN Contender C) ON C.idContender=CS.idContender
GROUP BY P.idParticipant,P.name,P.surname)
UNION(

SELECT "TOTAL PAY","","","",sum(TotalPay)
FROM (
(SELECT ROUND(count(S.idShow)*C.dailySalary,2) TotalPay
FROM (CoachInShow CS NATURAL JOIN  (SELECT * FROM `Show` WHERE MONTH(date)=2) S) RIGHT JOIN Coach C ON C.idCoach=CS.idCoach 
GROUP BY C.idCoach
)
UNION

(SELECT ROUND(count(S.idShow)*P.dailySalary,2) TotalPay
FROM (ContenderInShow CS NATURAL JOIN  (SELECT * FROM `Show` WHERE MONTH(date)=2) S) RIGHT JOIN (Participant P NATURAL JOIN Contender C) ON C.idContender=CS.idContender
GROUP BY P.idParticipant)) S);

-- Well Formed Groups
SELECT stageName,count(P.idParticipant) 
FROM Contender C LEFT JOIN Participant P ON P.idContender=C.idContender
WHERE C.type='GROUP' 
GROUP BY C.idContender,stageName
HAVING count(P.idParticipant) <2;



Name, Surname, Attended , TotalPay
...
"TOTAL PAY","" ,"" , TotalPayValue(summed up)

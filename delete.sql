SET @leastPaid=(select  C.stageName
from Contender C, Participant P
where C.idContender=P.idContender
GROUP BY C.idContender,C.stageName
HAVING SUM(P.hourlySalary)<=ALL (SELECT SUM(P.hourlySalary) from Contender C, Participant P
where C.idContender=P.idContender
GROUP BY C.idContender));

SELECT *  FROM Participant  WHERE idContender IN (SELECT idContender FROM Contender where stageName=@leastPaid);

SELECT *  FROM ContenderInShow WHERE idContender IN (SELECT idContender FROM Contender where stageName=@leastPaid);

DELETE FROM Contender
WHERE stageName=@leastPaid;

SELECT *  FROM Participant  WHERE idContender IN (SELECT idContender FROM Contender where stageName=@leastPaid);

SELECT *  FROM ContenderInShow WHERE idContender IN (SELECT idContender FROM Contender where stageName=@leastPaid);
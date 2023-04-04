USE PollingStation
GO

/*Creation of Tables for Candidates, General Users, and Admin*/
CREATE TABLE Candidate (
	CandidateID int PRIMARY KEY,
	FirstName varchar(30),
	LastName varchar(30),
	Address varchar(50),
	PhoneNum varchar(10),
	TotalVotes Int
);

CREATE TABLE UserVoter(
	VoterID int PRIMARY KEY,
	FirstName varchar(30),
	LastName varchar(30),
	Username varchar(20) UNIQUE,
	Password varchar(30),
	UserAddress varchar(50),
	PhoneNum varchar(10),
	HasVoted tinyint,
	CandidateID int,
	FOREIGN KEY (CandidateID) REFERENCES Candidate(CandidateID)
);

CREATE TABLE UserAdmin(
	AdminID int PRIMARY KEY,
	FirstName varchar(30),
	LastName varchar(30),
	Username varchar(20) UNIQUE,
	Password varchar(30),
	AdminAddress varchar(50),
	PhoneNum varchar(10),
	PollingOfficer tinyint
);


/*Creation of sample data to put into the tables*/
USE PollingStation
GO

SET XACT_ABORT ON

BEGIN TRAN
GO
IF @@TRANCOUNT= 0
BEGIN
	INSERT INTO Candidate
	VALUES (1, 'Jim', 'Briar', '123 Maple Lane', '9029891225', 45),
		   (2, 'Poppy', 'Brande', '54 YellowStone Drive', '9029995555', 67),
		   (3, 'Jim', 'Briar', '123 Maple Lane', '9029891225', 5); 

	INSERT INTO UserVoter
	VALUES (1, 'Jamie', 'Gold','JGold','Password1', '3345 Yore Street', '9029384756',1,2),
	       (2, 'Kennedy', 'Burgess','KBurg','Password2', '99 Red Stone Drive', '9029384006',0,null),
	       (3, 'Amari', 'Joyce','AJoyce','Password3', '66 Coast Lane', '902774756',1,1),
		   (4, 'Heath', 'Lin','HLin','Password4', '23 Blue River Path', '9029987356',0,null),
		   (5, 'Alanna', 'Cole','ACole','Password5', '3443 Belle Wind Drive', '9029789756',1,3);

	INSERT INTO UserAdmin
	VALUES(1,'Blaine', 'White', 'BWhite', 'AdminPass1','223 Oak Way', '9026568558',1),
		  (2, 'Dave','Brown', 'DBrown','AdminPass2', '232 Grey Stone Drive', '9024548778', 0),
		  (3, 'Louise', 'Vert', 'LVert', 'AdminPass3', '6549 Jubilee Street', '9024878788', 1);
END;


/*Register Candidate Information*/

USE PollingStation
GO

BEGIN TRAN

INSERT INTO Candidate
VALUES(4, 'Lily', 'Spence', '56 Highwind Lane', '9029851234', 0);

COMMIT TRAN

/*Update Candidate Information*/

USE PollingStation
GO
BEGIN TRAN

UPDATE Candidate
SET TotalVotes = 27, Address = '32 Longwind Drive'
WHERE CandidateID = 4;

COMMIT TRAN

/*Register New User*/

USE PollingStation
GO
BEGIN TRAN

INSERT INTO UserVoter
VALUES(6, 'Rae', 'Larson','RLarson','Password6', '23 Trunk Hwy', '9029554844',0,NULL);

COMMIT TRAN

/*Update User Infomration*/

USE PollingStation
GO
BEGIN TRAN

UPDATE UserVoter
SET Password = 'NewPasswordUser6', UserAddress = '255 Trunk Hwy'
WHERE VoterID = 4;

COMMIT TRAN

/*Update Login Info for Valid User/Admin*/

USE PollingStation
GO

BEGIN TRAN

UPDATE UserAdmin
SET Username = 'LouiseV', Password = 'AdminPass12345'
WHERE AdminID = 3;

COMMIT TRAN

/*Delete Specific User From Database*/
USE PollingStation
GO

DECLARE @DeleteUserTran varchar(30) = 'DeleteUserTransaction';

BEGIN TRAN @DeleteUserTran

DELETE FROM UserVoter
WHERE VoterID = 4

ROLLBACK TRAN @DeleteUserTran

/*Delete all records without deleteing the schema*/

USE PollingStation
GO

DECLARE @DeleteAllRecords varchar(20) = 'DeleteAllRecords';

BEGIN TRAN @DeleteAllRecords

TRUNCATE TABLE UserAdmin
TRUNCATE TABLE UserVoter
TRUNCATE TABLE Candidate

ROLLBACK TRAN @DeleteAllRecords


/*Candidates with the top 2 highest voting record*/
USE PollingStation
GO

SELECT TOP 2 FirstName, LastName, TotalVotes
FROM Candidate
ORDER BY TotalVotes DESC;

/*Candidate with least voting record*/

USE PollingStation
GO

SELECT TOP 1 FirstName, LastName, TotalVotes
FROM Candidate
ORDER BY TotalVotes ASC;

/*Candidates who got votes between 5 to 15*/
USE PollingStation
GO

SELECT FirstName, LastName, TotalVotes
FROM Candidate
WHERE TotalVotes > 4 AND TotalVotes < 16;

/*Voting Record for each Candidate*/
USE PollingStation
GO

SELECT FirstName, LastName, TotalVotes
FROM Candidate;

/*Candidate Winner with Highest Votes*/
USE PollingStation
GO

SELECT TOP 1 FirstName, LastName, TotalVotes
FROM Candidate
ORDER BY TotalVotes DESC;

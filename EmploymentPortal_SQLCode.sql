
--GROUP 14

--EMPLOYMENT PORTAL

CREATE DATABASE Project_Group14;

GO
USE Project_Group14;

CREATE TABLE AccountPlan
			 (account_plan_id INT NOT NULL PRIMARY KEY,
			  account_plan_type VARCHAR(10) NOT NULL,
			  account_plan_price MONEY NOT NULL,
			  account_plan_duration INT NOT NULL);

CREATE TABLE PortalStaff
			 (portal_staff_id INT NOT NULL PRIMARY KEY,
			  staff_first_name VARCHAR(20) NOT NULL,
			  staff_last_name VARCHAR(20),
			  staff_email_id VARCHAR(50) NOT NULL,
			  position VARCHAR(20),
			  staff_contact_no VARCHAR(10) NOT NULL);
			  
CREATE TABLE Users
			 (user_id INT NOT NULL PRIMARY KEY,
			  user_name VARCHAR(20) NOT NULL,
			  password VARBINARY(250) NOT NULL,
			  first_name VARCHAR(20) NOT NULL,
			  last_name VARCHAR(20),
			  email_id VARCHAR(50) NOT NULL,
			  contact_no VARCHAR(10) NOT NULL,
			  created_on DATETIME DEFAULT CURRENT_TIMESTAMP ,
			  last_login DATETIME,
			  user_type VARCHAR(1) NOT NULL,
			  user_state VARCHAR(30),
			  user_city VARCHAR(30),
			  user_pinCode VARCHAR(10),
			  portal_staff_id INT REFERENCES PortalStaff(portal_staff_id),
			  account_plan_id INT REFERENCES AccountPlan(account_plan_id));

CREATE TABLE UserPayment
			 (payment_id INT IDENTITY PRIMARY KEY,
			  payment_date DATETIME NOT NULL,
			  user_id INT REFERENCES Users(user_id),
			  account_plan_id INT REFERENCES AccountPlan(account_plan_id));		 

CREATE TABLE Candidate
			 (candidate_user_id INT NOT NULL PRIMARY KEY REFERENCES Users(user_id),
			  employment_status BIT NOT NULL,
			  experience INT,
			  preferred_city VARCHAR(30),
			  gender VARCHAR(10),
			  nationality VARCHAR(30),
			  expected_salary MONEY );

CREATE TABLE Resume
			 (resume_id INT IDENTITY PRIMARY KEY,
			  path VARCHAR(200) NOT NULL,
			  candidate_user_id INT NOT NULL REFERENCES Candidate(candidate_user_id));

CREATE TABLE Qualifications
			 (qualification_id INT IDENTITY PRIMARY KEY,
			  degree VARCHAR(20) NOT NULL,
			  major VARCHAR(50) NOT NULL);
		
CREATE TABLE University
			 (university_id INT IDENTITY PRIMARY KEY, 
			  university_name VARCHAR(200) NOT NULL);

CREATE TABLE CandidateHasQualifications
			 (candidate_user_id INT NOT NULL REFERENCES Candidate(candidate_user_id),
			  qualification_id INT NOT NULL REFERENCES Qualifications(qualification_id),
			  gpa DECIMAL NOT NULL,
			  graduation_year VARCHAR(4) NOT NULL,
			  university_id INT REFERENCES University(university_id)
			  PRIMARY KEY(candidate_user_id, qualification_id));

CREATE TABLE SkillSet
			 (skillset_id INT IDENTITY PRIMARY KEY,
			  skillset_name VARCHAR(50) NOT NULL);
			 		  
CREATE TABLE Certification
			 (certificate_id INT IDENTITY PRIMARY KEY,
			  certificate_name VARCHAR(150) NOT NULL);

CREATE TABLE CandidateHasSkillSet
			 (candidate_user_id INT NOT NULL REFERENCES Candidate(candidate_user_id),
			  skillset_id INT NOT NULL REFERENCES SkillSet(skillset_id),
			  skill_level VARCHAR(15),
			  certified BIT NOT NULL,
			  CONSTRAINT PKCandidateHasSkillSet PRIMARY KEY CLUSTERED(candidate_user_id, skillset_id));

CREATE TABLE CandidateSkillCertification
			 (candidate_user_id INT NOT NULL REFERENCES Candidate(candidate_user_id),
			  skillset_id INT NOT NULL REFERENCES SkillSet(skillset_id),
			  certificate_id INT NOT NULL REFERENCES Certification(certificate_id),
			  certification_no VARCHAR(20) NOT NULL,
			  certificate_validity DATE,
			  certification_date DATE NOT NULL
			  PRIMARY KEY(candidate_user_id, skillset_id, certificate_id));

CREATE TABLE Company
			 (company_id INT IDENTITY PRIMARY KEY,
			  company_name VARCHAR(50) NOT NULL,
			  company_state VARCHAR(30),
			  company_city VARCHAR(30),
			  company_country VARCHAR(30),
			  company_pinCode VARCHAR(10));		  

CREATE TABLE CompanyRecruiter
			 (recruiter_user_id INT NOT NULL PRIMARY KEY REFERENCES Users(user_id),
			  recruiter_position VARCHAR(20),
			  company_id INT NOT NULL REFERENCES Company(company_id));	  			   			   			  					 

CREATE TABLE JobVacancies
			 (job_id INT IDENTITY PRIMARY KEY,
			   job_title VARCHAR(50) NOT NULL,
			   job_is_active BIT NOT NULL,
			   job_type VARCHAR(50),
			   experience_required INT NOT NULL,
			   degree_required VARCHAR(50) NOT NULL,
			   major_required VARCHAR(50) NOT NULL,
			   job_salary MONEY,
			   job_state VARCHAR(30),
			   job_city VARCHAR(30),
			   created_on DATETIME DEFAULT CURRENT_TIMESTAMP,
			   recruiter_user_id INT NOT NULL REFERENCES CompanyRecruiter(recruiter_user_id));

CREATE TABLE InterviewSchedule
			 (interview_schedule_id INT IDENTITY PRIMARY KEY,
			  interview_date DATE NOT NULL,
			  interview_city VARCHAR(30),
			  interview_state VARCHAR(30),
			  interview_time TIME);

CREATE TABLE CandidateAppliesJobVacancies
			 (candidate_user_id INT NOT NULL REFERENCES Candidate(candidate_user_id),
			  job_id INT NOT NULL REFERENCES JobVacancies(job_id),
			  date_applied DATETIME DEFAULT CURRENT_TIMESTAMP,
			  interview_schedule_id INT REFERENCES InterviewSchedule(interview_schedule_id)
			  PRIMARY KEY(candidate_user_id, job_id));

--INSERT DATA

GO
INSERT INTO Qualifications
VALUES ('BE','Computer Science'),
	   ('BE','Information Technology'),
	   ('BE','Electronics and Telecommunication'),
	   ('BE','Mechanical'),
	   ('BE','Civil'),
	   ('BE','Mechatronics'),
	   ('BE','Chemical'),
	   ('BE','Computer Science'),
	   ('MS','Computer Engineering'),
	   ('MS','Information Technology'),
	   ('MS','Mechatronics'),
	   ('MS','Engineering Management'),
	   ('MS','Project Management'),
	   ('MS','Data Science'),
	   ('MS','Supply Chain Management'),
	   ('MS','Biotechnology'),
	   ('MS','Embedded Systems'),
	   ('MS','Petroleum Engineering');

INSERT INTO SkillSet 
VALUES ('SQL'),	   ('PHP'),	   ('Database Adminstration'),	   ('FrontEnd Development'),	   ('Backend Development'),	   ('Python'),	   ('Javascript'),	   ('Leadership'),	   ('Machine Learning'),	   ('Finance'),	   ('Java'),	   ('CPP'),
	   ('LeaderShip'),
	   ('Communication'),
	   ('Time Management'),
	   ('Risk Management');

INSERT INTO Certification 
VALUES ('PHP for Beginners - Become a PHP Master '),
	   ('The Complete SQL Bootcamp 2020: Go from Zero to Hero'),
       ('Learn Python Programming Masterclass'),
       ('Java Programming Masterclass for Software'),
       ('The Complete JavaScript Course 2020: Build Real Projects!'),
       ('Machine Learning by Stanford'),
       ('C++ Programming'),
       ('The Complete Front-End Web Development Course!'),
       ('The Complete Backend-End Web Development Course!'),
       ('Oracle DBA 11g/12c - Database Administration for Junior DBA'),
       ('The Complete Financial Analyst Course 2020'),
       ('Leadership Skills | Become a Leader People Like & Listen To'),
       ('Project Management Professional'),
       ('Certified ScrumMaster'),
       ('Certified Risk Management');

INSERT INTO University
  VALUES ('Amity University'),
         ('Dr C.V. Raman University'),
         ('Birla Institute of Technology & Science'),
         ('Jaypee University of Engineering & Technology'),
         ('Narsee Monjee Institute of Management Studies'),
         ('Savitribai Phule Pune University'),
         ('Manipal University'),
         ('NIMS University'),
         ('University of Mumbai'),
         ('Ajeenkya D.Y. Patil University'),
         ('University of Calicut'),
         ('Yenepoya University'),
         ('Bengaluru Central University'),
         ('SRM University');

INSERT INTO PortalStaff
VALUES (501,'Anita','Patil','anitapatil01@gmail.com','Manager',9011234584),
	   (502,'Seema','Patil','seema02patil@gmail.com','Administrator',9218274531),
	   (503,'Ram','Mahajan','ram.mahajan50@gmail.com','Administrator',8287234133),
	   (504,'Rahul','Khan','khanrahul@gmail.com','Marketing',7292264433),
	   (505,'Soha','Khan','sohaa.khan.45@gmail.com','Administrator',9328344685),
	   (506,'Swati','Sengupta','senswati14@gmail.com','Manager',9252364451),
	   (507,'Aisha','Ahmed','aishaahmed@gmail.com','Administrator',9241273210),
	   (508,'Ashish','Patel','ashishspatel@gmail.com','Marketing',9223570001),
	   (509,'Apoorva','Behl','behl.1.apoorva@gmail.com','Administrator',7218001532),
	   (510,'Amit','Singh','amitalisingh@gmail.com','Manager',9214961532);
	   		 
INSERT INTO AccountPlan
VALUES (10,'Basic',100,1),
       (11,'Basic',275,3),
       (12,'Basic',550,6),
       (13,'Basic',850,9),
       (14,'Basic',1100,12),
       (20,'Standard',200,1),
       (21,'Standard',575,3),
       (22,'Standard',1150,6),
       (23,'Standard',1750,9),
       (24,'Standard',2350,12),
       (30,'Premium',400,1),
       (31,'Premium',1200,3),
       (32,'Premium',2350,6),
       (33,'Premium',3500,9),
       (34,'Premium',4500,12);

INSERT INTO InterviewSchedule
VALUES ('2020-10-01','Pune','Maharashtra','10:00 AM'),
	   ('2020-11-05','Mumbai','Maharashtra','10:00 AM'),
       ('2020-12-06','Pune','Maharashtra','11:00 AM'),
       ('2021-03-25','Bangalore','Karnataka','12:00 PM'),
       ('2021-03-29','Pune','Maharashtra','2:00 PM'),
       ('2021-01-15','Agra','Delhi','10:00 AM'),
       ('2020-09-11','Gurgoan','Haryana','10:00 AM'),
       ('2020-12-30','Hyderabad','Telanaga','3:00 PM'),
       ('2021-03-05','Nashik','Maharashtra','3:00 PM'),
       ('2020-09-21','Chennai','Tamil Nadu','11:00 AM'),
       ('2020-10-12','Pune','Maharashtra','5:00 PM'),
       ('2021-02-16','Noida','Uttar Pradesh','4:00 PM');

INSERT INTO Company
VALUES ('Larsen & Toubro','Maharashtra','Mumbai','India',400001),
       ('Cognizant','NewJersey','Teaneck','USA',70666),
	   ('Advent Global Solutions INC','Houston','Texas','USA',77070),
	   ('Philips HealthCare','Tennessee','Franklin','USA',37067),
	   ('Sunteck Realty Limited','Maharashtra','Mumbai','India',400057),
	   ('Wipro Limited','Karnataka','Bengaluru','India',560035),
	   ('SalesForce','California','SanFrancisco','USA',94105),
	   ('YARD Software','Maharashtra','Pune','India',456001),
	   ('Google','California','MountainVeiw','USA',56807),
	   ('Microsoft','Washington','Redmond','USA',98052);


-- Encryption for Password attribute in User Entity	   

CREATE MASTER KEY
ENCRYPTION BY PASSWORD = 'Portal_User_P@sswOrd';

CREATE CERTIFICATE UserCertificate
WITH SUBJECT = 'Portal User Password Certificate',
EXPIRY_DATE = '2026-10-31';

CREATE SYMMETRIC KEY PortalSymmetricKey
WITH ALGORITHM = AES_128
ENCRYPTION BY CERTIFICATE UserCertificate;

OPEN SYMMETRIC KEY PortalSymmetricKey
DECRYPTION BY CERTIFICATE UserCertificate;



INSERT INTO Users
VALUES (1001,'alfisaifee',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'alfiA45')),
              'Alfia','Saifee','alfiasaif94@gmail.com',9762532017,DEFAULT,GETDATE(),'C','MadhyaPradesh','Bhopal','400098',503,12),
	   (1002,'iyerShah95',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'kigt6565')),
              'Shalini','Iyer','shalini_iyer@gmail.com',7825341096,DEFAULT,GETDATE(),'C','TamilNadu','Chennai','807058',509,NULL),
	   (1003,'adityaKul',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'juh789')),
              'Aditya','Kulkarni','kulkarni.aditya@sunteck.com',800974152,DEFAULT,GETDATE(),'E','Maharashtra','Pune','415097',503,33),
	   (1004,'shettyShruti',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'H@ufug894')),
              'Shruthi','Shetty','shetty_shruthi@salesforce.com',9054587102,DEFAULT,GETDATE(),'E',NULL,NULL,NULL,507,24),
	   (1005,'abishBaner',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'A@b8941op')),
              'Abish','Banerjee','abish.banerjee@advent.global.com',8901548792,DEFAULT,GETDATE(),'E','West Bengal','Kolkata','700852',505,34),
	   (1006,'deepali96',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'deepa')),
              'Deepali','Kasture','deepalikasture@gmail.com',982285612,DEFAULT,GETDATE(),'C','Maharashtra','Pune','400030',509,22),
       (1007,'kshiti96',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'kshiti')),
              'Kshitija','Waghurdekar','kshitijaw@hotmail.com',9822856123,DEFAULT,GETDATE(),'C','Maharashtra','Pune','400010',504,NULL),
       (1008,'mayuri96',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'mayu123')),
              'Mayuri','Mahandule','mahandulem@cognizant.com',9822812345,DEFAULT,GETDATE(),'E','Maharashtra','Nagar','400050',501,31),
       (1009,'rajat95',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'rajat11')),
              'Rajat','Kamble','rjkamble@wipro.com',9822867891,DEFAULT,GETDATE(),'E','Maharashtra','Mumbai','411060',508,33),
       (1010,'ani97',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'ani123')),
              'Aniruddha','Humane','a.humane@yard.com',9822885296,DEFAULT,GETDATE(),'E','Maharashtra','Pune','400040',507,33),
       (1011,'namitakm',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'namita123')),
              'Namita','Manage','namitakm@lnt.com',9761002238,DEFAULT,GETDATE(),'E','Maharashtra','Pune','411065',505,33),
       (1012,'rashmipatil',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'rashmipatil12')),
              'Rashmi','Patil','rashmipatil@gmail.com',9767892721,DEFAULT,GETDATE(),'C','Karnataka','Bangalore','401258',507,23),
       (1013,'nehabehl',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'nehab12')),
              'Neha','Behl','nehabehl12@gmail.com',9862532847,DEFAULT,GETDATE(),'C',NULL,NULL,NULL,509,14),
	   (1014,'ashishsen',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'ashishsen12')),
              'Ashish','Sengupta','ashishsengupta09@microsoft.com',8531012238,DEFAULT,GETDATE(),'E','Maharashtra','Mumbai','322065',505,24),
       (1015,'shruti45',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'shru456')),
              'Shruti','Bansal','shrutibansal.07@sunteck.com',9761002238,DEFAULT,GETDATE(),'E','California','San Francisco','456002',502,33),
	   (1016,'siddhantmangle',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'Sidd@123')),
              'Siddhant','Mangle','Siddhant14@hotmail.com',9876543210,DEFAULT,GETDATE(),'C','Maharashtra','Mumbai','400001',502,24),
       (1017,'yashaarya',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'y@sh6262')),
              'Yash','Aarya','yashaarya@gmail.com',9762567671,DEFAULT,GETDATE(),'C','WestBengal','Kolkata',NULL,505,11),
       (1018,'bhushankale',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'bhushaN$1212')),
              'Bhushan','Kale','bhushan1212@outlook.com',9833461212,DEFAULT,GETDATE(),'C','Maharashtra','Nashik','400123',505,32),
       (1019,'anshumankaran',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'anshK@ran32')),
              'Anshuman','Karan','anshuman.karan@gmail.com',9321234545,DEFAULT,GETDATE(),'C','Delhi','Delhi','100062',509,31),
       (1020,'ravishkumar',EncryptByKey(Key_GUID(N'PortalSymmetricKey'), convert(varbinary, 'Ravish%31')),
              'Ravish','Kumar','ravish.kumar@philips.com',9654213276,DEFAULT,GETDATE(),'E','MadhyaPradesh',NULL,'400676',507,22);
 
INSERT INTO Candidate
 VALUES (1001, 0, 8, 'Pune', 'F', 'Indian', 400000),
        (1002, 1, 26, NULL, 'F', 'Indian', 650000),
		(1012, 0, 15, 'Bangalore', 'F', 'Indian', 1200000),
        (1013, 1, 6,  NULL, 'F', 'Indian', 1000000),
		(1016, 1, 96,'Mumbai', 'M','Indian',1000000),
        (1017, 0, 0, 'Mumbai', 'M','Indian',50000),
		(1006, 0, 18, 'Banglore','F','Indian',300000),
        (1007, 1, 36, 'Chennai','F','Indian',800000),
		(1018, 0, 9,'Nashik','M','Indian',800000),
        (1019, 1, 54,'Delhi','M','Indian',1100000);

INSERT INTO CompanyRecruiter
VALUES (1003,'HR Administrator',5),
       (1004,'HR Assistant',7),
       (1005,'HR Manager', 3),
	   (1008,'HR Assistant', 2),
       (1015,'HR Head', 5),
       (1020, 'Associate', 4),
       (1009, 'HR Assistant',6),
       (1010, 'HR Manager',8),
       (1011,'Director',1), 
	   (1014,'HR Assistant',10);

INSERT INTO Resume
VALUES ('\\Resume\1001.pdf',1001),
       ('\\Resume\1002.pdf',1002),
	   ('\\Resume\1006.pdf',1006),
	   ('\\Resume\1007.pdf',1007),
	   ('\\Resume\1012.pdf',1012),
	   ('\\Resume\1013.pdf',1013),
	   ('\\Resume\1016.pdf',1016),
	   ('\\Resume\1017.pdf',1017),
	   ('\\Resume\1018.pdf',1018),
	   ('\\Resume\1019.pdf',1019);

INSERT INTO JobVacancies
VALUES ('Data Analyst',1,'Permanent',36,'MS','Computer Engineering',400000,'Maharashtra','Pune',DEFAULT,1010),
       ('Service Engineer',1,'Permanent',24,'BE','Electronics and Telecommunication',1400000,'Hyderabad','Telangana',DEFAULT,1014),
	   ('Cloud Engineer',0,'Permanent',12,'MS','InformationTechnology',1000000,'Karnataka','Bangalore','2019-12-10',1014),
	   ('Data Scientist',1,'Permanant',26,'MS','Computer Science',1000000,NULL,'Pune',DEFAULT,1004),
       ('Software Developer',1,'Permanant',46,'MS','Information Technology/Computer Science',2000000,'Maharashtra','Mumbai',DEFAULT,1004),
	   ('Project Manager',1,'Contract',36,'MS','Project Management',500000,'Gujarat','Ahmedabad',DEFAULT,1008),
       ('Java Developer',1,'Contract',24,'MS','Computer Engineering',1200000,'Maharashtra','Mumbai',DEFAULT,1009),
       ('Software Developer Engineer',1,'Permanent',18,'BE','Computer Engineering',700000,'Maharashtra','Pune',DEFAULT,1008),
	   ('Database Admin',1,'Permanent', 48, 'MS', 'Information Technology', 600000, 'Haryana', 'Gurgaon', DEFAULT, 1011),
       ('Project Lead', 0, 'Contract', 24, 'MS', 'Project Management', 900000, 'West Bengal', NULL, '2019-02-15', 1011),
       ('System Adminsitrator', 1, 'Permanent', 60, 'BE', 'Electronics and Telecommunication', 800000, 'Maharashtra', 'Mumbai', DEFAULT, 1005),
       ('Linux Administrator', 1, 'Contract', 12, 'BE', 'Information Technology', 400000, 'Maharashtra', 'Nagpur', DEFAULT, 1011),
	   ('Business Analyst',1,'Permanent',48,'BE','Computer Science',1000000,'Karnataka','Banglore',DEFAULT,1020 ),
       ('OperationsAssociate',1,'Contract',12,'BE','Civil Engineering',600000,'Haryana','Gurgaon',DEFAULT, 1015),
	   ('Project Manager',0,'Contract',48,'MS','Supply Chain Management',1400000,'Maharashtra','Mumbai','2020-05-25', 1015),
       ('Data Analyst',0,'Permanent',36,'MS','Data Science',1400000,'Haryana','Gurgaon','2020-07-02', 1020),
	   ('Product Manager',1,'Permanent',24,'MS','Information Technology',800000,'Telangana','Hyderabad',DEFAULT, 1020);


--Function for computed column PaymentValidityDate in User Payment Entity

GO
CREATE FUNCTION ComputePaymentValidityDate
(@PaymentID INT)
RETURNS DATETIME
AS
BEGIN
	DECLARE @ValidityDate DATETIME;

	SELECT @ValidityDate = DATEADD(MONTH, account_plan_duration, payment_date)
	FROM UserPayment up
	JOIN AccountPlan ap
	ON up.account_plan_id = ap.account_plan_id
	WHERE payment_id = @PaymentID;

	RETURN @ValidityDate
END
GO

ALTER TABLE UserPayment
ADD payment_validity_date AS (dbo.ComputePaymentValidityDate(payment_id));


INSERT INTO UserPayment(payment_date, user_id, account_plan_id)
VALUES ('2020-09-04 08:19',1004,24), 
       ('2020-10-01 15:10',1018,32),
	   ('2020-09-25 11:00',1019,31),
	   ('2020-11-15 07:19',1020,22),
	   ('2020-12-25 16:02',1019,23),
	   ('2021-05-20 22:36',1020,31),
	   ('2021-09-20 14:27',1020,31),
	   ('2020-10-14 16:19',1012,31),
       ('2020-11-15 23:23',1014,23),
       ('2020-10-04 11:58',1015,11),
       ('2021-05-04 12:36',1015,32),
       ('2020-11-18 06:45',1013,10),
	   ('2021-04-04 08:20',1013,21),
	   ('2021-10-23 15:39',1013,31),
	   ('2020-09-01 10:30',1008,10),
       ('2020-10-04 11:00',1008,32),
	   ('2020-10-05 09:30',1009,11),
	   ('2021-01-04 08:00',1009,21),
	   ('2021-04-10 11:00',1009,33),
       ('2020-11-03 10:20',1010,34),
	   ('2020-12-01 10:00',1011,23),
       ('2021-06-04 08:00',1011,33),
	   ('2020-09-02 07:18',1001,10),
	   ('2020-09-07 22:18',1003,10),
       ('2020-10-05 07:18',1001,12),
	   ('2020-10-07 22:18',1003,33),
	   ('2020-10-12 22:18',1005,34),
	   ('2020-09-23 10:16',1006,31),
       ('2020-12-17 13:05',1016,34),
       ('2021-04-11 21:07',1017,33);

INSERT INTO CandidateHasQualifications 
 VALUES   (1001,1,9.2,'2017',6),
    (1002,2,8.1,'2018',1),
    (1002,10,8.1,'2020',6),
    (1006,9,7.8,'2019',6),
    (1007,8,7.9,'2020',4),
    (1007,14,8.8,'2020',8),
    (1012,12,9.5,'2011',9),
    (1013,8,9.3,'2018',11),
    (1016,10,8.7,'2019',10),
    (1017,13,9.8,'2020',6),
    (1018,8,8.9,'2016',3),
    (1019,10,9.1,'2018',2),
    (1001,13,9.8,'2019',8),
    (1018,9,8.5,'2018',7),
    (1013,10,9.1,'2020',14);

INSERT INTO CandidateAppliesJobVacancies
VALUES (1001,5,'2020-08-20 15:30',7),
       (1001,8,'2020-11-19 21:30',NULL),
	   (1002,5,'2020-08-24 15:30',NULL),
	   (1002,8,'2020-08-26 16:30',NULL),
       (1006,11,'2020-10-05 04:52',8),
	   (1012,7,'2020-12-30 08:14', NULL),
	   (1013,1,'2020-10-05 17:09',1),
       (1013,13,'2020-11-10 23:40',NULL),
       (1016,17,'2020-09-20 04:19',4),
       (1016,14,'2020-10-02 18:07',10),
       (1016,6,'2020-12-30 06:08',NULL),
	   (1017,6,'2020-11-12 16:23',2),
       (1018,4,'2020-08-11 17:45',NULL),
       (1017,4,'2020-08-15 09:55',NULL),
       (1017,12,'2020-10-16 23:01',9),
       (1019,13,'2020-08-23 12:54',NULL),
       (1018,6,'2020-09-19 19:33',11);

INSERT INTO CandidateHasSkillSet
VALUES (1001,1,'Basic',1),
       (1002,3,'Intermediate',1),
       (1002,5,NULL,0),
       (1002,11,'Basic',1),
       (1006,12,'Advanced',1),
       (1007,7,'Advanced',0),
       (1007,6,'Basic',1),
       (1012,9,NULL,1),
       (1013,2,'Advanced',0),
       (1013,3,NULL,1),
       (1013,6,'Advanced',0),
       (1013,10,'Intermediate',0),
       (1016,4,'Intermediate',1),
       (1017,1,'Basic',1),
       (1017,5,'Basic',1),
       (1018,3,'Advanced',0),
       (1019,8,'Basic',1),
       (1019,9,'Intermediate',1),
       (1006,6,'Intermediate',1),
       (1006,4,NULL,0);
       
INSERT INTO CandidateSkillCertification
VALUES  (1001, 1,4, 'JP100385', '2020-12-21','2017-08-15'),
        (1002, 3,10, 'PHP203021',NULL,'2019-12-12'),
        (1006, 6,3, 'LS000012','2021-02-22','2020-01-01'),
		(1006, 12,7, 'OSCPP012','2025-02-22','2020-02-01'),
        (1007, 6,3, 'JS4632','2021-02-22','2018-11-23'),
        (1012, 9,6, 'CFA102030',NULL,'2018-06-26'),
        (1013, 3,10, 'DBA11021','2022-11-30','2019-03-22'),
        (1016, 4,8, 'ML124578',NULL,'2018-12-15'),
        (1017, 1,2, 'PY200352','2013-04-14','2019-06-18'),
		(1017, 5,11, 'PY200352',NULL,'2019-06-18'),
        (1018, 3,10, 'CPP12312' ,NULL,'2020-04-20'),
        (1019, 9,6, 'SQL145230',NULL,'2019-07-17'),
		(1002, 11,6, 'JAVA205621',NULL,'2020-06-12');


--VIEWS
GO
CREATE VIEW UserAccountPlanDetails ASSELECT first_name [User First Name], last_name [User Last Name],CASE WHEN user_type='C' THEN 'Candidate' ELSE 'Employer' END [User Type],ISNULL(account_plan_type,'Free') [Account Plan],ISNULL(CAST(MAX(payment_validity_date) AS CHAR),'Unlimited') [AccountValidityDate]FROM Users uLEFT JOIN AccountPlan apON u.account_plan_id = ap.account_plan_idLEFT JOIN UserPayment upON u.user_id = up.user_idGROUP BY u.user_id, first_name, last_name,user_type, account_plan_type;

GO
CREATE VIEW CompanyJobsVacancies AS
SELECT company_name,first_name,last_name,email_id,job_title,[experience_required],[degree_required],[major_required],[job_salary]
FROM [dbo].[CompanyRecruiter] cr
JOIN [dbo].[JobVacancies] jv
ON cr.[recruiter_user_id] = jv.[recruiter_user_id]
JOIN [dbo].[Company] c
ON cr.[company_id] = c.[company_id]
JOIN Users uON cr.[recruiter_user_id] = u.user_id
WHERE [job_is_active] = 1;


SELECT * FROM CompanyJobsVacancies;
SELECT * FROM UserAccountPlanDetails;

--check level constraint

GO
CREATE FUNCTION CheckFreeCandidate 
(@UserID INT)
RETURNS INT 
AS 
BEGIN
	DECLARE @Count INT;
	SELECT @Count = ISNULL(COUNT(*),0) 
	FROM [dbo].[CandidateAppliesJobVacancies]
	WHERE YEAR([date_applied]) = YEAR(GETDATE()) AND MONTH([date_applied]) = MONTH(GETDATE()) AND [candidate_user_id] = @UserID
	RETURN @Count
END

ALTER TABLE CandidateAppliesJobVacancies 
ADD CONSTRAINT LimitForFreeUser CHECK (dbo.CheckFreeCandidate([candidate_user_id]) <= 2) 


INSERT INTO CandidateAppliesJobVacancies
VALUES (1002,11,'2020-08-27 15:30',NULL)

--Trigger

GO
CREATE TRIGGER SetSkillCertified
ON [dbo].[CandidateSkillCertification]
AFTER INSERT
AS
BEGIN
	UPDATE css
	SET certified = 1
	FROM Inserted i
	JOIN [dbo].[CandidateHasSkillSet] css
	ON i.candidate_user_id = css.candidate_user_id 
	AND i.skillset_id = css.skillset_id

END

SELECT * FROM [dbo].[CandidateHasSkillSet]

INSERT INTO CandidateSkillCertification
VALUES  (1002, 5,9, 'CP001009', NULL,'2017-08-5')


GO
CREATE TRIGGER CandidateAppliesToActiveJobs
ON [dbo].[CandidateAppliesJobVacancies]
AFTER INSERT 
AS 
BEGIN
	DECLARE @IsActive Bit; 
	SELECT @IsActive = [job_is_active]
	FROM [dbo].[JobVacancies]
	WHERE [job_id] = (SELECT [job_id] FROM Inserted i)
	
	IF @IsActive = 0

		BEGIN
			ROLLBACK TRANSACTION 
			RAISERROR('Job is No Longer Active',16,1)

		END

END


INSERT INTO CandidateAppliesJobVacancies
VALUES (1001,3,'2020-08-20 15:30',7)



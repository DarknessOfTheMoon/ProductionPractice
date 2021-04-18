/* Создаем БазуДанных |  Отдел кадров и бухгалтерия некоторой компании */
CREATE DATABASE [HumanResourcesDepartment]
GO

/* Подключение БазыДанных */
USE [HumanResourcesDepartment]
GO

/*ТАБЛИЦА  "СОТРУДНИКИ"
---------------------------
	Поля: паспортные данные,
	фотография, 
	дом. и моб. телефоны, 
	тип работы,
	проект(ы), 
	зарплата */

CREATE TABLE[Personnel](

	[ID]				INT IDENTITY(0, 1),
	[IDPassportData]	INT	CONSTRAINT FK_Personnel_IDPassportData_PassportData_PassportDataID FOREIGN KEY REFERENCES [PassportData]([PassportDataID])		   NOT NULL,
	[Photo]				IMAGE																																   NOT NULL,
	[Home]				NVARCHAR(30)																														   NOT NULL,
	[IDPhone]			INT	CONSTRAINT FK_Personnel_IDPhone_Phone_PhoneID FOREIGN KEY REFERENCES [Phone]([PhoneID])											   NOT NULL,																																  
	[IDDepartment]		INT	CONSTRAINT FK_Personnel_IDDepartment_Department_DepartmentID FOREIGN  KEY REFERENCES [Department]([DepartmentID])				   NOT NULL,										
	[IDWork]			INT	CONSTRAINT FK_Personnel_IDWork_Work_WorkID FOREIGN KEY REFERENCES [Work]([WorkID])												   NOT NULL,	
	[IDProject]			INT	CONSTRAINT FK_Personnel_IDProject_Project_ProjectID FOREIGN  KEY REFERENCES [Project]([ProjectID])								   NOT NULL,
	[IDSalary]			INT	CONSTRAINT FK_Personnel_IDSalary_Salary_SalaryID FOREIGN  KEY REFERENCES [Salary]([SalaryID])									   NOT NULL,
	CONSTRAINT PK_Personnel_ID PRIMARY KEY([ID])

)
GO

/*ТАБЛИЦА  "ПАСПОРТНЫЕ ДАННЫЕ"
---------------------------
	Поля: фио,
	номер, 
	серия,
	кем выпущен*/

CREATE TABLE[PassportData](

	[PassportDataID]	INT IDENTITY(0, 1),
	[FIO]				NVARCHAR(50)																														    NOT NULL,
	[Number]			INT																																	    NOT NULL,
	[Series]			INT																																   	    NOT NULL,
	[Issued]			NVARCHAR(50)																														    NOT NULL,
	CONSTRAINT PK_PassportData_PassportDataID PRIMARY KEY([PassportDataID])
)
GO

/*ТАБЛИЦА  "НОМЕРА ТЕЛЕФОНОВ"
---------------------------
	Поля: номер телефона, 
	номер телефона_2,
	рабочий номер телефона*/

CREATE TABLE[Phone](

	[PhoneID]			INT IDENTITY(0, 1),	
	[PhoneNumber]		INT																																	     NOT NULL,
	[PhoneNumberTwo]	INT,
	[WorkPhoneNumber]	INT																																		 NOT NULL,
	CONSTRAINT PK_PHONE_PhoneID PRIMARY KEY([PhoneID])

)
GO

/*ТАБЛИЦА  "ОТДЕЛ"
---------------------------
	Поля: название, 
	комната,
	номер телефона,
	руководитель,
	размер финансирования,
	число сотрудников*/

CREATE TABLE[Department](

	[DepartmentID]		INT IDENTITY(0, 1),
	[Name]				NVARCHAR(30)																															  NOT NULL,
	[Room]				INT																																		  NOT NULL,
	[Phone]				INT																																		  NOT NULL,
	[Chief]				NVARCHAR(30)																															  NOT NULL,
	[Funding]			INT																											        					  NOT NULL,
	[NumberOfEmployees]	INT																																		  NOT NULL,
	CONSTRAINT	PK_Department_DepartmentID PRIMARY KEY([DepartmentID])

)
GO

/*ТАБЛИЦА  "РАБОТА"
--------------------------------------------
	Поля: пост(который занимает сотрудник), 
	тип работы(который выполняет сотрудник),
	задача*/

CREATE TABLE[Work](
	
	[WorkID]			INT IDENTITY(0, 1),	
	[Post]				NVARCHAR(30)																															   NOT NULL,
	[TypeWork]			NVARCHAR(30)																															   NOT NULL,
	[Task]				NVARCHAR(30)																															   NOT NULL,
	CONSTRAINT FK_Work_WorkID PRIMARY KEY([WorkID])	
)
GO

/*ТАБЛИЦА  "ПРОЕКТ"
---------------------------
	Поля: название, 
	дата начала, 
	дата окончания,
	тип проекта*/

CREATE TABLE[Project](

	[ProjectID]				INT IDENTITY(0, 1),				
	[Name]					NVARCHAR(50)																														   NOT NULL,
	[StartDate]				DATE																																   NOT NULL,
	[EndDate]				DATE																																   NOT NULL,
	[IDAdditionalInformation]	INT CONSTRAINT FK_Project_IDAdditionalInformation_AdditionalInformation_AdditionalInformationID 
	FOREIGN KEY REFERENCES [AdditionalInformation]([AdditionalInformationID])																					   NOT NULL,

	CONSTRAINT PK_Project_ProjectID PRIMARY KEY([ProjectID])
)
GO

/*ТАБЛИЦА  "ДОП.ИНФОРМАЦИЯ О ПРОЕКТЕ"
---------------------------
	Поля: название,
	задача проекта,
	статья расходов,
	размер финансирования,
	тип финансирования*/

CREATE TABLE[AdditionalInformation](

	[AdditionalInformationID]	INT IDENTITY(0, 1),				
	[NameProject]			NVARCHAR(50)																															NOT NULL,
	[TaskProject]			NVARCHAR(MAX)																														    NOT NULL,	
	[ItemsOfExpenditure]	NVARCHAR(MAX)																															NOT NULL,
	[Funding]				INT																											        				    NOT NULL,
	[IDTypeFunding]			INT CONSTRAINT FK_TypeProject_IDTypeFunding_TypeFunding_TypeFundingID FOREIGN KEY REFERENCES [TypeFunding]([TypeFundingID])			    NOT NULL,		
	CONSTRAINT PK_Project_AdditionalInformationID PRIMARY KEY([AdditionalInformationID])
)
GO

/*ТАБЛИЦА  "ТИП ФИНАНСИРОВАНИЯ"
-----------------------------------------------------
	Поля: тип финансирования (периодический, разовый) */

CREATE TABLE[TypeFunding](
							
	[TypeFundingID]		INT IDENTITY(0, 1),					
	[TypeFunding]		NVARCHAR(30)																															   NOT NULL,   
	CONSTRAINT FK_TypeFunding_TypeFundingID PRIMARY KEY([TypeFundingID])
)
GO

/*ТАБЛИЦА  "ЗАРАБОТНАЯ ПЛАТА"
---------------------------------------------
	Поля: размер зарплаты ,
	форма зарплаты (почасовая, фиксированная)*/

CREATE TABLE[Salary](
							
	[SalaryID]			INT IDENTITY(0, 1),					
	[SalaryAmount]		INT																																		   NOT NULL,   
	[SalaryType]		NVARCHAR(20)
	CONSTRAINT FK_Salary_SalaryID PRIMARY KEY([SalaryID])
)
GO

/* Добавление данных в таблицу [TypeFunding] */
INSERT INTO [TypeFunding]([TypeFunding]) VALUES ('Периодический')
INSERT INTO [TypeFunding]([TypeFunding]) VALUES ('Разовый')

/* Добавление данных в таблицу [Salary] */
INSERT INTO [Salary]([SalaryAmount], [SalaryType]) VALUES (300, 'Почасовая')
INSERT INTO [Salary]([SalaryAmount], [SalaryType]) VALUES (30000, 'Фиксированная')

/* Удаление данных из таблицы [TypeFunding] | Удаляется одна строка, у которой ID равен 2 */
DELETE [TypeFunding]
WHERE [TypeFundingID] = 2

/* Редактирование данных в таблице [AdditionalInformation] |  */
UPDATE [AdditionalInformation]
SET Funding = Funding + 100

/* Выборка данных | В данной выборке мы получаем данные поля "размера финансирования"  */
SELECT Funding  FROM [AdditionalInformation]

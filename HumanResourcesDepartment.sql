/* ������� ���������� |  ����� ������ � ����������� ��������� �������� */
CREATE DATABASE [HumanResourcesDepartment]
GO

/* ����������� ���������� */
USE [HumanResourcesDepartment]
GO

/*�������  "����������"
---------------------------
	����: ���������� ������,
	����������, 
	���. � ���. ��������, 
	��� ������,
	������(�), 
	�������� */

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

/*�������  "���������� ������"
---------------------------
	����: ���,
	�����, 
	�����,
	��� �������*/

CREATE TABLE[PassportData](

	[PassportDataID]	INT IDENTITY(0, 1),
	[FIO]				NVARCHAR(50)																														    NOT NULL,
	[Number]			INT																																	    NOT NULL,
	[Series]			INT																																   	    NOT NULL,
	[Issued]			NVARCHAR(50)																														    NOT NULL,
	CONSTRAINT PK_PassportData_PassportDataID PRIMARY KEY([PassportDataID])
)
GO

/*�������  "������ ���������"
---------------------------
	����: ����� ��������, 
	����� ��������_2,
	������� ����� ��������*/

CREATE TABLE[Phone](

	[PhoneID]			INT IDENTITY(0, 1),	
	[PhoneNumber]		INT																																	     NOT NULL,
	[PhoneNumberTwo]	INT,
	[WorkPhoneNumber]	INT																																		 NOT NULL,
	CONSTRAINT PK_PHONE_PhoneID PRIMARY KEY([PhoneID])

)
GO

/*�������  "�����"
---------------------------
	����: ��������, 
	�������,
	����� ��������,
	������������,
	������ ��������������,
	����� �����������*/

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

/*�������  "������"
--------------------------------------------
	����: ����(������� �������� ���������), 
	��� ������(������� ��������� ���������),
	������*/

CREATE TABLE[Work](
	
	[WorkID]			INT IDENTITY(0, 1),	
	[Post]				NVARCHAR(30)																															   NOT NULL,
	[TypeWork]			NVARCHAR(30)																															   NOT NULL,
	[Task]				NVARCHAR(30)																															   NOT NULL,
	CONSTRAINT FK_Work_WorkID PRIMARY KEY([WorkID])	
)
GO

/*�������  "������"
---------------------------
	����: ��������, 
	���� ������, 
	���� ���������,
	��� �������*/

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

/*�������  "���.���������� � �������"
---------------------------
	����: ��������,
	������ �������,
	������ ��������,
	������ ��������������,
	��� ��������������*/

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

/*�������  "��� ��������������"
-----------------------------------------------------
	����: ��� �������������� (�������������, �������) */

CREATE TABLE[TypeFunding](
							
	[TypeFundingID]		INT IDENTITY(0, 1),					
	[TypeFunding]		NVARCHAR(30)																															   NOT NULL,   
	CONSTRAINT FK_TypeFunding_TypeFundingID PRIMARY KEY([TypeFundingID])
)
GO

/*�������  "���������� �����"
---------------------------------------------
	����: ������ �������� ,
	����� �������� (���������, �������������)*/

CREATE TABLE[Salary](
							
	[SalaryID]			INT IDENTITY(0, 1),					
	[SalaryAmount]		INT																																		   NOT NULL,   
	[SalaryType]		NVARCHAR(20)
	CONSTRAINT FK_Salary_SalaryID PRIMARY KEY([SalaryID])
)
GO

/* ���������� ������ � ������� [TypeFunding] */
INSERT INTO [TypeFunding]([TypeFunding]) VALUES ('�������������')
INSERT INTO [TypeFunding]([TypeFunding]) VALUES ('�������')

/* ���������� ������ � ������� [Salary] */
INSERT INTO [Salary]([SalaryAmount], [SalaryType]) VALUES (300, '���������')
INSERT INTO [Salary]([SalaryAmount], [SalaryType]) VALUES (30000, '�������������')

/* �������� ������ �� ������� [TypeFunding] | ��������� ���� ������, � ������� ID ����� 2 */
DELETE [TypeFunding]
WHERE [TypeFundingID] = 2

/* �������������� ������ � ������� [AdditionalInformation] |  */
UPDATE [AdditionalInformation]
SET Funding = Funding + 100

/* ������� ������ | � ������ ������� �� �������� ������ ���� "������� ��������������"  */
SELECT Funding  FROM [AdditionalInformation]

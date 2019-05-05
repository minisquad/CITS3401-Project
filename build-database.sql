/*
SQL Script for building the database 'PetAdoption'

Authors: Bruce How (22242664) & Haolin Wu (21706137)
*/

USE master
GO

IF EXISTS (SELECT [name] FROM [master].[sys].[databases] WHERE [name] = N'PetAdoption')
DROP DATABASE PetAdoption;
PRINT CHAR(13) + CHAR(10) + 'DROPPED EXISTING DATABASE';
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING NEW DATABASE';
GO

CREATE DATABASE PetAdoption;
GO

USE PetAdoption;
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimBreed';
GO

CREATE TABLE DimBreed (
	BreedID INT PRIMARY KEY IDENTITY,
	PrimaryBreed INT NOT NULL,
	SecondaryBreed INT
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimBreedLabels';
GO

CREATE TABLE DimBreedLabels (
	BreedLabelID INT PRIMARY KEY IDENTITY,
	BreedName VARCHAR(100)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimColor';
GO

CREATE TABLE DimColor (
	ColorID INT PRIMARY KEY IDENTITY,
	PrimaryColor INT NOT NULL,
	SecondaryColor INT,
	TertiaryColor INT
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimColorLabels';
GO

CREATE TABLE DimColorLabels (
	ColorLabelID INT PRIMARY KEY IDENTITY,
	ColorName VARCHAR(10) NOT NULL
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimLocation';
GO

CREATE TABLE DimLocation (
	LocationID INT PRIMARY KEY IDENTITY,
	State INT
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimState';
GO

CREATE TABLE DimState (
	StateID INT PRIMARY KEY IDENTITY,
	State VARCHAR(100) NOT NULL
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimGender';
GO

CREATE TABLE DimGender (
	GenderID INT PRIMARY KEY IDENTITY,
	Gender VARCHAR(10) NOT NULL
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimType';
GO

CREATE TABLE DimType (
	TypeID INT PRIMARY KEY IDENTITY,
	Type VARCHAR(10) NOT NULL
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimAge';
GO

CREATE TABLE DimAge (
	AgeID INT PRIMARY KEY IDENTITY,
	Months INT NOT NULL,
	Years INT
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimMaturitySize';
GO

CREATE TABLE DimMaturitySize (
	MaturitySizeID INT PRIMARY KEY IDENTITY,
	MaturitySize VARCHAR(13)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimFurLength';
GO

CREATE TABLE DimFurLength (
	FurLengthID INT PRIMARY KEY IDENTITY,
	FurLength VARCHAR(13)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimVaccinated';
GO

CREATE TABLE DimVaccinated (
	VaccinatedID INT PRIMARY KEY IDENTITY,
	Vaccinated VARCHAR(8)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimDewormed';
GO

CREATE TABLE DimDewormed (
	DewormedID INT PRIMARY KEY IDENTITY,
	Dewormed VARCHAR(8)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimSterilized';
GO

CREATE TABLE DimSterilized (
	SterilizedID INT PRIMARY KEY IDENTITY,
	Sterilized VARCHAR(8)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimHealth';
GO

CREATE TABLE DimHealth (
	HealthID INT PRIMARY KEY IDENTITY,
	Health VARCHAR(14)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE DimRescuer';
GO

CREATE TABLE DimRescuer (
	RescuerID INT PRIMARY KEY IDENTITY,
	Rescuer VARCHAR(32)
);
GO

PRINT CHAR(13) + CHAR(10) + 'CREATING TABLE FactPetAdoptionRate';
GO

CREATE TABLE FactPetAdoptionSpeed (
	PetID INT PRIMARY KEY IDENTITY,
	PetAltID VARCHAR(9),
	BreedID INT,
	ColorID INT,
	TypeID INT,
	GenderID INT,
	AgeID INT,
	LocationID INT,
	MaturitySizeID INT,
	FurLengthID INT,
	VaccinatedID INT,
	DewormedID INT,
	SterilizedID INT,
	HealthID INT,
	RescuerID INT,
	VideoAmt INT,
	PhotoAmt INT,
	Fee INT,
	AdoptionSpeed INT
);
GO

PRINT CHAR(13) + CHAR(10) + 'ADDING DIM CONSTRAINTS';
GO

ALTER TABLE DimBreed ADD
CONSTRAINT FK_PrimaryBreed FOREIGN KEY (PrimaryBreed) REFERENCES DimBreedLabels(BreedLabelID),
CONSTRAINT FK_SecondaryBreed FOREIGN KEY (SecondaryBreed) REFERENCES DimBreedLabels(BreedLabelID);

ALTER TABLE DimColor ADD
CONSTRAINT FK_PrimaryColor FOREIGN KEY (PrimaryColor) REFERENCES DimColorLabels(ColorLabelID),
CONSTRAINT FK_SecondaryColor FOREIGN KEY (SecondaryColor) REFERENCES DimColorLabels(ColorLabelID),
CONSTRAINT FK_TertiaryColor FOREIGN KEY (TertiaryColor) REFERENCES DimColorLabels(ColorLabelID);

ALTER TABLE DimLocation ADD
CONSTRAINT FK_State FOREIGN KEY (State) REFERENCES DimState(StateID);
GO

PRINT CHAR(13) + CHAR(10) + 'ADDING DIM FACT RELATION CONSTRAINTS';
GO

ALTER TABLE FactPetAdoptionSpeed ADD
CONSTRAINT FK_BreedID FOREIGN KEY (BreedID) REFERENCES DimBreed(BreedID),
CONSTRAINT FK_ColorID FOREIGN KEY (ColorID) REFERENCES DimColor(ColorID),
CONSTRAINT FK_TypeID FOREIGN KEY (TypeID) REFERENCES DimType(TypeID),
CONSTRAINT FK_GenderID FOREIGN KEY (GenderID) REFERENCES DimGender(GenderID),
CONSTRAINT FK_AgeID FOREIGN KEY (AgeID) REFERENCES DimAge(AgeID),
CONSTRAINT FK_LocationID FOREIGN KEY (LocationID) REFERENCES DimLocation(LocationID),
CONSTRAINT FK_MaturitySizeID FOREIGN KEY (MaturitySizeID) REFERENCES DimMaturitySize(MaturitySizeID),
CONSTRAINT FK_FurLengthID FOREIGN KEY (FurLengthID) REFERENCES DimFurLength(FurLengthID),
CONSTRAINT FK_VaccinatedID FOREIGN KEY (VaccinatedID) REFERENCES DimVaccinated(VaccinatedID),
CONSTRAINT FK_DewormedID FOREIGN KEY (DewormedID) REFERENCES DimDewormed(DewormedID),
CONSTRAINT FK_SterilizedID FOREIGN KEY (SterilizedID) REFERENCES DimSterilized(SterilizedID),
CONSTRAINT FK_HealthID FOREIGN KEY (HealthID) REFERENCES DimHealth(HealthID),
CONSTRAINT FK_RescuerID FOREIGN KEY (RescuerID) REFERENCES DimRescuer(RescuerID);

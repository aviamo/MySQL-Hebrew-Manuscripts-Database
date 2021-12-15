CREATE DATABASE Checkpoint charset hebrew;
USE Checkpoint;

CREATE TABLE IF NOT EXISTS tblManuscriptTitles(
	ManuscriptTitleID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptTitle VARCHAR(100) NOT NULL,
    ManuscriptHTitle VARCHAR(100)
    );
    
CREATE INDEX ManuscriptTitle_index ON tblManuscriptTitles (ManuscriptTitle);
CREATE INDEX ManuscriptHTitle_index ON tblManuscriptTitles (ManuscriptHTitle);

CREATE TABLE IF NOT EXISTS tblAuthors(
	AuthorID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    AuthorFName VARCHAR(50) NOT NULL,
	AuthorLName	VARCHAR(50),
    AuthorHFName VARCHAR(50),
    AuthorHLName VARCHAR(50)
    );
CREATE INDEX AuthorFName_index ON tblAuthors(AuthorFName);
CREATE INDEX AuthorLName_index ON tblAuthors(AuthorLName);
CREATE INDEX AuthorHFName_index ON tblAuthors(AuthorHFName);
CREATE INDEX AuthorHLName_index ON tblAuthors(AuthorHLName);

CREATE TABLE IF NOT EXISTS tblManuscriptDates(
	ManuscriptDateID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptDate INTEGER NOT NULL
    );

CREATE TABLE IF NOT EXISTS tblLanguages(
	LanguageID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    LanguageName VARCHAR(50) NOT NULL UNIQUE
    );

CREATE INDEX LanguageName_index ON tblLanguages(LanguageName);

CREATE TABLE IF NOT EXISTS tblScribes(
	ScribeID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ScribeFName VARCHAR(50) NOT NULL,
    ScribeLName VARCHAR(50),
    ScribeHFName VARCHAR(50),
    ScribeHLName VARCHAR(50)
    );

CREATE INDEX ScribeFName_index ON tblScribes(ScribeFName);
CREATE INDEX ScribeLName_index ON tblScribes(ScribeLName);
CREATE INDEX ScribeHFName_index ON tblScribes(ScribeHFName);
CREATE INDEX ScribeHLName_index ON tblScribes(ScribeHLName);

CREATE TABLE IF NOT EXISTS tblMaterials(
	MaterialID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    MaterialName VARCHAR(50) NOT NULL UNIQUE
    );

CREATE INDEX MaterialName_index ON tblMaterials(MaterialName);

CREATE TABLE IF NOT EXISTS tblManuscripts(
	ManuscriptID INTEGER NOT NULL UNIQUE PRIMARY KEY,
	ManuscriptTitle	INTEGER NOT NULL,
    ManuscriptAuthor INTEGER,
    ManuscriptContent TINYTEXT,
    ManuscriptNotes TEXT,
    ManuscriptDate INTEGER,
    ManuscriptScribes INTEGER,
    ManuscriptMaterialAge INTEGER NOT NULL,
    FOREIGN KEY ManuscriptTitle_tblManuscriptsFK (ManuscriptTitle) REFERENCES tblManuscriptTitles(ManuscriptTitleID),
    FOREIGN KEY ManuscriptAuthor_tblManuscriptsFK (ManuscriptAuthor) REFERENCES tblAuthors(AuthorID),
    FOREIGN KEY ManuscriptDate_tblManuscriptsFK (ManuscriptDate) REFERENCES tblManuscriptDates(ManuscriptDateID),
    FOREIGN KEY ManuscriptScribes_tblManuscriptsFK (ManuscriptScribes) REFERENCES tblScribes(ScribeID)
    );
    
CREATE TABLE IF NOT EXISTS tblManuscriptLanguages(
	ManuscriptLanguageID INTEGER NOT NULL UNIQUE PRIMARY KEY,
	ManuscriptID INTEGER,
	LanguageID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptLanguagesFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY LanguageID_tblManuscriptLanguagesFK (LanguageID) REFERENCES tblLanguages(LanguageID)
	);

CREATE TABLE IF NOT EXISTS tblManuscriptMaterials(
	ManuscriptMaterialID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptID INTEGER,
    MaterialID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptMaterialsFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY MaterialID_tblManuscriptMaterialsFK (MaterialID) REFERENCES tblMaterials(MaterialID)
    );


CREATE TABLE IF NOT EXISTS tblConditions(
	ConditionID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ConditionName VARCHAR(50) NOT NULL UNIQUE
    );

CREATE INDEX ConditionName_index ON tblConditions(ConditionName);

CREATE TABLE IF NOT EXISTS tblManuscriptConditions(
	ManuscriptConditionID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptID INTEGER,
    ConditionID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptConditionsFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY ConditionID_tblManuscriptConditionsFK (ConditionID) REFERENCES tblConditions(ConditionID)
    );

CREATE TABLE IF NOT EXISTS tblCompleteness(
	CompletenessID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    CompletenessStatus VARCHAR(50) NOT NULL UNIQUE
    );
    
CREATE INDEX CompletenessStatus_index ON tblCompleteness(CompletenessStatus);
    
CREATE TABLE IF NOT EXISTS tblManuscriptCompleteness(
	ManuscriptCompletenessID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptID INTEGER,
    CompletenessID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptCompletenessFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY CompletenessID_tblManuscriptCompletenessFK (CompletenessID) REFERENCES tblCompleteness(CompletenessID) 
	);
    
CREATE TABLE IF NOT EXISTS tblScripts(
	ScriptID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ScriptName VARCHAR(50) NOT NULL UNIQUE
    );
    
CREATE INDEX ScriptName_index ON tblScripts(ScriptName);

CREATE TABLE IF NOT EXISTS tblManuscriptScripts(
	ManuscriptScriptID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptID INTEGER,
    ScriptID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptScriptsFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY ScriptID_tblManuscriptScriptsFK (ScriptID) REFERENCES tblScripts(ScriptID)
    );

CREATE TABLE IF NOT EXISTS tblProvenances(
	ProvenanceID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ProvenanceName VARCHAR(50) NOT NULL UNIQUE
    );
    
CREATE INDEX ProvenanceName_index ON tblProvenances(ProvenanceName);

CREATE TABLE IF NOT EXISTS tblManuscriptProvenances(
	ManuscriptProvenanceID INTEGER NOT NULL UNIQUE PRIMARY KEY,
    ManuscriptID INTEGER,
    ProvenanceID INTEGER,
    FOREIGN KEY ManuscriptID_tblManuscriptProvenancesFK (ManuscriptID) REFERENCES tblManuscripts(ManuscriptID),
    FOREIGN KEY ProvenanceID_tblManuscriptProvenancesFK (ProvenanceID) REFERENCES tblProvenances(ProvenanceID)
    );



    



    
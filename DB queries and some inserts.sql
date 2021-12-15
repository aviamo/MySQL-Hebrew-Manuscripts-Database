CREATE DATABASE Checkpoint2 charset hebrew;
USE Checkpoint2;

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
AuthorLName VARCHAR(50),
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
MaterialName VARCHAR(100) NOT NULL UNIQUE
);

CREATE INDEX MaterialName_index ON tblMaterials(MaterialName);

CREATE TABLE IF NOT EXISTS tblManuscripts(
ManuscriptID INTEGER NOT NULL UNIQUE PRIMARY KEY,
ManuscriptTitle INTEGER NOT NULL,
ManuscriptAuthor INTEGER,
ManuscriptContent TINYTEXT,
ManuscriptNotes TEXT,
ManuscriptDate INTEGER,
ManuscriptScribes INTEGER,
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
ConditionName VARCHAR(100) NOT NULL UNIQUE
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


INSERT INTO tblAuthors VALUES
('1', 'Menahem ben Saruq', '', 'מנחם בן יעקב', 'אבן סרוק'),
('2', 'Rashi', '', 'שלמה בן יצחק', 'רש\"י'),
('3', 'Moses', 'Maimonides', 'משה בן מימון', 'רמב\"ם'),
('4', 'Judah ben Solomon', 'Harizi', 'יהודה בן שלמה', 'חריזי'),
('5', 'Jehiel ben Jekuthiel ben Benjamin', 'Anav', 'יחיאל בן יקותיאל', 'הרופא'),
('6', 'Yehudah ben Mosheh', 'al-Butini', 'יהודה בן משה', 'אלבוטוני'),
('7', 'Samson ben Zadok', '', 'שמשון בן צדוק', ''),
('8', 'Asher ben Jehiel', '', 'אשר בן יחיאל', ''),
('9', 'Tanhum ben Yosef', 'ha-Yerushalmi', 'תנחום בן יוסף', 'הירושלמי‏'),
('10', 'Nathanael ben Isaiah', '', 'נתנאל בן ישעיהו', '')
;

INSERT INTO tblCompleteness VALUES 
('1', 'Complete'),
('2', 'Lacuna'),
('3', 'Incomplete at beginning'),
('4', 'Incomplete at end'),
('5', 'Pages mutilated'),
('6', 'Loss of text'),
('7', 'Leaves missing'),
('8', 'Gaps'),
('9', 'Losses to rust from clasps of earlier binding'),
('10', 'Several lacunae')
;

INSERT INTO tblConditions VALUES 
('1', 'much damaged'),
('2', 'worm-eaten'),
('3', 'usage stains'),
('4', 'slightly stained'),
('5', 'damp at edges, mostly repaired and infilled before rebinding'),
('6', 'wormed'),
('7', 'much damaged in the margins'),
('8', 'stainded'),
('9', 'some folios partly stained'),
('10', 'slight traces of worming')
;

INSERT INTO tblLanguages VALUES
('1', 'Hebrew'),
('2', 'Judeo-Arabic'),
('3', 'Aramaic'),
('4', 'Judeo-Persian'),
('5', 'Aramaic of the Zohar'),
('6', 'French'),
('7', 'Ladino'),
('8', 'German'),
('9', 'Arabic'),
('10', 'Yiddish')
;

INSERT INTO tblMaterials VALUES
('1', 'Paper'),
('2', 'Parchment'),
('3', 'Paper codex'),
('4', 'Parchment codex'),
('5', 'Leather'),
('6', 'Red leather'),
('7', 'Parchment codex with many damaged pages repaired with paper'),
('8', 'Oriental paper'),
('9', 'Mixed paper and vellum')
;

INSERT INTO tblProvenances VALUES
('1', 'Italy'),
('2', 'Irak'),
('3', 'Baghdad'),
('4', 'Italy, Central'),
('5', 'Viterbo'),
('6', 'Unknown'),
('7', 'Rome'),
('8', 'France'),
('9', 'Yemen'),
('10', 'Spain, Central')
;

INSERT INTO tblScribes VALUES
('1', 'Avraham ben Hasdai', 'of Perpignan', 'אברהם בכמ\"ר חסדאי', 'מפירפניאן'),
('2', 'Eliyahu', '', '', ''),
('3', 'Shem Tov ben Shemu\'el Barukh', '', 'שם טוב בר\' שמואל ברוך', ''),
('4', 'Mahpots ibn Ma\'ots', '', '', ''),
('5', 'Rafa\'el', '', '', ''),
('6', 'Hayim ben Mikha\'el', '', 'חיים בכמ\"ר מיכאל', ''),
('7', 'Yosef bar Avraham', 'Pereir', 'יוסף בר אברהם', 'פריר'),
('8', 'Yosef', '', 'יחיאל ח\"י הסופר בכ\"ר יואב כת\"ב ע\"ה מביתאל', ''),
('9', 'Avraham ben Shemu\'el', 'Fi\'avi', 'אברהם בר\' שמואל', 'פיאבי'),
('10', 'Shelomoh ben Mosheh ben Shelomoh ha-Rofe\'', '', 'שלמה הצעיר ונח\"ל בכאמ\"ר משה ישר\"ו בכמ\"ר שלמה הרופא', '')
;

INSERT INTO tblScripts VALUES 
('1', 'Arabic'),
('2', 'Italian'),
('3', 'square'),
('4', 'Oriental'),
('5', 'semi-cursive'),
('6', 'unpunctuated'),
('7', 'cursive'),
('8', 'Sefardi'),
('9', 'Ashkenazi'),
('10', 'French')
;

INSERT INTO tblManuscriptTitles VALUES
('1', 'Makalah 5', ''),
('2', 'Mahberet', 'מחברת'),
('3', 'Perush Bava metsi\'a', 'פירוש בבא מציעא'),
('4', 'More nevukhim', 'מורה נבוכים'),
('5', 'Tahkemoni', 'תחכמוני'),
('6', 'Sefer ma\'alot ha-midot', 'ספר מעלות המדות'),
('7', 'Mahzor', 'מחזור'),
('8', 'Nevi\'im', 'נביאים'),
('9', 'Sefer yesod [Mishneh Torah]', 'ספר יסוד [משנה תורה]'),
('10', 'Mishneh Torah', 'משנה תורה')
;

INSERT INTO tblManuscriptDates VALUES
('1', '1024'),
('2', '1091'),
('3', '1192'),
('4', '1273'),
('5', '1282'),
('6', '1283'),
('7', '1287'),
('8', '1291'),
('9', '1293'),
('10', '1295')
;

INSERT INTO tblManuscripts VALUES
('1', '1', NULL, 'A large fragment of Karaite Sefer ha-mitsvot.', 'Contains parts of Makalah 5, treating on forbidden degrees in marriage. Hebrew quotations are also in Arabic characters.', '1', NULL),
('2', '2', '1', 'The Hebrew dictionary, with a commentary.', NULL, '2', NULL),
('3', '3', '2', 'Rashi\'s commentary on Bava metsi\'a (a fragment).', NULL, '3', NULL),
('4', '4', '3', 'Philosophical writings.', 'In the Hebrew translation of Shemuel ibn Tibbon, preceded by the translator\'s introduction and the epistle of Maimonides to Yosef ibn Aknin. The work itself begins on folio 10r.', '4', '11'),
('5', '5', '4', 'Poetical writings.', 'Folios 1-2 contain, in a later hand, a complete index giving the subject of the fifty Makamat in Hebrew. The Arabic table of contents occupies folios 3-4, but is defective atthe beginning.', '5', '12'),
('6', '6', '3', 'Philosophical writings.', 'In the Hebrew translation of Shemuel ibn Tibbon.\nSee page 231-342, page 298-299, page 131-150, page 125.', '6', '13'),
('7', '7', '5', 'Ethical writings.', 'A codicological comparison with other manuscripts written by Jehiel ben Jekuthiel shows that this manuscript is an autograph, a clean copy of his work written for Shelomoh ben Mosheh ben Yosef. See also page 51.', '7', '14'),
('8', '8', NULL, 'A festival prayer book, according to the (old) French rite.', NULL, '8', NULL),
('9', '9', NULL, 'Former and Latter Prophets, accentuated and punctuated.', NULL, '9', '15'),
('10', '10', '6', 'Sefer yesod [Mishneh Torah], a commentary on the first three books of Maimonides\' Mishneh Torah, by Yehudah ben Mosheh al-Butini.', NULL, '10', NULL)
;

INSERT INTO tblManuscriptCompleteness VALUES 
('1', '1', '11'),
('2', '1', '7'),
('3', '2', '3'),
('4', '3', '3'),
('5', '3', '4'),
('6', '3', '5'),
('7', '3', '6'),
('8', '8', '3'),
('9', '8', '10'),
('10', '8', '12')
;

INSERT INTO tblManuscriptConditions VALUES
('1', '1', '1'),
('2', '1', '2'),
('3', '2', '3'),
('4', '4', '4'),
('5', '5', '5'),
('6', '5', '6'),
('7', '6', '7'),
('8', '6', '8'),
('9', '7', '9'),
('10', '8', '8')
;


INSERT INTO tblManuscriptLanguages VALUES
('1', '1', '9'),
('2', '2', '1'),
('3', '3', '3'),
('4', '3', '1'),
('5', '4', '1'),
('6', '5', '1'),
('7', '6', '1'),
('8', '7', '1'),
('9', '8', '1'),
('10', '9', '1')
;

INSERT INTO tblManuscriptMaterials VALUES
('1', '1', '3'),
('2', '2', '4'),
('3', '3', '4'),
('4', '4', '4'),
('5', '5', '4'),
('6', '6', '3'),
('7', '7', '4'),
('8', '8', '4'),
('9', '9', '4'),
('10', '10', '4')
;

INSERT INTO tblManuscriptProvenances VALUES
('1', '2', '1'),
('2', '3', '2'),
('3', '3', '3'),
('4', '4', '4'),
('5', '4', '5'),
('6', '5', '6'),
('7', '6', '4'),
('8', '6', '7'),
('9', '7', '1'),
('10', '8', '1')
;

INSERT INTO tblManuscriptScripts VALUES
('1', '1', '1'),
('2', '2', '2'),
('3', '2', '3'),
('4', '3', '4'),
('5', '3', '5'),
('6', '3', '6'),
('7', '4', '2'),
('8', '4', '5'),
('9', '4', '6'),
('10', '4', '7')
;


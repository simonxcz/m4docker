-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/global.changelog-master.xml
-- Ran at: 24/12/19 16:13
-- Against: liquibase@jdbc:postgresql://localhost:5432/squash_dist_cur
-- Liquibase version: 2.0.5
-- *********************************************************************

-- Create Database Lock Table
CREATE TABLE databasechangeloglock (ID INT NOT NULL, LOCKED BOOLEAN NOT NULL, LOCKGRANTED TIMESTAMP WITH TIME ZONE, LOCKEDBY VARCHAR(255), CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

INSERT INTO databasechangeloglock (ID, LOCKED) VALUES (1, FALSE);

-- Lock Database
-- Create Database Change Log Table
CREATE TABLE databasechangelog (ID VARCHAR(63) NOT NULL, AUTHOR VARCHAR(63) NOT NULL, FILENAME VARCHAR(200) NOT NULL, DATEEXECUTED TIMESTAMP WITH TIME ZONE NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35), DESCRIPTION VARCHAR(255), COMMENTS VARCHAR(255), TAG VARCHAR(255), LIQUIBASE VARCHAR(20), CONSTRAINT PK_DATABASECHANGELOG PRIMARY KEY (ID, AUTHOR, FILENAME));

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/auth/auth.changelog-1.0.xml::1::gfouquet::(Checksum: 3:c3f1c8c5573dd761b4aa35d473b1db7d)
CREATE TABLE AUTH_USER (LOGIN VARCHAR(50) NOT NULL, PASSWORD CHAR(40) NOT NULL, ACTIVE BOOLEAN DEFAULT TRUE NOT NULL, CONSTRAINT PK_AUTH_USER PRIMARY KEY (LOGIN));

COMMENT ON TABLE AUTH_USER IS 'Stores users credentials';

COMMENT ON COLUMN AUTH_USER.LOGIN IS 'The user''s unique identifier';

COMMENT ON COLUMN AUTH_USER.PASSWORD IS 'SHA-1 hash of the user''s password';

CREATE UNIQUE INDEX IDX_AUTHENTICATION ON AUTH_USER(LOGIN);

INSERT INTO AUTH_USER (ACTIVE, LOGIN, PASSWORD) VALUES (TRUE, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Create Index, Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/auth/auth.changelog-1.0.xml', '1', '2.0.5', '3:c3f1c8c5573dd761b4aa35d473b1db7d', 1);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::1::gfouquet::(Checksum: 3:0827c56c3da3a248891d04c6f0ddb00e)
CREATE TABLE CORE_USER (ID bigserial NOT NULL, LOGIN VARCHAR(50) NOT NULL, FIRST_NAME VARCHAR(50) DEFAULT '' NOT NULL, LAST_NAME VARCHAR(50) DEFAULT '' NOT NULL, EMAIL VARCHAR(50) DEFAULT '' NOT NULL, ACTIVE BOOLEAN DEFAULT FALSE NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, CONSTRAINT PK_CORE_USER PRIMARY KEY (ID), CONSTRAINT CT_UNIQUE_USER_LOGIN UNIQUE (LOGIN));

COMMENT ON COLUMN CORE_USER.LOGIN IS 'The user''s login as provided by the authentication system';

COMMENT ON COLUMN CORE_USER.FIRST_NAME IS 'The user''s first name';

COMMENT ON COLUMN CORE_USER.LAST_NAME IS 'The user''s last name';

COMMENT ON COLUMN CORE_USER.EMAIL IS 'The user''s e-mail';

COMMENT ON COLUMN CORE_USER.ACTIVE IS 'User is active or not';

COMMENT ON COLUMN CORE_USER.CREATED_BY IS 'nom du createur de cet utilisateur.';

COMMENT ON COLUMN CORE_USER.CREATED_ON IS 'Date de creation de cet utilisateur. Il s''agit de la date de creation de l''entree dans       la base, non d''une date metier.';

COMMENT ON COLUMN CORE_USER.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN CORE_USER.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

CREATE UNIQUE INDEX DX_USER_LOGIN ON CORE_USER(LOGIN);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '1', '2.0.5', '3:0827c56c3da3a248891d04c6f0ddb00e', 2);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::2::gfouquet::(Checksum: 3:9cb7669efca04a3d97a7de885d0408fb)
CREATE TABLE CORE_GROUP (ID bigserial NOT NULL, QUALIFIED_NAME VARCHAR(255) NOT NULL, CONSTRAINT PK_CORE_GROUP PRIMARY KEY (ID), CONSTRAINT CT_UN_GRP_QUAL_NAME UNIQUE (QUALIFIED_NAME));

COMMENT ON COLUMN CORE_GROUP.QUALIFIED_NAME IS 'Qualified name of the group, both used as a functional key and a localization key. Should be something like ''squashtest.authz.group._app module_._GroupName_''';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '2', '2.0.5', '3:9cb7669efca04a3d97a7de885d0408fb', 3);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::3::gfouquet::(Checksum: 3:9f898022aa169e6e6fe3643d9a8536e0)
CREATE TABLE CORE_GROUP_AUTHORITY (GROUP_ID BIGINT NOT NULL, AUTHORITY VARCHAR(50) NOT NULL, CONSTRAINT FK_GRP_AUTH_GRP FOREIGN KEY (GROUP_ID) REFERENCES CORE_GROUP(ID));

COMMENT ON COLUMN CORE_GROUP_AUTHORITY.GROUP_ID IS 'Shared key with CORE_GROUP table';

COMMENT ON COLUMN CORE_GROUP_AUTHORITY.AUTHORITY IS 'The authority';

CREATE INDEX DX_GRP_ID ON CORE_GROUP_AUTHORITY(GROUP_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '3', '2.0.5', '3:9f898022aa169e6e6fe3643d9a8536e0', 4);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::4::gfouquet::(Checksum: 3:12d5a7ac46a1fc80f78b4abf1e2cbbc8)
CREATE TABLE CORE_GROUP_MEMBER (USER_ID BIGINT NOT NULL, GROUP_ID BIGINT NOT NULL, CONSTRAINT FK_GRP_MEMBER_USR FOREIGN KEY (USER_ID) REFERENCES CORE_USER(ID), CONSTRAINT FK_GRP_MEMBER_GRP FOREIGN KEY (GROUP_ID) REFERENCES CORE_GROUP(ID));

CREATE UNIQUE INDEX DX_GRP_MEMBER ON CORE_GROUP_MEMBER(USER_ID, GROUP_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '4', '2.0.5', '3:12d5a7ac46a1fc80f78b4abf1e2cbbc8', 5);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::5::gfouquet::(Checksum: 3:003d6da0a4bdceba7282faefe2e73525)
INSERT INTO CORE_GROUP (QUALIFIED_NAME) VALUES ('squashtest.authz.group.core.Admin');

INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_ADMIN', (select max(ID) from CORE_GROUP));

INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_USER', (select max(ID) from CORE_GROUP));

INSERT INTO CORE_USER (CREATED_BY, CREATED_ON, EMAIL, LAST_NAME, LOGIN) VALUES ('liquibase', CURRENT_TIMESTAMP, 'admin@squashtest.org', 'Squash Administrator', 'admin');

INSERT INTO CORE_GROUP_MEMBER (GROUP_ID, USER_ID) VALUES ((select max(ID) from CORE_GROUP), (select max(ID) from CORE_USER));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Insert Row (x5)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '5', '2.0.5', '3:003d6da0a4bdceba7282faefe2e73525', 6);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::7::gfouquet::(Checksum: 3:2872b424d0bf771cf612c1dc63533d84)
CREATE TABLE ACL_CLASS (ID bigserial NOT NULL, CLASSNAME VARCHAR(255) NOT NULL, CONSTRAINT PK_ACL_CLASS PRIMARY KEY (ID), CONSTRAINT CT_UN_CLASSNAME UNIQUE (CLASSNAME));

COMMENT ON COLUMN ACL_CLASS.CLASSNAME IS 'Fully qualified classname';

CREATE UNIQUE INDEX DX_CLASS_NAME ON ACL_CLASS(CLASSNAME);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '7', '2.0.5', '3:2872b424d0bf771cf612c1dc63533d84', 7);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::8::gfouquet::(Checksum: 3:2c5ed802f9f1885284157f65b772d4ae)
CREATE TABLE ACL_OBJECT_IDENTITY (ID bigserial NOT NULL, IDENTITY BIGINT NOT NULL, CLASS_ID BIGINT NOT NULL, CONSTRAINT PK_ACL_OBJECT_ID PRIMARY KEY (ID), CONSTRAINT FK_ACL_OBJ_ID_ACL_CLASS FOREIGN KEY (CLASS_ID) REFERENCES ACL_CLASS(ID));

COMMENT ON COLUMN ACL_OBJECT_IDENTITY.IDENTITY IS 'The id of the target entity';

ALTER TABLE ACL_OBJECT_IDENTITY ADD UNIQUE (IDENTITY, CLASS_ID);

CREATE INDEX DX_OBJ_ID_IDENTITY ON ACL_OBJECT_IDENTITY(IDENTITY);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Add Unique Constraint, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '8', '2.0.5', '3:2c5ed802f9f1885284157f65b772d4ae', 8);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::9::gfouquet::(Checksum: 3:14139425ec3263f63ca78174b6cfe960)
CREATE TABLE ACL_GROUP (ID bigserial NOT NULL, QUALIFIED_NAME VARCHAR(255) NOT NULL, CONSTRAINT PK_ACL_GRP PRIMARY KEY (ID), CONSTRAINT CT_UN_ACL_GRP_QUAL_NAME UNIQUE (QUALIFIED_NAME));

COMMENT ON COLUMN ACL_GROUP.QUALIFIED_NAME IS 'Group''s qualified name, both used as a functional key and a localization key. Should be something like ''squashtest.acl.group._app module_._GroupName_''';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '9', '2.0.5', '3:14139425ec3263f63ca78174b6cfe960', 9);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::10::gfouquet::(Checksum: 3:fcf338b8327512d052f48426bc2b2cd4)
CREATE TABLE ACL_GROUP_PERMISSION (ACL_GROUP_ID BIGINT NOT NULL, PERMISSION_MASK INT DEFAULT 0 NOT NULL, CLASS_ID BIGINT NOT NULL, PERMISSION_ORDER INT DEFAULT 0 NOT NULL, GRANTING BOOLEAN DEFAULT TRUE NOT NULL, CONSTRAINT FK_ACL_GRP_PERMISSION_ACL_GRP FOREIGN KEY (ACL_GROUP_ID) REFERENCES ACL_GROUP(ID), CONSTRAINT FK_SC_AUTH_ACL_CLASS FOREIGN KEY (CLASS_ID) REFERENCES ACL_CLASS(ID));

COMMENT ON COLUMN ACL_GROUP_PERMISSION.PERMISSION_MASK IS 'Mask of permissions as defined by spring security';

COMMENT ON COLUMN ACL_GROUP_PERMISSION.CLASS_ID IS 'The class to which the permissions apply';

ALTER TABLE ACL_GROUP_PERMISSION ADD CONSTRAINT PK_ACL_GRP_PERMISSION PRIMARY KEY (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table, Add Primary Key', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '10', '2.0.5', '3:fcf338b8327512d052f48426bc2b2cd4', 10);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml::11::gfouquet::(Checksum: 3:9ae257f0e06c96c6b7d52b475eb4af62)
CREATE TABLE ACL_RESPONSIBILITY_SCOPE_ENTRY (ID bigserial NOT NULL, USER_ID BIGINT NOT NULL, ACL_GROUP_ID BIGINT NOT NULL, OBJECT_IDENTITY_ID BIGINT NOT NULL, CONSTRAINT PK_RESP_SCOPE_ENTRY PRIMARY KEY (ID), CONSTRAINT FK_RESP_SCOPE_USER FOREIGN KEY (USER_ID) REFERENCES CORE_USER(ID), CONSTRAINT FK_RESP_SCOPE_ACL_GRP FOREIGN KEY (ACL_GROUP_ID) REFERENCES ACL_GROUP(ID), CONSTRAINT FK_RESP_SCOPE_OBJ_ID FOREIGN KEY (OBJECT_IDENTITY_ID) REFERENCES ACL_OBJECT_IDENTITY(ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.15.0.xml', '11', '2.0.5', '3:9ae257f0e06c96c6b7d52b475eb4af62', 11);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.20.0.xml::core-0.20.0.01::ramoussou::(Checksum: 3:80791e9849bdd487180343805c35b3e2)
-- Creation of a new table CORE_CONFIG containing Application configuration
CREATE TABLE CORE_CONFIG (STR_KEY VARCHAR(255) NOT NULL, VALUE TEXT, CONSTRAINT PK_CORE_CONFIG PRIMARY KEY (STR_KEY));

COMMENT ON COLUMN CORE_CONFIG.STR_KEY IS 'Configuration Key';

COMMENT ON COLUMN CORE_CONFIG.VALUE IS 'Configuration value';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', 'Creation of a new table CORE_CONFIG containing Application configuration', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.20.0.xml', 'core-0.20.0.01', '2.0.5', '3:80791e9849bdd487180343805c35b3e2', 12);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.20.0.xml::core-0.20.0.02::gfouquet::(Checksum: 3:b440864cd51c94293db4c375b14d73b4)
-- Default welcome message
insert into CORE_CONFIG (STR_KEY, VALUE) values ('WELCOME_MESSAGE', '<p><span style="color:#ff0000;">The administrator default login is <strong>admin/admin</strong> (you can change this password in the &quot;<em>My account (admin)</em>&quot; menu).</span></p><p>Go to the &quot;<em>Administration&quot;</em> menu (in the upper right corner) to create new users and projects, or change this default home message.</p><p>&nbsp;</p>');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Default welcome message', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-0.20.0.xml', 'core-0.20.0.02', '2.0.5', '3:b440864cd51c94293db4c375b14d73b4', 13);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-1.1.1.xml::core-1.1.1.RELEASE.01::mpagnon::(Checksum: 3:b32be3c4e5a9a4c1790c516c467fdcce)
-- Add new line in CORE_CONFIG for LOGIN_MESSAGE
insert into CORE_CONFIG (STR_KEY, VALUE) select 'LOGIN_MESSAGE', VALUE from CORE_CONFIG where STR_KEY = 'WELCOME_MESSAGE';

update CORE_CONFIG set VALUE = '1.1.1' where STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add new line in CORE_CONFIG for LOGIN_MESSAGE', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-1.1.1.xml', 'core-1.1.1.RELEASE.01', '2.0.5', '3:b32be3c4e5a9a4c1790c516c467fdcce', 14);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-1.4.0.xml::core-feat-327::mpagnon::(Checksum: 3:34782a78840d9958a93867752ac303e8)
-- Because admin was not active , need to make sure that all user active in auth_user are active in core_user
update CORE_USER
					set ACTIVE = true
					where CORE_USER.LOGIN in (select AUTH_USER.LOGIN from AUTH_USER where AUTH_USER.ACTIVE = true);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Because admin was not active , need to make sure that all user active in auth_user are active in core_user', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/core/core.changelog-1.4.0.xml', 'core-feat-327', '2.0.5', '3:34782a78840d9958a93867752ac303e8', 15);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.01::bsiri::(Checksum: 3:4e6c3f9dea5db7ce08cde70ffee4b555)
-- This table maintains the mapping between an issue in Squash and an 
-- 			issue in the remote bugtracker
CREATE TABLE ISSUE (ISSUE_ID bigserial NOT NULL, REMOTE_ISSUE_ID VARCHAR(255) NOT NULL, CONSTRAINT PK_ISSUE PRIMARY KEY (ISSUE_ID));

COMMENT ON COLUMN ISSUE.REMOTE_ISSUE_ID IS 'considering the different types    a bugtracker may use for its own primary keys, we use here a varchar type as it is generic enough';

CREATE INDEX idx_issue ON ISSUE(ISSUE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This table maintains the mapping between an issue in Squash and an 
			issue in the remote bugtracker', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.01', '2.0.5', '3:4e6c3f9dea5db7ce08cde70ffee4b555', 16);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.02::bsiri::(Checksum: 3:4923e5c1de211cad8c0f4b3c771c81af)
-- each Squash entity that may be attached to one or several bugs will be given an issue list. This table will maintain that list, an entry means that some entity refering to it have several.
CREATE TABLE ISSUE_LIST (ISSUE_LIST_ID bigserial NOT NULL, CONSTRAINT PK_ISSUE_LIST PRIMARY KEY (ISSUE_LIST_ID));

CREATE INDEX idx_issue_list ON ISSUE_LIST(ISSUE_LIST_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'each Squash entity that may be attached to one or several bugs will be given an issue list. This table will maintain that list, an entry means that some entity refering to it have several.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.02', '2.0.5', '3:4923e5c1de211cad8c0f4b3c771c81af', 17);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.03::bsiri::(Checksum: 3:cf1b8733816e62e4fd608d629a0db0a0)
-- This table will map one issue_list to (0,several) issues
CREATE TABLE ISSUE_LIST_CONTENT (ISSUE_LIST_ID BIGINT NOT NULL, ISSUE_ID BIGINT NOT NULL, CONSTRAINT fk_list_issue_issue FOREIGN KEY (ISSUE_ID) REFERENCES ISSUE(ISSUE_ID), CONSTRAINT fk_list_issue_list FOREIGN KEY (ISSUE_LIST_ID) REFERENCES ISSUE_LIST(ISSUE_LIST_ID));

COMMENT ON COLUMN ISSUE_LIST_CONTENT.ISSUE_LIST_ID IS 'fk to the issue list';

COMMENT ON COLUMN ISSUE_LIST_CONTENT.ISSUE_ID IS 'fk to an issue';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This table will map one issue_list to (0,several) issues', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.03', '2.0.5', '3:cf1b8733816e62e4fd608d629a0db0a0', 18);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.04-pg::gfouquet::(Checksum: 3:f5c52b72f100c6f1147111174540e360)
-- Cette table contient le contenu d'une pièce jointe, dont les meta infos sont stockees dans la 
--       table ATTACHMENT. La relation entre les deux tables est 1-1
CREATE TABLE ATTACHMENT_CONTENT (ATTACHMENT_CONTENT_ID bigserial NOT NULL, STREAM_CONTENT OID DEFAULT NULL, CONSTRAINT PK_ATTACHMENT_CONTENT PRIMARY KEY (ATTACHMENT_CONTENT_ID));

COMMENT ON COLUMN ATTACHMENT_CONTENT.ATTACHMENT_CONTENT_ID IS 'clé primaire du contenu de la piece jointe. Devrait être autogénérée.';

COMMENT ON COLUMN ATTACHMENT_CONTENT.STREAM_CONTENT IS 'Le contenu de la piece jointe.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Cette table contient le contenu d''une pièce jointe, dont les meta infos sont stockees dans la 
      table ATTACHMENT. La relation entre les deux tables est 1-1', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.04-pg', '2.0.5', '3:f5c52b72f100c6f1147111174540e360', 19);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.05::bsiri::(Checksum: 3:c3a74f53f543266e9664ced59749936d)
-- Cette table stockera les pieces jointes. La piece elle même est un blob stocke a part dans
-- 					la table ATTACHMENT_CONTENT. La relation entre les deux tables est 1-1
CREATE TABLE ATTACHMENT (ATTACHMENT_ID bigserial NOT NULL, NAME VARCHAR(255) NOT NULL, TYPE VARCHAR(10) NOT NULL, SIZE BIGINT NOT NULL, ADDED_ON TIMESTAMP WITH TIME ZONE NOT NULL, CONTENT_ID BIGINT, CONSTRAINT PK_ATTACHMENT PRIMARY KEY (ATTACHMENT_ID), CONSTRAINT fk_attachment_content FOREIGN KEY (CONTENT_ID) REFERENCES ATTACHMENT_CONTENT(ATTACHMENT_CONTENT_ID));

COMMENT ON COLUMN ATTACHMENT.ATTACHMENT_ID IS 'clé primaire de la piece jointe. Devrait être autogénérée.';

COMMENT ON COLUMN ATTACHMENT.NAME IS 'nom de la piece jointe';

COMMENT ON COLUMN ATTACHMENT.TYPE IS 'type de la piece jointe. Cette information pourrait etre trivialement deduite du nom de fichier';

COMMENT ON COLUMN ATTACHMENT.SIZE IS 'taille de la piece jointe en octet. Cette information est déterminée au moment de l''upload et doit etre fournie a la base     dès sa création';

COMMENT ON COLUMN ATTACHMENT.ADDED_ON IS 'Date de l''ajout de la piece jointe.';

COMMENT ON COLUMN ATTACHMENT.CONTENT_ID IS 'cle etrangere vers la table ATTACHMENT_CONTENT';

CREATE INDEX idx_attachment ON ATTACHMENT(ATTACHMENT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table stockera les pieces jointes. La piece elle même est un blob stocke a part dans
					la table ATTACHMENT_CONTENT. La relation entre les deux tables est 1-1', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.05', '2.0.5', '3:c3a74f53f543266e9664ced59749936d', 20);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.06::bsiri::(Checksum: 3:91e399d585df7a01de44b11c56ccc4b4)
-- Cette table matérialise une liste d'ATTACHMENT. Bien qu'elle ne contienne que sa clé primaire, 
-- 			sa raison d'exister est, au niveau de l'application, de fournir 'd'un point de vue technique) 
-- 			une entité indépendante des entités métier auquel on rajoute les pièces jointes (d'un point de vue métier).
CREATE TABLE ATTACHMENT_LIST (ATTACHMENT_LIST_ID bigserial NOT NULL, CONSTRAINT PK_ATTACHMENT_LIST PRIMARY KEY (ATTACHMENT_LIST_ID));

COMMENT ON COLUMN ATTACHMENT_LIST.ATTACHMENT_LIST_ID IS 'clé primaire, devrait être autogénérée.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table matérialise une liste d''ATTACHMENT. Bien qu''elle ne contienne que sa clé primaire, 
			sa raison d''exister est, au niveau de l''application, de fournir ''d''un point de vue technique) 
			une entité indépendante des entités métier auquel on ra...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.06', '2.0.5', '3:91e399d585df7a01de44b11c56ccc4b4', 21);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.07::bsiri::(Checksum: 3:5aafdf5b488ea626d85ef782959884d0)
-- Table d'association entre un cas de test et ses pieces jointes
CREATE TABLE ATTACHMENT_LIST_CONTENT (AL_ID BIGINT NOT NULL, ATTACHMENT_ID BIGINT NOT NULL, CONSTRAINT fk_list_attachment_attachment FOREIGN KEY (ATTACHMENT_ID) REFERENCES ATTACHMENT(ATTACHMENT_ID), CONSTRAINT fk_list_attachment_list FOREIGN KEY (AL_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN ATTACHMENT_LIST_CONTENT.AL_ID IS 'clé étrangère vers ATTACHMENT_LIST.';

COMMENT ON COLUMN ATTACHMENT_LIST_CONTENT.ATTACHMENT_ID IS 'clé étrangère vers la table ATTACHMENT';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Table d''association entre un cas de test et ses pieces jointes', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.07', '2.0.5', '3:5aafdf5b488ea626d85ef782959884d0', 22);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.08::ramoussou::(Checksum: 3:10f6bb98e3ad8c7688581c2434dc5596)
-- Table representant les projets englobants les libraries d'entite que nous utilisons.
CREATE TABLE PROJECT (PROJECT_ID bigserial NOT NULL, NAME VARCHAR(255) NOT NULL, DESCRIPTION TEXT, LABEL VARCHAR(255), ACTIVE BOOLEAN DEFAULT TRUE NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CL_ID BIGINT, TCL_ID BIGINT, RL_ID BIGINT, CONSTRAINT PK_PROJECT PRIMARY KEY (PROJECT_ID));

COMMENT ON COLUMN PROJECT.PROJECT_ID IS 'cle primaire de la table';

COMMENT ON COLUMN PROJECT.NAME IS 'nom du projet';

COMMENT ON COLUMN PROJECT.DESCRIPTION IS 'description du projet';

COMMENT ON COLUMN PROJECT.LABEL IS 'Label du projet';

COMMENT ON COLUMN PROJECT.ACTIVE IS 'si le projet est actif ou non';

COMMENT ON COLUMN PROJECT.CREATED_BY IS 'nom du createur du projet.';

COMMENT ON COLUMN PROJECT.CREATED_ON IS 'Date de creation de ce projet. Il s''agit de la date de creation de l''entree dans la base, non d''une date metier.';

COMMENT ON COLUMN PROJECT.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

COMMENT ON COLUMN PROJECT.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN PROJECT.CL_ID IS 'cle etrangere de la table campaign-Library';

COMMENT ON COLUMN PROJECT.TCL_ID IS 'cle etrangere de la table TESTCASE-Library';

COMMENT ON COLUMN PROJECT.RL_ID IS 'cle etrangere de la table REQUIREMENT-Library';

CREATE INDEX idx_project ON PROJECT(PROJECT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', 'Table representant les projets englobants les libraries d''entite que nous utilisons.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.08', '2.0.5', '3:10f6bb98e3ad8c7688581c2434dc5596', 23);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.09::bsiri::(Checksum: 3:6ca7c6625c398a565905e6de822b7398)
-- Cette table gere les bibliotheques de cas de test. Une bibliotheque de cas de test peut contenir plusieurs 
-- 		repertoires et/ou cas de test, ces deux entites etant regroupees sous l'appellation generique d'element de bibliotheque 
-- 		de cas de test (test case library nodes).
CREATE TABLE TEST_CASE_LIBRARY (TCL_ID bigserial NOT NULL, PROJECT_ID BIGINT, CONSTRAINT PK_TEST_CASE_LIBRARY PRIMARY KEY (TCL_ID), CONSTRAINT fk_tcl_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN TEST_CASE_LIBRARY.TCL_ID IS 'cle primaire autogeneree';

COMMENT ON COLUMN TEST_CASE_LIBRARY.PROJECT_ID IS 'cle etrangere de la table Project';

CREATE INDEX idx_test_case_library ON TEST_CASE_LIBRARY(TCL_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les bibliotheques de cas de test. Une bibliotheque de cas de test peut contenir plusieurs 
		repertoires et/ou cas de test, ces deux entites etant regroupees sous l''appellation generique d''element de bibliotheque 
		de cas de test (tes...', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.09', '2.0.5', '3:6ca7c6625c398a565905e6de822b7398', 24);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.10::bsiri::(Checksum: 3:70c11ac27e2a6bb65143efee427cd28e)
-- Cette table gere les bibliotheques d'exigences. Une bibliotheque d'exigences peut contenir plusieurs repertoires 
-- 				et/ou exigences, ces deux entites etant regroupees sous l'appellation generique d'element de bibliotheque d'exigences (requirement 
-- 				library nodes).
CREATE TABLE REQUIREMENT_LIBRARY (RL_ID bigserial NOT NULL, PROJECT_ID BIGINT, CONSTRAINT PK_REQUIREMENT_LIBRARY PRIMARY KEY (RL_ID), CONSTRAINT fk_rl_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN REQUIREMENT_LIBRARY.RL_ID IS 'cle primaire autogeneree';

COMMENT ON COLUMN REQUIREMENT_LIBRARY.PROJECT_ID IS 'cle etrangere de la table Project';

CREATE INDEX idx_requirement_library ON REQUIREMENT_LIBRARY(RL_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les bibliotheques d''exigences. Une bibliotheque d''exigences peut contenir plusieurs repertoires 
				et/ou exigences, ces deux entites etant regroupees sous l''appellation generique d''element de bibliotheque d''exigences (requirement 
		...', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.10', '2.0.5', '3:70c11ac27e2a6bb65143efee427cd28e', 25);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.11::bsiri::(Checksum: 3:fd84d5da84499f830851aa8a825f8ff9)
-- Cette table gere les bibliotheques de campagnes. Une bibliotheque 
-- 		de campagnes peut contenir plusieurs repertoires et/ou campagnes, ces deux 
-- 		entites etant regroupees sous l'appellation generique d'element de bibliotheque 
-- 		de campagnes (campaign library nodes).
CREATE TABLE CAMPAIGN_LIBRARY (CL_ID bigserial NOT NULL, PROJECT_ID BIGINT, CONSTRAINT PK_CAMPAIGN_LIBRARY PRIMARY KEY (CL_ID), CONSTRAINT fk_cl_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN CAMPAIGN_LIBRARY.CL_ID IS 'cle primaire autogeneree';

COMMENT ON COLUMN CAMPAIGN_LIBRARY.PROJECT_ID IS 'cle etrangere de la table Project';

CREATE INDEX idx_campaign_library ON CAMPAIGN_LIBRARY(CL_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les bibliotheques de campagnes. Une bibliotheque 
		de campagnes peut contenir plusieurs repertoires et/ou campagnes, ces deux 
		entites etant regroupees sous l''appellation generique d''element de bibliotheque 
		de campagnes (campaign...', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.11', '2.0.5', '3:fd84d5da84499f830851aa8a825f8ff9', 26);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.12::ramoussou::(Checksum: 3:2e779973c9bd4020fafd9645e240fb4b)
ALTER TABLE PROJECT ADD CONSTRAINT fk_project_cl FOREIGN KEY (CL_ID) REFERENCES CAMPAIGN_LIBRARY (CL_ID);

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_tcl FOREIGN KEY (TCL_ID) REFERENCES TEST_CASE_LIBRARY (TCL_ID);

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_rl FOREIGN KEY (RL_ID) REFERENCES REQUIREMENT_LIBRARY (RL_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', '', NOW(), 'Add Foreign Key Constraint (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.12', '2.0.5', '3:2e779973c9bd4020fafd9645e240fb4b', 27);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.13::bsiri::(Checksum: 3:77ff261548687bed7e3050fc610081cc)
-- Cette table represente un element (generique) faisant partie d'une bibliotheque de cas de test. Cet element 
-- 		generique peut representer soit un repertoire, soit un cas de test. Pour cette raison, que l'utilisateur cree l'un ou 
-- 		l'autre cette table sera necessairement alimentee, et contiendra la cle primaire de l'element en question.
-- 		Toutefois le type reel de l'element cas de test ou repertoire) n'est pas renseigne, il est necessaire de rechercher 
-- 		si la cle est referencee dans la table TEST_CASE_FOLDER ou TEST_CASE pour determiner si cet element releve de l'un ou l'autre.
CREATE TABLE TEST_CASE_LIBRARY_NODE (TCLN_ID bigserial NOT NULL, DELETED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, DESCRIPTION TEXT DEFAULT null, NAME VARCHAR(255) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, PROJECT_ID BIGINT, CONSTRAINT PK_TEST_CASE_LIBRARY_NODE PRIMARY KEY (TCLN_ID), CONSTRAINT fk_tcln_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.TCLN_ID IS 'cle primaire autogeneree.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.DELETED_ON IS 'drapeau indiquant si l''element est actif (NULL) ou logiquement supprime (not NULL).';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.DESCRIPTION IS 'Une description associee a cet element. Devrait etre un champ texte long ou un clob.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.NAME IS 'Le nom/label de l''element en question.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.CREATED_BY IS 'nom du createur de ce cas de test.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.CREATED_ON IS 'Date de creation de ce cas de test. Il s''agit de la date de creation de l''entree dans la base, non d''une date metier.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.PROJECT_ID IS 'FK to the Project to which belongs this resource';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table represente un element (generique) faisant partie d''une bibliotheque de cas de test. Cet element 
		generique peut representer soit un repertoire, soit un cas de test. Pour cette raison, que l''utilisateur cree l''un ou 
		l''autre cette table ...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.13', '2.0.5', '3:77ff261548687bed7e3050fc610081cc', 28);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.14::bsiri::(Checksum: 3:a9d2e473eafcd420919c707d59260567)
-- Cette table represente un element (generique) faisant partie d'une bibliotheque d'exigences. Cet element 
-- 				generique peut representer soit un repertoire, soit une exigence. Pour cette raison, que l'utilisateur cree l'un ou l'autre 
-- 				cette table sera necessairement alimentee, et contiendra la cle primaire de l'element en question. Toutefois le type reel 
-- 				de l'element (exigence ou repertoire) n'est pas renseigne, il est necessaire de rechercher si la cle est referencee dans 
-- 				la table REQUIREMENT_FOLDER ou REQUIREMENT pour determiner si cet element releve de l'un ou l'autre.
CREATE TABLE REQUIREMENT_LIBRARY_NODE (RLN_ID bigserial NOT NULL, DELETED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, DESCRIPTION TEXT DEFAULT null, NAME VARCHAR(255) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, PROJECT_ID BIGINT, CONSTRAINT PK_REQUIREMENT_LIBRARY_NODE PRIMARY KEY (RLN_ID), CONSTRAINT fk_rln_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.RLN_ID IS 'cle primaire autogeneree';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.DELETED_ON IS 'drapeau indiquant si l''element est actif (NULL) ou logiquement supprime (not NULL).';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.DESCRIPTION IS 'Une description associee a cet element. Devrait etre un champ texte long ou un clob.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.NAME IS 'Le nom/label de l''element en question.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.CREATED_BY IS 'nom du createur de ce cas de test.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.CREATED_ON IS 'Date de creation de cette exigence. Il s''agit de la date de creation de l''entree dans la base, non d''une date metier.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_NODE.PROJECT_ID IS 'FK to the Project to which belongs this resource';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table represente un element (generique) faisant partie d''une bibliotheque d''exigences. Cet element 
				generique peut representer soit un repertoire, soit une exigence. Pour cette raison, que l''utilisateur cree l''un ou l''autre 
				cette table s...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.14', '2.0.5', '3:a9d2e473eafcd420919c707d59260567', 29);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.15::bsiri::(Checksum: 3:dabf7a16ee4eea69980a88a02299a585)
-- Cette table represente un element (generique) faisant partie 
-- 				d'une bibliotheque de campagne. Cet element generique peut representer soit 
-- 				un repertoire, soit une campagne. Pour cette raison, que l'utilisateur cree 
-- 				l'un ou l'autre cette table sera necessairement alimentee, et contiendra 
-- 				la cle primaire de l'element en question. Toutefois le type reel de l'element 
-- 				(campagne ou repertoire) n'est pas renseigne, il est necessaire de rechercher 
-- 				si la cle est referencee dans la table CAMPAIGN_FOLDER ou CAMPAIGN pour determiner 
-- 				si cet element releve de l'un ou l'autre.
CREATE TABLE CAMPAIGN_LIBRARY_NODE (CLN_ID bigserial NOT NULL, DELETED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, DESCRIPTION TEXT DEFAULT null, NAME VARCHAR(255) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, PROJECT_ID BIGINT DEFAULT NULL, CONSTRAINT PK_CAMPAIGN_LIBRARY_NODE PRIMARY KEY (CLN_ID), CONSTRAINT fk_cln_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.CLN_ID IS 'cle primaire autogeneree';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.DELETED_ON IS 'drapeau indiquant si l''element est actif (NULL) ou logiquement supprime (not NULL).';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.DESCRIPTION IS 'Une description associee a cet element. Devrait etre un champ texte long ou un clob.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.NAME IS 'Le nom/label de l''element en question.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.CREATED_BY IS 'nom du createur de cette campagne.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.CREATED_ON IS 'Date de creation de cette campagne. Il s''agit de la date de creation de l''entree dans     la base, non d''une date metier.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.PROJECT_ID IS 'FK to the Project to which belongs this resource';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table represente un element (generique) faisant partie 
				d''une bibliotheque de campagne. Cet element generique peut representer soit 
				un repertoire, soit une campagne. Pour cette raison, que l''utilisateur cree 
				l''un ou l''autre cette ta...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.15', '2.0.5', '3:dabf7a16ee4eea69980a88a02299a585', 30);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.16::bsiri::(Checksum: 3:958c749a03fa027fdd348b7d4923fc52)
-- Cette table gere les cas de test proprement dits. Une entree dans cette table indique que l'element reference dans la table TEST_CASE_LIBRARY_NODE par la cle primaire (egalement cle etrangere) est de type cas de test.
CREATE TABLE TEST_CASE (TCLN_ID BIGINT NOT NULL, "VERSION" INT NOT NULL, EXECUTION_MODE VARCHAR(255) DEFAULT null, ATTACHMENT_LIST_ID BIGINT NOT NULL, CONSTRAINT PK_TEST_CASSE PRIMARY KEY (TCLN_ID), CONSTRAINT fk_test_case_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID), CONSTRAINT fk_test_case_test_case_node FOREIGN KEY (TCLN_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID));

COMMENT ON COLUMN TEST_CASE.TCLN_ID IS 'cle primaire, qui est aussi une cle etrangere vers la table TEST_CASE_LIBRARY_NODE. Ne doit donc pas etre autogeneree.';

COMMENT ON COLUMN TEST_CASE."VERSION" IS 'Le numero de version de ce cas de test';

COMMENT ON COLUMN TEST_CASE.EXECUTION_MODE IS 'Mode d''execution du test case. Bien que ce champs soit caractere variable, les donnees reelles seront la representation texte d''un type enumere.';

COMMENT ON COLUMN TEST_CASE.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

CREATE INDEX idx_test_case ON TEST_CASE(TCLN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les cas de test proprement dits. Une entree dans cette table indique que l''element reference dans la table TEST_CASE_LIBRARY_NODE par la cle primaire (egalement cle etrangere) est de type cas de test.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.16', '2.0.5', '3:958c749a03fa027fdd348b7d4923fc52', 31);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.17::bsiri::(Checksum: 3:7ab96cee4052f3f5d3d3202a15b0f734)
-- Cette table est rudimentaire. La cle primaire est simplement une cle etrangere vers la table TEST_CASE_LIBRARY_NODE (relation qualifiante). 
-- 		Une entree dans cette table indique que l'element indexe par cette cle est de type repertoire.
CREATE TABLE TEST_CASE_FOLDER (TCLN_ID BIGINT NOT NULL, CONSTRAINT PK_TEST_CASE_FOLDER PRIMARY KEY (TCLN_ID), CONSTRAINT fk_folder_test_case_node FOREIGN KEY (TCLN_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID));

COMMENT ON COLUMN TEST_CASE_FOLDER.TCLN_ID IS 'cle primaire, qui est une cle etrangere vers la table CAMPAIGN_LIBRARY_NODE. Ne doit donc pas etre autogeneree.';

CREATE INDEX idx_tc_folder ON TEST_CASE_FOLDER(TCLN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table est rudimentaire. La cle primaire est simplement une cle etrangere vers la table TEST_CASE_LIBRARY_NODE (relation qualifiante). 
		Une entree dans cette table indique que l''element indexe par cette cle est de type repertoire.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.17', '2.0.5', '3:7ab96cee4052f3f5d3d3202a15b0f734', 32);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.18::bsiri::(Checksum: 3:974cd4efa946c3c586e4cf657e3da0f5)
-- Cette table associe les bibliotheques de cas de test a leur contenu (elements de bibliotheques de cas de test). 
-- 		Le contenu d'une bibliotheque de cas de test est arborescent et est represente suivant un patron composite 
-- 		(voire TEST_CASE_LIBRARY_NODE, TEST_CASE_FOLDER, TEST_CASE). Par defaut la presente table peut contenir uniquement 
-- 		les references vers les elements fils directs; on peut aussi mettre en relation une bibliotheque de cas de test avec 
-- 		n'importe quel element de son contenu (quelque soit sa profondeur hierarchique) pour des raisons d'optimisation.
CREATE TABLE TEST_CASE_LIBRARY_CONTENT (LIBRARY_ID BIGINT NOT NULL, CONTENT_ID BIGINT NOT NULL, CONSTRAINT fk_test_case_lib_content_lib FOREIGN KEY (LIBRARY_ID) REFERENCES TEST_CASE_LIBRARY(TCL_ID), CONSTRAINT fk_test_case_lib_content_content FOREIGN KEY (CONTENT_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID), UNIQUE (CONTENT_ID));

COMMENT ON COLUMN TEST_CASE_LIBRARY_CONTENT.LIBRARY_ID IS 'cle etrangere vers une bibliotheque de cas de test.';

COMMENT ON COLUMN TEST_CASE_LIBRARY_CONTENT.CONTENT_ID IS 'cle etrangere vers un noeud de la bibliotheque de cas de test.';

CREATE INDEX idx_test_case_lib_content_content ON TEST_CASE_LIBRARY_CONTENT(CONTENT_ID);

CREATE INDEX idx_test_case_lib_content_lib ON TEST_CASE_LIBRARY_CONTENT(LIBRARY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe les bibliotheques de cas de test a leur contenu (elements de bibliotheques de cas de test). 
		Le contenu d''une bibliotheque de cas de test est arborescent et est represente suivant un patron composite 
		(voire TEST_CASE_LIBRARY_NO...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.18', '2.0.5', '3:974cd4efa946c3c586e4cf657e3da0f5', 33);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.19::bsiri::(Checksum: 3:afae4a16d26c6b777160d1c69eeb7980)
-- Cette table gere la hierarchie entre elements d'une bibliotheque de cas de test, associant un element fils a 
-- 		un repertoire parent (si non NULL) ou eventuellement aucun (NULL, dans le cas ou l'element est a la racine de la bibliotheque 
-- 		de cas de test).
CREATE TABLE TCLN_RELATIONSHIP (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, CONSTRAINT fk_tcln_relationship_ancestor FOREIGN KEY (ANCESTOR_ID) REFERENCES TEST_CASE_FOLDER(TCLN_ID), CONSTRAINT fk_tcln_relationship_descendant FOREIGN KEY (DESCENDANT_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID), UNIQUE (DESCENDANT_ID));

COMMENT ON COLUMN TCLN_RELATIONSHIP.ANCESTOR_ID IS 'cle etrangere vers le repertoire parent (il s''agit necessairement d''un repertoire).';

COMMENT ON COLUMN TCLN_RELATIONSHIP.DESCENDANT_ID IS 'cle etrangere vers l''element fils.';

CREATE INDEX idx_tcln_relationship_descendant ON TCLN_RELATIONSHIP(DESCENDANT_ID);

CREATE INDEX idx_tcln_relationship_ancestor ON TCLN_RELATIONSHIP(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere la hierarchie entre elements d''une bibliotheque de cas de test, associant un element fils a 
		un repertoire parent (si non NULL) ou eventuellement aucun (NULL, dans le cas ou l''element est a la racine de la bibliotheque 
		de cas de t...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.19', '2.0.5', '3:afae4a16d26c6b777160d1c69eeb7980', 34);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.20::bsiri::(Checksum: 3:a338d63bb4e8bdc84a9be5748180a008)
-- Cette table gere les campagnes proprement dites. Une entree 
-- 				dans cette table indique que l'element reference dans la table CAMPAIGN_LIBRARY_NODE 
-- 				par la cle primaire (egalement cle etrangere) est de type campagne.
CREATE TABLE CAMPAIGN (CLN_ID BIGINT NOT NULL, ACTUAL_END_AUTO BOOLEAN NOT NULL, ACTUAL_END_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, ACTUAL_START_AUTO BOOLEAN NOT NULL, ACTUAL_START_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, SCHEDULED_END_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, SCHEDULED_START_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT PK_CAMPAIGN PRIMARY KEY (CLN_ID), CONSTRAINT FK_CAMPAIGN_CL_NODE FOREIGN KEY (CLN_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID), CONSTRAINT fk_campaign_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN CAMPAIGN.ACTUAL_END_AUTO IS 'Drapeau indiquant si l''utilisateur a choisit une determination automatique de la date de depart effective ou non.';

COMMENT ON COLUMN CAMPAIGN.ACTUAL_END_DATE IS 'Date de fin effective (reelle) de la campagne.';

COMMENT ON COLUMN CAMPAIGN.ACTUAL_START_AUTO IS 'Drapeau indiquant si l''utilisateur a choisit une determination automatique de la date de fin effective ou non.';

COMMENT ON COLUMN CAMPAIGN.ACTUAL_START_DATE IS 'Date de depar effective (reelle) de la campagne.';

COMMENT ON COLUMN CAMPAIGN.SCHEDULED_END_DATE IS 'Date planifiee de fin de la campagne.';

COMMENT ON COLUMN CAMPAIGN.SCHEDULED_START_DATE IS 'Date planifiee de debut de la campagne.';

COMMENT ON COLUMN CAMPAIGN.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les campagnes proprement dites. Une entree 
				dans cette table indique que l''element reference dans la table CAMPAIGN_LIBRARY_NODE 
				par la cle primaire (egalement cle etrangere) est de type campagne.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.20', '2.0.5', '3:a338d63bb4e8bdc84a9be5748180a008', 35);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.21::bsiri::(Checksum: 3:097d056da8cab56d6c7510dca188b264)
-- Cette table est rudimentaire. La cle primaire est simplement 
-- 				une cle etrangere vers la table CAMPAIGN_LIBRARY_NODE (relation qualifiante). 
-- 				Une entree dans cette table indique que l'element indexe par cette cle est 
-- 				de type repertoire.
CREATE TABLE CAMPAIGN_FOLDER (CLN_ID BIGINT NOT NULL, CONSTRAINT PK_CAMPAIGN_FOLDER PRIMARY KEY (CLN_ID), CONSTRAINT FK_CAMPAIGN_FOLDER_CL_NODE FOREIGN KEY (CLN_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID));

COMMENT ON COLUMN CAMPAIGN_FOLDER.CLN_ID IS 'cle primaire, qui est une cle etrangere vers la table CAMPAIGN_LIBRARY_NODE. Ne doit donc pas etre autogeneree.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table est rudimentaire. La cle primaire est simplement 
				une cle etrangere vers la table CAMPAIGN_LIBRARY_NODE (relation qualifiante). 
				Une entree dans cette table indique que l''element indexe par cette cle est 
				de type repertoire.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.21', '2.0.5', '3:097d056da8cab56d6c7510dca188b264', 36);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.22::bsiri::(Checksum: 3:a45d3cfc2a298842fef802a55c8f7779)
-- Cette table gere les bibliotheques de campagnes. Une bibliotheque 
-- 				de campagnes peut contenir plusieurs repertoires et/ou campagnes, ces deux 
-- 				entites etant regroupees sous l'appellation generique d'element de bibliotheque 
-- 				de campagnes (campaign library nodes).
CREATE TABLE CAMPAIGN_LIBRARY_CONTENT (LIBRARY_ID BIGINT NOT NULL, CONTENT_ID BIGINT NOT NULL, CONSTRAINT fk_cl_content_lib FOREIGN KEY (LIBRARY_ID) REFERENCES CAMPAIGN_LIBRARY(CL_ID), CONSTRAINT fk_cl_content_content FOREIGN KEY (CONTENT_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID), UNIQUE (CONTENT_ID));

COMMENT ON COLUMN CAMPAIGN_LIBRARY_CONTENT.LIBRARY_ID IS 'cle etrangere vers une bibliotheque de campagnes.';

COMMENT ON COLUMN CAMPAIGN_LIBRARY_CONTENT.CONTENT_ID IS 'cle etrangere vers un noeud de la bibliotheque de campagnes.';

CREATE UNIQUE INDEX dx_cl_content_cl_node ON CAMPAIGN_LIBRARY_CONTENT(CONTENT_ID);

CREATE INDEX dx_cl_content_campaign_lib ON CAMPAIGN_LIBRARY_CONTENT(LIBRARY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les bibliotheques de campagnes. Une bibliotheque 
				de campagnes peut contenir plusieurs repertoires et/ou campagnes, ces deux 
				entites etant regroupees sous l''appellation generique d''element de bibliotheque 
				de campagnes (ca...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.22', '2.0.5', '3:a45d3cfc2a298842fef802a55c8f7779', 37);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.23::bsiri::(Checksum: 3:d2df248f7905d7cd3031d82abae63bf4)
-- Cette table gere la hierarchie entre elements d'une bibliotheque 
-- 				de campagne, associant un element fils a un repertoire parent (si non NULL) 
-- 				ou eventuellement aucun (NULL, dans le cas ou l'element est a la racine de 
-- 				la bibliotheque de campagne).
CREATE TABLE CLN_RELATIONSHIP (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, CONSTRAINT idx_cln_relationship_descendant FOREIGN KEY (DESCENDANT_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID), CONSTRAINT fk_cln_relationship_ancestor FOREIGN KEY (ANCESTOR_ID) REFERENCES CAMPAIGN_FOLDER(CLN_ID), UNIQUE (DESCENDANT_ID));

COMMENT ON COLUMN CLN_RELATIONSHIP.ANCESTOR_ID IS 'cle etrangere vers le repertoire parent (il s''agit necessairement d''un repertoire).';

COMMENT ON COLUMN CLN_RELATIONSHIP.DESCENDANT_ID IS 'cle etrangere vers l''element fils.';

CREATE INDEX dx_cln_relationship_descendant ON CLN_RELATIONSHIP(DESCENDANT_ID);

CREATE INDEX dx_cln_relationship_ancestor ON CLN_RELATIONSHIP(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere la hierarchie entre elements d''une bibliotheque 
				de campagne, associant un element fils a un repertoire parent (si non NULL) 
				ou eventuellement aucun (NULL, dans le cas ou l''element est a la racine de 
				la bibliotheque de ca...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.23', '2.0.5', '3:d2df248f7905d7cd3031d82abae63bf4', 38);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.24::bsiri::(Checksum: 3:73bf704391132aab5dba024c0ac13c38)
CREATE TABLE ITERATION (ITERATION_ID bigserial NOT NULL, DELETED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, DESCRIPTION TEXT DEFAULT null, NAME VARCHAR(255) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, ACTUAL_END_AUTO BOOLEAN NOT NULL, ACTUAL_END_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, ACTUAL_START_AUTO BOOLEAN NOT NULL, ACTUAL_START_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, SCHEDULED_END_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, SCHEDULED_START_DATE TIMESTAMP WITH TIME ZONE DEFAULT null, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT PK_ITERATION PRIMARY KEY (ITERATION_ID), CONSTRAINT fk_iteration__attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN ITERATION.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.24', '2.0.5', '3:73bf704391132aab5dba024c0ac13c38', 39);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.25::bsiri::(Checksum: 3:51e8cc1f164086246ecead34823b1448)
CREATE TABLE CAMPAIGN_ITERATION (CAMPAIGN_ID BIGINT NOT NULL, ITERATION_ID BIGINT NOT NULL, ITERATION_ORDER INT NOT NULL, CONSTRAINT fk_camp_iter_iteration FOREIGN KEY (ITERATION_ID) REFERENCES ITERATION(ITERATION_ID), CONSTRAINT fk_camp_iter_campaign FOREIGN KEY (CAMPAIGN_ID) REFERENCES CAMPAIGN(CLN_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.25', '2.0.5', '3:51e8cc1f164086246ecead34823b1448', 40);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.26::bsiri::(Checksum: 3:5a513e8d87c090f9bc4b47b47bf05c8a)
-- Cette table gere les pas de test d'un cas de test.
CREATE TABLE TEST_STEP (TEST_STEP_ID bigserial NOT NULL, EXPECTED_RESULT TEXT DEFAULT null, ACTION TEXT NOT NULL, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT PK_TEST_STEP PRIMARY KEY (TEST_STEP_ID), CONSTRAINT fk_test_step__attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN TEST_STEP.TEST_STEP_ID IS 'cle primaire autogeneree.';

COMMENT ON COLUMN TEST_STEP.EXPECTED_RESULT IS 'le resultat attendu de l''action effectuee.';

COMMENT ON COLUMN TEST_STEP.ACTION IS 'action a realiser dans ce pas de test.';

COMMENT ON COLUMN TEST_STEP.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les pas de test d''un cas de test.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.26', '2.0.5', '3:5a513e8d87c090f9bc4b47b47bf05c8a', 41);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.27::bsiri::(Checksum: 3:f7aa9c081ea1f80aabaa9d9e35cdf43a)
-- Cette table associe un cas de test a ses pas de test. Meme si virtuellement la relation entre un cas de 
-- 		test et sa liste de pas de test est 1..*, cette table d'association existe pour ajouter un attribut d'ordre (la 
-- 		liste des pas de test est ordonnee). La cle primaire est ici composite, et ne doit pas etre autogeneree.
CREATE TABLE TEST_CASE_STEPS (TEST_CASE_ID BIGINT NOT NULL, STEP_ID BIGINT NOT NULL, STEP_ORDER INT NOT NULL, CONSTRAINT fk_tc_steps_step FOREIGN KEY (STEP_ID) REFERENCES TEST_STEP(TEST_STEP_ID), CONSTRAINT fk_tc_steps_tc FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN TEST_CASE_STEPS.TEST_CASE_ID IS 'cle etrangere vers TEST_CASE.';

COMMENT ON COLUMN TEST_CASE_STEPS.STEP_ID IS 'cle etrangere vers la table TEST_STEP.';

COMMENT ON COLUMN TEST_CASE_STEPS.STEP_ORDER IS 'numero d''ordre d''un pas de test dans la liste des pas de test d''un cas de test.';

CREATE INDEX idx_tc_steps_step ON TEST_CASE_STEPS(STEP_ID);

CREATE INDEX idx_tc_steps_tc ON TEST_CASE_STEPS(TEST_CASE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe un cas de test a ses pas de test. Meme si virtuellement la relation entre un cas de 
		test et sa liste de pas de test est 1..*, cette table d''association existe pour ajouter un attribut d''ordre (la 
		liste des pas de test est ordo...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.27', '2.0.5', '3:f7aa9c081ea1f80aabaa9d9e35cdf43a', 42);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.28::xpr::(Checksum: 3:f0fe8221736982edf61f00098266d93f)
CREATE TABLE PROJECT_FILTER (PROJECT_FILTER_ID bigserial NOT NULL, ACTIVATED BOOLEAN DEFAULT FALSE NOT NULL, USER_LOGIN VARCHAR(255) NOT NULL, CONSTRAINT PK_PROJECT_FILTER PRIMARY KEY (PROJECT_FILTER_ID));

COMMENT ON COLUMN PROJECT_FILTER.ACTIVATED IS 'filter activated yes or no';

COMMENT ON COLUMN PROJECT_FILTER.USER_LOGIN IS 'unique user login';

CREATE INDEX DX_UN_PROJECT_FILTER_USER ON PROJECT_FILTER(USER_LOGIN);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('xpr', '', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.28', '2.0.5', '3:f0fe8221736982edf61f00098266d93f', 43);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.29::xpr::(Checksum: 3:84be3a27181bbaf2e53d715219078843)
CREATE TABLE PROJECT_FILTER_ENTRY (PROJECT_ID BIGINT NOT NULL, FILTER_ID BIGINT NOT NULL, CONSTRAINT FK_PROJ_FILTER_ENTRY_PROJ_FILTER FOREIGN KEY (FILTER_ID) REFERENCES PROJECT_FILTER(PROJECT_FILTER_ID), CONSTRAINT FK_PROJ_FILTER_ENTRY_PROJ FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN PROJECT_FILTER_ENTRY.PROJECT_ID IS 'foreign key to project';

COMMENT ON COLUMN PROJECT_FILTER_ENTRY.FILTER_ID IS 'foreign key to filter';

ALTER TABLE PROJECT_FILTER_ENTRY ADD CONSTRAINT PK_PROJ_FILTER_ENTRY PRIMARY KEY (PROJECT_ID, FILTER_ID);

CREATE INDEX dx_pfp_project ON PROJECT_FILTER_ENTRY(PROJECT_ID);

CREATE INDEX dx_pfp_filter ON PROJECT_FILTER_ENTRY(FILTER_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('xpr', '', NOW(), 'Create Table, Add Primary Key, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.29', '2.0.5', '3:84be3a27181bbaf2e53d715219078843', 44);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.30::bsiri::(Checksum: 3:4e4246703f7bfc305b0e14b9ed587820)
-- Cette table gere les exigences proprement dites. Une entree dans cette table indique que l'element reference 
-- 				dans la table REQUIREMENT_LIBRARY_NODE par la cle primaire (egalement cle etrangere) est de type exigence.
CREATE TABLE REQUIREMENT (RLN_ID BIGINT NOT NULL, REFERENCE VARCHAR(20), CRITICALITY VARCHAR(255) DEFAULT 'UNDEFINED' NOT NULL, ATTACHMENT_LIST_ID BIGINT NOT NULL, CONSTRAINT PK_REQUIREMENT PRIMARY KEY (RLN_ID), CONSTRAINT fk_requirement_requirement_node FOREIGN KEY (RLN_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID), CONSTRAINT fk_requirement_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN REQUIREMENT.RLN_ID IS 'cle primaire, qui est aussi une cle etrangere vers la table REQUIREMENT_LIBRARY_NODE. Ne doit donc pas etre autogeneree.';

COMMENT ON COLUMN REQUIREMENT.REFERENCE IS 'Identifiant de l''exigence';

COMMENT ON COLUMN REQUIREMENT.CRITICALITY IS 'Requirement criticality. Althought this field is a variable character, the data will be the text representation of an enumeration';

COMMENT ON COLUMN REQUIREMENT.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

CREATE INDEX idx_requirement ON REQUIREMENT(RLN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les exigences proprement dites. Une entree dans cette table indique que l''element reference 
				dans la table REQUIREMENT_LIBRARY_NODE par la cle primaire (egalement cle etrangere) est de type exigence.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.30', '2.0.5', '3:4e4246703f7bfc305b0e14b9ed587820', 45);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.31::bsiri::(Checksum: 3:df70c5c8de2e94240a24f3eda7a972dc)
-- Cette table est rudimentaire. La cle primaire est simplement une cle etrangere vers la table REQUIREMENT_LIBRARY_NODE 
-- 				(relation qualifiante). Une entree dans cette table indique que l'element indexe par cette cle est de type repertoire.
CREATE TABLE REQUIREMENT_FOLDER (RLN_ID BIGINT NOT NULL, CONSTRAINT PK_REQUIREMENT_FOLDER PRIMARY KEY (RLN_ID), CONSTRAINT fk_folder_requirement_node FOREIGN KEY (RLN_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID));

COMMENT ON COLUMN REQUIREMENT_FOLDER.RLN_ID IS 'cle primaire, qui est une cle etrangere vers la table REQUIREMENT_LIBRARY_NODE. Ne doit donc pas etre autogeneree.';

CREATE INDEX idx_req_folder ON REQUIREMENT_FOLDER(RLN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table est rudimentaire. La cle primaire est simplement une cle etrangere vers la table REQUIREMENT_LIBRARY_NODE 
				(relation qualifiante). Une entree dans cette table indique que l''element indexe par cette cle est de type repertoire.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.31', '2.0.5', '3:df70c5c8de2e94240a24f3eda7a972dc', 46);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.32::bsiri::(Checksum: 3:f3c140be4ee750aaf78e1b6985ecfbac)
-- Cette table associe les bibliotheques d'exigences a leur contenu (elements de bibliotheques d'exigence). 
-- 		Le contenu d'une bibliotheque d'exigence est arborescent et est represente suivant un patron composite (voire REQUIREMENT_LIBRARY_NODE, 
-- 		REQUIREMENT_FOLDER, REQUIREMENT). Par defaut la presente table peut contenir uniquement les references vers les elements 
-- 		fils directs; on peut aussi mettre en relation une bibliotheque d'exigence avec n'importe quel element de son contenu (quelque 
-- 		soit sa profondeur hierarchique) pour des raisons d'optimisation.
CREATE TABLE REQUIREMENT_LIBRARY_CONTENT (LIBRARY_ID BIGINT NOT NULL, CONTENT_ID BIGINT NOT NULL, CONSTRAINT fk_requirement_lib_content_content FOREIGN KEY (CONTENT_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID), CONSTRAINT fk_requirement_lib_content_lib FOREIGN KEY (LIBRARY_ID) REFERENCES REQUIREMENT_LIBRARY(RL_ID), UNIQUE (CONTENT_ID));

COMMENT ON COLUMN REQUIREMENT_LIBRARY_CONTENT.LIBRARY_ID IS 'cle etrangere vers une bibliotheque d''exigence.';

COMMENT ON COLUMN REQUIREMENT_LIBRARY_CONTENT.CONTENT_ID IS 'cle etrangere vers un noeud de la bibliotheque d''exigences.';

CREATE INDEX idx_requirement_lib_content_content ON REQUIREMENT_LIBRARY_CONTENT(CONTENT_ID);

CREATE INDEX idx_requirement_lib_content_lib ON REQUIREMENT_LIBRARY_CONTENT(LIBRARY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe les bibliotheques d''exigences a leur contenu (elements de bibliotheques d''exigence). 
		Le contenu d''une bibliotheque d''exigence est arborescent et est represente suivant un patron composite (voire REQUIREMENT_LIBRARY_NODE, 
		REQUI...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.32', '2.0.5', '3:f3c140be4ee750aaf78e1b6985ecfbac', 47);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.33::bsiri::(Checksum: 3:2871df094de3dea7956c501df28c6a3c)
-- Cette table gere la hierarchie entre elements d'une bibliotheque d'exigences, associant un element fils 
-- 				a un repertoire parent.
CREATE TABLE RLN_RELATIONSHIP (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, CONSTRAINT fk_rln_relationship_ancestor FOREIGN KEY (ANCESTOR_ID) REFERENCES REQUIREMENT_FOLDER(RLN_ID), CONSTRAINT fk_rln_relationship_descendant FOREIGN KEY (DESCENDANT_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID), UNIQUE (DESCENDANT_ID));

COMMENT ON COLUMN RLN_RELATIONSHIP.ANCESTOR_ID IS 'cle etrangere vers le repertoire parent (il s''agit necessairement d''un repertoire).';

COMMENT ON COLUMN RLN_RELATIONSHIP.DESCENDANT_ID IS 'cle etrangere vers l''element fils.';

CREATE INDEX idx_rln_relationship_descendant ON RLN_RELATIONSHIP(DESCENDANT_ID);

CREATE INDEX idx_rln_relationship_ancestor ON RLN_RELATIONSHIP(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere la hierarchie entre elements d''une bibliotheque d''exigences, associant un element fils 
				a un repertoire parent.', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.33', '2.0.5', '3:2871df094de3dea7956c501df28c6a3c', 48);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.34::bsiri::(Checksum: 3:677016450819c882153db2d9093348b1)
-- Cette table associe un cas de test avec une liste d'execution. Elle conserve également
-- 		en mémoire le status d'execution, qui devra sera mis à jour au fur et à mesure qu'une execution 
-- 		est ajoutée ou exécutée.
CREATE TABLE ITEM_TEST_PLAN (ITEM_TEST_PLAN_ID bigserial NOT NULL, EXECUTION_STATUS VARCHAR(255) DEFAULT null, LAST_EXECUTED_BY VARCHAR(255) DEFAULT null, LAST_EXECUTED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, TCLN_ID BIGINT, LABEL VARCHAR(255), CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_ITEM_TEST_PLAN PRIMARY KEY (ITEM_TEST_PLAN_ID), CONSTRAINT fk_itertestplan_test_case FOREIGN KEY (TCLN_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN ITEM_TEST_PLAN.ITEM_TEST_PLAN_ID IS 'clé primaire du test plan. Devrait être autogénérée.';

COMMENT ON COLUMN ITEM_TEST_PLAN.EXECUTION_STATUS IS 'Status d''execution de ce plan de test. Bien que ce champs soit caractère variable, les données réelles     seront la représentation texte d''un type énuméré. Sera recalculé en fonction du status de     sa derniere execution';

COMMENT ON COLUMN ITEM_TEST_PLAN.LAST_EXECUTED_BY IS 'Nom du dernier utilisateur ayant execute cet instance.';

COMMENT ON COLUMN ITEM_TEST_PLAN.LAST_EXECUTED_ON IS 'Date de derniere execution de cette instance.';

COMMENT ON COLUMN ITEM_TEST_PLAN.TCLN_ID IS 'Clé étrangère vers le cas de test référencé';

COMMENT ON COLUMN ITEM_TEST_PLAN.LABEL IS 'Le label (duplicata du nom du cas de test) du test plan';

COMMENT ON COLUMN ITEM_TEST_PLAN.CREATED_BY IS 'nom du créateur du testplan';

COMMENT ON COLUMN ITEM_TEST_PLAN.CREATED_ON IS 'Date de création du test plan. Il s''agit de la date de création de l''entrée dans la base, non d''une date métier.';

COMMENT ON COLUMN ITEM_TEST_PLAN.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis à jour cet instance.';

COMMENT ON COLUMN ITEM_TEST_PLAN.LAST_MODIFIED_ON IS 'Date de dernière mise à jour de cette instance.';

CREATE INDEX idx_itertestplan ON ITEM_TEST_PLAN(ITEM_TEST_PLAN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe un cas de test avec une liste d''execution. Elle conserve également
		en mémoire le status d''execution, qui devra sera mis à jour au fur et à mesure qu''une execution 
		est ajoutée ou exécutée.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.34', '2.0.5', '3:677016450819c882153db2d9093348b1', 49);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.35::bsiri::(Checksum: 3:bbb6238456ee0b3789507be210559f4a)
-- Cette table associe une iteration a ses test plans. Même si virtuellement la relation entre une iteration
-- 		 et sa liste de test plans est 1..*, cette table d'association existe pour ajouter un attribut d'ordre (la 
-- 		liste des test plans est ordonnée). La clé primaire est ici composite, et ne doit pas être autogénérée.
CREATE TABLE ITEM_TEST_PLAN_LIST (ITERATION_ID BIGINT NOT NULL, ITEM_TEST_PLAN_ID BIGINT NOT NULL, ITEM_TEST_PLAN_ORDER INT NOT NULL, CONSTRAINT "fk_ITEM_TESTplan_testplan" FOREIGN KEY (ITEM_TEST_PLAN_ID) REFERENCES ITEM_TEST_PLAN(ITEM_TEST_PLAN_ID), CONSTRAINT fk_item_test_plan_iteration FOREIGN KEY (ITERATION_ID) REFERENCES ITERATION(ITERATION_ID));

COMMENT ON COLUMN ITEM_TEST_PLAN_LIST.ITERATION_ID IS 'clé étrangère vers ITERATION.';

COMMENT ON COLUMN ITEM_TEST_PLAN_LIST.ITEM_TEST_PLAN_ID IS 'clé étrangère vers la table ITEM_TEST_PLAN';

COMMENT ON COLUMN ITEM_TEST_PLAN_LIST.ITEM_TEST_PLAN_ORDER IS 'numéro d''ordre d''une execution dans la liste des test plans d''une itération.';

CREATE INDEX "idx_ITEM_TESTplan_iteration" ON ITEM_TEST_PLAN_LIST(ITERATION_ID);

CREATE INDEX "idx_ITEM_TESTplan_testplan" ON ITEM_TEST_PLAN_LIST(ITEM_TEST_PLAN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe une iteration a ses test plans. Même si virtuellement la relation entre une iteration
		 et sa liste de test plans est 1..*, cette table d''association existe pour ajouter un attribut d''ordre (la 
		liste des test plans est ordonnée)...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.35', '2.0.5', '3:bbb6238456ee0b3789507be210559f4a', 50);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.36::bsiri::(Checksum: 3:6db9b5c08ba6fc50bfb43f5109fa5a43)
-- Table des executions. Une execution correspond à un cas de test, et ses pas d'execution (voir EXECUTION_STEP) correspondent
-- 		à des pas de test. Pour assurer un contrôle sur les modifications de l'entité source une référence est gardée vers le 
-- 		cas de test source (de même que EXECUTION_STEP garde une référence vers le TEST_STEP correspondant, même si les données sont 
-- 		dans les faits dupliqués).
CREATE TABLE EXECUTION (EXECUTION_ID bigserial NOT NULL, TCLN_ID BIGINT, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, DESCRIPTION TEXT DEFAULT null, NAME VARCHAR(255) NOT NULL, EXECUTION_MODE VARCHAR(255) DEFAULT null, EXECUTION_STATUS VARCHAR(255) DEFAULT null, LAST_EXECUTED_BY VARCHAR(255) DEFAULT null, LAST_EXECUTED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, ATTACHMENT_LIST_ID BIGINT, ISSUE_LIST_ID BIGINT NOT NULL, CONSTRAINT PK_EXECUTION PRIMARY KEY (EXECUTION_ID), CONSTRAINT fk_execution_test_case FOREIGN KEY (TCLN_ID) REFERENCES TEST_CASE(TCLN_ID), CONSTRAINT fk_execution_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID), CONSTRAINT fk_execution_issue_list FOREIGN KEY (ISSUE_LIST_ID) REFERENCES ISSUE_LIST(ISSUE_LIST_ID));

COMMENT ON COLUMN EXECUTION.EXECUTION_ID IS 'clé primaire de l''execution. Devrait être autogénérée.';

COMMENT ON COLUMN EXECUTION.TCLN_ID IS 'Clé étrangère vers le cas de test référencé. Cette information est redondante puisque      il s''agit toujours du même que celui du test plan, cependant cette information ne devant     jamais évoluer il n''y a pas de risque à dénormaliser';

COMMENT ON COLUMN EXECUTION.CREATED_BY IS 'nom du créateur de l''execution.';

COMMENT ON COLUMN EXECUTION.CREATED_ON IS 'Date de création de cette execution. Il s''agit de la date de création de l''entrée dans la base, non d''une date métier.';

COMMENT ON COLUMN EXECUTION.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis à jour cet instance.';

COMMENT ON COLUMN EXECUTION.LAST_MODIFIED_ON IS 'Date de dernière mise à jour de cette instance.';

COMMENT ON COLUMN EXECUTION.DESCRIPTION IS 'Une description associée à cet élément. Devrait être un champ texte long ou un clob.';

COMMENT ON COLUMN EXECUTION.NAME IS 'Le nom/label de l''élément en question.';

COMMENT ON COLUMN EXECUTION.EXECUTION_MODE IS 'Mode d''execution de cette execution. Bien que ce champs soit caractère variable, les données réelles     seront la représentation texte d''un type énuméré. C''est une copie du mode d''execution du cas de test référencé.';

COMMENT ON COLUMN EXECUTION.EXECUTION_STATUS IS 'Status d''execution de ce plan de test. Bien que ce champs soit caractère variable, les données réelles     seront la représentation texte d''un type énuméré. Sera recalculé en fonction du status de     sa derniere execution';

COMMENT ON COLUMN EXECUTION.LAST_EXECUTED_BY IS 'Nom du dernier utilisateur ayant execute cet instance.';

COMMENT ON COLUMN EXECUTION.LAST_EXECUTED_ON IS 'Date de derniere execution de cette instance.';

COMMENT ON COLUMN EXECUTION.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

COMMENT ON COLUMN EXECUTION.ISSUE_LIST_ID IS 'clé étrangère vers un ISSUE_LIST, l''entité qui gère les listes d''issues.';

CREATE INDEX idx_execution ON EXECUTION(EXECUTION_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Table des executions. Une execution correspond à un cas de test, et ses pas d''execution (voir EXECUTION_STEP) correspondent
		à des pas de test. Pour assurer un contrôle sur les modifications de l''entité source une référence est gardée vers le 
		cas d...', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.36', '2.0.5', '3:6db9b5c08ba6fc50bfb43f5109fa5a43', 51);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.37::bsiri::(Checksum: 3:2cc260f36456b3930ceede7332059452)
-- Associe les executions aux test plans
CREATE TABLE ITEM_TEST_PLAN_EXECUTION (ITEM_TEST_PLAN_ID BIGINT NOT NULL, EXECUTION_ID BIGINT NOT NULL, EXECUTION_ORDER INT NOT NULL, CONSTRAINT fk_testplan_exec_exec FOREIGN KEY (EXECUTION_ID) REFERENCES EXECUTION(EXECUTION_ID), CONSTRAINT fk_testplan_exec_testplan FOREIGN KEY (ITEM_TEST_PLAN_ID) REFERENCES ITEM_TEST_PLAN(ITEM_TEST_PLAN_ID));

COMMENT ON COLUMN ITEM_TEST_PLAN_EXECUTION.ITEM_TEST_PLAN_ID IS 'clé étrangère vers ITEM_TEST_PLAN.';

COMMENT ON COLUMN ITEM_TEST_PLAN_EXECUTION.EXECUTION_ID IS 'clé étrangère vers la table EXECUTION';

COMMENT ON COLUMN ITEM_TEST_PLAN_EXECUTION.EXECUTION_ORDER IS 'numéro d''ordre d''une execution dans la liste des test plans d''une itération.';

CREATE INDEX idx_testplan_exec_testplan ON ITEM_TEST_PLAN_EXECUTION(ITEM_TEST_PLAN_ID);

CREATE INDEX idx_testplan_exec_exec ON ITEM_TEST_PLAN_EXECUTION(EXECUTION_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Associe les executions aux test plans', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.37', '2.0.5', '3:2cc260f36456b3930ceede7332059452', 52);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.38::bsiri::(Checksum: 3:0b7eeee1a4e20b8418ec30b1d220cbf5)
-- Cette table gère les pas d'execution d'une execution. Voir la table EXECUTION pour plus de détails.
CREATE TABLE EXECUTION_STEP (EXECUTION_STEP_ID bigserial NOT NULL, EXPECTED_RESULT TEXT DEFAULT null, ACTION TEXT NOT NULL, EXECUTION_STATUS VARCHAR(255) DEFAULT null, LAST_EXECUTED_BY VARCHAR(255) DEFAULT null, LAST_EXECUTED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, COMMENT TEXT, TEST_STEP_ID BIGINT, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, ATTACHMENT_LIST_ID BIGINT, ISSUE_LIST_ID BIGINT NOT NULL, CONSTRAINT PK_EXECUTION_STEP PRIMARY KEY (EXECUTION_STEP_ID), CONSTRAINT fk_execution_step_issue_list FOREIGN KEY (ISSUE_LIST_ID) REFERENCES ISSUE_LIST(ISSUE_LIST_ID), CONSTRAINT fk_executionstep_teststep FOREIGN KEY (TEST_STEP_ID) REFERENCES TEST_STEP(TEST_STEP_ID), CONSTRAINT fk_execution_step__attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN EXECUTION_STEP.EXECUTION_STEP_ID IS 'clé primaire autogénérée.';

COMMENT ON COLUMN EXECUTION_STEP.EXPECTED_RESULT IS 'le résultat attendu de l''action effectuée.';

COMMENT ON COLUMN EXECUTION_STEP.ACTION IS 'action à réaliser dans ce pas d''execution.';

COMMENT ON COLUMN EXECUTION_STEP.EXECUTION_STATUS IS 'Status de l''execution de ce pas d''execution. Bien que ce champs soit caractère variable, les données réelles     seront la représentation texte d''un type énuméré.';

COMMENT ON COLUMN EXECUTION_STEP.LAST_EXECUTED_BY IS 'Nom du dernier utilisateur ayant execute cet instance.';

COMMENT ON COLUMN EXECUTION_STEP.LAST_EXECUTED_ON IS 'Date de derniere execution de cette instance.';

COMMENT ON COLUMN EXECUTION_STEP.COMMENT IS 'commentaire libre du recetteur.';

COMMENT ON COLUMN EXECUTION_STEP.TEST_STEP_ID IS 'Clé étrangère vers le pas de test référencé';

COMMENT ON COLUMN EXECUTION_STEP.CREATED_BY IS 'nom du créateur du pas d''execution.';

COMMENT ON COLUMN EXECUTION_STEP.CREATED_ON IS 'Date de création de ce pas d''execution. Il s''agit de la date de création de l''entrée dans la base, non d''une date métier.';

COMMENT ON COLUMN EXECUTION_STEP.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis à jour cet instance.';

COMMENT ON COLUMN EXECUTION_STEP.LAST_MODIFIED_ON IS 'Date de dernière mise à jour de cette instance.';

COMMENT ON COLUMN EXECUTION_STEP.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

COMMENT ON COLUMN EXECUTION_STEP.ISSUE_LIST_ID IS 'clé étrangère vers un ISSUE_LIST, l''entité qui gère les listes d''issues.';

CREATE INDEX idx_executionstep ON EXECUTION_STEP(EXECUTION_STEP_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gère les pas d''execution d''une execution. Voir la table EXECUTION pour plus de détails.', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.38', '2.0.5', '3:0b7eeee1a4e20b8418ec30b1d220cbf5', 53);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.39::bsiri::(Checksum: 3:973dad84ab8afd2ed0428f2fcad18c33)
-- Cette table associe une executions à ses pas d'execution. Même si virtuellement la relation entre une execution
-- 		 et sa liste de pas d'execution est 1..*, cette table d'association existe pour ajouter un attribut d'ordre (la 
-- 		liste des pas executions est ordonnée). La clé primaire est ici composite, et ne doit pas être autogénérée.
CREATE TABLE EXECUTION_EXECUTION_STEPS (EXECUTION_ID BIGINT NOT NULL, EXECUTION_STEP_ID BIGINT NOT NULL, EXECUTION_STEP_ORDER INT NOT NULL, CONSTRAINT fk_exec_exec_step_exec_step FOREIGN KEY (EXECUTION_STEP_ID) REFERENCES EXECUTION_STEP(EXECUTION_STEP_ID), CONSTRAINT fk_exec_exec_step_exec FOREIGN KEY (EXECUTION_ID) REFERENCES EXECUTION(EXECUTION_ID));

COMMENT ON COLUMN EXECUTION_EXECUTION_STEPS.EXECUTION_ID IS 'clé étrangère vers la table EXECUTION.';

COMMENT ON COLUMN EXECUTION_EXECUTION_STEPS.EXECUTION_STEP_ID IS 'clé étrangère vers EXECUTION_STEP';

COMMENT ON COLUMN EXECUTION_EXECUTION_STEPS.EXECUTION_STEP_ORDER IS 'numéro d''ordre d''un pas d''execution dans la liste des pas d''executions d''une execution.';

CREATE INDEX idx_exec_exec_step_exec ON EXECUTION_EXECUTION_STEPS(EXECUTION_ID);

CREATE INDEX idx_exec_exec_step_exec_step ON EXECUTION_EXECUTION_STEPS(EXECUTION_STEP_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table associe une executions à ses pas d''execution. Même si virtuellement la relation entre une execution
		 et sa liste de pas d''execution est 1..*, cette table d''association existe pour ajouter un attribut d''ordre (la 
		liste des pas execution...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.39', '2.0.5', '3:973dad84ab8afd2ed0428f2fcad18c33', 54);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.40::bsiri::(Checksum: 3:022678424f32aff0ea457d87cfc81c39)
-- Cette table gere les associations entre cas de test et exigences. 
-- 				La cle primaire est composite et ne doit pas etre autogeneree.
CREATE TABLE TEST_CASE_REQUIREMENT_LINK (TEST_CASE_ID BIGINT NOT NULL, REQUIREMENT_ID BIGINT NOT NULL, CONSTRAINT fk_tc_req_req FOREIGN KEY (REQUIREMENT_ID) REFERENCES REQUIREMENT(RLN_ID), CONSTRAINT fk_tc_req_tc FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN TEST_CASE_REQUIREMENT_LINK.TEST_CASE_ID IS 'cle etrangere vers TEST_CASE';

COMMENT ON COLUMN TEST_CASE_REQUIREMENT_LINK.REQUIREMENT_ID IS 'cle etrangere vers REQUIREMENT';

ALTER TABLE TEST_CASE_REQUIREMENT_LINK ADD CONSTRAINT pk_tc_req_link PRIMARY KEY (TEST_CASE_ID, REQUIREMENT_ID);

CREATE INDEX idx_tc_req_tc ON TEST_CASE_REQUIREMENT_LINK(TEST_CASE_ID);

CREATE INDEX idx_tc_req_req ON TEST_CASE_REQUIREMENT_LINK(REQUIREMENT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Cette table gere les associations entre cas de test et exigences. 
				La cle primaire est composite et ne doit pas etre autogeneree.', NOW(), 'Create Table, Add Primary Key, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.40', '2.0.5', '3:022678424f32aff0ea457d87cfc81c39', 55);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.41::adurand::(Checksum: 3:05303033f44dedf713634bc5d2a8f876)
-- Cette table gere les associations entre les campagnes et les cas de test (= les plans de test des campagnes).La cle primaire est composite et ne doit pas etre autogeneree.
CREATE TABLE CAMPAIGN_TEST_PLAN (CAMPAIGN_ID BIGINT NOT NULL, TEST_CASE_ID BIGINT NOT NULL, CONSTRAINT fk_camp_tp_camp FOREIGN KEY (CAMPAIGN_ID) REFERENCES CAMPAIGN(CLN_ID), CONSTRAINT fk_camp_tp_tc FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN.CAMPAIGN_ID IS 'cle etrangere vers CAMPAIGN';

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN.TEST_CASE_ID IS 'cle etrangere vers TEST_CASE';

ALTER TABLE CAMPAIGN_TEST_PLAN ADD CONSTRAINT pk_camp_tp PRIMARY KEY (CAMPAIGN_ID, TEST_CASE_ID);

CREATE INDEX idx_camp_tp_camp ON CAMPAIGN_TEST_PLAN(CAMPAIGN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('adurand', 'Cette table gere les associations entre les campagnes et les cas de test (= les plans de test des campagnes).La cle primaire est composite et ne doit pas etre autogeneree.', NOW(), 'Create Table, Add Primary Key, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.41', '2.0.5', '3:05303033f44dedf713634bc5d2a8f876', 56);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.42::bsiri::(Checksum: 3:efcf1c28e93336d052ae489901878a3a)
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.43::xpr::(Checksum: 3:ae6e2167fb4b8136983297802a1c7d60)
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.44::gfouquet::(Checksum: 3:67ee96d82ee3e4cc07bf2c0e252cee36)
INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_TM_USER', (select ID from CORE_GROUP where QUALIFIED_NAME='squashtest.authz.group.core.Admin'));

INSERT INTO CORE_GROUP (QUALIFIED_NAME) VALUES ('squashtest.tm.group.User');

INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_TM_USER', (select max(ID) from CORE_GROUP));

INSERT INTO CORE_GROUP (QUALIFIED_NAME) VALUES ('squashtest.authz.group.tm.ProjectManager');

INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_TM_PROJECT_MANAGER', (select max(ID) from CORE_GROUP));

INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.csp.tm.domain.project.Project');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.ProjectManager');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '15');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '8');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.TestEditor');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '15');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '8');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.TestRunner');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Insert Row (x20)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.44', '2.0.5', '3:67ee96d82ee3e4cc07bf2c0e252cee36', 57);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml::tm-0.14.0.45::gfouquet::(Checksum: 3:17d0e76b39bf9550b5d66f84108de444)
INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.ProjectViewer');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Insert Row (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.15.0.xml', 'tm-0.14.0.45', '2.0.5', '3:17d0e76b39bf9550b5d66f84108de444', 58);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml::tm-0.17.0.01::gfouquet::(Checksum: 3:98ccb741049fc7ae4b5e4d02b64ae4e8)
-- This table stores "action" tests steps, i.e. steps with an action and expected result, which were formerly stored in TEST_STEP
CREATE TABLE ACTION_TEST_STEP (TEST_STEP_ID BIGINT NOT NULL, ACTION TEXT NOT NULL, EXPECTED_RESULT TEXT DEFAULT null, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT pk_action_step PRIMARY KEY (TEST_STEP_ID), CONSTRAINT fk_action_step_test_step FOREIGN KEY (TEST_STEP_ID) REFERENCES TEST_STEP(TEST_STEP_ID), CONSTRAINT fk_action_test_step_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN ACTION_TEST_STEP.TEST_STEP_ID IS 'Shared key with TEST_STEP table';

COMMENT ON COLUMN ACTION_TEST_STEP.ACTION IS 'The step''s action';

COMMENT ON COLUMN ACTION_TEST_STEP.EXPECTED_RESULT IS 'The step''s expected result';

COMMENT ON COLUMN ACTION_TEST_STEP.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'This table stores "action" tests steps, i.e. steps with an action and expected result, which were formerly stored in TEST_STEP', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml', 'tm-0.17.0.01', '2.0.5', '3:98ccb741049fc7ae4b5e4d02b64ae4e8', 59);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml::tm-0.17.0.02::gfouquet::(Checksum: 3:a54eda81c8b073f49f3c48b969724007)
-- Data migration from TEST_STEP to ACTION_TEST_STEP
insert into ACTION_TEST_STEP (TEST_STEP_ID, ACTION, EXPECTED_RESULT, ATTACHMENT_LIST_ID) select TEST_STEP_ID, ACTION, EXPECTED_RESULT, ATTACHMENT_LIST_ID from TEST_STEP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Data migration from TEST_STEP to ACTION_TEST_STEP', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml', 'tm-0.17.0.02', '2.0.5', '3:a54eda81c8b073f49f3c48b969724007', 60);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml::tm-0.17.0.03::gfouquet::(Checksum: 3:24b184e1522e87284c5bc4435010d822)
-- Removes useless comlumns from TEST_STEP
ALTER TABLE TEST_STEP DROP CONSTRAINT fk_test_step__attachment_list;

ALTER TABLE TEST_STEP DROP COLUMN ACTION;

ALTER TABLE TEST_STEP DROP COLUMN EXPECTED_RESULT;

ALTER TABLE TEST_STEP DROP COLUMN ATTACHMENT_LIST_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Removes useless comlumns from TEST_STEP', NOW(), 'Drop Foreign Key Constraint, Drop Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml', 'tm-0.17.0.03', '2.0.5', '3:24b184e1522e87284c5bc4435010d822', 61);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml::tm-0.17.0.04::gfouquet::(Checksum: 3:f17d3f5ef7678112090526434ab02012)
-- This table stores "call" tests steps, i.e. steps which call an entire test case
CREATE TABLE CALL_TEST_STEP (TEST_STEP_ID BIGINT NOT NULL, CALLED_TEST_CASE_ID BIGINT NOT NULL, CONSTRAINT pk_call_step PRIMARY KEY (TEST_STEP_ID), CONSTRAINT fk_call_step_called_test_case FOREIGN KEY (CALLED_TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID), CONSTRAINT fk_call_step_test_step FOREIGN KEY (TEST_STEP_ID) REFERENCES TEST_STEP(TEST_STEP_ID));

COMMENT ON COLUMN CALL_TEST_STEP.TEST_STEP_ID IS 'Shared key with TEST_STEP table';

COMMENT ON COLUMN CALL_TEST_STEP.CALLED_TEST_CASE_ID IS 'ID of called test case';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'This table stores "call" tests steps, i.e. steps which call an entire test case', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.17.0.xml', 'tm-0.17.0.04', '2.0.5', '3:f17d3f5ef7678112090526434ab02012', 62);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.01::ramoussou::(Checksum: 3:a2c617f3cd30d4df478396383ec1120b)
-- We have to set campaign_ID and Test_plan_order to "true" to let hibernate persist new items
CREATE TABLE CAMPAIGN_TEST_PLAN_ITEM (CTPI_ID bigserial NOT NULL, CAMPAIGN_ID BIGINT, TEST_CASE_ID BIGINT NOT NULL, USER_ID BIGINT, TEST_PLAN_ORDER INT, CONSTRAINT PK_CAMPAIGN_TEST_PLAN_ITEM PRIMARY KEY (CTPI_ID), CONSTRAINT fk_camp_tp_campaign FOREIGN KEY (CAMPAIGN_ID) REFERENCES CAMPAIGN(CLN_ID), CONSTRAINT fk_camp_tp_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER(ID), CONSTRAINT fk_camp_tp_testcase FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.CTPI_ID IS 'clé primaire du test plan. Devrait être autogénérée.';

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.CAMPAIGN_ID IS 'cle etrangere vers CAMPAIGN';

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.TEST_CASE_ID IS 'cle etrangere vers TEST_CASE';

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.USER_ID IS 'Id de l''utilisateur assigné a ce cas de test reférenncé';

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.TEST_PLAN_ORDER IS 'numéro d''ordre d''une execution dans la liste des test plans d''une itération.';

CREATE INDEX idx_camptestplan ON CAMPAIGN_TEST_PLAN_ITEM(CTPI_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', 'We have to set campaign_ID and Test_plan_order to "true" to let hibernate persist new items', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml', 'tm-0.19.0.01', '2.0.5', '3:a2c617f3cd30d4df478396383ec1120b', 63);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.02::ramoussou::(Checksum: 3:bab4e9ace40d3f38f0a909166ffa3543)
-- Migrates data from unordered campaign test plan table to ordered test plan table. 
-- 	 		Items which references (soft) deleted test cases and which should not be in the table are not migrated
insert into CAMPAIGN_TEST_PLAN_ITEM (CAMPAIGN_ID, TEST_CASE_ID) 
			select tp.CAMPAIGN_ID, tp.TEST_CASE_ID 
			from CAMPAIGN_TEST_PLAN tp 
				inner join TEST_CASE_LIBRARY_NODE tc on tc.TCLN_ID = tp.TEST_CASE_ID
			where tc.DELETED_ON is null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', 'Migrates data from unordered campaign test plan table to ordered test plan table. 
	 		Items which references (soft) deleted test cases and which should not be in the table are not migrated', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml', 'tm-0.19.0.02', '2.0.5', '3:bab4e9ace40d3f38f0a909166ffa3543', 64);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.03::ramoussou::(Checksum: 3:7cf5b162cc14dd208a967e41dfb3ad4e)
-- Calculate and insert and add Not null constraint on order for Campaign Test Plan For H2
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.04::ramoussou::(Checksum: 3:905488109451a024de6e2560c5076e65)
-- Calculate and insert and add Not null constraint on order for Campaign Test Plan for myssql
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.04-postgres::mpagnon::(Checksum: 3:8447241e5630abc830696ab5b207c8b2)
-- Calculate and insert and add Not null constraint on order for Campaign Test Plan for postgresql
CREATE  TABLE MIGRATION_CAMPAIGN_TEST_PLAN (
      TEST_PLAN_ORDER BIGINT NULL DEFAULT NULL,
      CAMPAIGN_ID BIGINT NULL DEFAULT NULL,
      TEST_CASE_ID BIGINT NULL DEFAULT NULL
      );

CREATE OR REPLACE FUNCTION testfunction() RETURNS text AS 
$$
DECLARE rn integer := 0-1;
rn2 integer := 0;
prevcamp bigint := 0;
r record;
BEGIN
FOR r in (select ctp.CAMPAIGN_ID, ctp.TEST_CASE_ID  from CAMPAIGN_TEST_PLAN_ITEM ctp order by CAMPAIGN_ID)
LOOP
	IF prevcamp  = r.CAMPAIGN_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevcamp := r.CAMPAIGN_ID;
        END IF;
	  insert into MIGRATION_CAMPAIGN_TEST_PLAN (TEST_PLAN_ORDER, CAMPAIGN_ID, TEST_CASE_ID)
       select rn, r.CAMPAIGN_ID , r.TEST_CASE_ID  ;
      
       

END LOOP;
return 'ok';
END
$$ LANGUAGE plpgsql;

select testfunction();
DROP FUNCTION TestFunction();

update CAMPAIGN_TEST_PLAN_ITEM citp set TEST_PLAN_ORDER 
      = 
        (select mctp.TEST_PLAN_ORDER from MIGRATION_CAMPAIGN_TEST_PLAN mctp 
        where mctp.CAMPAIGN_ID = citp.CAMPAIGN_ID 
        and mctp.TEST_CASE_ID = citp.TEST_CASE_ID);

drop table MIGRATION_CAMPAIGN_TEST_PLAN;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Calculate and insert and add Not null constraint on order for Campaign Test Plan for postgresql', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml', 'tm-0.19.0.04-postgres', '2.0.5', '3:8447241e5630abc830696ab5b207c8b2', 65);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.06::ramoussou::(Checksum: 3:f9e834dd9a237218a636c461a1f14acb)
-- Drop table CAMPAIGN_TEST_PLAN
DROP TABLE CAMPAIGN_TEST_PLAN;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', 'Drop table CAMPAIGN_TEST_PLAN', NOW(), 'Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml', 'tm-0.19.0.06', '2.0.5', '3:f9e834dd9a237218a636c461a1f14acb', 66);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml::tm-0.19.0.07::ramoussou::(Checksum: 3:3464e0eb5a1a382e6691a4f727ec00e0)
ALTER TABLE ITEM_TEST_PLAN ADD USER_ID BIGINT;

ALTER TABLE ITEM_TEST_PLAN ADD CONSTRAINT fk_itertestplan_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER (ID);

COMMENT ON COLUMN ITEM_TEST_PLAN.USER_ID IS 'Id de l''utilisateur assigné a ce cas de test reférenncé';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('ramoussou', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.19.0.xml', 'tm-0.19.0.07', '2.0.5', '3:3464e0eb5a1a382e6691a4f727ec00e0', 67);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.01::gfouquet::(Checksum: 3:79d0a7f41b244e13231f6617599db287)
-- The PROJECT_ID foreign key in TEST_CASE_LIBRARY is useless, the useful one is in the PROJECT table
ALTER TABLE TEST_CASE_LIBRARY DROP CONSTRAINT fk_tcl_project;

ALTER TABLE TEST_CASE_LIBRARY DROP COLUMN PROJECT_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'The PROJECT_ID foreign key in TEST_CASE_LIBRARY is useless, the useful one is in the PROJECT table', NOW(), 'Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.01', '2.0.5', '3:79d0a7f41b244e13231f6617599db287', 68);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.02::gfouquet::(Checksum: 3:90ee0d65007fd13cf852fd74c93cc5ab)
-- The PROJECT_ID foreign key in REQUIREMENT_LIBRARY is useless, the useful one is in the PROJECT table
ALTER TABLE REQUIREMENT_LIBRARY DROP CONSTRAINT fk_rl_project;

ALTER TABLE REQUIREMENT_LIBRARY DROP COLUMN PROJECT_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'The PROJECT_ID foreign key in REQUIREMENT_LIBRARY is useless, the useful one is in the PROJECT table', NOW(), 'Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.02', '2.0.5', '3:90ee0d65007fd13cf852fd74c93cc5ab', 69);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.03::gfouquet::(Checksum: 3:2839276f429b636cc801c6e05258e229)
-- The PROJECT_ID foreign key in CAMPAIGN_LIBRARY is useless, the useful one is in the PROJECT table
ALTER TABLE CAMPAIGN_LIBRARY DROP CONSTRAINT fk_cl_project;

ALTER TABLE CAMPAIGN_LIBRARY DROP COLUMN PROJECT_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'The PROJECT_ID foreign key in CAMPAIGN_LIBRARY is useless, the useful one is in the PROJECT table', NOW(), 'Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.03', '2.0.5', '3:2839276f429b636cc801c6e05258e229', 70);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.05::bsiri::(Checksum: 3:33f92afafccb2a461ebeee6b06c0d503)
ALTER TABLE EXECUTION ALTER COLUMN  ISSUE_LIST_ID DROP NOT NULL;

ALTER TABLE EXECUTION_STEP ALTER COLUMN  ISSUE_LIST_ID DROP NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', '', NOW(), 'Drop Not-Null Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.05', '2.0.5', '3:33f92afafccb2a461ebeee6b06c0d503', 71);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.07::bsiri::(Checksum: 3:01c34eb5d2046c3d206c2658ef6efdb8)
-- add an ondelete set null to the fk campaign test plan item  -> core user
ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM DROP CONSTRAINT fk_camp_tp_user;

ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM ADD CONSTRAINT fk_camp_tp_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER (ID) ON DELETE SET NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'add an ondelete set null to the fk campaign test plan item  -> core user', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.07', '2.0.5', '3:01c34eb5d2046c3d206c2658ef6efdb8', 72);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.40::gfouquet::(Checksum: 3:ab522a0d38bc1df143c84b75c668820b)
-- Replace the ATTACHMENT_LIST_CONTENT table by a FK in ATTACHMENT
ALTER TABLE ATTACHMENT ADD ATTACHMENT_LIST_ID BIGINT;

update ATTACHMENT a set ATTACHMENT_LIST_ID = (select AL_ID from ATTACHMENT_LIST_CONTENT alc where
			alc.ATTACHMENT_ID = a.ATTACHMENT_ID);

DROP TABLE ATTACHMENT_LIST_CONTENT;

ALTER TABLE ATTACHMENT ADD CONSTRAINT fk_attachment_att_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

ALTER TABLE ATTACHMENT ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Replace the ATTACHMENT_LIST_CONTENT table by a FK in ATTACHMENT', NOW(), 'Add Column, Custom SQL, Drop Table, Add Foreign Key Constraint, Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.40', '2.0.5', '3:ab522a0d38bc1df143c84b75c668820b', 73);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.41::gfouquet::(Checksum: 3:726804bd77783ba5146a81d59aaab4ac)
-- Replace the ISSUE_LIST_CONTENT table by a FK in ISSUE
ALTER TABLE ISSUE ADD ISSUE_LIST_ID BIGINT;

COMMENT ON COLUMN ISSUE.ISSUE_LIST_ID IS 'References the list of issue to which an issue belongs';

update ISSUE i set ISSUE_LIST_ID = (select ISSUE_LIST_ID from ISSUE_LIST_CONTENT ilc where ilc.ISSUE_ID =
			i.ISSUE_ID);

DROP TABLE ISSUE_LIST_CONTENT;

ALTER TABLE ISSUE ADD CONSTRAINT fk_issue_issue_list FOREIGN KEY (ISSUE_LIST_ID) REFERENCES ISSUE_LIST (ISSUE_LIST_ID);

ALTER TABLE ISSUE ALTER COLUMN  ISSUE_LIST_ID SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Replace the ISSUE_LIST_CONTENT table by a FK in ISSUE', NOW(), 'Add Column, Custom SQL, Drop Table, Add Foreign Key Constraint, Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.41', '2.0.5', '3:726804bd77783ba5146a81d59aaab4ac', 74);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml::tm-0.20.0.42::gfouquet::(Checksum: 3:0fe189d2c826b59230a2e5fea194ff17)
-- Rename ITEM_TEST_PLAN into ITERATION_TEST_PLAN_ITEM
ALTER TABLE ITEM_TEST_PLAN RENAME TO ITERATION_TEST_PLAN_ITEM;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Rename ITEM_TEST_PLAN into ITERATION_TEST_PLAN_ITEM', NOW(), 'Rename Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.20.0.xml', 'tm-0.20.0.42', '2.0.5', '3:0fe189d2c826b59230a2e5fea194ff17', 75);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml::tm-0.23.0.01::bsiri::(Checksum: 3:4c7a622b9ce59f63f8a353974546e243)
-- remove ProjectManager and TestRunner from the ACL permission table
delete from ACL_GROUP_PERMISSION where ACL_GROUP_ID in 
			(select id from ACL_GROUP where qualified_name='squashtest.acl.group.tm.ProjectManager' 
			or qualified_name='squashtest.acl.group.tm.TestRunner');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'remove ProjectManager and TestRunner from the ACL permission table', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml', 'tm-0.23.0.01', '2.0.5', '3:4c7a622b9ce59f63f8a353974546e243', 76);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml::tm-0.23.0.02::bsiri::(Checksum: 3:0d9176e53082f38f2505081b41416b75)
-- all users that were ProjectManager or TestRunner on anything are now TestEditor
update ACL_RESPONSIBILITY_SCOPE_ENTRY
			set ACL_GROUP_ID = (select id from ACL_GROUP where qualified_name='squashtest.acl.group.tm.TestEditor')
			where ACL_GROUP_ID in (select id from ACL_GROUP where qualified_name='squashtest.acl.group.tm.ProjectManager' 
									or qualified_name='squashtest.acl.group.tm.TestRunner');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'all users that were ProjectManager or TestRunner on anything are now TestEditor', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml', 'tm-0.23.0.02', '2.0.5', '3:0d9176e53082f38f2505081b41416b75', 77);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml::tm-0.23.0.03::bsiri::(Checksum: 3:8de0f418634703a9aa5c73e391db6471)
-- remove ProjectManager and TestRunner from the existing acl groups
delete from ACL_GROUP
			where qualified_name='squashtest.acl.group.tm.ProjectManager' 
			or qualified_name='squashtest.acl.group.tm.TestRunner';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'remove ProjectManager and TestRunner from the existing acl groups', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-0.23.0.xml', 'tm-0.23.0.03', '2.0.5', '3:8de0f418634703a9aa5c73e391db6471', 78);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.01::gfouquet::(Checksum: 3:7b812bb021cbb1145febc9bad5624b79)
-- Corrects status to BLOCKED in EXECUTION table
UPDATE EXECUTION SET EXECUTION_STATUS = 'BLOCKED' WHERE EXECUTION_STATUS='BLOQUED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Corrects status to BLOCKED in EXECUTION table', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.01', '2.0.5', '3:7b812bb021cbb1145febc9bad5624b79', 79);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.02::gfouquet::(Checksum: 3:e0a5f002e81988762e6b1b2d329f84b1)
-- Corrects status to BLOCKED in EXECUTION_STEP table
UPDATE EXECUTION_STEP SET EXECUTION_STATUS = 'BLOCKED' WHERE EXECUTION_STATUS='BLOQUED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Corrects status to BLOCKED in EXECUTION_STEP table', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.02', '2.0.5', '3:e0a5f002e81988762e6b1b2d329f84b1', 80);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.03::gfouquet::(Checksum: 3:8ed2c90c46fdd119a126dfce9311bf50)
-- Corrects status to BLOCKED in EXECUTION_STEP table
UPDATE ITERATION_TEST_PLAN_ITEM SET EXECUTION_STATUS = 'BLOCKED' WHERE EXECUTION_STATUS='BLOQUED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Corrects status to BLOCKED in EXECUTION_STEP table', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.03', '2.0.5', '3:8ed2c90c46fdd119a126dfce9311bf50', 81);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.04::gfouquet::(Checksum: 3:602af0823f8965c71e6f8ba05124a2cd)
-- Adds an importance to test cases
ALTER TABLE TEST_CASE ADD IMPORTANCE VARCHAR(20) NOT NULL DEFAULT 'LOW';

COMMENT ON COLUMN TEST_CASE.IMPORTANCE IS 'The importance of the test case';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds an importance to test cases', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.04', '2.0.5', '3:602af0823f8965c71e6f8ba05124a2cd', 82);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.05::gfouquet::(Checksum: 3:d600b40e7b3fb8526cd8184109d2dfbe)
-- Adds a auto compute importance property to test cases
ALTER TABLE TEST_CASE ADD IMPORTANCE_AUTO BOOLEAN NOT NULL DEFAULT FALSE;

COMMENT ON COLUMN TEST_CASE.IMPORTANCE_AUTO IS 'Should the importance be automatically computed';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds a auto compute importance property to test cases', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.05', '2.0.5', '3:d600b40e7b3fb8526cd8184109d2dfbe', 83);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.06::gfouquet::(Checksum: 3:2e544b51db99e2b730f9bac869c54861)
-- Adds a TM database version number
INSERT INTO CORE_CONFIG (STR_KEY, VALUE) VALUES ('squashtest.tm.database.version', '1.1.0');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds a TM database version number', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.06', '2.0.5', '3:2e544b51db99e2b730f9bac869c54861', 84);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.07::gfouquet::(Checksum: 3:7aeec9343a5b8e86f987d291a5edb778)
-- A tree node organizes resources. These are stored in the RESOURCE table
CREATE TABLE RESOURCE (RES_ID bigserial NOT NULL, NAME VARCHAR(255) NOT NULL, DESCRIPTION TEXT DEFAULT null, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_RESOURCE PRIMARY KEY (RES_ID));

COMMENT ON COLUMN RESOURCE.RES_ID IS 'generated surrogate key';

COMMENT ON COLUMN RESOURCE.NAME IS 'Resource''s name';

COMMENT ON COLUMN RESOURCE.DESCRIPTION IS 'Resource''s description';

COMMENT ON COLUMN RESOURCE.CREATED_BY IS 'Who created this requirement''s version';

COMMENT ON COLUMN RESOURCE.CREATED_ON IS 'When this requirement''s version was created';

COMMENT ON COLUMN RESOURCE.LAST_MODIFIED_BY IS 'Who modified this requirement''s version last';

COMMENT ON COLUMN RESOURCE.LAST_MODIFIED_ON IS 'When this requirement''s version was last modified';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'A tree node organizes resources. These are stored in the RESOURCE table', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.07', '2.0.5', '3:7aeec9343a5b8e86f987d291a5edb778', 85);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.08::gfouquet::(Checksum: 3:7969f710831387cc73bc194aa34d1b8c)
-- SIMPLE_RESOURCE stores "concrete" resources with a name and a description
CREATE TABLE SIMPLE_RESOURCE (RES_ID BIGINT NOT NULL, CONSTRAINT pk_simple_resource PRIMARY KEY (RES_ID), CONSTRAINT fk_resource FOREIGN KEY (RES_ID) REFERENCES RESOURCE(RES_ID));

COMMENT ON COLUMN SIMPLE_RESOURCE.RES_ID IS 'shared key with RESOURCE table';

ALTER TABLE REQUIREMENT_FOLDER ADD RES_ID BIGINT;

ALTER TABLE REQUIREMENT_FOLDER ADD CONSTRAINT fk_req_folder_simple_resource FOREIGN KEY (RES_ID) REFERENCES SIMPLE_RESOURCE (RES_ID);

COMMENT ON COLUMN REQUIREMENT_FOLDER.RES_ID IS 'FK to SIMPLE_RESOURCE table';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'SIMPLE_RESOURCE stores "concrete" resources with a name and a description', NOW(), 'Create Table, Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.08', '2.0.5', '3:7969f710831387cc73bc194aa34d1b8c', 86);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.09::gfouquet::(Checksum: 3:8eef6e42740a9a0de705a27dcbfa9ba8)
-- Moves requirement folder data into SIMPLE_RESOURCE table
insert into RESOURCE (RES_ID, NAME, DESCRIPTION, CREATED_BY, CREATED_ON, LAST_MODIFIED_BY, LAST_MODIFIED_ON) 
			select f.RLN_ID, NAME, DESCRIPTION, CREATED_BY, CREATED_ON, LAST_MODIFIED_BY, LAST_MODIFIED_ON
			from REQUIREMENT_LIBRARY_NODE n
			inner join REQUIREMENT_FOLDER f on n.RLN_Id = f.RLN_ID
			where n.DELETED_ON is null;

insert into SIMPLE_RESOURCE (RES_ID) 
			select res.RES_ID
			from REQUIREMENT_LIBRARY_NODE n
			inner join REQUIREMENT_FOLDER f on n.RLN_Id = f.RLN_ID
			inner join RESOURCE res on res.RES_ID = f.RLN_ID
			where n.DELETED_ON is null;

update REQUIREMENT_FOLDER 
			set RES_ID = RLN_ID
			where exists (select 1 from REQUIREMENT_LIBRARY_NODE where REQUIREMENT_LIBRARY_NODE.RLN_ID = REQUIREMENT_FOLDER.RLN_ID and DELETED_ON is null);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Moves requirement folder data into SIMPLE_RESOURCE table', NOW(), 'Custom SQL (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.09', '2.0.5', '3:8eef6e42740a9a0de705a27dcbfa9ba8', 87);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.10::gfouquet::(Checksum: 3:11e8ae33c5eb2ee02e6046721193047f)
-- Creates REQUIREMENT_VERSION table in which we store the versions of requirements
CREATE TABLE REQUIREMENT_VERSION (RES_ID BIGINT NOT NULL, REQUIREMENT_ID BIGINT, REFERENCE VARCHAR(20), VERSION_NUMBER INT DEFAULT 1, CRITICALITY VARCHAR(50) DEFAULT 'UNDEFINED' NOT NULL, REQUIREMENT_STATUS VARCHAR(50) DEFAULT 'WORK_IN_PROGRESS' NOT NULL, ATTACHMENT_LIST_ID BIGINT NOT NULL, CONSTRAINT pk_requirement_version PRIMARY KEY (RES_ID), CONSTRAINT fk_requirement_version_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID), CONSTRAINT fk_req_version_resource FOREIGN KEY (RES_ID) REFERENCES RESOURCE(RES_ID), CONSTRAINT fk_requirement_version_requirement FOREIGN KEY (REQUIREMENT_ID) REFERENCES REQUIREMENT(RLN_ID));

COMMENT ON COLUMN REQUIREMENT_VERSION.RES_ID IS 'shared key with RESOURCE table';

COMMENT ON COLUMN REQUIREMENT_VERSION.REQUIREMENT_ID IS 'FK to the requirement. Should not be null but is nullable because of cyclic association REQ - REQ_VER';

COMMENT ON COLUMN REQUIREMENT_VERSION.REFERENCE IS 'The requirement''s reference';

COMMENT ON COLUMN REQUIREMENT_VERSION.VERSION_NUMBER IS 'This requirement''s version number';

COMMENT ON COLUMN REQUIREMENT_VERSION.CRITICALITY IS 'Requirement criticality. Althought this field is a variable character, the data will be the text representation of an enumeration';

COMMENT ON COLUMN REQUIREMENT_VERSION.ATTACHMENT_LIST_ID IS 'FK to a requirement''s list of attachments';

ALTER TABLE REQUIREMENT_VERSION ADD CONSTRAINT cu_version_of_requirement UNIQUE (REQUIREMENT_ID, VERSION_NUMBER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Creates REQUIREMENT_VERSION table in which we store the versions of requirements', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.10', '2.0.5', '3:11e8ae33c5eb2ee02e6046721193047f', 88);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.11::gfouquet::(Checksum: 3:0baecf978673f11a9f8dd9999fed2cd1)
-- Migrates requirement data into REQUIREMENT_VERSION table
insert into RESOURCE 
				(RES_ID, NAME, DESCRIPTION, CREATED_BY, CREATED_ON, LAST_MODIFIED_BY, LAST_MODIFIED_ON) 
			select r.RLN_ID, NAME, DESCRIPTION, CREATED_BY, CREATED_ON, LAST_MODIFIED_BY, LAST_MODIFIED_ON
			from REQUIREMENT_LIBRARY_NODE n
			inner join REQUIREMENT r on n.RLN_Id = r.RLN_ID
			where n.DELETED_ON is null;

insert into REQUIREMENT_VERSION 
				(RES_ID, REQUIREMENT_ID, REFERENCE, CRITICALITY, ATTACHMENT_LIST_ID) 
			select res.RES_ID, r.RLN_ID, REFERENCE, CRITICALITY, ATTACHMENT_LIST_ID
			from REQUIREMENT_LIBRARY_NODE n
			inner join REQUIREMENT r on n.RLN_Id = r.RLN_ID
			inner join RESOURCE res on res.RES_ID = r.RLN_ID
			where n.DELETED_ON is null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Migrates requirement data into REQUIREMENT_VERSION table', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.11', '2.0.5', '3:0baecf978673f11a9f8dd9999fed2cd1', 89);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.12::gfouquet::(Checksum: 3:4a2bca6beb7751e2c4a5f50b1ecb0c2b)
-- Adds the 'latest version' relationship between REQUIREMENT and REQUIREMENT_VERSION tables
ALTER TABLE REQUIREMENT ADD CURRENT_VERSION_ID BIGINT;

ALTER TABLE REQUIREMENT ADD CONSTRAINT fk_requirement_current_version FOREIGN KEY (CURRENT_VERSION_ID) REFERENCES REQUIREMENT_VERSION (RES_ID);

COMMENT ON COLUMN REQUIREMENT.CURRENT_VERSION_ID IS 'FK to REQUIREMENT_VERSION linking to the requirement''s latest version. Should not be null but the column is nullable because of cyclic relationship between the tables.';

update REQUIREMENT r
			set CURRENT_VERSION_ID = (
				select RES_ID 
				from REQUIREMENT_VERSION rv 
				where rv.REQUIREMENT_ID = r.RLN_ID
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds the ''latest version'' relationship between REQUIREMENT and REQUIREMENT_VERSION tables', NOW(), 'Add Column, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.12', '2.0.5', '3:4a2bca6beb7751e2c4a5f50b1ecb0c2b', 90);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.13::gfouquet::(Checksum: 3:f808950f1318acd85849691d30ef7418)
-- Test Cases now cover Requirements versions. We create a new association table and populate it from TEST_CASE_REQUIREMENT_LINK
CREATE TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION (VERIFIED_REQ_VERSION_ID BIGINT, VERIFYING_TEST_CASE_ID BIGINT, CONSTRAINT fk_verifying_test_case FOREIGN KEY (VERIFYING_TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID), CONSTRAINT fk_verified_req_version FOREIGN KEY (VERIFIED_REQ_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID));

COMMENT ON COLUMN TEST_CASE_VERIFIED_REQUIREMENT_VERSION.VERIFIED_REQ_VERSION_ID IS 'FK to the verified requirement';

COMMENT ON COLUMN TEST_CASE_VERIFIED_REQUIREMENT_VERSION.VERIFYING_TEST_CASE_ID IS 'FK to the verifying test case';

insert into TEST_CASE_VERIFIED_REQUIREMENT_VERSION (VERIFYING_TEST_CASE_ID, VERIFIED_REQ_VERSION_ID)
			select TEST_CASE_ID, RES_ID
			from TEST_CASE_REQUIREMENT_LINK tcrl
			inner join REQUIREMENT_VERSION rv on rv.REQUIREMENT_ID = tcrl.REQUIREMENT_ID;

ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION ALTER COLUMN  VERIFIED_REQ_VERSION_ID SET NOT NULL;

ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION ALTER COLUMN  VERIFYING_TEST_CASE_ID SET NOT NULL;

ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION ADD CONSTRAINT uc_tc_verifies_req_version UNIQUE (VERIFIED_REQ_VERSION_ID, VERIFYING_TEST_CASE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Test Cases now cover Requirements versions. We create a new association table and populate it from TEST_CASE_REQUIREMENT_LINK', NOW(), 'Create Table, Custom SQL, Add Not-Null Constraint (x2), Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.13', '2.0.5', '3:f808950f1318acd85849691d30ef7418', 91);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.14::gfouquet::(Checksum: 3:434950a4c673124b5466920aa1d43907)
-- Trashes the now useless TEST_CASE_REQUIREMENT_LINK table
ALTER TABLE TEST_CASE_REQUIREMENT_LINK DROP CONSTRAINT fk_tc_req_tc;

ALTER TABLE TEST_CASE_REQUIREMENT_LINK DROP CONSTRAINT fk_tc_req_req;

DROP TABLE TEST_CASE_REQUIREMENT_LINK;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Trashes the now useless TEST_CASE_REQUIREMENT_LINK table', NOW(), 'Drop Foreign Key Constraint (x2), Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.14', '2.0.5', '3:434950a4c673124b5466920aa1d43907', 92);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.15::bsiri::(Checksum: 3:df9ca9a019aead911d53118c13fe27b7)
-- This table is the main table of the event logging system, in other words the history of a business entity. As for Squash TM
-- 		version 1.1.0 and until further notice, we log here requirement modifications only. It may grows to log other entities in the future, ie test cases.
-- 		Note : the application will fill this table itself, since we don't want triggers in the database.
CREATE TABLE REQUIREMENT_AUDIT_EVENT (EVENT_ID bigserial NOT NULL, REQ_VERSION_ID BIGINT NOT NULL, EVENT_DATE TIMESTAMP WITH TIME ZONE NOT NULL, AUTHOR VARCHAR(255) NOT NULL, CONSTRAINT PK_REQUIREMENT_AUDIT_EVENT PRIMARY KEY (EVENT_ID), CONSTRAINT fk_audit_event_requirement_version FOREIGN KEY (REQ_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID));

COMMENT ON COLUMN REQUIREMENT_AUDIT_EVENT.REQ_VERSION_ID IS 'the ID of the target entity. As for 1.1.0 and until further notice, the target is always a requirement version.';

COMMENT ON COLUMN REQUIREMENT_AUDIT_EVENT.EVENT_DATE IS 'the timestamp of the log entry';

COMMENT ON COLUMN REQUIREMENT_AUDIT_EVENT.AUTHOR IS 'the login of the user who generated the event';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This table is the main table of the event logging system, in other words the history of a business entity. As for Squash TM
		version 1.1.0 and until further notice, we log here requirement modifications only. It may grows to log other entities in the ...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.15', '2.0.5', '3:df9ca9a019aead911d53118c13fe27b7', 93);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.16::bsiri::(Checksum: 3:f7781e8a8128679b692a576e954b946d)
-- It is a child table of REQUIREMENT_AUDIT_EVENT. This table exists for the sole purpose of qualifying a given event in a creation event, as such its content is empty (the sheer presence
-- 		of an entry in this table is sufficient)
CREATE TABLE REQUIREMENT_CREATION (EVENT_ID BIGINT NOT NULL, CONSTRAINT PK_CREATION_EVENT PRIMARY KEY (EVENT_ID), CONSTRAINT fk_create_audit FOREIGN KEY (EVENT_ID) REFERENCES REQUIREMENT_AUDIT_EVENT(EVENT_ID));

COMMENT ON COLUMN REQUIREMENT_CREATION.EVENT_ID IS 'primary key, which is also a foreign key to REQUIREMENT_AUDIT_EVENT (they share that key : do not make this table autoincrement it).';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'It is a child table of REQUIREMENT_AUDIT_EVENT. This table exists for the sole purpose of qualifying a given event in a creation event, as such its content is empty (the sheer presence
		of an entry in this table is sufficient)', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.16', '2.0.5', '3:f7781e8a8128679b692a576e954b946d', 94);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.17::bsiri::(Checksum: 3:04d14fac6434ead391f617b4f49e303a)
-- This is a child table of REQUIREMENT_AUDIT_EVENT. This table will log updates on the target entity. Not every operations will be logged. 
-- 			Note 1 : As for version 1.1.0 and until further notice for the sake of simplicity we log both the former and the new value. It may change in the future.
-- 			Note 2 : For technical reasons this table exists in two flavors. The twin table is REQUIREMENT_LARGE_PROPERTY_CHANGE. This table will log standard attributes, 
-- 			while the other one will log blobs.
CREATE TABLE REQUIREMENT_PROPERTY_CHANGE (EVENT_ID BIGINT NOT NULL, OLD_VALUE VARCHAR(100), NEW_VALUE VARCHAR(100), PROPERTY_NAME VARCHAR(100), CONSTRAINT PK_PPT_CHANGE PRIMARY KEY (EVENT_ID), CONSTRAINT "fk_PPT_change_audit" FOREIGN KEY (EVENT_ID) REFERENCES REQUIREMENT_AUDIT_EVENT(EVENT_ID));

COMMENT ON COLUMN REQUIREMENT_PROPERTY_CHANGE.EVENT_ID IS 'primary key, which is also a foreign key to REQUIREMENT_AUDIT_EVENT (they share that key : do not make this table autoincrement it).';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This is a child table of REQUIREMENT_AUDIT_EVENT. This table will log updates on the target entity. Not every operations will be logged. 
			Note 1 : As for version 1.1.0 and until further notice for the sake of simplicity we log both the former and th...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.17', '2.0.5', '3:04d14fac6434ead391f617b4f49e303a', 95);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.18::bsiri::(Checksum: 3:f7bcd79666e2e120c0a26260a1028380)
-- This is a child table of REQUIREMENT_AUDIT_EVENT. This table will log updates on the target entity. Not every operations will be logged. 
-- 			Note 1 : As for version 1.1.0 and until further notice for the sake of simplicity we log both the former and the new value. It may change in the future.
-- 			Note 2 : For technical reasons this table exists in two flavors. The twin table is REQUIREMENT_PROPERTY_CHANGE. This table will log blobs, 
-- 			while the other one will log standard attributes.
CREATE TABLE REQUIREMENT_LARGE_PROPERTY_CHANGE (EVENT_ID BIGINT NOT NULL, OLD_VALUE TEXT DEFAULT null, NEW_VALUE TEXT DEFAULT null, PROPERTY_NAME VARCHAR(100), CONSTRAINT PK_LARGE_PPT_CHANGE PRIMARY KEY (EVENT_ID), CONSTRAINT "fk_lPPT_change_audit" FOREIGN KEY (EVENT_ID) REFERENCES REQUIREMENT_AUDIT_EVENT(EVENT_ID));

COMMENT ON COLUMN REQUIREMENT_LARGE_PROPERTY_CHANGE.EVENT_ID IS 'primary key, which is also a foreign key to REQUIREMENT_AUDIT_EVENT (they share that key : do not make this table autoincrement it).';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This is a child table of REQUIREMENT_AUDIT_EVENT. This table will log updates on the target entity. Not every operations will be logged. 
			Note 1 : As for version 1.1.0 and until further notice for the sake of simplicity we log both the former and th...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.18', '2.0.5', '3:f7bcd79666e2e120c0a26260a1028380', 96);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.19::bsiri::(Checksum: 3:9a53e8e6e08eb787dbab66e10b85cfe9)
-- Will immediately update the tables with the create_events of existing requirements.
insert into REQUIREMENT_AUDIT_EVENT (REQ_VERSION_ID, EVENT_DATE, AUTHOR) 
			select rv.RES_ID, CREATED_ON, CREATED_BY  
			from REQUIREMENT_VERSION rv 
			inner join RESOURCE r on r.RES_ID = rv.RES_ID;

insert into REQUIREMENT_CREATION (event_id) select event_id from REQUIREMENT_AUDIT_EVENT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Will immediately update the tables with the create_events of existing requirements.', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.19', '2.0.5', '3:9a53e8e6e08eb787dbab66e10b85cfe9', 97);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.20::gfouquet::(Checksum: 3:bee2aa78c17ce9f26bdc145f4d2faa69)
-- Remove obsolete columns from REQUIREMENT and REQUIREMENT_LIBRARY_NODE table. 
-- 			Data is now in REQUIREMENT_VERSION and REQUIREMENT_FOLDER tables.
ALTER TABLE REQUIREMENT DROP COLUMN REFERENCE;

ALTER TABLE REQUIREMENT DROP COLUMN CRITICALITY;

ALTER TABLE REQUIREMENT DROP CONSTRAINT fk_requirement_attachment_list;

ALTER TABLE REQUIREMENT DROP COLUMN ATTACHMENT_LIST_ID;

ALTER TABLE REQUIREMENT_LIBRARY_NODE DROP COLUMN NAME;

ALTER TABLE REQUIREMENT_LIBRARY_NODE DROP COLUMN DESCRIPTION;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Remove obsolete columns from REQUIREMENT and REQUIREMENT_LIBRARY_NODE table. 
			Data is now in REQUIREMENT_VERSION and REQUIREMENT_FOLDER tables.', NOW(), 'Drop Column (x2), Drop Foreign Key Constraint, Drop Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.20', '2.0.5', '3:bee2aa78c17ce9f26bdc145f4d2faa69', 98);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.21::fogaillard::(Checksum: 3:749fd7e10d0f1275176e6e5379316cb8)
-- Add Prerequisite collumn to the test_case table
ALTER TABLE TEST_CASE ADD PREREQUISITE TEXT DEFAULT null;

COMMENT ON COLUMN TEST_CASE.PREREQUISITE IS 'the prerequisite for a test_case';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('fogaillard', 'Add Prerequisite collumn to the test_case table', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.21', '2.0.5', '3:749fd7e10d0f1275176e6e5379316cb8', 99);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.22::bsiri::(Checksum: 3:f21b8cdf96f5a52a837b8a843b3c0dfd)
-- Add the table TEST_SUITE. A TEST_SUITE is basically a view on a subset of ITERATION_TEST_PLAN_ITEMs.
CREATE TABLE TEST_SUITE (ID bigserial NOT NULL, NAME VARCHAR(100), DESCRIPTION TEXT DEFAULT null, ATTACHMENT_LIST_ID BIGINT NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_TEST_SUITE PRIMARY KEY (ID), CONSTRAINT fk_test_suite_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN TEST_SUITE.CREATED_BY IS 'Who created this test suite';

COMMENT ON COLUMN TEST_SUITE.CREATED_ON IS 'When this test suite was created';

COMMENT ON COLUMN TEST_SUITE.LAST_MODIFIED_BY IS 'Who modified this test suite last';

COMMENT ON COLUMN TEST_SUITE.LAST_MODIFIED_ON IS 'When this test suite was last modified';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Add the table TEST_SUITE. A TEST_SUITE is basically a view on a subset of ITERATION_TEST_PLAN_ITEMs.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.22', '2.0.5', '3:f21b8cdf96f5a52a837b8a843b3c0dfd', 100);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.23::bsiri::(Checksum: 3:cc2c3ce46094fc05b76f34154fea809c)
-- Association table between ITERATION and TEST_SUITE. Like in many other places here, the purpose of this association table is not to model a n-n cardinality between ITERATION and 
-- 			TEST_SUITE, but 1-n. We thus gain performance at the expense of the model quality.
CREATE TABLE ITERATION_TEST_SUITE (ITERATION_ID BIGINT NOT NULL, TEST_SUITE_ID BIGINT NOT NULL, CONSTRAINT fk_iteration_test_suite_suite FOREIGN KEY (TEST_SUITE_ID) REFERENCES TEST_SUITE(ID), CONSTRAINT fk_iteration_test_suite_iteration FOREIGN KEY (ITERATION_ID) REFERENCES ITERATION(ITERATION_ID), UNIQUE (TEST_SUITE_ID));

CREATE INDEX dx_iteration_test_suite_iteration ON ITERATION_TEST_SUITE(ITERATION_ID);

CREATE INDEX dx_iteration_test_suite_suite ON ITERATION_TEST_SUITE(TEST_SUITE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Association table between ITERATION and TEST_SUITE. Like in many other places here, the purpose of this association table is not to model a n-n cardinality between ITERATION and 
			TEST_SUITE, but 1-n. We thus gain performance at the expense of the mo...', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.23', '2.0.5', '3:cc2c3ce46094fc05b76f34154fea809c', 101);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.24::bsiri::(Checksum: 3:7b4ae4519e1c0fa1c18c75f27c75c8a8)
-- Hereby an ITERATION_TEST_PLAN_ITEM shalt reference 0 or 1 TEST_SUITE
ALTER TABLE ITERATION_TEST_PLAN_ITEM ADD TEST_SUITE BIGINT DEFAULT null;

ALTER TABLE ITERATION_TEST_PLAN_ITEM ADD CONSTRAINT fk_itpi_testsuite FOREIGN KEY (TEST_SUITE) REFERENCES TEST_SUITE (ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Hereby an ITERATION_TEST_PLAN_ITEM shalt reference 0 or 1 TEST_SUITE', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.24', '2.0.5', '3:7b4ae4519e1c0fa1c18c75f27c75c8a8', 102);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml::tm-1.1.0.25::fogaillard::(Checksum: 3:507c15d0675f77b3a197c7d7f607f682)
-- Add Prerequisite collumn to the execution table
ALTER TABLE EXECUTION ADD PREREQUISITE TEXT DEFAULT null;

COMMENT ON COLUMN EXECUTION.PREREQUISITE IS 'the prerequisite for a test_case execution';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('fogaillard', 'Add Prerequisite collumn to the execution table', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.1.0.xml', 'tm-1.1.0.25', '2.0.5', '3:507c15d0675f77b3a197c7d7f607f682', 103);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.32::mpagnon::(Checksum: 3:90da51d034265bddab458bf2cb1340e6)
INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.ProjectManager');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '32');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '8');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', '', NOW(), 'Insert Row (x6)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.32', '2.0.5', '3:90da51d034265bddab458bf2cb1340e6', 104);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-1::mpagnon::(Checksum: 3:7ec2104ebfaac35cfc9daac99d3a9326)
-- add acl-class and acl-groups
INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.csp.tm.domain.requirement.RequirementLibrary');

INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.csp.tm.domain.testcase.TestCaseLibrary');

INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.csp.tm.domain.campaign.CampaignLibrary');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.TestRunner');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.TestDesigner');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.AdvanceTester');

INSERT INTO ACL_GROUP (QUALIFIED_NAME) VALUES ('squashtest.acl.group.tm.Validator');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'add acl-class and acl-groups', NOW(), 'Insert Row (x7)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-1', '2.0.5', '3:7ec2104ebfaac35cfc9daac99d3a9326', 105);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-2::mpagnon::(Checksum: 3:e89ca0317424a04b6fd94396619224a6)
-- remove existing permissions and redefine them
TRUNCATE TABLE ACL_GROUP_PERMISSION;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'remove existing permissions and redefine them', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-2', '2.0.5', '3:e89ca0317424a04b6fd94396619224a6', 106);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-3::mpagnon::(Checksum: 3:225504bd6a738b6d974968be183c87f2)
-- ProjectManager / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '32');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '512');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '512');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '128');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1024');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'ProjectManager / CampaignLibrary', NOW(), 'Insert Row (x26)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-3', '2.0.5', '3:225504bd6a738b6d974968be183c87f2', 107);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-4::mpagnon::(Checksum: 3:0b1e26bb09cae69721b814e68ab3e85b)
-- TestEditor / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '128');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1024');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'TestEditor / CampaignLibrary', NOW(), 'Insert Row (x23)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-4', '2.0.5', '3:0b1e26bb09cae69721b814e68ab3e85b', 108);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-5::mpagnon::(Checksum: 3:978f35b6b98e4c777664656ca5842573)
-- ProjectViewer / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'ProjectViewer / CampaignLibrary', NOW(), 'Insert Row (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-5', '2.0.5', '3:978f35b6b98e4c777664656ca5842573', 109);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-6::mpagnon::(Checksum: 3:bee4f7ed123e4e6a36f03f51f9167c98)
-- TestRunner / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '128');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1024');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'TestRunner / CampaignLibrary', NOW(), 'Insert Row (x5)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-6', '2.0.5', '3:bee4f7ed123e4e6a36f03f51f9167c98', 110);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-7::mpagnon::(Checksum: 3:a80fff3186b159d8f7d260916f70bd9a)
-- TestDesigner / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'TestDesigner / CampaignLibrary', NOW(), 'Insert Row (x16)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-7', '2.0.5', '3:a80fff3186b159d8f7d260916f70bd9a', 111);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-8::mpagnon::(Checksum: 3:3c3a9108132480e399c803596ae9c4f2)
-- AdvanceTester / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '128');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1024');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'AdvanceTester / CampaignLibrary', NOW(), 'Insert Row (x14)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-8', '2.0.5', '3:3c3a9108132480e399c803596ae9c4f2', 112);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-9::mpagnon::(Checksum: 3:e3fcbf536483063022c4843f78d506c1)
-- Validator / CampaignLibrary
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Validator / CampaignLibrary', NOW(), 'Insert Row (x6)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-9', '2.0.5', '3:e3fcbf536483063022c4843f78d506c1', 113);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-10::mpagnon::(Checksum: 3:bef756c0b744c1e235e17add47210541)
-- Existing Data Update: Delete acls for deleted projects in 1.1.1
DELETE FROM ACL_RESPONSIBILITY_SCOPE_ENTRY
			 WHERE OBJECT_IDENTITY_ID not in (
				select aoi.ID from  ACL_OBJECT_IDENTITY aoi, ACL_CLASS ac , PROJECT p
				where ac.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project' 
				and ac.ID = aoi.CLASS_ID
				and aoi.IDENTITY = p.PROJECT_ID
			);

DELETE FROM ACL_OBJECT_IDENTITY
			WHERE IDENTITY not in (
				select  p.PROJECT_ID from PROJECT p
			)
			and CLASS_ID in (
				select ac.ID from ACL_CLASS ac where ac.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project' 
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update: Delete acls for deleted projects in 1.1.1', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-10', '2.0.5', '3:bef756c0b744c1e235e17add47210541', 114);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-11::mpagnon::(Checksum: 3:7e07f9d4d5ad2ab698697ce5fb344295)
-- Existing Data Update for ACL_OBJECT_IDENTITY / REQUIREMENT_LIBRARY
insert into ACL_OBJECT_IDENTITY (IDENTITY, CLASS_ID)
			select p.RL_ID, ac2.ID
			from  ACL_CLASS ac1, ACL_CLASS ac2, PROJECT p, ACL_OBJECT_IDENTITY aoi
			where ac2.CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary'
			and p.PROJECT_ID = aoi.IDENTITY
			and aoi.CLASS_ID = ac1.ID 
			and ac1.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_OBJECT_IDENTITY / REQUIREMENT_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-11', '2.0.5', '3:7e07f9d4d5ad2ab698697ce5fb344295', 115);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-12::mpagnon::(Checksum: 3:e341c11b9ecf86ac6c7680940391a38b)
-- Existing Data Update for ACL_OBJECT_IDENTITY / TEST_CASE_LIBRARY
insert into ACL_OBJECT_IDENTITY (IDENTITY, CLASS_ID)
			select p.TCL_ID, ac2.ID
			from  ACL_CLASS ac1, ACL_CLASS ac2, PROJECT p, ACL_OBJECT_IDENTITY aoi
			where ac2.CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary'
			and p.PROJECT_ID = aoi.IDENTITY
			and aoi.CLASS_ID = ac1.ID 
			and ac1.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_OBJECT_IDENTITY / TEST_CASE_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-12', '2.0.5', '3:e341c11b9ecf86ac6c7680940391a38b', 116);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-13::mpagnon::(Checksum: 3:33f76b9ba0f7f5f328b3c31f01b02a65)
-- Existing Data Update for ACL_OBJECT_IDENTITY / CAMPAIGN_LIBRARY
insert into ACL_OBJECT_IDENTITY (IDENTITY, CLASS_ID)
			select p.CL_ID, ac2.ID
			from  ACL_CLASS ac1, ACL_CLASS ac2, PROJECT p, ACL_OBJECT_IDENTITY aoi
			where ac2.CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary'
			and p.PROJECT_ID = aoi.IDENTITY
			and aoi.CLASS_ID = ac1.ID 
			and ac1.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_OBJECT_IDENTITY / CAMPAIGN_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-13', '2.0.5', '3:33f76b9ba0f7f5f328b3c31f01b02a65', 117);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-14::mpagnon::(Checksum: 3:6497fdb66ae815d8badaffaf328f8bce)
-- Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / REQUIREMENT_LIBRARY
insert into ACL_RESPONSIBILITY_SCOPE_ENTRY (USER_ID, ACL_GROUP_ID, OBJECT_IDENTITY_ID)
			select arse.USER_ID, arse.ACL_GROUP_ID, aoiRequirement.ID
			from ACL_RESPONSIBILITY_SCOPE_ENTRY arse, ACL_OBJECT_IDENTITY aoiProject, ACL_CLASS aclassProject, ACL_OBJECT_IDENTITY aoiRequirement, ACL_CLASS aclassRequirement, PROJECT p
			where arse.OBJECT_IDENTITY_ID = aoiProject.ID
			and aoiProject.CLASS_ID = aclassProject.ID
			and aclassProject.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'
			and p.PROJECT_ID = aoiProject.IDENTITY
			and aoiRequirement.IDENTITY = p.RL_ID
			and aoiRequirement.CLASS_ID = aclassRequirement.ID
			and aclassRequirement.CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / REQUIREMENT_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-14', '2.0.5', '3:6497fdb66ae815d8badaffaf328f8bce', 118);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-15::mpagnon::(Checksum: 3:a5201760a6e03f033820401b3f488a7d)
-- Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / TEST_CASE_LIBRARY
insert into ACL_RESPONSIBILITY_SCOPE_ENTRY (USER_ID, ACL_GROUP_ID, OBJECT_IDENTITY_ID)
			select arse.USER_ID, arse.ACL_GROUP_ID, aoiTestCase.ID
			from ACL_RESPONSIBILITY_SCOPE_ENTRY arse, ACL_OBJECT_IDENTITY aoiProject, ACL_CLASS aclassProject, ACL_OBJECT_IDENTITY aoiTestCase, ACL_CLASS aclassTestCase, PROJECT p
			where arse.OBJECT_IDENTITY_ID = aoiProject.ID
			and aoiProject.CLASS_ID = aclassProject.ID
			and aclassProject.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'
			and p.PROJECT_ID = aoiProject.IDENTITY
			and aoiTestCase.IDENTITY = p.TCL_ID
			and aoiTestCase.CLASS_ID = aclassTestCase.ID
			and aclassTestCase.CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / TEST_CASE_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-15', '2.0.5', '3:a5201760a6e03f033820401b3f488a7d', 119);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.34-16::mpagnon::(Checksum: 3:cba831d75d165c2cfa3feb789de74ef9)
-- Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / CAMPAIGN_LIBRARY
insert into ACL_RESPONSIBILITY_SCOPE_ENTRY (USER_ID, ACL_GROUP_ID, OBJECT_IDENTITY_ID)
			select arse.USER_ID, arse.ACL_GROUP_ID, aoiCampaign.ID
			from ACL_RESPONSIBILITY_SCOPE_ENTRY arse, ACL_OBJECT_IDENTITY aoiProject, ACL_CLASS aclassProject, ACL_OBJECT_IDENTITY aoiCampaign, ACL_CLASS aclassCampaign, PROJECT p
			where arse.OBJECT_IDENTITY_ID = aoiProject.ID
			and aoiProject.CLASS_ID = aclassProject.ID
			and aclassProject.CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project'
			and p.PROJECT_ID = aoiProject.IDENTITY
			and aoiCampaign.IDENTITY = p.CL_ID
			and aoiCampaign.CLASS_ID = aclassCampaign.ID
			and aclassCampaign.CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Existing Data Update for ACL_RESPONSIBILITY_SCOPE_ENTRY / CAMPAIGN_LIBRARY', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.34-16', '2.0.5', '3:cba831d75d165c2cfa3feb789de74ef9', 120);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.35-01::bsiri::(Checksum: 3:82a94192242d975538bbc05704aec87d)
-- table ISSUE nows holds the bugtracker name where the remote issues are hosted
ALTER TABLE ISSUE ADD BT_NAME VARCHAR(60) NOT NULL;

UPDATE ISSUE SET BT_NAME = 'default';

CREATE INDEX idx_bt_name ON ISSUE(BT_NAME);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'table ISSUE nows holds the bugtracker name where the remote issues are hosted', NOW(), 'Add Column, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.35-01', '2.0.5', '3:82a94192242d975538bbc05704aec87d', 121);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.36-01::mpagnon::(Checksum: 3:1b5fcef232cf2faab752bd448469dc0c)
-- table RequirementVersion nows holds a Category attribute
ALTER TABLE REQUIREMENT_VERSION ADD CATEGORY VARCHAR(50) NOT NULL DEFAULT 'UNDEFINED';

COMMENT ON COLUMN REQUIREMENT_VERSION.CATEGORY IS 'Requirement category. Althought this field is a variable character, the data will be the text representation of an enumeration';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'table RequirementVersion nows holds a Category attribute', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.36-01', '2.0.5', '3:1b5fcef232cf2faab752bd448469dc0c', 122);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml::tm-1.2.0.36-02::mpagnon::(Checksum: 3:3360838ead20282ef502404a7fefc830)
-- table Test-Case nows holds a Reference attribute
ALTER TABLE TEST_CASE ADD REFERENCE VARCHAR(20) NOT NULL DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'table Test-Case nows holds a Reference attribute', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.2.0.xml', 'tm-1.2.0.36-02', '2.0.5', '3:3360838ead20282ef502404a7fefc830', 123);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0.01::gfouquet::(Checksum: 3:a485a541f9f651ccfaff9d8e6417d1c3)
-- Adds a TM database version number
UPDATE CORE_CONFIG SET STR_KEY = 'squashtest.tm.database.version', VALUE = '1.3.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds a TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0.01', '2.0.5', '3:a485a541f9f651ccfaff9d8e6417d1c3', 124);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0.2::gfouquet::(Checksum: 3:c640d8ac650fe8f6006086929242d891)
-- Add a default group to users who do not have one (should be users from alpha versions)
create temporary table GROUPLESS_USERS (USER_ID INTEGER);

insert
			into GROUPLESS_USERS (USER_ID)
			select cu.ID from CORE_USER cu
			where
			cu.ID not in (select cgm.USER_ID from CORE_GROUP_MEMBER cgm);

insert
			into CORE_GROUP_MEMBER (USER_ID, GROUP_ID)
			select cu.ID, cg.ID
			from
			CORE_USER cu, CORE_GROUP cg
			where cg.QUALIFIED_NAME =
			'squashtest.tm.group.User'
			and cu.ID in (select USER_ID from
			GROUPLESS_USERS);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Add a default group to users who do not have one (should be users from alpha versions)', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0.2', '2.0.5', '3:c640d8ac650fe8f6006086929242d891', 125);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.0::bsiri::(Checksum: 3:d41d8cd98f00b204e9800998ecf8427e)
-- The following serie of changeset labelled tm-1.3-feat-1112.x implements the closure table
-- 			modelization for tree-like data	at 
-- 			http://www.mysqlperformanceblog.com/2011/02/14/moving-subtrees-in-closure-table/, 
-- 			with a focus on the mysql-specifics shortcomings regarding modifying a table already
-- 			under modification. 
-- 			
-- 			Big kudos to you Bill Karwin !
INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The following serie of changeset labelled tm-1.3-feat-1112.x implements the closure table
			modelization for tree-like data	at 
			http://www.mysqlperformanceblog.com/2011/02/14/moving-subtrees-in-closure-table/, 
			with a focus on the mysql-specific...', NOW(), 'Empty', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.0', '2.0.5', '3:d41d8cd98f00b204e9800998ecf8427e', 126);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.01::bsiri::(Checksum: 3:99fd3365d5a4e2e5ab22251b964eb0e4)
-- closure table for test case library nodes. Its content is set and modified by four triggers, see 
-- 			changeset 'tm-1.3-feat-1112.05-mysql' or 'tm-1.3-feat-1112.05-h2'.
CREATE TABLE TCLN_RELATIONSHIP_CLOSURE (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, DEPTH SMALLINT NOT NULL, CONSTRAINT fk_tcln_relationship_clos_desc FOREIGN KEY (DESCENDANT_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID), CONSTRAINT fk_tcln_relationship_clos_anc FOREIGN KEY (ANCESTOR_ID) REFERENCES TEST_CASE_LIBRARY_NODE(TCLN_ID));

COMMENT ON COLUMN TCLN_RELATIONSHIP_CLOSURE.ANCESTOR_ID IS 'cle etrangere vers le noeud parent. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN TCLN_RELATIONSHIP_CLOSURE.DESCENDANT_ID IS 'cle etrangere vers l''element fils. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN TCLN_RELATIONSHIP_CLOSURE.DEPTH IS 'stores how deep is the descendant element nested in the subtree of the ancestor element';

CREATE INDEX idx_tcln_relationship_clos_desc ON TCLN_RELATIONSHIP_CLOSURE(DESCENDANT_ID);

CREATE INDEX idx_tcln_relationship_clos_anc ON TCLN_RELATIONSHIP_CLOSURE(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'closure table for test case library nodes. Its content is set and modified by four triggers, see 
			changeset ''tm-1.3-feat-1112.05-mysql'' or ''tm-1.3-feat-1112.05-h2''.', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.01', '2.0.5', '3:99fd3365d5a4e2e5ab22251b964eb0e4', 127);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.02::bsiri::(Checksum: 3:441617d39b17884a498947ee0356236a)
-- closure table for requirement library nodes. Its content is set and modified by four triggers, see 
-- 			changeset 'tm-1.3-feat-1112.06-mysql' or 'tm-1.3-feat-1112.06-h2'.
CREATE TABLE RLN_RELATIONSHIP_CLOSURE (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, DEPTH SMALLINT NOT NULL, CONSTRAINT fk_rln_relationship_clos_anc FOREIGN KEY (ANCESTOR_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID), CONSTRAINT fk_rln_relationship_clos_desc FOREIGN KEY (DESCENDANT_ID) REFERENCES REQUIREMENT_LIBRARY_NODE(RLN_ID));

COMMENT ON COLUMN RLN_RELATIONSHIP_CLOSURE.ANCESTOR_ID IS 'cle etrangere vers le noeud parent. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN RLN_RELATIONSHIP_CLOSURE.DESCENDANT_ID IS 'cle etrangere vers l''element fils. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN RLN_RELATIONSHIP_CLOSURE.DEPTH IS 'stores how deep is the descendant element nested in the subtree of the ancestor element';

CREATE INDEX idx_rln_relationship_clos_desc ON RLN_RELATIONSHIP_CLOSURE(DESCENDANT_ID);

CREATE INDEX idx_rln_relationship_clos_anc ON RLN_RELATIONSHIP_CLOSURE(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'closure table for requirement library nodes. Its content is set and modified by four triggers, see 
			changeset ''tm-1.3-feat-1112.06-mysql'' or ''tm-1.3-feat-1112.06-h2''.', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.02', '2.0.5', '3:441617d39b17884a498947ee0356236a', 128);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.03::bsiri::(Checksum: 3:adf216326aaf2837331d8a203b98f174)
-- closure table for campaign library nodes. Its content is set and modified by four triggers, see 
-- 			changeset 'tm-1.3-feat-1112.07-mysql' or 'tm-1.3-feat-1112.07-h2'.
CREATE TABLE CLN_RELATIONSHIP_CLOSURE (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, DEPTH SMALLINT NOT NULL, CONSTRAINT fk_cln_relationship_clos_desc FOREIGN KEY (DESCENDANT_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID), CONSTRAINT fk_cln_relationship_clos_anc FOREIGN KEY (ANCESTOR_ID) REFERENCES CAMPAIGN_LIBRARY_NODE(CLN_ID));

COMMENT ON COLUMN CLN_RELATIONSHIP_CLOSURE.ANCESTOR_ID IS 'cle etrangere vers le noeud parent. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN CLN_RELATIONSHIP_CLOSURE.DESCENDANT_ID IS 'cle etrangere vers l''element fils. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN CLN_RELATIONSHIP_CLOSURE.DEPTH IS 'stores how deep is the descendant element nested in the subtree of the ancestor element';

CREATE INDEX idx_cln_relationship_clos_desc ON CLN_RELATIONSHIP_CLOSURE(DESCENDANT_ID);

CREATE INDEX idx_cln_relationship_clos_anc ON CLN_RELATIONSHIP_CLOSURE(ANCESTOR_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'closure table for campaign library nodes. Its content is set and modified by four triggers, see 
			changeset ''tm-1.3-feat-1112.07-mysql'' or ''tm-1.3-feat-1112.07-h2''.', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.03', '2.0.5', '3:adf216326aaf2837331d8a203b98f174', 129);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.04::bsiri::(Checksum: 3:c8cc273c614bb28a8fcdb028c25dbc3f)
-- first step of the migration : creation of temporary tables in which we will dump 
-- 			the X_RELATIONSHIP tables, then truncate the later. We will reinsert the data once 
-- 			the triggers are all set.
CREATE TABLE TCLN_RELATIONSHIP_TMP (ANCESTOR_ID BIGINT, DESCENDANT_ID BIGINT);

CREATE TABLE RLN_RELATIONSHIP_TMP (ANCESTOR_ID BIGINT, DESCENDANT_ID BIGINT);

CREATE TABLE CLN_RELATIONSHIP_TMP (ANCESTOR_ID BIGINT, DESCENDANT_ID BIGINT);

insert into TCLN_RELATIONSHIP_TMP
			select * from TCLN_RELATIONSHIP;

insert into RLN_RELATIONSHIP_TMP
			select * from RLN_RELATIONSHIP;

insert into CLN_RELATIONSHIP_TMP
			select * from CLN_RELATIONSHIP;

delete from TCLN_RELATIONSHIP;

delete from RLN_RELATIONSHIP;

delete from CLN_RELATIONSHIP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'first step of the migration : creation of temporary tables in which we will dump 
			the X_RELATIONSHIP tables, then truncate the later. We will reinsert the data once 
			the triggers are all set.', NOW(), 'Create Table (x3), Custom SQL (x6)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.04', '2.0.5', '3:c8cc273c614bb28a8fcdb028c25dbc3f', 130);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.05-postgresql::mpagnon::(Checksum: 3:d7cfa1ff5ebb8a2ce685d566dbcf7bb8)
-- postgresql-triggers for TCLN_RELATIONSHIP_CLOSURE table
drop trigger if exists ins_tcln_after on TEST_CASE_LIBRARY_NODE;
      drop function if exists ins_tcln_after();
      create function ins_tcln_after() returns trigger as $ins_tcln_after$
      begin
        insert into TCLN_RELATIONSHIP_CLOSURE
        values (new.tcln_id, new.tcln_id, 0); 
        return new;
      end;
      $ins_tcln_after$ language plpgsql;
      
      create trigger ins_tcln_after after insert on TEST_CASE_LIBRARY_NODE
      for each row execute procedure ins_tcln_after();

drop trigger if exists del_tcln_before on TEST_CASE_LIBRARY_NODE;
      drop function if exists del_tcln_before();
      create function del_tcln_before() returns trigger as $del_tcln_before$
      begin
        delete from TCLN_RELATIONSHIP_CLOSURE 
        where ancestor_id=old.tcln_id 
        and descendant_id=old.tcln_id;  
        return old;
      end;
      $del_tcln_before$ language plpgsql;
      
      create trigger del_tcln_before before delete on TEST_CASE_LIBRARY_NODE
      for each row execute procedure del_tcln_before();

drop trigger if exists attach_tcln_after on TCLN_RELATIONSHIP;
      drop function if exists attach_tcln_after();
      create function attach_tcln_after() returns trigger as $attach_tcln_after$
      begin
        insert into TCLN_RELATIONSHIP_CLOSURE
        select c1.ancestor_id, c2.descendant_id, c1.depth + c2.depth + 1
        from TCLN_RELATIONSHIP_CLOSURE c1
        cross join TCLN_RELATIONSHIP_CLOSURE c2
        where c1.descendant_id = new.ancestor_id
        and c2.ancestor_id = new.descendant_id;   
        return new;
      end;
      $attach_tcln_after$ language plpgsql;
      
      create trigger attach_tcln_after after insert on TCLN_RELATIONSHIP
      for each row execute procedure attach_tcln_after();

drop trigger if exists detach_tcln_before on TCLN_RELATIONSHIP;
      drop function if exists detach_tcln_before();
      create function detach_tcln_before() returns trigger as $detach_tcln_before$
      begin
        delete from TCLN_RELATIONSHIP_CLOSURE 
        where descendant_id in ( select descendant_id from TCLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        and ancestor_id not in ( select descendant_id from TCLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        ;
        return old;
      
      end;
      $detach_tcln_before$ language plpgsql;
      
      create trigger detach_tcln_before before delete on TCLN_RELATIONSHIP
      for each row execute procedure detach_tcln_before();

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'postgresql-triggers for TCLN_RELATIONSHIP_CLOSURE table', NOW(), 'Create Procedure (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.05-postgresql', '2.0.5', '3:d7cfa1ff5ebb8a2ce685d566dbcf7bb8', 131);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.06-postgresql::mpagnon::(Checksum: 3:da5c2a4af847f6c0dd3abd5c9db52da5)
-- postgresql-triggers for RLN_RELATIONSHIP_CLOSURE table
drop trigger if exists ins_rln_after on REQUIREMENT_LIBRARY_NODE;
      drop function if exists ins_rln_after();
      create function ins_rln_after() returns trigger as $ins_rln_after$
      begin
        insert into RLN_RELATIONSHIP_CLOSURE 
        values (new.rln_id, new.rln_id, 0);
        return new;
      end;
      $ins_rln_after$ language plpgsql;
      
      create trigger ins_rln_after after insert on REQUIREMENT_LIBRARY_NODE
      for each row execute procedure ins_rln_after();

drop trigger if exists del_rln_before on REQUIREMENT_LIBRARY_NODE;
      drop function if exists del_rln_before();
      create function del_rln_before() returns trigger as $del_rln_before$
      begin
        delete from RLN_RELATIONSHIP_CLOSURE 
        where ancestor_id = old.rln_id 
        and descendant_id = old.rln_id; 
        return old;
      end;
      $del_rln_before$ language plpgsql;
      
      create trigger del_rln_before before delete on REQUIREMENT_LIBRARY_NODE
      for each row execute procedure del_rln_before();

drop trigger if exists attach_rln_after on RLN_RELATIONSHIP;
      drop function if exists attach_rln_after();
      create function attach_rln_after() returns trigger as $attach_rln_after$
      begin
        insert into RLN_RELATIONSHIP_CLOSURE
        select c1.ancestor_id, c2.descendant_id, c1.depth + c2.depth + 1
        from RLN_RELATIONSHIP_CLOSURE c1
        cross join RLN_RELATIONSHIP_CLOSURE c2
        where c1.descendant_id = new.ancestor_id
        and c2.ancestor_id = new.descendant_id;
        return new;
      end;
      $attach_rln_after$ language plpgsql;
      
      create trigger attach_rln_after after insert on RLN_RELATIONSHIP
      for each row execute procedure attach_rln_after();

drop trigger if exists detach_rln_before on RLN_RELATIONSHIP;
      drop function if exists detach_rln_before();
      create function detach_rln_before() returns trigger as $detach_rln_before$
      begin
      delete from RLN_RELATIONSHIP_CLOSURE 
        where descendant_id in ( select descendant_id from RLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        and ancestor_id not in ( select descendant_id from RLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        ;
        return old;
      end;
      $detach_rln_before$ language plpgsql;
      
      create trigger detach_rln_before before delete on RLN_RELATIONSHIP
      for each row execute procedure detach_rln_before();

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'postgresql-triggers for RLN_RELATIONSHIP_CLOSURE table', NOW(), 'Create Procedure (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.06-postgresql', '2.0.5', '3:da5c2a4af847f6c0dd3abd5c9db52da5', 132);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.07-postgresql::mpagnon::(Checksum: 3:12027eeb905361558c5c7d9532191d3b)
-- postgresql-triggers for CLN_RELATIONSHIP_CLOSURE table
drop trigger if exists ins_cln_after on CAMPAIGN_LIBRARY_NODE;
      drop function if exists ins_cln_after();
      create function ins_cln_after() returns trigger as $ins_cln_after$
      begin
        insert into CLN_RELATIONSHIP_CLOSURE
        values (new.cln_id, new.cln_id, 0);
        return new;
      end;
      $ins_cln_after$ language plpgsql;
      
      create trigger ins_cln_after after insert on CAMPAIGN_LIBRARY_NODE
      for each row execute procedure ins_cln_after();

drop trigger if exists del_cln_before on CAMPAIGN_LIBRARY_NODE;
      drop function if exists del_cln_before();
      create function del_cln_before() returns trigger as $del_cln_before$
      begin
        delete from CLN_RELATIONSHIP_CLOSURE 
        where ancestor_id = old.cln_id 
        and descendant_id = old.cln_id;
        return old;
      end;
      $del_cln_before$ language plpgsql;
      
      create trigger del_cln_before before delete on CAMPAIGN_LIBRARY_NODE
      for each row execute procedure del_cln_before();

drop trigger if exists attach_cln_after on CLN_RELATIONSHIP;
       drop function if exists attach_cln_after();
      create function attach_cln_after() returns trigger as $attach_cln_after$
      begin
        insert into CLN_RELATIONSHIP_CLOSURE
        select c1.ancestor_id, c2.descendant_id, c1.depth + c2.depth + 1
        from CLN_RELATIONSHIP_CLOSURE c1
        cross join CLN_RELATIONSHIP_CLOSURE c2
        where c1.descendant_id = new.ancestor_id
        and c2.ancestor_id = new.descendant_id;
        return new;
      end;
      $attach_cln_after$ language plpgsql;
      
      create trigger attach_cln_after after insert on CLN_RELATIONSHIP
      for each row execute procedure attach_cln_after();

drop trigger if exists detach_cln_before on CLN_RELATIONSHIP;
      drop function if exists detach_cln_before();
      create function detach_cln_before() returns trigger as $detach_cln_before$
      begin
        delete from CLN_RELATIONSHIP_CLOSURE 
        where descendant_id in ( select descendant_id from CLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        and ancestor_id not in ( select descendant_id from CLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
        ;
        return old;
      end;
      $detach_cln_before$ language plpgsql;
      
      create trigger detach_cln_before before delete on CLN_RELATIONSHIP
      for each row execute procedure detach_cln_before();

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'postgresql-triggers for CLN_RELATIONSHIP_CLOSURE table', NOW(), 'Create Procedure (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.07-postgresql', '2.0.5', '3:12027eeb905361558c5c7d9532191d3b', 133);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.08::bsiri::(Checksum: 3:8fe9ae051c17a059358fb13d14f2ed29)
-- this step is mandatory if we want the next one to work (triggers need the nodes to have self-reference in the closure tables)
insert into TCLN_RELATIONSHIP_CLOSURE
			select tcln_id, tcln_id, 0
			from TEST_CASE_LIBRARY_NODE
			where deleted_on is null;

insert into RLN_RELATIONSHIP_CLOSURE
			select rln_id, rln_id, 0
			from
			REQUIREMENT_LIBRARY_NODE
			where deleted_on is null;

insert into CLN_RELATIONSHIP_CLOSURE
			select cln_id, cln_id, 0
			from
			CAMPAIGN_LIBRARY_NODE
			where deleted_on is null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'this step is mandatory if we want the next one to work (triggers need the nodes to have self-reference in the closure tables)', NOW(), 'Custom SQL (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.08', '2.0.5', '3:8fe9ae051c17a059358fb13d14f2ed29', 134);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.09::bsiri::(Checksum: 3:639e7a0abd3bc0a34b286a770910f8b4)
-- we can now reinsert our data from the tmp tables and let the triggers do the job
insert into TCLN_RELATIONSHIP
			select * from TCLN_RELATIONSHIP_TMP;

insert into RLN_RELATIONSHIP
			select * from RLN_RELATIONSHIP_TMP;

insert into CLN_RELATIONSHIP
			select * from CLN_RELATIONSHIP_TMP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'we can now reinsert our data from the tmp tables and let the triggers do the job', NOW(), 'Custom SQL (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.09', '2.0.5', '3:639e7a0abd3bc0a34b286a770910f8b4', 135);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1112.10::bsiri::(Checksum: 3:d0a27d40e8e9b9efb5ebe6a91abb6aca)
-- If success, we can now drop our temp tables and complete the migration
DROP TABLE TCLN_RELATIONSHIP_TMP;

DROP TABLE RLN_RELATIONSHIP_TMP;

DROP TABLE CLN_RELATIONSHIP_TMP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'If success, we can now drop our temp tables and complete the migration', NOW(), 'Drop Table (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1112.10', '2.0.5', '3:d0a27d40e8e9b9efb5ebe6a91abb6aca', 136);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1209.01::mpagnon::(Checksum: 3:defbf8305a7fce0c9d2f6523331d888c)
-- To connect Squash TM to a bugtracker, you must provide the name and the url of the bugtracker. The mantis plugin is shipped with the application
-- 	 IFRAME_FRIENDLY :tells if the bugtracker page can be accessed through an iframe : if the response header of the bugtracker page has the property [X-Frame-Options = DENY] the answer is false
-- 	 URL : must point to the base name of the end point. Eg : http://www.yourdomain.com/mantis . Tips : Prefer IPs over localhost and domain names over IPs. If you don't some minor issues may occur when reporting an issue.
CREATE TABLE BUGTRACKER (BUGTRACKER_ID bigserial NOT NULL, NAME VARCHAR(50) NOT NULL, KIND VARCHAR(50) DEFAULT 'mantis' NOT NULL, URL VARCHAR(255) NOT NULL, IFRAME_FRIENDLY BOOLEAN DEFAULT FALSE NOT NULL, CONSTRAINT PK_BUGTRACKER PRIMARY KEY (BUGTRACKER_ID));

COMMENT ON TABLE BUGTRACKER IS 'stores bugtrackers informations';

COMMENT ON COLUMN BUGTRACKER.BUGTRACKER_ID IS 'primary key, should be auto-generated.';

COMMENT ON COLUMN BUGTRACKER.NAME IS 'identifies the instance configured.';

COMMENT ON COLUMN BUGTRACKER.KIND IS 'tells what kind of connector should be used';

COMMENT ON COLUMN BUGTRACKER.URL IS 'the bugtracker url';

COMMENT ON COLUMN BUGTRACKER.IFRAME_FRIENDLY IS 'tells if the bugtracker page can be accessed through an iframe';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'To connect Squash TM to a bugtracker, you must provide the name and the url of the bugtracker. The mantis plugin is shipped with the application
	 IFRAME_FRIENDLY :tells if the bugtracker page can be accessed through an iframe : if the response header ...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1209.01', '2.0.5', '3:defbf8305a7fce0c9d2f6523331d888c', 137);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1181.01::bsiri::(Checksum: 3:089301e7802af061a7135098a5805bdd)
-- creating table TEST_AUTOMATION_SERVER
CREATE TABLE TEST_AUTOMATION_SERVER (SERVER_ID bigserial NOT NULL, BASE_URL VARCHAR(255) NOT NULL, LOGIN VARCHAR(50) NOT NULL, PASSWORD VARCHAR(255) NOT NULL, KIND VARCHAR(30) DEFAULT 'jenkins' NOT NULL, CONSTRAINT PK_TEST_AUTOMATION_SERVER PRIMARY KEY (SERVER_ID));

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.BASE_URL IS 'the url of the server';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.LOGIN IS 'the login TM will use';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.PASSWORD IS 'yes, this is a plain clear password in the database. Until we have what it takes to make it better.';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.KIND IS 'the kind of automated test server TM will deal with.';

CREATE INDEX idx_autotest_server ON TEST_AUTOMATION_SERVER(SERVER_ID);

ALTER TABLE TEST_AUTOMATION_SERVER ADD CONSTRAINT uni_autotest_server UNIQUE (BASE_URL, LOGIN);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'creating table TEST_AUTOMATION_SERVER', NOW(), 'Create Table, Create Index, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1181.01', '2.0.5', '3:089301e7802af061a7135098a5805bdd', 138);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1181.02::bsiri::(Checksum: 3:62bfccf08ab461a9202a7288e1df89be)
-- creating table TEST_AUTOMATION_PROJECT
CREATE TABLE TEST_AUTOMATION_PROJECT (PROJECT_ID bigserial NOT NULL, NAME VARCHAR(50) NOT NULL, SERVER_ID BIGINT, CONSTRAINT PK_TEST_AUTOMATION_PROJECT PRIMARY KEY (PROJECT_ID), CONSTRAINT fk_auto_test_project FOREIGN KEY (SERVER_ID) REFERENCES TEST_AUTOMATION_SERVER(SERVER_ID));

COMMENT ON COLUMN TEST_AUTOMATION_PROJECT.SERVER_ID IS 'foreign key to an automated test server';

CREATE INDEX idx_auto_test_project ON TEST_AUTOMATION_PROJECT(PROJECT_ID);

ALTER TABLE TEST_AUTOMATION_PROJECT ADD CONSTRAINT uni_autotest_project UNIQUE (NAME, SERVER_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'creating table TEST_AUTOMATION_PROJECT', NOW(), 'Create Table, Create Index, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1181.02', '2.0.5', '3:62bfccf08ab461a9202a7288e1df89be', 139);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1181.03::bsiri::(Checksum: 3:0aa83558ede587eab6dba3c5615274b8)
-- now a PROJECT may or may not have test automation enabled
ALTER TABLE PROJECT ADD TEST_AUTOMATION_ENABLED BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'now a PROJECT may or may not have test automation enabled', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1181.03', '2.0.5', '3:0aa83558ede587eab6dba3c5615274b8', 140);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1181.04::bsiri::(Checksum: 3:2e342ec4d8845ca9310cb70c3992379e)
-- table where TM projects and TA projects are bound to each others
CREATE TABLE TM_TA_PROJECTS (TM_PROJECT_ID BIGINT NOT NULL, TA_PROJECT_ID BIGINT NOT NULL, CONSTRAINT fk_tm_ta_projects_tm FOREIGN KEY (TM_PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_tm_ta_projects_ta FOREIGN KEY (TA_PROJECT_ID) REFERENCES TEST_AUTOMATION_PROJECT(PROJECT_ID));

ALTER TABLE TM_TA_PROJECTS ADD CONSTRAINT pk_tm_ta_projects PRIMARY KEY (TM_PROJECT_ID, TA_PROJECT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'table where TM projects and TA projects are bound to each others', NOW(), 'Create Table, Add Primary Key', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1181.04', '2.0.5', '3:2e342ec4d8845ca9310cb70c3992379e', 141);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.01::mpagnon::(Checksum: 3:a8249eba32af76a637ec9ea446e92e54)
-- Bugtracker project represent the project's name in a configured bugtracker
CREATE TABLE BUGTRACKER_BINDING (BUGTRACKER_BINDING_ID bigserial NOT NULL, BUGTRACKER_ID BIGINT NOT NULL, PROJECT_NAME VARCHAR(255), PROJECT_ID BIGINT NOT NULL, CONSTRAINT PK_BUGTRACKER_BINDING PRIMARY KEY (BUGTRACKER_BINDING_ID), CONSTRAINT FK_BUGTRACKER_BINDING_BUGTRACKER FOREIGN KEY (BUGTRACKER_ID) REFERENCES BUGTRACKER(BUGTRACKER_ID), CONSTRAINT FK_BUGTRACKER_BINDING_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN BUGTRACKER_BINDING.PROJECT_NAME IS 'project-name in the bugtracker';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Bugtracker project represent the project''s name in a configured bugtracker', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.01', '2.0.5', '3:a8249eba32af76a637ec9ea446e92e54', 142);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.04::mpagnon::(Checksum: 3:ccc10006653c4f2635a3768dc6a2f04e)
-- Data migration: add all bugtrackers that had an issue
insert into BUGTRACKER (NAME, KIND, URL, IFRAME_FRIENDLY)
			select distinct issues.BT_NAME , 'mantis', 'TO BE DEFINED', true
			from ISSUE issues;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Data migration: add all bugtrackers that had an issue', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.04', '2.0.5', '3:ccc10006653c4f2635a3768dc6a2f04e', 143);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.05::mpagnon::(Checksum: 3:a9bd40911864a678b0c67e6fb8f4253f)
-- New foreign key in ISSUE table that points to a BUGTRACKER
ALTER TABLE ISSUE ADD BUGTRACKER_ID BIGINT;

ALTER TABLE ISSUE ADD CONSTRAINT fk_issue_bugtracker FOREIGN KEY (BUGTRACKER_ID) REFERENCES BUGTRACKER (BUGTRACKER_ID);

COMMENT ON COLUMN ISSUE.BUGTRACKER_ID IS 'Issue''s bugtracker';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'New foreign key in ISSUE table that points to a BUGTRACKER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.05', '2.0.5', '3:a9bd40911864a678b0c67e6fb8f4253f', 144);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.06::mpagnon::(Checksum: 3:410ac4d270b36d8c582a4ae001a307f4)
-- Data migration : update issue's bugtracker FK with migrated BTs
CREATE TABLE ISSUEBT
			(
			ISSUEID BIGINT,
			BTID BIGINT
			);

Insert into ISSUEBT (ISSUEID, BTID)
			select distinct iss.ISSUE_ID,
			bt.BUGTRACKER_ID
			from ISSUE as iss, BUGTRACKER as bt
			where iss.BT_NAME = bt.NAME;

update ISSUE
			set BUGTRACKER_ID = (
				select BTID from ISSUEBT 
				where ISSUEBT.ISSUEID = ISSUE.ISSUE_ID
			);

DROP table ISSUEBT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Data migration : update issue''s bugtracker FK with migrated BTs', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.06', '2.0.5', '3:410ac4d270b36d8c582a4ae001a307f4', 145);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.07::mpagnon::(Checksum: 3:8db7a0d029f7e427f43c482f6f49ebe7)
-- Drop of column "BT_NAME" on table issue because it is not used anymore => use of FK to table BUGTRACKER instead
ALTER TABLE ISSUE DROP COLUMN BT_NAME;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Drop of column "BT_NAME" on table issue because it is not used anymore => use of FK to table BUGTRACKER instead', NOW(), 'Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.07', '2.0.5', '3:8db7a0d029f7e427f43c482f6f49ebe7', 146);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1194.08::mpagnon::(Checksum: 3:27f8b473a60fb5a4eeee9f6faa4c82d8)
-- After Data migration : issue's bugtracker must not be null
ALTER TABLE ISSUE ALTER COLUMN  BUGTRACKER_ID SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'After Data migration : issue''s bugtracker must not be null', NOW(), 'Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1194.08', '2.0.5', '3:27f8b473a60fb5a4eeee9f6faa4c82d8', 147);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1210.01::bsiri::(Checksum: 3:4c9b3806e8ad67f8b6ceb37a62616d18)
-- Creation of the table AUTOMATED_TEST
CREATE TABLE AUTOMATED_TEST (TEST_ID bigserial NOT NULL, NAME VARCHAR(255), PROJECT_ID BIGINT, CONSTRAINT PK_AUTOMATED_TEST PRIMARY KEY (TEST_ID), CONSTRAINT fk_automated_test_project FOREIGN KEY (PROJECT_ID) REFERENCES TEST_AUTOMATION_PROJECT(PROJECT_ID));

ALTER TABLE AUTOMATED_TEST ADD CONSTRAINT uni_auto_test UNIQUE (NAME, PROJECT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creation of the table AUTOMATED_TEST', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1210.01', '2.0.5', '3:4c9b3806e8ad67f8b6ceb37a62616d18', 148);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1210.02::bsiri::(Checksum: 3:b3908ccdd7b72dc53d6d9645fe358b98)
-- a TEST_CASE can now refer to 0 or 1 AUTOMATED_TEST
ALTER TABLE TEST_CASE ADD TA_TEST BIGINT DEFAULT null;

ALTER TABLE TEST_CASE ADD CONSTRAINT fk_test_case_ta_test FOREIGN KEY (TA_TEST) REFERENCES AUTOMATED_TEST (TEST_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'a TEST_CASE can now refer to 0 or 1 AUTOMATED_TEST', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1210.02', '2.0.5', '3:b3908ccdd7b72dc53d6d9645fe358b98', 149);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1210.03::gfouquet::(Checksum: 3:5c1676c12fff5e9fb3d0088a83a86006)
-- Added a role / group for test automation clients
INSERT INTO CORE_GROUP (QUALIFIED_NAME) VALUES ('squashtest.authz.group.tm.TestAutomationServer');

INSERT INTO CORE_GROUP_AUTHORITY (AUTHORITY, GROUP_ID) VALUES ('ROLE_TA_API_CLIENT', (select max(ID) from CORE_GROUP));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Added a role / group for test automation clients', NOW(), 'Insert Row (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1210.03', '2.0.5', '3:5c1676c12fff5e9fb3d0088a83a86006', 150);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1211.01::bsiri::(Checksum: 3:8acdd23d131835dfe7e74448a92297d1)
-- Creation of the automated suites table. Note that althought its ID is
-- 			still the primary key, it won't be autogenerated : the system will supply it 
-- 			along the rest instead.
-- 			
-- 			A automated suite groups together a bunch of test automation executions, 
-- 			which themselves refer to test automation tests.
CREATE TABLE AUTOMATED_SUITE (SUITE_ID VARCHAR(50) NOT NULL, CONSTRAINT PK_AUTOMATED_SUITE PRIMARY KEY (SUITE_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creation of the automated suites table. Note that althought its ID is
			still the primary key, it won''t be autogenerated : the system will supply it 
			along the rest instead.
			
			A automated suite groups together a bunch of test automation execut...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1211.01', '2.0.5', '3:8acdd23d131835dfe7e74448a92297d1', 151);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml::tm-1.3.0-feat-1211.02::bsiri::(Checksum: 3:a101bd36f7d9c501c587cf5e6d5c78c0)
-- Table for the automated executions extender. An automated execution is 
-- 			an extension to Executions that handles things related to test automation.
-- 			
-- 			The correct business model would have been that an automated execution is a specialization of 
-- 			execution, thus inherited from it. Sadly Hibernates got in the way so we came
-- 			up with that solution instead.
CREATE TABLE AUTOMATED_EXECUTION_EXTENDER (EXTENDER_ID bigserial NOT NULL, MASTER_EXECUTION_ID BIGINT NOT NULL, TEST_ID BIGINT NOT NULL, RESULT_URL VARCHAR(300), SUITE_ID VARCHAR(50), RESULT_SUMMARY TEXT DEFAULT null, CONSTRAINT PK_AUTOMATED_EXECUTION_EXTENDER PRIMARY KEY (EXTENDER_ID), CONSTRAINT fk_auto_exec_suite FOREIGN KEY (SUITE_ID) REFERENCES AUTOMATED_SUITE(SUITE_ID), CONSTRAINT fk_auto_exec_exec FOREIGN KEY (MASTER_EXECUTION_ID) REFERENCES EXECUTION(EXECUTION_ID), CONSTRAINT fk_auto_exec_auto_test FOREIGN KEY (TEST_ID) REFERENCES AUTOMATED_TEST(TEST_ID));

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.MASTER_EXECUTION_ID IS 'foreign key to the Execution it attaches to.';

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.TEST_ID IS 'we save that information as soon as the auto execution is created,              because it may change in the future (even if the test case that this execution             is linked to stays otherwhise the same)';

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.RESULT_URL IS 'urls longer than 300 chars should go to hell';

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.SUITE_ID IS 'foreignkey of the suite this execution belongs to';

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.RESULT_SUMMARY IS 'a short debriefing of a test once it has been        executed, for instance an error message';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Table for the automated executions extender. An automated execution is 
			an extension to Executions that handles things related to test automation.
			
			The correct business model would have been that an automated execution is a specialization of 
...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.3.0.xml', 'tm-1.3.0-feat-1211.02', '2.0.5', '3:a101bd36f7d9c501c587cf5e6d5c78c0', 152);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.00::gfouquet::(Checksum: 3:4ef18a63bbd3169cef35179fb8c91028)
-- Adds a TM database version number
UPDATE CORE_CONFIG SET STR_KEY = 'squashtest.tm.database.version', VALUE = '1.4.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds a TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.00', '2.0.5', '3:4ef18a63bbd3169cef35179fb8c91028', 153);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0-feat-1109.01::gfouquet::(Checksum: 3:8f83c1af5962af42e68d6401ef310c9f)
-- Creates a table for Custom Fields
CREATE TABLE CUSTOM_FIELD (CF_ID bigserial NOT NULL, FIELD_TYPE CHAR(3) NOT NULL, NAME VARCHAR(255) NOT NULL, LABEL VARCHAR(255) DEFAULT '' NOT NULL, OPTIONAL BOOLEAN DEFAULT TRUE NOT NULL, DEFAULT_VALUE VARCHAR(255), INPUT_TYPE CHAR(30) NOT NULL, CONSTRAINT pk_custom_field PRIMARY KEY (CF_ID));

COMMENT ON COLUMN CUSTOM_FIELD.FIELD_TYPE IS 'CF : simple, SSF : multiple-choice';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Creates a table for Custom Fields', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0-feat-1109.01', '2.0.5', '3:8f83c1af5962af42e68d6401ef310c9f', 154);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0-feat-1109.02::gfouquet::(Checksum: 3:ec08ab8b8e2359f529da4a311a6c84ab)
-- Creates a table for Custom Fields Options
CREATE TABLE CUSTOM_FIELD_OPTION (CF_ID BIGINT NOT NULL, LABEL VARCHAR(255) NOT NULL, POSITION INT NOT NULL, CONSTRAINT fk_cf_option_cf FOREIGN KEY (CF_ID) REFERENCES CUSTOM_FIELD(CF_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Creates a table for Custom Fields Options', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0-feat-1109.02', '2.0.5', '3:ec08ab8b8e2359f529da4a311a6c84ab', 155);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0-feat-1390.01::gfouquet::(Checksum: 3:cadfa5b3c7e141db73867b4bc8e98a18)
-- Creates a table for Custom Fields Binding
CREATE TABLE CUSTOM_FIELD_BINDING (CFB_ID bigserial NOT NULL, CF_ID BIGINT NOT NULL, BOUND_ENTITY VARCHAR(30) NOT NULL, BOUND_PROJECT_ID BIGINT NOT NULL, POSITION INT, CONSTRAINT pk_cfb_option PRIMARY KEY (CFB_ID), CONSTRAINT fk_cfb_bound_project FOREIGN KEY (BOUND_PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_cfb_cf FOREIGN KEY (CF_ID) REFERENCES CUSTOM_FIELD(CF_ID));

ALTER TABLE CUSTOM_FIELD_BINDING ADD CONSTRAINT uc_cf_entity_proj_bnd UNIQUE (BOUND_PROJECT_ID, BOUND_ENTITY, CF_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Creates a table for Custom Fields Binding', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0-feat-1390.01', '2.0.5', '3:cadfa5b3c7e141db73867b4bc8e98a18', 156);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0-feat-1390.02::gfouquet::(Checksum: 3:8fc5d161321c668c715d5e5a5be4bf90)
-- Creates a table for rendering locations of a bound custom field
CREATE TABLE CUSTOM_FIELD_RENDERING_LOCATION (CFB_ID BIGINT NOT NULL, RENDERING_LOCATION VARCHAR(30) NOT NULL, CONSTRAINT fk_cfb_render_loc_cfb FOREIGN KEY (CFB_ID) REFERENCES CUSTOM_FIELD_BINDING(CFB_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Creates a table for rendering locations of a bound custom field', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0-feat-1390.02', '2.0.5', '3:8fc5d161321c668c715d5e5a5be4bf90', 157);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.01::mpagnon::(Checksum: 3:2b44c9ff7d0cf014f99833e33912a423)
-- Add property attachment list in library nodes, projects and libraries
ALTER TABLE TEST_CASE_LIBRARY_NODE ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE TEST_CASE_LIBRARY_NODE ADD CONSTRAINT "fk_tcNode_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN TEST_CASE_LIBRARY_NODE.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE CAMPAIGN_LIBRARY_NODE ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE CAMPAIGN_LIBRARY_NODE ADD CONSTRAINT "fk_campNode_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN CAMPAIGN_LIBRARY_NODE.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE RESOURCE ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE RESOURCE ADD CONSTRAINT fk_resource_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN RESOURCE.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE PROJECT ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN PROJECT.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE REQUIREMENT_LIBRARY ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE REQUIREMENT_LIBRARY ADD CONSTRAINT "fk_reqLib_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN REQUIREMENT_LIBRARY.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE TEST_CASE_LIBRARY ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE TEST_CASE_LIBRARY ADD CONSTRAINT "fk_tcLib_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN TEST_CASE_LIBRARY.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

ALTER TABLE CAMPAIGN_LIBRARY ADD ATTACHMENT_LIST_ID BIGINT;

ALTER TABLE CAMPAIGN_LIBRARY ADD CONSTRAINT "fk_campLib_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

COMMENT ON COLUMN CAMPAIGN_LIBRARY.ATTACHMENT_LIST_ID IS 'clé étrangère vers un ATTACHMENT_LIST, l''entité qui gère les pièces jointes.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add property attachment list in library nodes, projects and libraries', NOW(), 'Add Column (x7)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.01', '2.0.5', '3:2b44c9ff7d0cf014f99833e33912a423', 158);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.02::mpagnon::(Checksum: 3:1699dc3bd6443b42d5b84be37244fcdf)
-- Migrate existing attachment lists
update TEST_CASE_LIBRARY_NODE
			set ATTACHMENT_LIST_ID = (select TEST_CASE.ATTACHMENT_LIST_ID from TEST_CASE where TEST_CASE.TCLN_ID = TEST_CASE_LIBRARY_NODE.TCLN_ID);

update CAMPAIGN_LIBRARY_NODE
			set ATTACHMENT_LIST_ID = (select CAMPAIGN.ATTACHMENT_LIST_ID from CAMPAIGN where CAMPAIGN.CLN_ID = CAMPAIGN_LIBRARY_NODE.CLN_ID);

update RESOURCE
			set ATTACHMENT_LIST_ID = (select REQUIREMENT_VERSION.ATTACHMENT_LIST_ID from REQUIREMENT_VERSION where REQUIREMENT_VERSION.RES_ID = RESOURCE.RES_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Migrate existing attachment lists', NOW(), 'Custom SQL (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.02', '2.0.5', '3:1699dc3bd6443b42d5b84be37244fcdf', 159);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.03::mpagnon::(Checksum: 3:9489cb2edd3dd5c64179ed2221a3e581)
-- Add attachment lists to test_case_folders
ALTER TABLE ATTACHMENT_LIST ADD TCLN_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT fk_tcln FOREIGN KEY (TCLN_ID) REFERENCES TEST_CASE_LIBRARY_NODE (TCLN_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.TCLN_ID IS 'colonne provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (TCLN_ID)
			select TEST_CASE_FOLDER.TCLN_ID from TEST_CASE_FOLDER;

update TEST_CASE_LIBRARY_NODE 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.TCLN_ID = TEST_CASE_LIBRARY_NODE.TCLN_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT fk_tcln;

ALTER TABLE ATTACHMENT_LIST DROP COLUMN TCLN_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to test_case_folders', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.03', '2.0.5', '3:9489cb2edd3dd5c64179ed2221a3e581', 160);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.04::mpagnon::(Checksum: 3:9067e9a177ebc3d48e3ba6ee428dfa95)
-- Add attachment lists to campaign_folders
ALTER TABLE ATTACHMENT_LIST ADD CLN_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT fk_cln FOREIGN KEY (CLN_ID) REFERENCES CAMPAIGN_LIBRARY_NODE (CLN_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.CLN_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (CLN_ID)
			select CAMPAIGN_FOLDER.CLN_ID from CAMPAIGN_FOLDER;

update CAMPAIGN_LIBRARY_NODE 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.CLN_ID = CAMPAIGN_LIBRARY_NODE.CLN_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT fk_cln;

ALTER TABLE ATTACHMENT_LIST DROP COLUMN CLN_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to campaign_folders', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.04', '2.0.5', '3:9067e9a177ebc3d48e3ba6ee428dfa95', 161);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.05::mpagnon::(Checksum: 3:132d9664007ea9ef0be3785013bba662)
-- Add attachment lists to requirement folders
ALTER TABLE ATTACHMENT_LIST ADD RES_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT fk_sr FOREIGN KEY (RES_ID) REFERENCES RESOURCE (RES_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.RES_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (RES_ID)
			select SIMPLE_RESOURCE.RES_ID from SIMPLE_RESOURCE;

update RESOURCE 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.RES_ID = RESOURCE.RES_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT fk_sr;

ALTER TABLE ATTACHMENT_LIST DROP COLUMN RES_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to requirement folders', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.05', '2.0.5', '3:132d9664007ea9ef0be3785013bba662', 162);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.06::mpagnon::(Checksum: 3:8f9980911439ce0cbb91a1cf37288805)
-- Add attachment lists to projects
ALTER TABLE ATTACHMENT_LIST ADD PROJECT_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT fk_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (PROJECT_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.PROJECT_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (PROJECT_ID)
			select PROJECT.PROJECT_ID from PROJECT;

update PROJECT 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.PROJECT_ID = PROJECT.PROJECT_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT fk_project;

ALTER TABLE ATTACHMENT_LIST DROP COLUMN PROJECT_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to projects', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.06', '2.0.5', '3:8f9980911439ce0cbb91a1cf37288805', 163);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.07::mpagnon::(Checksum: 3:8effa97f3aa3afdfb1165e54f3590dbb)
-- Add attachment lists to reqLib
ALTER TABLE ATTACHMENT_LIST ADD RL_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT "fk_rLib" FOREIGN KEY (RL_ID) REFERENCES REQUIREMENT_LIBRARY (RL_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.RL_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (RL_ID)
			select REQUIREMENT_LIBRARY.RL_ID from REQUIREMENT_LIBRARY;

update REQUIREMENT_LIBRARY 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.RL_ID = REQUIREMENT_LIBRARY.RL_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT "fk_rLib";

ALTER TABLE ATTACHMENT_LIST DROP COLUMN RL_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to reqLib', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.07', '2.0.5', '3:8effa97f3aa3afdfb1165e54f3590dbb', 164);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.08::mpagnon::(Checksum: 3:a0a88d53a3a4159ea8924339b4ec7371)
-- Add attachment lists to test_case_library
ALTER TABLE ATTACHMENT_LIST ADD TCL_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT "fk_tcLib" FOREIGN KEY (TCL_ID) REFERENCES TEST_CASE_LIBRARY (TCL_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.TCL_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (TCL_ID)
			select TEST_CASE_LIBRARY.TCL_ID from TEST_CASE_LIBRARY;

update TEST_CASE_LIBRARY 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.TCL_ID = TEST_CASE_LIBRARY.TCL_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT "fk_tcLib";

ALTER TABLE ATTACHMENT_LIST DROP COLUMN TCL_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to test_case_library', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.08', '2.0.5', '3:a0a88d53a3a4159ea8924339b4ec7371', 165);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.09::mpagnon::(Checksum: 3:eb49cfdde8f39905ce3134599987b174)
-- Add attachment lists to campaign libraries
ALTER TABLE ATTACHMENT_LIST ADD CL_ID BIGINT;

ALTER TABLE ATTACHMENT_LIST ADD CONSTRAINT "fk_cLib" FOREIGN KEY (CL_ID) REFERENCES CAMPAIGN_LIBRARY (CL_ID);

COMMENT ON COLUMN ATTACHMENT_LIST.CL_ID IS 'table provisoire pour se rapeller de à qui était destinée la nouvelle attachment_list';

insert into ATTACHMENT_LIST (CL_ID)
			select CAMPAIGN_LIBRARY.CL_ID from CAMPAIGN_LIBRARY;

update CAMPAIGN_LIBRARY 
			set ATTACHMENT_LIST_ID = (select ATTACHMENT_LIST.ATTACHMENT_LIST_ID from ATTACHMENT_LIST where ATTACHMENT_LIST.CL_ID = CAMPAIGN_LIBRARY.CL_ID)
			where ATTACHMENT_LIST_ID is null;

ALTER TABLE ATTACHMENT_LIST DROP CONSTRAINT "fk_cLib";

ALTER TABLE ATTACHMENT_LIST DROP COLUMN CL_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add attachment lists to campaign libraries', NOW(), 'Add Column, Custom SQL (x2), Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.09', '2.0.5', '3:eb49cfdde8f39905ce3134599987b174', 166);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.010::mpagnon::(Checksum: 3:53271a83b14f6d877528c3f746ade8c8)
-- Make attachment_list_ids new fks not nullable
ALTER TABLE TEST_CASE_LIBRARY_NODE ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE CAMPAIGN_LIBRARY_NODE ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE RESOURCE ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE PROJECT ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE REQUIREMENT_LIBRARY ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE CAMPAIGN_LIBRARY ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

ALTER TABLE TEST_CASE_LIBRARY ALTER COLUMN  ATTACHMENT_LIST_ID SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Make attachment_list_ids new fks not nullable', NOW(), 'Add Not-Null Constraint (x7)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.010', '2.0.5', '3:53271a83b14f6d877528c3f746ade8c8', 167);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1513.11::mpagnon::(Checksum: 3:d9940e95526714a749acbc2df372c2cf)
-- Drop previous attachment list ids
ALTER TABLE TEST_CASE DROP CONSTRAINT fk_test_case_attachment_list;

ALTER TABLE CAMPAIGN DROP CONSTRAINT fk_campaign_attachment_list;

ALTER TABLE REQUIREMENT_VERSION DROP CONSTRAINT fk_requirement_version_attachment_list;

ALTER TABLE TEST_CASE DROP COLUMN ATTACHMENT_LIST_ID;

ALTER TABLE CAMPAIGN DROP COLUMN ATTACHMENT_LIST_ID;

ALTER TABLE REQUIREMENT_VERSION DROP COLUMN ATTACHMENT_LIST_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Drop previous attachment list ids', NOW(), 'Drop Foreign Key Constraint (x3), Drop Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1513.11', '2.0.5', '3:d9940e95526714a749acbc2df372c2cf', 168);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1392.01::bsiri::(Checksum: 3:3ff2bd1da5ba3ca536fefc185d4f5c77)
-- The table CUSTOM_FIELD_VALUE holds instances of a CUSTOM_FIELD that are bound to instances of : 
-- 			test cases, requirement version, campagnes, iterations and test suites. A custom field value is created 
-- 			when a custom field binding is created or an entity subject to an existing custom field binding is created. 
-- 			A custom field value is destroyed when the bound entity instance is destroyed or the custom field binding 
-- 			is destroyed.			
-- 						
-- 			Note that in this table the coupling between the custom field value and the bound entity is week : it consists of a pair
-- 			of Type/ID (BINDABLE_ENTITY_TYPE and BINDABLE_ENTITY_ID) rather than a foreign key to the said entity, nor is true 
-- 			the opposite ( ie no FK from a test case to a custom field value).
CREATE TABLE CUSTOM_FIELD_VALUE (CFV_ID bigserial NOT NULL, BOUND_ENTITY_ID BIGINT NOT NULL, BOUND_ENTITY_TYPE VARCHAR(30) NOT NULL, CFB_ID BIGINT NOT NULL, VALUE VARCHAR(255), CONSTRAINT pk_custom_field_value PRIMARY KEY (CFV_ID), CONSTRAINT fk_cfv_cf_binding FOREIGN KEY (CFB_ID) REFERENCES CUSTOM_FIELD_BINDING(CFB_ID));

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.CFV_ID IS 'technical id';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.BOUND_ENTITY_ID IS 'the id of the bound entity';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.BOUND_ENTITY_TYPE IS 'the kind of entity. Note that this information is also contained by the                  custom field binding.';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.CFB_ID IS 'the custom field binding that holds all the data';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.VALUE IS 'the value of that particular custom field value';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The table CUSTOM_FIELD_VALUE holds instances of a CUSTOM_FIELD that are bound to instances of : 
			test cases, requirement version, campagnes, iterations and test suites. A custom field value is created 
			when a custom field binding is created or an...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1392.01', '2.0.5', '3:3ff2bd1da5ba3ca536fefc185d4f5c77', 169);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1553.00::flaurens::(Checksum: 3:09e5775825b118f2e53c9ee6b264b530)
-- Adds a nature field to test cases
ALTER TABLE TEST_CASE ADD TC_NATURE VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adds a nature field to test cases', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1553.00', '2.0.5', '3:09e5775825b118f2e53c9ee6b264b530', 170);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1554.00::flaurens::(Checksum: 3:ff8827ecb0c7f0a6464bf71be87b1d2d)
-- Adds a type field to test cases
ALTER TABLE TEST_CASE ADD TC_TYPE VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adds a type field to test cases', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1554.00', '2.0.5', '3:ff8827ecb0c7f0a6464bf71be87b1d2d', 171);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1609.00::flaurens::(Checksum: 3:bc981c15be6c964ee3c651fe7a50fe66)
-- Adds a status field to test cases
ALTER TABLE TEST_CASE ADD TC_STATUS VARCHAR(30) NOT NULL DEFAULT 'WORK_IN_PROGRESS';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adds a status field to test cases', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1609.00', '2.0.5', '3:bc981c15be6c964ee3c651fe7a50fe66', 172);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1596.00::flaurens::(Checksum: 3:9265cec34c398e1e0e2e5db46f9e01bc)
-- Adds test case related fields to executions for denormalization
ALTER TABLE EXECUTION ADD TC_NATURE VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

ALTER TABLE EXECUTION ADD TC_TYPE VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

ALTER TABLE EXECUTION ADD TC_STATUS VARCHAR(30) NOT NULL DEFAULT 'WORK_IN_PROGRESS';

ALTER TABLE EXECUTION ADD IMPORTANCE VARCHAR(20) NOT NULL DEFAULT 'LOW';

ALTER TABLE EXECUTION ADD REFERENCE VARCHAR(20) DEFAULT null;

ALTER TABLE EXECUTION ADD TC_DESCRIPTION TEXT DEFAULT null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adds test case related fields to executions for denormalization', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1596.00', '2.0.5', '3:9265cec34c398e1e0e2e5db46f9e01bc', 173);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1596.01::flaurens::(Checksum: 3:417f247ae9933e6f592c9d1caa4d4997)
-- adds test case information to executions created prior to the changeset tm-1.4.0.feat-1596.00
create table EXECUTION_TEST_CASE_DATA (TCLN_ID BIGINT, TC_DESCRIPTION TEXT, REFERENCE VARCHAR(20), IMPORTANCE VARCHAR(20), TC_NATURE VARCHAR(30), TC_TYPE VARCHAR(30), TC_STATUS VARCHAR(30));

insert into EXECUTION_TEST_CASE_DATA (TCLN_ID, TC_DESCRIPTION, REFERENCE, IMPORTANCE, TC_NATURE, TC_TYPE, TC_STATUS)
				select
					tc.tcln_id AS TCLN_ID,
					tcln.description AS DESCRIPTION,
					tc.reference AS REFERENCE,
					tc.importance AS IMPORTANCE,
					tc.tc_nature AS TCNATURE,
					tc.tc_type AS TCTYPE,
					tc.tc_status AS TCSTATUS
				from TEST_CASE tc
				join TEST_CASE_LIBRARY_NODE tcln on tcln.tcln_id = tc.tcln_id;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adds test case information to executions created prior to the changeset tm-1.4.0.feat-1596.00', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1596.01', '2.0.5', '3:417f247ae9933e6f592c9d1caa4d4997', 174);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1596.01-a::mpagnon::(Checksum: 3:52c10d25222de47923adddd800a091c9)
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1596.01-b::mpagnon::(Checksum: 3:ed14382f2e7eb8cb7b61be96640dbe8b)
-- this grammar is not supported by h2 and is more efficient
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1110.01::gfouquet::(Checksum: 3:cb29a4e0fdfd7678777182ec9d4378f2)
-- Adds a type discriminator column on PROJECT
ALTER TABLE PROJECT ADD PROJECT_TYPE CHAR(1) NOT NULL DEFAULT 'P';

COMMENT ON COLUMN PROJECT.PROJECT_TYPE IS 'P: project, T: project template';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Adds a type discriminator column on PROJECT', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1110.01', '2.0.5', '3:cb29a4e0fdfd7678777182ec9d4378f2', 175);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1393.01::mpagnon::(Checksum: 3:c8dd98f3b1a0724f1d6620ae4dbef481)
-- Adds a className for the ProjectTemplate, this is needed so that a project template can hold user's permissions
INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.csp.tm.domain.project.ProjectTemplate');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Adds a className for the ProjectTemplate, this is needed so that a project template can hold user''s permissions', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1393.01', '2.0.5', '3:c8dd98f3b1a0724f1d6620ae4dbef481', 176);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1628.01::flaurens::(Checksum: 3:3fa7ef454684cf4578514710e007516a)
ALTER TABLE REQUIREMENT_VERSION ALTER COLUMN  REFERENCE SET DEFAULT '';

ALTER TABLE TEST_CASE ALTER COLUMN  REFERENCE SET DEFAULT '';

ALTER TABLE EXECUTION ALTER COLUMN  REFERENCE SET DEFAULT '';

ALTER TABLE REQUIREMENT_VERSION ALTER COLUMN REFERENCE TYPE VARCHAR(50);

ALTER TABLE TEST_CASE ALTER COLUMN REFERENCE TYPE VARCHAR(50);

ALTER TABLE EXECUTION ALTER COLUMN REFERENCE TYPE VARCHAR(50);

ALTER TABLE REQUIREMENT_VERSION ALTER COLUMN  REFERENCE SET DEFAULT '';

ALTER TABLE TEST_CASE ALTER COLUMN  REFERENCE SET DEFAULT '';

ALTER TABLE EXECUTION ALTER COLUMN  REFERENCE SET DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Add Default Value (x3), Modify data type (x3), Add Default Value (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1628.01', '2.0.5', '3:3fa7ef454684cf4578514710e007516a', 177);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1638.01::mpagnon::(Checksum: 3:7fedce0143f1676056ea73d819d85dd5)
ALTER TABLE CUSTOM_FIELD ADD CODE VARCHAR(30) NOT NULL DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1638.01', '2.0.5', '3:7fedce0143f1676056ea73d819d85dd5', 178);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml::tm-1.4.0.feat-1638.02::mpagnon::(Checksum: 3:6083a7212cc3145d022f30bf00f6e614)
ALTER TABLE CUSTOM_FIELD_OPTION ADD CODE VARCHAR(30) NOT NULL DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.0.xml', 'tm-1.4.0.feat-1638.02', '2.0.5', '3:6083a7212cc3145d022f30bf00f6e614', 179);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml::tm-1.4.1.00::mpagnon::(Checksum: 3:b37d19668e368b6ee87bbfb67d57268a)
-- Adds a TM database version number
UPDATE CORE_CONFIG SET STR_KEY = 'squashtest.tm.database.version', VALUE = '1.4.1' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Adds a TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml', 'tm-1.4.1.00', '2.0.5', '3:b37d19668e368b6ee87bbfb67d57268a', 180);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml::tm-1.4.1.issue-1864-01::mpagnon::(Checksum: 3:e85391a9baa4b3fb216c065df7314754)
-- fixed database integrity for execution importance
update EXECUTION exe
			set importance = 'LOW'
			where exe.importance <>
			'LOW'
			and exe.importance <> 'HIGH'
			and exe.importance <>
			'MEDIUM'
			and exe.importance <> 'VERY_HIGH';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'fixed database integrity for execution importance', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml', 'tm-1.4.1.issue-1864-01', '2.0.5', '3:e85391a9baa4b3fb216c065df7314754', 181);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml::tm-1.4.1.issue-1864-02::mpagnon::(Checksum: 3:08780dc3dfe52747bff4119bf0b7cccd)
-- fixed database integrity for execution tc_nature
update EXECUTION exe
			set tc_nature = 'UNDEFINED'
			where exe.tc_nature <>
			'ATDD'
			and exe.tc_nature <> 'BUSINESS_TESTING'
			and exe.tc_nature <> 'FUNCTIONAL_TESTING'
			and exe.tc_nature <> 'NON_FUNCTIONAL_TESTING'
			and exe.tc_nature <> 'PERFORMANCE_TESTING'
			and exe.tc_nature <> 'SECURITY_TESTING'
			and exe.tc_nature <> 'UNDEFINED'
			and exe.tc_nature <> 'USER_TESTING';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'fixed database integrity for execution tc_nature', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml', 'tm-1.4.1.issue-1864-02', '2.0.5', '3:08780dc3dfe52747bff4119bf0b7cccd', 182);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml::tm-1.4.1.issue-1864-03::mpagnon::(Checksum: 3:4257292a1081cc6f06ad1ac43ae324b5)
-- fixed database integrity for execution tc_type
update EXECUTION exe
			set tc_type = 'UNDEFINED'
			where exe.tc_type <>
			'COMPLIANCE_TESTING'
			and exe.tc_type <> 'CORRECTION_TESTING'
			and exe.tc_type <> 'END_TO_END_TESTING'
			and exe.tc_type <> 'EVOLUTION_TESTING'
			and exe.tc_type <> 'PARTNER_TESTING'
			and exe.tc_type <> 'REGRESSION_TESTING'
			and exe.tc_type <> 'UNDEFINED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'fixed database integrity for execution tc_type', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml', 'tm-1.4.1.issue-1864-03', '2.0.5', '3:4257292a1081cc6f06ad1ac43ae324b5', 183);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml::tm-1.4.1.issue-1864-04::mpagnon::(Checksum: 3:e84cc2e8f2b57d7a3fd2d91f4bfff9fc)
-- fixed database integrity for execution tc_status
update EXECUTION exe
			set tc_status = 'WORK_IN_PROGRESS'
			where exe.tc_status
			<> 'APPROVED'
			and exe.tc_status <> 'OBSOLETE'
			and exe.tc_status <> 'TO_BE_UPDATED'
			and exe.tc_status <> 'UNDER_REVIEW'
			and exe.tc_status <> 'WORK_IN_PROGRESS';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'fixed database integrity for execution tc_status', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.4.1.xml', 'tm-1.4.1.issue-1864-04', '2.0.5', '3:e84cc2e8f2b57d7a3fd2d91f4bfff9fc', 184);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00::mpagnon::(Checksum: 3:771816a2a8ccd3044f6b266fd3f73b69)
-- Update TM database version number
UPDATE CORE_CONFIG SET STR_KEY = 'squashtest.tm.database.version', VALUE = '1.5.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00', '2.0.5', '3:771816a2a8ccd3044f6b266fd3f73b69', 185);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.feat-1596.02::bsiri::(Checksum: 3:772dac41f7a3501da93800e6abc69972)
-- dropping the temp table from changest tm-1.4.0.feat-1596.01
DROP TABLE EXECUTION_TEST_CASE_DATA;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'dropping the temp table from changest tm-1.4.0.feat-1596.01', NOW(), 'Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.feat-1596.02', '2.0.5', '3:772dac41f7a3501da93800e6abc69972', 186);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-issue-1838.01::mpagnon::(Checksum: 3:8a1c20d21263fa9fcec49bd647dfeaa0)
-- Update table custom-field-value so that all mandatory cuf have a value
update CUSTOM_FIELD_VALUE
			set VALUE = (
			select cf.DEFAULT_VALUE
			from CUSTOM_FIELD_BINDING cfb
			join CUSTOM_FIELD cf on cfb.CF_ID =
			cf.CF_ID
			where cfb.CFB_ID = CUSTOM_FIELD_VALUE.CFB_ID
			)
			where
			(CUSTOM_FIELD_VALUE.VALUE is null or
			LTRIM(RTRIM(CUSTOM_FIELD_VALUE.VALUE)) = '' )
			and exists (
			select *
			from CUSTOM_FIELD_BINDING cfb
			join CUSTOM_FIELD cf on cfb.CF_ID =
			cf.CF_ID
			where cfb.CFB_ID = CUSTOM_FIELD_VALUE.CFB_ID
			and cf.OPTIONAL =
			false);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update table custom-field-value so that all mandatory cuf have a value', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-issue-1838.01', '2.0.5', '3:8a1c20d21263fa9fcec49bd647dfeaa0', 187);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1390.03::bsiri::(Checksum: 3:c0563be4ca255d84a63edf5200f670d6)
-- adding cascade delete on the rendering locations when custom field bindings are removed (prune the orphans)
ALTER TABLE CUSTOM_FIELD_RENDERING_LOCATION DROP CONSTRAINT fk_cfb_render_loc_cfb;

ALTER TABLE CUSTOM_FIELD_RENDERING_LOCATION ADD CONSTRAINT fk_cfb_render_loc_cfb FOREIGN KEY (CFB_ID) REFERENCES CUSTOM_FIELD_BINDING (CFB_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'adding cascade delete on the rendering locations when custom field bindings are removed (prune the orphans)', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1390.03', '2.0.5', '3:c0563be4ca255d84a63edf5200f670d6', 188);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1850.01::mpagnon::(Checksum: 3:474031fcb1dbc12086d9d94fccfa8567)
-- The table DENORMALIZED_FIELD_VALUE holds instances of a FIELD that are bound to instances of : 
-- 			executions, execution-steps	when they are created from test-cases or test-case-steps holding CUSTOM_FIELDS.
-- 			A "denormalized field value" is destroyed when the "denormalized field holder" instance is destroyed.
-- 						
-- 			Note that in this table the coupling between the "denormalized field value" and the "denormalized field holder" is week : it consists of a pair
-- 			of Type/ID (DENORMALIZED_FIELD_HOLDER_TYPE and DENORMALIZED_FIELD_HOLDER_ID) rather than a foreign key to the said entity, nor is true 
-- 			the opposite ( ie no FK from an execution to a denormalized field value).
CREATE TABLE DENORMALIZED_FIELD_VALUE (DFV_ID bigserial NOT NULL, CFV_ID BIGINT, CODE VARCHAR(30) DEFAULT '' NOT NULL, DENORMALIZED_FIELD_HOLDER_ID BIGINT NOT NULL, DENORMALIZED_FIELD_HOLDER_TYPE VARCHAR(30) NOT NULL, INPUT_TYPE CHAR(30) NOT NULL, LABEL VARCHAR(255) DEFAULT '' NOT NULL, POSITION INT, VALUE VARCHAR(255), CONSTRAINT pk_denormalized_field PRIMARY KEY (DFV_ID));

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.CFV_ID IS 'the custom field value where the denormalized field is copied from';

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.DENORMALIZED_FIELD_HOLDER_ID IS 'the id of the denormalized field holder.';

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.DENORMALIZED_FIELD_HOLDER_TYPE IS 'the kind of entity.';

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.VALUE IS 'the value of that particular custom field value';

ALTER TABLE DENORMALIZED_FIELD_VALUE ADD CONSTRAINT fk_dfv_cfv_binding FOREIGN KEY (CFV_ID) REFERENCES CUSTOM_FIELD_VALUE (CFV_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'The table DENORMALIZED_FIELD_VALUE holds instances of a FIELD that are bound to instances of : 
			executions, execution-steps	when they are created from test-cases or test-case-steps holding CUSTOM_FIELDS.
			A "denormalized field value" is destroyed ...', NOW(), 'Create Table, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1850.01', '2.0.5', '3:474031fcb1dbc12086d9d94fccfa8567', 189);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1850.02::mpagnon::(Checksum: 3:6d7439f1e6df0371a72e9dc76e7f913e)
-- Create table for denormalized field rendering location
CREATE TABLE DENORMALIZED_FIELD_RENDERING_LOCATION (DFV_ID BIGINT NOT NULL, RENDERING_LOCATION VARCHAR(30) NOT NULL);

ALTER TABLE DENORMALIZED_FIELD_RENDERING_LOCATION ADD CONSTRAINT fk_dfb_render_loc_dfb FOREIGN KEY (DFV_ID) REFERENCES DENORMALIZED_FIELD_VALUE (DFV_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Create table for denormalized field rendering location', NOW(), 'Create Table, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1850.02', '2.0.5', '3:6d7439f1e6df0371a72e9dc76e7f913e', 190);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0-feat-821::gfouquet::(Checksum: 3:eec7880021f82a34d47341ee4df5da78)
-- Change class names in ACL system
UPDATE ACL_CLASS SET CLASSNAME = 'org.squashtest.tm.domain.project.Project' WHERE CLASSNAME = 'org.squashtest.csp.tm.domain.project.Project';

UPDATE ACL_CLASS SET CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary' WHERE CLASSNAME = 'org.squashtest.csp.tm.domain.requirement.RequirementLibrary';

UPDATE ACL_CLASS SET CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary' WHERE CLASSNAME = 'org.squashtest.csp.tm.domain.testcase.TestCaseLibrary';

UPDATE ACL_CLASS SET CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary' WHERE CLASSNAME = 'org.squashtest.csp.tm.domain.campaign.CampaignLibrary';

UPDATE ACL_CLASS SET CLASSNAME = 'org.squashtest.tm.domain.project.ProjectTemplate' WHERE CLASSNAME = 'org.squashtest.csp.tm.domain.project.ProjectTemplate';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', 'Change class names in ACL system', NOW(), 'Update Data (x5)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0-feat-821', '2.0.5', '3:eec7880021f82a34d47341ee4df5da78', 191);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.01::mpagnon::(Checksum: 3:17ff51de01f9ae0d7d952b07493eb882)
-- Create tables CORE_PARTY, CORE_TEAM
CREATE TABLE CORE_PARTY (PARTY_ID bigserial NOT NULL, CONSTRAINT pk_party PRIMARY KEY (PARTY_ID));

CREATE TABLE CORE_TEAM (PARTY_ID BIGINT NOT NULL, NAME VARCHAR(50) NOT NULL, DESCRIPTION VARCHAR(255), CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, CONSTRAINT pk_team PRIMARY KEY (PARTY_ID), CONSTRAINT fk_team_party FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY(PARTY_ID));

COMMENT ON COLUMN CORE_TEAM.PARTY_ID IS 'cle primaire, qui est aussi une cle etrangere vers la table PARTY_ID Ne doit donc pas etre autogeneree.';

COMMENT ON COLUMN CORE_TEAM.CREATED_ON IS 'Date de creation. Il s''agit de la date de creation de l''entree dans       la base, non d''une date metier.';

COMMENT ON COLUMN CORE_TEAM.LAST_MODIFIED_ON IS 'Date de derniere mise a jour de cette instance.';

COMMENT ON COLUMN CORE_TEAM.LAST_MODIFIED_BY IS 'Nom du dernier utilisateur ayant mis a jour cet instance.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Create tables CORE_PARTY, CORE_TEAM', NOW(), 'Create Table (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.01', '2.0.5', '3:17ff51de01f9ae0d7d952b07493eb882', 192);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.02::mpagnon::(Checksum: 3:7ce1a4865ebee7c34cb6c05bf46bac63)
-- change name of USER_ID into PARTY_ID in CORE_USER, ACL_RESPONSIBILITY_SCOPE_ENTRY and CORE_GROUP_MEMBER. We need to drop FKs on user first.
ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM DROP CONSTRAINT fk_camp_tp_user;

ALTER TABLE ITERATION_TEST_PLAN_ITEM DROP CONSTRAINT fk_itertestplan_user;

ALTER TABLE ACL_RESPONSIBILITY_SCOPE_ENTRY DROP CONSTRAINT FK_RESP_SCOPE_USER;

ALTER TABLE CORE_GROUP_MEMBER DROP CONSTRAINT FK_GRP_MEMBER_USR;

ALTER TABLE CORE_USER RENAME COLUMN ID TO PARTY_ID;

ALTER TABLE ACL_RESPONSIBILITY_SCOPE_ENTRY RENAME COLUMN USER_ID TO PARTY_ID;

ALTER TABLE CORE_GROUP_MEMBER RENAME COLUMN USER_ID TO PARTY_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'change name of USER_ID into PARTY_ID in CORE_USER, ACL_RESPONSIBILITY_SCOPE_ENTRY and CORE_GROUP_MEMBER. We need to drop FKs on user first.', NOW(), 'Drop Foreign Key Constraint (x4), Rename Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.02', '2.0.5', '3:7ce1a4865ebee7c34cb6c05bf46bac63', 193);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.04::mpagnon::(Checksum: 3:a9a4dabaa3984599d89f8dd17f56397a)
-- Create a PARTY for each CORE_USER
insert into CORE_PARTY(PARTY_ID)
			select PARTY_ID from CORE_USER;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Create a PARTY for each CORE_USER', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.04', '2.0.5', '3:a9a4dabaa3984599d89f8dd17f56397a', 194);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.postgresql::mpagnon::(Checksum: 3:4f331ac4df9a0e43276bde36a03d2464)
-- Update party sequence after inserts
SELECT setval('core_party_party_id_seq', (SELECT MAX(party_id) from core_party));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update party sequence after inserts', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.postgresql', '2.0.5', '3:4f331ac4df9a0e43276bde36a03d2464', 195);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.05::mpagnon::(Checksum: 3:a0f6b56302dcf5de63c9bc4e0070bb26)
-- Replace reference on user with reference on party
ALTER TABLE ACL_RESPONSIBILITY_SCOPE_ENTRY ADD CONSTRAINT fk_arse_party FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY (PARTY_ID);

ALTER TABLE CORE_GROUP_MEMBER ADD CONSTRAINT fk_group_member_party FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY (PARTY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Replace reference on user with reference on party', NOW(), 'Add Foreign Key Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.05', '2.0.5', '3:a0f6b56302dcf5de63c9bc4e0070bb26', 196);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.06::mpagnon::(Checksum: 3:be8ac6424bf708bce926f9a5422926f8)
-- Remove autoIncrement on core_user pk and add fk on Party table
create or replace function __liquibase_drop_pk(tableName text) returns void as $$ declare pkname text; sql text; begin pkname = c.conname from pg_class r, pg_constraint c where r.oid = c.conrelid and contype = 'p' and relname ilike tableName; sql = 'alter table ' || tableName || ' drop constraint ' || pkname; execute sql; end; $$ language plpgsql; select __liquibase_drop_pk('CORE_USER'); drop function __liquibase_drop_pk(tableName text);

ALTER TABLE CORE_USER ADD CONSTRAINT pk_core_user PRIMARY KEY (PARTY_ID);

ALTER TABLE CORE_USER ADD CONSTRAINT fk_core_user_party FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY (PARTY_ID);

ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM ADD CONSTRAINT fk_camp_tp_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER (PARTY_ID);

ALTER TABLE ITERATION_TEST_PLAN_ITEM ADD CONSTRAINT fk_itertestplan_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER (PARTY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Remove autoIncrement on core_user pk and add fk on Party table', NOW(), 'Drop Primary Key, Add Primary Key, Add Foreign Key Constraint (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.06', '2.0.5', '3:be8ac6424bf708bce926f9a5422926f8', 197);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1864.03::mpagnon::(Checksum: 3:ac46d1c0c320671c71d759a31ef46cdf)
-- create table team member
CREATE TABLE CORE_TEAM_MEMBER (TEAM_ID BIGINT NOT NULL, USER_ID BIGINT NOT NULL, CONSTRAINT fk_team_member_team FOREIGN KEY (TEAM_ID) REFERENCES CORE_TEAM(PARTY_ID), CONSTRAINT fk_team_member_user FOREIGN KEY (USER_ID) REFERENCES CORE_USER(PARTY_ID));

CREATE UNIQUE INDEX DX_TEAM_MEMBER ON CORE_TEAM_MEMBER(TEAM_ID, USER_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'create table team member', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1864.03', '2.0.5', '3:ac46d1c0c320671c71d759a31ef46cdf', 198);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1984.01::flaurens::(Checksum: 3:12d840fe62edf955008ba632c6aca4b2)
-- create table item_test_plan_test_suite
CREATE TABLE TEST_SUITE_TEST_PLAN_ITEM (TPI_ID BIGINT NOT NULL, SUITE_ID BIGINT NOT NULL, CONSTRAINT fk_test_suite_test_plan_item_test_suite FOREIGN KEY (SUITE_ID) REFERENCES TEST_SUITE(ID), CONSTRAINT fk_test_suite_test_plan_item_test_plan_item FOREIGN KEY (TPI_ID) REFERENCES ITERATION_TEST_PLAN_ITEM(ITEM_TEST_PLAN_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'create table item_test_plan_test_suite', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1984.01', '2.0.5', '3:12d840fe62edf955008ba632c6aca4b2', 199);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1984.02::flaurens::(Checksum: 3:c7159fa321fd066634bed9777be2d7f9)
-- migrate data to table test_suite_test_plan_item
insert into TEST_SUITE_TEST_PLAN_ITEM (TPI_ID, SUITE_ID)
			select ITEM_TEST_PLAN_ID, TEST_SUITE from ITERATION_TEST_PLAN_ITEM
			where TEST_SUITE IS NOT NULL;

ALTER TABLE ITERATION_TEST_PLAN_ITEM DROP CONSTRAINT fk_itpi_testsuite;

ALTER TABLE ITERATION_TEST_PLAN_ITEM DROP COLUMN TEST_SUITE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'migrate data to table test_suite_test_plan_item', NOW(), 'Custom SQL, Drop Foreign Key Constraint, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1984.02', '2.0.5', '3:c7159fa321fd066634bed9777be2d7f9', 200);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1902.01::bsiri::(Checksum: 3:1cecce2e50a491cae71fab04421659ac)
-- creating the tables and references for the workspace plugins
CREATE TABLE TEST_CASE_LIBRARY_PLUGINS (LIBRARY_ID BIGINT NOT NULL, PLUGIN_ID VARCHAR(100) NOT NULL, CONSTRAINT fk_plugin_tclib FOREIGN KEY (LIBRARY_ID) REFERENCES TEST_CASE_LIBRARY(TCL_ID));

CREATE TABLE REQUIREMENT_LIBRARY_PLUGINS (LIBRARY_ID BIGINT NOT NULL, PLUGIN_ID VARCHAR(100) NOT NULL, CONSTRAINT fk_plugin_rlib FOREIGN KEY (LIBRARY_ID) REFERENCES REQUIREMENT_LIBRARY(RL_ID));

CREATE TABLE CAMPAIGN_LIBRARY_PLUGINS (LIBRARY_ID BIGINT NOT NULL, PLUGIN_ID VARCHAR(100) NOT NULL, CONSTRAINT fk_plugin_clib FOREIGN KEY (LIBRARY_ID) REFERENCES CAMPAIGN_LIBRARY(CL_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'creating the tables and references for the workspace plugins', NOW(), 'Create Table (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1902.01', '2.0.5', '3:1cecce2e50a491cae71fab04421659ac', 201);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1984.03::flaurens::(Checksum: 3:c97b3fea29e22fe2612c276f71ad62ed)
-- add column for ordering to table TEST_SUITE_TEST_PLAN_ITEM
ALTER TABLE TEST_SUITE_TEST_PLAN_ITEM ADD TEST_PLAN_ORDER INT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'add column for ordering to table TEST_SUITE_TEST_PLAN_ITEM', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-1984.03', '2.0.5', '3:c97b3fea29e22fe2612c276f71ad62ed', 202);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-2003.01::mpagnon::(Checksum: 3:da18fce611d98ef6ccef23d1daa0f901)
-- The new table is called  "REQUIREMENT_VERSION_COVERAGE"
ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION DROP CONSTRAINT fk_verified_req_version;

ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION DROP CONSTRAINT fk_verifying_test_case;

ALTER TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION DROP CONSTRAINT uc_tc_verifies_req_version;

CREATE TABLE REQUIREMENT_VERSION_COVERAGE (REQUIREMENT_VERSION_COVERAGE_ID bigserial NOT NULL, VERIFIED_REQ_VERSION_ID BIGINT, VERIFYING_TEST_CASE_ID BIGINT, CONSTRAINT pk_requirement_version_coverage PRIMARY KEY (REQUIREMENT_VERSION_COVERAGE_ID), CONSTRAINT fk_verified_req_version FOREIGN KEY (VERIFIED_REQ_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID), CONSTRAINT fk_verifying_test_case FOREIGN KEY (VERIFYING_TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN REQUIREMENT_VERSION_COVERAGE.REQUIREMENT_VERSION_COVERAGE_ID IS 'generated surrogate key';

COMMENT ON COLUMN REQUIREMENT_VERSION_COVERAGE.VERIFIED_REQ_VERSION_ID IS 'FK to the verified requirement version';

COMMENT ON COLUMN REQUIREMENT_VERSION_COVERAGE.VERIFYING_TEST_CASE_ID IS 'FK to the verifying test case';

ALTER TABLE REQUIREMENT_VERSION_COVERAGE ALTER COLUMN  VERIFIED_REQ_VERSION_ID SET NOT NULL;

ALTER TABLE REQUIREMENT_VERSION_COVERAGE ALTER COLUMN  VERIFYING_TEST_CASE_ID SET NOT NULL;

ALTER TABLE REQUIREMENT_VERSION_COVERAGE ADD CONSTRAINT uc_tc_verifies_req_version UNIQUE (VERIFIED_REQ_VERSION_ID, VERIFYING_TEST_CASE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'The new table is called  "REQUIREMENT_VERSION_COVERAGE"', NOW(), 'Drop Foreign Key Constraint (x2), Drop Unique Constraint, Create Table, Add Not-Null Constraint (x2), Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-2003.01', '2.0.5', '3:da18fce611d98ef6ccef23d1daa0f901', 203);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-2003.02::mpagnon::(Checksum: 3:eb25425ba209ef8c10037b4fbd1a13b7)
-- We migrate datas from TEST_CASE_VERIFIED_REQUIREMENT_VERSION to REQUIREMENT_VERSION_COVERAGE.
Insert into REQUIREMENT_VERSION_COVERAGE(VERIFIED_REQ_VERSION_ID, VERIFYING_TEST_CASE_ID)
			select VERIFIED_REQ_VERSION_ID, VERIFYING_TEST_CASE_ID from TEST_CASE_VERIFIED_REQUIREMENT_VERSION;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'We migrate datas from TEST_CASE_VERIFIED_REQUIREMENT_VERSION to REQUIREMENT_VERSION_COVERAGE.', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-2003.02', '2.0.5', '3:eb25425ba209ef8c10037b4fbd1a13b7', 204);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-2003.03::mpagnon::(Checksum: 3:19e90e356af9c11c040321085d046b44)
-- We drop the old TEST_CASE_VERIFIED_REQUIREMENT_VERSION table.
DROP TABLE TEST_CASE_VERIFIED_REQUIREMENT_VERSION;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'We drop the old TEST_CASE_VERIFIED_REQUIREMENT_VERSION table.', NOW(), 'Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-2003.03', '2.0.5', '3:19e90e356af9c11c040321085d046b44', 205);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-2003.04::mpagnon::(Checksum: 3:ea32093b375bc67eb08eb8af84f4c2d4)
-- Let's add a table VERIFYING_STEPS to hold the steps that are concerned by the requirement coverage
CREATE TABLE VERIFYING_STEPS (REQUIREMENT_VERSION_COVERAGE_ID BIGINT NOT NULL, TEST_STEP_ID BIGINT NOT NULL, CONSTRAINT fk_verifying_step_requirement_version_coverage FOREIGN KEY (REQUIREMENT_VERSION_COVERAGE_ID) REFERENCES REQUIREMENT_VERSION_COVERAGE(REQUIREMENT_VERSION_COVERAGE_ID), CONSTRAINT fk_verifying_step_action_test_step FOREIGN KEY (TEST_STEP_ID) REFERENCES ACTION_TEST_STEP(TEST_STEP_ID));

COMMENT ON COLUMN VERIFYING_STEPS.REQUIREMENT_VERSION_COVERAGE_ID IS 'FK to the concerned requirement-version-coverage';

COMMENT ON COLUMN VERIFYING_STEPS.TEST_STEP_ID IS 'FK to the concerned action test step';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Let''s add a table VERIFYING_STEPS to hold the steps that are concerned by the requirement coverage', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-feat-2003.04', '2.0.5', '3:ea32093b375bc67eb08eb8af84f4c2d4', 206);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-feat-1966.01::bsiri::(Checksum: 3:c1bbbb48d574fd555457e24fed64876d)
-- fixing mysql text data type for Squash schema version 1.4.x and before (see issue 1966). Dev note : it would have been best to use
-- 		the tag <modifyColumn> instead of raw sql, because the xml could have been efficiently parsed by the dbdoc generator. 
-- 		However the dbdoc does not tell which datatype the columns anyway (for now), so let us say that the following raw sql is just fine.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-issue-2061.01::mpagnon::(Checksum: 3:60cf25d777ae63777f14959720352984)
-- Because imported test-cases did not have custom-field-values we need to fix the database.
insert into CUSTOM_FIELD_VALUE (BOUND_ENTITY_ID, BOUND_ENTITY_TYPE, CFB_ID, VALUE)
			select tc.TCLN_ID, 'TEST_CASE', binding.CFB_ID, cuf.DEFAULT_VALUE
			from TEST_CASE tc
			join TEST_CASE_LIBRARY_NODE tcln ON tc.TCLN_ID = tcln.TCLN_ID
			join PROJECT project ON tcln.PROJECT_ID = project.PROJECT_ID
			join CUSTOM_FIELD_BINDING binding ON binding.BOUND_PROJECT_ID = project.PROJECT_ID
			join CUSTOM_FIELD cuf ON binding.CF_ID = cuf.CF_ID
			where not exists (
				select * from CUSTOM_FIELD_VALUE val 
				where val.BOUND_ENTITY_ID = tc.TCLN_ID 
				and val.BOUND_ENTITY_TYPE='TEST_CASE' 
				and val.CFB_ID = binding.CFB_ID
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Because imported test-cases did not have custom-field-values we need to fix the database.', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-issue-2061.01', '2.0.5', '3:60cf25d777ae63777f14959720352984', 207);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml::tm-1.5.0.00-issue-2146.01::mpagnon::(Checksum: 3:20c02e1368dc82ca88d244545b622cc7)
-- also fix for [Issue 1895]
UPDATE REQUIREMENT_PROPERTY_CHANGE
			SET PROPERTY_NAME = ''
			WHERE PROPERTY_NAME is null;

ALTER TABLE REQUIREMENT_PROPERTY_CHANGE ALTER COLUMN  PROPERTY_NAME SET NOT NULL;

UPDATE REQUIREMENT_LARGE_PROPERTY_CHANGE
			SET PROPERTY_NAME = ''
			WHERE PROPERTY_NAME is null;

ALTER TABLE REQUIREMENT_LARGE_PROPERTY_CHANGE ALTER COLUMN  PROPERTY_NAME SET NOT NULL;

UPDATE EXECUTION
			SET REFERENCE = ''
			WHERE REFERENCE is null;

ALTER TABLE EXECUTION ALTER COLUMN  REFERENCE SET NOT NULL;

ALTER TABLE EXECUTION ALTER COLUMN  REFERENCE SET DEFAULT '';

UPDATE EXECUTION
			SET PREREQUISITE = ''
			WHERE PREREQUISITE is null;

ALTER TABLE EXECUTION ALTER COLUMN  PREREQUISITE SET NOT NULL;

UPDATE REQUIREMENT_VERSION
			SET REFERENCE = ''
			WHERE REFERENCE is null;

ALTER TABLE REQUIREMENT_VERSION ALTER COLUMN  REFERENCE SET NOT NULL;

ALTER TABLE REQUIREMENT_VERSION ALTER COLUMN  REFERENCE SET DEFAULT '';

UPDATE TEST_CASE
			SET PREREQUISITE= ''
			WHERE PREREQUISITE is null;

ALTER TABLE TEST_CASE ALTER COLUMN  PREREQUISITE SET NOT NULL;

UPDATE TEST_CASE
			SET REFERENCE = ''
			WHERE REFERENCE is null;

ALTER TABLE TEST_CASE ALTER COLUMN  REFERENCE SET NOT NULL;

ALTER TABLE TEST_CASE ALTER COLUMN  REFERENCE SET DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'also fix for [Issue 1895]', NOW(), 'Custom SQL, Add Not-Null Constraint, Custom SQL, Add Not-Null Constraint, Custom SQL, Add Not-Null Constraint, Add Default Value, Custom SQL, Add Not-Null Constraint, Custom SQL, Add Not-Null Constraint, Add Default Value, Custom SQL, Add Not-Null Cons...', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.0.xml', 'tm-1.5.0.00-issue-2146.01', '2.0.5', '3:20c02e1368dc82ca88d244545b622cc7', 208);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml::tm-1.5.1::mpagnon::(Checksum: 3:fbb40866e9b269ec1b80b00d1c53f45a)
-- Update TM database version number
UPDATE CORE_CONFIG SET STR_KEY = 'squashtest.tm.database.version', VALUE = '1.5.1' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml', 'tm-1.5.1', '2.0.5', '3:fbb40866e9b269ec1b80b00d1c53f45a', 209);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml::tm-1.5.0.issue-2261-01::mpagnon,bsiri::(Checksum: 3:87b6ca96153ba3bbe35ffd0891b70653)
-- First we create help table that will help us match the iteration test plan orders with the test-suite's test plan items.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml::tm-1.5.0.issue-2261-02-postgresql::mpagnon,bsiri::(Checksum: 3:ae502a919be31d44b91ceff5c97fe8ab)
-- enforce the security on that column
-- ------------------------------------------------------------------------------
			-- create the temporary tables
			-- ------------------------------------------------------------------------------
			
			create table TEMP_DISCONTINUOUS_SUITE_ITEM(ITEM_ID BIGINT NOT NULL, SUITE_ID BIGINT NOT NULL);

create table TEMP_CONTINUOUS_SUITE_ITEM(ITEM_ID BIGINT NOT NULL, SUITE_ID BIGINT NOT NULL, TP_ORDER INT NOT NULL);

-- ------------------------------------------------------------------------------
			-- gather the data that need migration
			-- ------------------------------------------------------------------------------
						
			
			insert into TEMP_DISCONTINUOUS_SUITE_ITEM (SUITE_ID, ITEM_ID) 
			select tstpitem.SUITE_ID, tstpitem.TPI_ID 
			from TEST_SUITE_TEST_PLAN_ITEM tstpitem 
			where
				tstpitem.SUITE_ID in ( 
					select distinct tstpi2.suite_id 
					from TEST_SUITE_TEST_PLAN_ITEM tstpi2
					where tstpi2.TEST_PLAN_ORDER is null
				);

-- ------------------------------------------------------------------------------
        -- Code for posgresql database to find continuous orders for test suite test plan.
        -- Then we compute continuous orders for test-suite test plan items
        -- ------------------------------------------------------------------------------
        
        CREATE OR REPLACE FUNCTION OrderSuites() RETURNS text AS 
        $$
        DECLARE rn integer := 0-1;
        rn2 integer := 0;
        prevsuite bigint := 0;
        r record;
        BEGIN
        FOR r in (select tdsi.SUITE_ID, tdsi.ITEM_ID from TEMP_DISCONTINUOUS_SUITE_ITEM tdsi order by SUITE_ID)
        LOOP
         IF prevsuite  = r.SUITE_ID 
                THEN 
                     rn2 := rn ;
                     rn := rn2 + 1;
                ELSE rn := 0 ; 
                     prevsuite := r.SUITE_ID;
                END IF;
           insert into TEMP_CONTINUOUS_SUITE_ITEM (TP_ORDER, SUITE_ID, ITEM_ID)
               select rn, r.SUITE_ID , r.ITEM_ID  ;
              
               
        
        END LOOP;
        return 'ok';
        END
        $$ LANGUAGE plpgsql;
        
        select OrderSuites();
        drop function OrderSuites();

-- ------------------------------------------------------------------------------
			-- And finally we set the right orders in the concerned table without forgetting to delete the help tables.
			-- ------------------------------------------------------------------------------
			
			update TEST_SUITE_TEST_PLAN_ITEM
			set TEST_PLAN_ORDER = 
				(select TEMP_CONTINUOUS_SUITE_ITEM.TP_ORDER
				from  TEMP_CONTINUOUS_SUITE_ITEM
				where TEMP_CONTINUOUS_SUITE_ITEM.SUITE_ID = TEST_SUITE_TEST_PLAN_ITEM.SUITE_ID
				and TEST_SUITE_TEST_PLAN_ITEM.TPI_ID = TEMP_CONTINUOUS_SUITE_ITEM.ITEM_ID)
			where 
				SUITE_ID in (
					select distinct tcsi2.SUITE_ID from TEMP_CONTINUOUS_SUITE_ITEM tcsi2
				);

DROP TABLE TEMP_DISCONTINUOUS_SUITE_ITEM;

DROP TABLE TEMP_CONTINUOUS_SUITE_ITEM;

ALTER TABLE TEST_SUITE_TEST_PLAN_ITEM ALTER COLUMN  TEST_PLAN_ORDER SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon,bsiri', 'enforce the security on that column', NOW(), 'Custom SQL, Create Procedure, Custom SQL, Drop Table (x2), Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml', 'tm-1.5.0.issue-2261-02-postgresql', '2.0.5', '3:ae502a919be31d44b91ceff5c97fe8ab', 210);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.5.1.xml::tm-1.5.0.issue-2261-02::mpagnon,bsiri::(Checksum: 3:3740e86f3d5046ef904a254c4b16b400)
-- First we create help table that will help us match the iteration test plan orders with the test-suite's test plan items.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0::mpagnon::(Checksum: 3:44fa0971a21cf0ff8ba72bac20568984)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.6.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0', '2.0.5', '3:44fa0971a21cf0ff8ba72bac20568984', 211);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2334-01::flaurens::(Checksum: 3:3d8ec8510433cc5cbe5194b22057cb88)
-- Change type of column description in table core_team
CREATE TABLE CORE_TEAM_TEMP (ID BIGINT DEFAULT NULL, DESCRIPTION TEXT DEFAULT null);

insert into CORE_TEAM_TEMP (ID, DESCRIPTION)
			select PARTY_ID, DESCRIPTION from CORE_TEAM;

ALTER TABLE CORE_TEAM DROP COLUMN DESCRIPTION;

ALTER TABLE CORE_TEAM ADD DESCRIPTION TEXT DEFAULT null;

update CORE_TEAM ct
            set DESCRIPTION = (select ctt.DESCRIPTION
                               from CORE_TEAM_TEMP ctt
                               where ctt.ID = ct.PARTY_ID);

DROP TABLE CORE_TEAM_TEMP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Change type of column description in table core_team', NOW(), 'Create Table, Custom SQL, Drop Column, Add Column, Custom SQL, Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2334-01', '2.0.5', '3:3d8ec8510433cc5cbe5194b22057cb88', 212);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.feat-1101-01::mpagnon::(Checksum: 3:a6572d9cd64b76b53fdafb14a169b44b)
-- Add table to handle test cases PARAMETERS
CREATE TABLE PARAMETER (PARAM_ID bigserial NOT NULL, NAME VARCHAR(255) DEFAULT '' NOT NULL, TEST_CASE_ID BIGINT NOT NULL, DESCRIPTION TEXT NOT NULL, CONSTRAINT pk_parameter PRIMARY KEY (PARAM_ID), CONSTRAINT fk_parameter_test_case FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN PARAMETER.PARAM_ID IS 'the PARAMETER primary key';

COMMENT ON COLUMN PARAMETER.NAME IS 'the parameter name, should be unique among parameters of the same test case';

COMMENT ON COLUMN PARAMETER.TEST_CASE_ID IS 'the test case where the parameter is declared';

COMMENT ON COLUMN PARAMETER.DESCRIPTION IS 'the description of the parameter';

ALTER TABLE PARAMETER ADD UNIQUE (NAME, TEST_CASE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add table to handle test cases PARAMETERS', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.feat-1101-01', '2.0.5', '3:a6572d9cd64b76b53fdafb14a169b44b', 213);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.feat-1101-02::mpagnon::(Checksum: 3:7988c3f7d4bed8d82dd21398694377fe)
-- Add tables to handle test cases DATASETS
CREATE TABLE DATASET (DATASET_ID bigserial NOT NULL, NAME VARCHAR(255) DEFAULT '' NOT NULL, TEST_CASE_ID BIGINT NOT NULL, CONSTRAINT pk_dataset PRIMARY KEY (DATASET_ID), CONSTRAINT fk_dataset_test_case FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN DATASET.DATASET_ID IS 'the DATASET primary key';

COMMENT ON COLUMN DATASET.NAME IS 'the dataset name, should be unique among parameters of the same test case';

COMMENT ON COLUMN DATASET.TEST_CASE_ID IS 'the test case where the parameter is declared';

ALTER TABLE DATASET ADD UNIQUE (NAME, TEST_CASE_ID);

CREATE TABLE DATASET_PARAM_VALUE (DATASET_PARAM_VALUE_ID bigserial NOT NULL, DATASET_ID BIGINT NOT NULL, PARAM_ID BIGINT NOT NULL, PARAM_VALUE VARCHAR(255) DEFAULT '' NOT NULL, CONSTRAINT pk_dataset_param_value PRIMARY KEY (DATASET_PARAM_VALUE_ID), CONSTRAINT fk_dataset_param_value_dataset FOREIGN KEY (DATASET_ID) REFERENCES DATASET(DATASET_ID), CONSTRAINT fk_dataset_param_value_param FOREIGN KEY (PARAM_ID) REFERENCES PARAMETER(PARAM_ID));

COMMENT ON COLUMN DATASET_PARAM_VALUE.DATASET_PARAM_VALUE_ID IS 'the DATASET_PARAM_VALUE primary key';

COMMENT ON COLUMN DATASET_PARAM_VALUE.DATASET_ID IS 'the dataset holding the value for the parameter';

COMMENT ON COLUMN DATASET_PARAM_VALUE.PARAM_ID IS 'the parameter to set the value of';

COMMENT ON COLUMN DATASET_PARAM_VALUE.PARAM_VALUE IS 'the value for the parameter in the dataset';

ALTER TABLE DATASET_PARAM_VALUE ADD UNIQUE (DATASET_ID, PARAM_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add tables to handle test cases DATASETS', NOW(), 'Create Table, Add Unique Constraint, Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.feat-1101-02', '2.0.5', '3:7988c3f7d4bed8d82dd21398694377fe', 214);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.feat-1128-01::mpagnon::(Checksum: 3:c20286a7b7084452c09438ddd7ad8d66)
-- Add column to bind a test plan item to a DATASET
ALTER TABLE ITERATION_TEST_PLAN_ITEM ADD DATASET_ID BIGINT;

ALTER TABLE ITERATION_TEST_PLAN_ITEM ADD CONSTRAINT fk_iteration_test_plan_item_dataset FOREIGN KEY (DATASET_ID) REFERENCES DATASET (DATASET_ID);

COMMENT ON COLUMN ITERATION_TEST_PLAN_ITEM.DATASET_ID IS 'the dataset the test plan item should use to replace the parameters in new execution steps';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Add column to bind a test plan item to a DATASET', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.feat-1128-01', '2.0.5', '3:c20286a7b7084452c09438ddd7ad8d66', 215);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2203-01::flaurens::(Checksum: 3:8674d5e47646be66f97168fd484e04ad)
-- remove inactive users from all teams
delete from CORE_TEAM_MEMBER
			where USER_ID in (select cu.PARTY_ID 
			                  from CORE_USER cu
			                  where cu.ACTIVE = false);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'remove inactive users from all teams', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2203-01', '2.0.5', '3:8674d5e47646be66f97168fd484e04ad', 216);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2203-02::flaurens::(Checksum: 3:47577c8868b9cc23188e8a20458f561c)
-- remove core rights of inactive users
delete from CORE_GROUP_MEMBER
			where PARTY_ID in (select cu.PARTY_ID 
			                   from CORE_USER cu
			                   where cu.ACTIVE = false);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'remove core rights of inactive users', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2203-02', '2.0.5', '3:47577c8868b9cc23188e8a20458f561c', 217);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2203-03::flaurens::(Checksum: 3:b33c46fc1b66cf2f55cd314f40ed4f8e)
-- remove acl rights of inactive users
delete from ACL_RESPONSIBILITY_SCOPE_ENTRY
			where PARTY_ID in (select cu.PARTY_ID 
			                   from CORE_USER cu
			                   where cu.ACTIVE = false);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'remove acl rights of inactive users', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2203-03', '2.0.5', '3:b33c46fc1b66cf2f55cd314f40ed4f8e', 218);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2454-01::bsiri::(Checksum: 3:2ea9a08fbaa337f4288ac6f9367a0efb)
-- cleaning test suite test plan ordering : some collections have non-contiguous elements. This 
-- 		is due to issue #2454, because of shortcomings in the code in charge of deleting test cases and dependent 
-- 		entities.
-- 			It looks pretty much like tm-1.5.0.issue-2261-01 (in the 1.5.1 changelog), except we're not dealing with order = null.
-- 			
-- 			Note : this script might already have been executed if at some point Squash 1.5.2 was used.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2454-02::bsiri::(Checksum: 3:758587cd787b305a0c669ef26dda62fb)
-- cleaning test suite test plan ordering : some collections have non-contiguous elements. This 
-- 		is due to issue #2454, because of shortcomings in the code in charge of deleting test cases and dependent 
-- 		entities.
-- 			It looks pretty much like tm-1.5.0.issue-2261-01 (in the 1.5.1 changelog), except we're not dealing with order = null.
-- 			
-- 			Note : this script might already have been executed if at some point Squash 1.5.2 was used.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2454-02-postgresql::mpagnon::(Checksum: 3:bcb771c3465600909297d53a60ba9e43)
-- cleaning test suite test plan ordering : some collections have non-contiguous elements. This 
-- 		is due to issue #2454, because of shortcomings in the code in charge of deleting test cases and dependent 
-- 		entities.
-- 			It looks pretty much like tm-1.5.0.issue-2261-01 (in the 1.5.1 changelog), except we're not dealing with order = null.
-- 			
-- 			Note : this script might already have been executed if at some point Squash 1.5.2 was used.
create table TEMP_DISCONTINUOUS_SUITE_ITEM(
      ITEM_ID BIGINT NOT NULL, 
      SUITE_ID BIGINT NOT NULL);

create table TEMP_CONTINUOUS_SUITE_ITEM(
      ITEM_ID BIGINT NOT NULL,
       SUITE_ID BIGINT NOT NULL, 
       TP_ORDER INT NOT NULL);

insert into TEMP_DISCONTINUOUS_SUITE_ITEM (SUITE_ID, ITEM_ID) 
      select tstpitem.suite_id, tstpitem.tpi_id 
      from TEST_SUITE_TEST_PLAN_ITEM tstpitem;

CREATE OR REPLACE FUNCTION ordersuites() RETURNS text AS 
        $$
        DECLARE rn integer := 0-1;
        rn2 integer := 0;
        prevsuite bigint := 0;
        r record;
        BEGIN
        FOR r in (select tdsi.SUITE_ID, tdsi.ITEM_ID from TEMP_DISCONTINUOUS_SUITE_ITEM tdsi order by tdsi.SUITE_ID, tdsi.ITEM_ID)
        LOOP
              IF prevsuite  = r.SUITE_ID 
                THEN 
                     rn2 := rn ;
                     rn := rn2 + 1;
                ELSE rn := 0 ; 
                     prevsuite := r.SUITE_ID;
              END IF;
           insert into TEMP_CONTINUOUS_SUITE_ITEM (TP_ORDER, SUITE_ID, ITEM_ID)
               select rn, r.SUITE_ID , r.ITEM_ID  ;
              
               
        
        END LOOP;
        return 'ok';
        END
        $$ LANGUAGE plpgsql;
        
        select ordersuites();
        drop function ordersuites();

update TEST_SUITE_TEST_PLAN_ITEM tstpi
      set TEST_PLAN_ORDER = 
        (select tcsi.TP_ORDER
        from  TEMP_CONTINUOUS_SUITE_ITEM tcsi
        where tcsi.SUITE_ID = tstpi.SUITE_ID
        and tstpi.TPI_ID = tcsi.ITEM_ID);

drop table TEMP_DISCONTINUOUS_SUITE_ITEM;

drop table TEMP_CONTINUOUS_SUITE_ITEM;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'cleaning test suite test plan ordering : some collections have non-contiguous elements. This 
		is due to issue #2454, because of shortcomings in the code in charge of deleting test cases and dependent 
		entities.
			It looks pretty much like tm-1.5.0...', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2454-02-postgresql', '2.0.5', '3:bcb771c3465600909297d53a60ba9e43', 219);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2474-01::bsiri::(Checksum: 3:707eb09e44214f4a6564dbcc2595bdff)
-- fixes the action test steps having no custom fields when copied from one project to another. Works for both mysql and h2.
insert into CUSTOM_FIELD_VALUE(bound_entity_id, bound_entity_type, cfb_id, value)
			select ats.test_step_id, 'TEST_STEP',  cfb.cfb_id, cf.default_value
			from ACTION_TEST_STEP ats
			inner join TEST_CASE_STEPS tcs on ats.test_step_id = tcs.step_id
			inner join TEST_CASE_LIBRARY_NODE tcln on tcs.test_case_id = tcln.tcln_id
			inner join CUSTOM_FIELD_BINDING cfb on tcln.project_id = cfb.bound_project_id
			inner join CUSTOM_FIELD cf on cfb.cf_id = cf.cf_id
			where cfb.bound_entity = 'TEST_STEP'
			and ats.test_step_id not in (
				select cfv2.bound_entity_id
				from CUSTOM_FIELD_VALUE cfv2
				inner join CUSTOM_FIELD_BINDING cfb2 on cfv2.cfb_id = cfb2.cfb_id
				where cfb2.bound_entity = 'TEST_STEP'
				and cfb2.bound_project_id = cfb.bound_project_id
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'fixes the action test steps having no custom fields when copied from one project to another. Works for both mysql and h2.', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2474-01', '2.0.5', '3:707eb09e44214f4a6564dbcc2595bdff', 220);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2485-01::flaurens::(Checksum: 3:b4c6769abca7e076b2b7c15e8a2e0cca)
-- replaces fk-constraint which wrongly cascades the deletion of denormalized field values
ALTER TABLE DENORMALIZED_FIELD_VALUE DROP CONSTRAINT fk_dfv_cfv_binding;

ALTER TABLE DENORMALIZED_FIELD_VALUE ADD CONSTRAINT fk_dfv_cfv_binding FOREIGN KEY (CFV_ID) REFERENCES CUSTOM_FIELD_VALUE (CFV_ID) ON DELETE SET NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'replaces fk-constraint which wrongly cascades the deletion of denormalized field values', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2485-01', '2.0.5', '3:b4c6769abca7e076b2b7c15e8a2e0cca', 221);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml::tm-1.6.0.issue-2536-01::flaurens::(Checksum: 3:bfc71563d410979038de2087efc95be1)
-- giving testrunners reading rights on projects
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.project.Project'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'giving testrunners reading rights on projects', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.6.0.xml', 'tm-1.6.0.issue-2536-01', '2.0.5', '3:bfc71563d410979038de2087efc95be1', 222);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0::bsiri::(Checksum: 3:e487152700beeea52eeda3275fb09eeb)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.7.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0', '2.0.5', '3:e487152700beeea52eeda3275fb09eeb', 223);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1107-01::bsiri::(Checksum: 3:bd6474134f670ab19e5440dc42195c1f)
-- Modifying RLN_RELATIONSHIP and RLN_RELATIONSHIP_CLOSURE : requirements can now accept more requirements 
-- 		(but no folders). Cautious : there is no way to express that a a requirement can only accept requirements as children.
ALTER TABLE RLN_RELATIONSHIP DROP CONSTRAINT fk_rln_relationship_ancestor;

ALTER TABLE RLN_RELATIONSHIP DROP CONSTRAINT fk_rln_relationship_descendant;

ALTER TABLE RLN_RELATIONSHIP ADD CONSTRAINT fk_rln_relationship_ancestor FOREIGN KEY (ANCESTOR_ID) REFERENCES REQUIREMENT_LIBRARY_NODE (RLN_ID);

ALTER TABLE RLN_RELATIONSHIP ADD CONSTRAINT fk_rln_relationship_descendant FOREIGN KEY (DESCENDANT_ID) REFERENCES REQUIREMENT_LIBRARY_NODE (RLN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Modifying RLN_RELATIONSHIP and RLN_RELATIONSHIP_CLOSURE : requirements can now accept more requirements 
		(but no folders). Cautious : there is no way to express that a a requirement can only accept requirements as children.', NOW(), 'Drop Foreign Key Constraint (x2), Add Foreign Key Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1107-01', '2.0.5', '3:bd6474134f670ab19e5440dc42195c1f', 224);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-01::flaurens::(Checksum: 3:6e48a7ae6a4c474adb23e075dcba2b7d)
-- adding entries for indexing dates in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.requirement.date');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing dates in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-01', '2.0.5', '3:6e48a7ae6a4c474adb23e075dcba2b7d', 225);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-02::flaurens::(Checksum: 3:f3cb7f953543a17b4d1c154c7e442401)
-- adding entries for indexing dates in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.testcase.date');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing dates in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-02', '2.0.5', '3:f3cb7f953543a17b4d1c154c7e442401', 226);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-03::flaurens::(Checksum: 3:45eb510ab2fbd7f639ecddbe84464f9f)
-- adding entries for indexing dates in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.campaign.date');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing dates in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-03', '2.0.5', '3:45eb510ab2fbd7f639ecddbe84464f9f', 227);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-04::flaurens::(Checksum: 3:9fb520a42c5abd1166267f706b8b9b77)
-- adding entries for indexing versions in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.requirement.version');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing versions in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-04', '2.0.5', '3:9fb520a42c5abd1166267f706b8b9b77', 228);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-05::flaurens::(Checksum: 3:238b90d96db5cf853377733356cadff2)
-- adding entries for indexing versions in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.testcase.version');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing versions in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-05', '2.0.5', '3:238b90d96db5cf853377733356cadff2', 229);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-1090-06::flaurens::(Checksum: 3:b9e59a82fea7f6e9f96a88b51283f2b4)
-- adding entries for indexing versions in table core_config
INSERT INTO CORE_CONFIG (STR_KEY) VALUES ('lastindexing.campaign.version');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'adding entries for indexing versions in table core_config', NOW(), 'Insert Row', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-1090-06', '2.0.5', '3:b9e59a82fea7f6e9f96a88b51283f2b4', 230);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml::tm-1.7.0.feat-2648::mpagnon::(Checksum: 3:695514959b39640bf03440a5fbb091e1)
-- add permission ATTACH to Validator on Test-case library
INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary'), '2048');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary'), '64');

DELETE FROM ACL_GROUP_PERMISSION  WHERE ACL_GROUP_ID = (select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester')
				and PERMISSION_MASK = 2
				and CLASS_ID = (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary');

DELETE FROM ACL_GROUP_PERMISSION  WHERE ACL_GROUP_ID = (select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester')
				and PERMISSION_MASK = 4
				and CLASS_ID = (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary');

DELETE FROM ACL_GROUP_PERMISSION  WHERE ACL_GROUP_ID = (select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester')
				and PERMISSION_MASK = 8
				and CLASS_ID = (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary');

DELETE FROM ACL_GROUP_PERMISSION  WHERE ACL_GROUP_ID = (select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester')
				and PERMISSION_MASK = 256
				and CLASS_ID = (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary'), '64');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary'), '256');

DELETE FROM ACL_GROUP_PERMISSION  WHERE ACL_GROUP_ID = (select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester')
				and PERMISSION_MASK = 1024
				and CLASS_ID = (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary'), '256');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.requirement.RequirementLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.testcase.TestCaseLibrary'), '1024');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'add permission ATTACH to Validator on Test-case library', NOW(), 'Insert Row (x3), Delete Data (x4), Insert Row (x2), Delete Data, Insert Row (x5)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.0.xml', 'tm-1.7.0.feat-2648', '2.0.5', '3:695514959b39640bf03440a5fbb091e1', 231);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1::mpagnon::(Checksum: 3:704687745c9c0f218a642929b1e30e3f)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.7.1' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1', '2.0.5', '3:704687745c9c0f218a642929b1e30e3f', 232);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-01::mpagnon::(Checksum: 3:68b5f0e453857633365c9710e5a0ae24)
-- create table to store the id of entities to delete
CREATE TABLE ENTITIES_TO_DELETE (ENTITY_NAME VARCHAR(30), ENTITY_ID BIGINT);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'create table to store the id of entities to delete', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-01', '2.0.5', '3:68b5f0e453857633365c9710e5a0ae24', 233);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-02::mpagnon::(Checksum: 3:bb934c8baa9b8a4ba21766365b8820f3)
-- Store the ids of the ghost executions
insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select distinct 'EXECUTION', E.EXECUTION_ID
			from EXECUTION E left outer join ITEM_TEST_PLAN_EXECUTION ITPE
			on E.EXECUTION_ID = ITPE.EXECUTION_ID
			where ITPE.EXECUTION_ID is null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Store the ids of the ghost executions', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-02', '2.0.5', '3:bb934c8baa9b8a4ba21766365b8820f3', 234);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-03::mpagnon::(Checksum: 3:8ddf17c0a207e5990e601785e165d470)
-- Store the ids of the execution steps
insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select
			'EXECUTION_STEP', ES.EXECUTION_STEP_ID
			from EXECUTION_STEP ES, EXECUTION_EXECUTION_STEPS EES, ENTITIES_TO_DELETE ETD
			where ES.EXECUTION_STEP_ID = EES.EXECUTION_STEP_ID
			and EES.EXECUTION_ID =	ETD.ENTITY_ID
			and ETD.ENTITY_NAME = 'EXECUTION';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Store the ids of the execution steps', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-03', '2.0.5', '3:8ddf17c0a207e5990e601785e165d470', 235);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-04::mpagnon::(Checksum: 3:0daeae5e4dd689bcf981b8f5262d0109)
-- Store the ids of the issue lists to delete
insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select 'ISSUE_LIST', E.ISSUE_LIST_ID
			from EXECUTION E,  ENTITIES_TO_DELETE ETD
			where E.EXECUTION_ID = ETD.ENTITY_ID
			and ETD.ENTITY_NAME = 'EXECUTION';

insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select 'ISSUE_LIST', ES.ISSUE_LIST_ID
			from   EXECUTION_STEP ES,  ENTITIES_TO_DELETE ETD2
			where ES.EXECUTION_STEP_ID = ETD2.ENTITY_ID
			and	ETD2.ENTITY_NAME = 'EXECUTION_STEP';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Store the ids of the issue lists to delete', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-04', '2.0.5', '3:0daeae5e4dd689bcf981b8f5262d0109', 236);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-05::mpagnon::(Checksum: 3:62636bc8eb17d19b1dd725e251e898cb)
-- Store the ids of the issue lists to delete
insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select 'ATTACHMENT_LIST', E.ATTACHMENT_LIST_ID
			from EXECUTION E,  ENTITIES_TO_DELETE ETD
			where  E.EXECUTION_ID = ETD.ENTITY_ID
			and ETD.ENTITY_NAME = 'EXECUTION';

insert into ENTITIES_TO_DELETE (ENTITY_NAME, ENTITY_ID)
			select 'ATTACHMENT_LIST', ES.ATTACHMENT_LIST_ID
			from  EXECUTION_STEP ES,  ENTITIES_TO_DELETE ETD2
			where  ES.EXECUTION_STEP_ID = ETD2.ENTITY_ID
			and	ETD2.ENTITY_NAME = 'EXECUTION_STEP';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Store the ids of the issue lists to delete', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-05', '2.0.5', '3:62636bc8eb17d19b1dd725e251e898cb', 237);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-06::mpagnon::(Checksum: 3:a800251d0d6a914edc45934a77ddf1ed)
-- DELETE Issues of execution and execution steps to delete
DELETE FROM ISSUE  WHERE exists (
				select 1
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'ISSUE_LIST'
				and ENTITY_ID = ISSUE_LIST_ID
				);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'DELETE Issues of execution and execution steps to delete', NOW(), 'Delete Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-06', '2.0.5', '3:a800251d0d6a914edc45934a77ddf1ed', 238);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-07::mpagnon::(Checksum: 3:8876a68af7b32012273a65351485fd5c)
-- DELETE Automated execution extender of executions to delete
DELETE FROM AUTOMATED_EXECUTION_EXTENDER  WHERE exists (
				select	1 
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'EXECUTION'
				and ENTITY_ID = MASTER_EXECUTION_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'DELETE Automated execution extender of executions to delete', NOW(), 'Delete Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-07', '2.0.5', '3:8876a68af7b32012273a65351485fd5c', 239);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-08::mpagnon::(Checksum: 3:900bc764b6e513995c6afe9a19979f02)
-- DELETE automated suites that are not linked to any automated execution extender
DELETE FROM AUTOMATED_SUITE  WHERE not exists (
				select 1
				from AUTOMATED_EXECUTION_EXTENDER
				where AUTOMATED_SUITE.SUITE_ID = AUTOMATED_EXECUTION_EXTENDER.SUITE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'DELETE automated suites that are not linked to any automated execution extender', NOW(), 'Delete Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-08', '2.0.5', '3:900bc764b6e513995c6afe9a19979f02', 240);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-09::mpagnon::(Checksum: 3:186698b62dfabaeb568577fffd561506)
-- Delete execution steps of ghost executions
DELETE FROM EXECUTION_EXECUTION_STEPS  WHERE exists (
				select 1 
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'EXECUTION_STEP'
				and ENTITY_ID = EXECUTION_STEP_ID);

DELETE FROM EXECUTION_STEP  WHERE exists (
				select 1 
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'EXECUTION_STEP'
				and EXECUTION_STEP_ID = ENTITY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Delete execution steps of ghost executions', NOW(), 'Delete Data (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-09', '2.0.5', '3:186698b62dfabaeb568577fffd561506', 241);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-10::mpagnon::(Checksum: 3:47d07b4d4a0877813ee39b635393da38)
-- Delete ghost executions
DELETE FROM EXECUTION  WHERE exists (
				select 1 
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'EXECUTION'
				and EXECUTION_ID = ENTITY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Delete ghost executions', NOW(), 'Delete Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-10', '2.0.5', '3:47d07b4d4a0877813ee39b635393da38', 242);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-11::mpagnon::(Checksum: 3:22899dd09e8779cb77785618956a214c)
-- DELETE Attachments of execution and execution steps to delete
DELETE FROM ATTACHMENT  WHERE exists (
				select 1
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'ATTACHMENT_LIST'
				and ENTITY_ID = ATTACHMENT_LIST_ID
				);

DELETE FROM ATTACHMENT_CONTENT  WHERE not exists (
				select 1
				from ATTACHMENT
				where CONTENT_ID = ATTACHMENT_CONTENT_ID
				);

DELETE FROM ATTACHMENT_LIST  WHERE exists (
				select 1
				from ENTITIES_TO_DELETE
				where ENTITY_NAME = 'ATTACHMENT_LIST'
				and ATTACHMENT_LIST_ID = ENTITY_ID
				);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'DELETE Attachments of execution and execution steps to delete', NOW(), 'Delete Data (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-11', '2.0.5', '3:22899dd09e8779cb77785618956a214c', 243);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-12::mpagnon::(Checksum: 3:a2d86fa017d0bd1fe52873006638c208)
-- DELETE issue lists of executions and execution-steps to delete
DELETE FROM ISSUE_LIST  WHERE exists (
				select 1 
				from ENTITIES_TO_DELETE
				where ENTITY_NAME ='ISSUE_LIST'
				and ENTITY_ID = ISSUE_LIST_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'DELETE issue lists of executions and execution-steps to delete', NOW(), 'Delete Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-12', '2.0.5', '3:a2d86fa017d0bd1fe52873006638c208', 244);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml::tm-1.7.1.issue-2873-13::mpagnon::(Checksum: 3:a223a65d8dc3d320d65403a98819cc88)
-- Drop table used to store the ids of the entities to delete
DROP TABLE ENTITIES_TO_DELETE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Drop table used to store the ids of the entities to delete', NOW(), 'Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.7.1.xml', 'tm-1.7.1.issue-2873-13', '2.0.5', '3:a223a65d8dc3d320d65403a98819cc88', 245);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0::mpagnon::(Checksum: 3:d36dd82b1e8f15f61603318dd9657371)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.8.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'tm-1.8.0', '2.0.5', '3:d36dd82b1e8f15f61603318dd9657371', 246);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.feat-2688::mpagnon::(Checksum: 3:64dc16326c294f57452163ce0b900d51)
-- add permission READ_UNASSIGNED on Campaign library for all users but TestRunners
insert into ACL_GROUP_PERMISSION (ACL_GROUP_ID, PERMISSION_MASK, CLASS_ID)
      select ACL_GROUP.ID, 4096, ACL_CLASS.ID
      from ACL_GROUP , ACL_CLASS
      where ACL_GROUP.QUALIFIED_NAME != 'squashtest.acl.group.tm.TestRunner'
      and ACL_CLASS.CLASSNAME = 'org.squashtest.tm.domain.campaign.CampaignLibrary';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'add permission READ_UNASSIGNED on Campaign library for all users but TestRunners', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'tm-1.8.0.feat-2688', '2.0.5', '3:64dc16326c294f57452163ce0b900d51', 247);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.issue-1846-02::mpagnon::(Checksum: 3:5bc6788443ecb4a0235d2cace5356547)
-- Remove the DELETED_ON columns
ALTER TABLE CAMPAIGN_LIBRARY_NODE DROP COLUMN DELETED_ON;

ALTER TABLE TEST_CASE_LIBRARY_NODE DROP COLUMN DELETED_ON;

ALTER TABLE REQUIREMENT_LIBRARY_NODE DROP COLUMN DELETED_ON;

ALTER TABLE ITERATION DROP COLUMN DELETED_ON;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Remove the DELETED_ON columns', NOW(), 'Drop Column (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'tm-1.8.0.issue-1846-02', '2.0.5', '3:5bc6788443ecb4a0235d2cace5356547', 248);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.issue-3009-01::bsiri::(Checksum: 3:534184792528cc289f946a0d1b0a08e3)
-- As of 1.8.0 anyone that executes a test becomes de facto its assignee. This changeset will update the iteration 
-- 			test plan items and assign it to the last executor (if any) if it hasn't an assignee already
update ITERATION_TEST_PLAN_ITEM itpi
      set USER_ID = (select cu.PARTY_ID from CORE_USER cu where cu.LOGIN = itpi.LAST_EXECUTED_BY)
      where itpi.USER_ID IS NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'As of 1.8.0 anyone that executes a test becomes de facto its assignee. This changeset will update the iteration 
			test plan items and assign it to the last executor (if any) if it hasn''t an assignee already', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'tm-1.8.0.issue-3009-01', '2.0.5', '3:534184792528cc289f946a0d1b0a08e3', 249);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::core-1.8.0-feat-2699-00::bsiri::(Checksum: 3:c310a0691836587afa1c22c6e3b2a1a8)
-- actually remove user accounts that were deactivated
delete from CORE_TEAM_MEMBER
      where USER_ID in (
      select PARTY_ID from CORE_USER
      where ACTIVE= false
      );

delete from CORE_GROUP_MEMBER
      where PARTY_ID in (
      select PARTY_ID from CORE_USER
      where ACTIVE= false
      );

update ITERATION_TEST_PLAN_ITEM SET USER_ID = NULL WHERE USER_ID IN (SELECT PARTY_ID FROM CORE_USER WHERE active = false );

update CAMPAIGN_TEST_PLAN_ITEM SET USER_ID = NULL WHERE USER_ID IN (SELECT PARTY_ID FROM CORE_USER WHERE active =
      false );

delete from CORE_USER where active = false;

delete from CORE_PARTY where PARTY_ID not in
      (select PARTY_ID from CORE_USER)
      and PARTY_ID not in
      (select PARTY_ID from CORE_TEAM);

delete from AUTH_USER where active= false;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'actually remove user accounts that were deactivated', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'core-1.8.0-feat-2699-00', '2.0.5', '3:c310a0691836587afa1c22c6e3b2a1a8', 250);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::core-1.8.0-feat-2699-01::bsiri::(Checksum: 3:42632085412cb18c068eb9b645f4b950)
-- the CORE_GROUP squashtest.tm.group.User is now renamed to the normalized squashtest.authz.group.tm.User
UPDATE CORE_GROUP SET QUALIFIED_NAME = 'squashtest.authz.group.tm.User' WHERE ID = 2;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'the CORE_GROUP squashtest.tm.group.User is now renamed to the normalized squashtest.authz.group.tm.User', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'core-1.8.0-feat-2699-01', '2.0.5', '3:42632085412cb18c068eb9b645f4b950', 251);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::core-1.8.0-feat-2699-02::bsiri::(Checksum: 3:b836ac219073c8957e573d6c6604c6fe)
-- the CORE_GROUP squashtest.authz.tm.group.ProjectManager is deleted and the users belonging to that group are now 
-- 		demoted to squashtest.authz.group.tm.User
UPDATE CORE_GROUP_MEMBER SET GROUP_ID = '2' WHERE GROUP_ID = 3;

DELETE FROM CORE_GROUP_AUTHORITY  WHERE GROUP_ID = 3;

DELETE FROM CORE_GROUP  WHERE ID = 3;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'the CORE_GROUP squashtest.authz.tm.group.ProjectManager is deleted and the users belonging to that group are now 
		demoted to squashtest.authz.group.tm.User', NOW(), 'Update Data, Delete Data (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'core-1.8.0-feat-2699-02', '2.0.5', '3:b836ac219073c8957e573d6c6604c6fe', 252);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::core-1.8.0-feat-2699-03::bsiri::(Checksum: 3:d063dbd2d9a2665bfe67a7eec60b6144)
-- The table CORE_PARY_AUTHORITY stores personal authorities. As for TM 1.8.0 the users and teams now have blanket permissions 
-- 			(aka authorities) for themselves, not only via core_group membership. However, a user will still belong to one of the CORE_GROUPs and 
-- 			the personal authorities will stack with the authorities of the group they belong to.
CREATE TABLE CORE_PARTY_AUTHORITY (PARTY_ID BIGINT NOT NULL, AUTHORITY VARCHAR(50) NOT NULL, CONSTRAINT FK_PARTY_AUTHORITY_PARTY FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY(PARTY_ID));

COMMENT ON COLUMN CORE_PARTY_AUTHORITY.PARTY_ID IS 'The CORE_PARTY';

COMMENT ON COLUMN CORE_PARTY_AUTHORITY.AUTHORITY IS 'The authority';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The table CORE_PARY_AUTHORITY stores personal authorities. As for TM 1.8.0 the users and teams now have blanket permissions 
			(aka authorities) for themselves, not only via core_group membership. However, a user will still belong to one of the CORE_G...', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'core-1.8.0-feat-2699-03', '2.0.5', '3:d063dbd2d9a2665bfe67a7eec60b6144', 253);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::core-1.8.0-feat-2699-04::bsiri::(Checksum: 3:0d0108ea67847977c9497d64786bffe4)
-- we have now to set the role ROLE_TM_PROJECT_MANAGER to the corresponding users
insert into CORE_PARTY_AUTHORITY(PARTY_ID, AUTHORITY)
      select distinct cu.PARTY_ID, 'ROLE_TM_PROJECT_MANAGER' from CORE_USER cu
      where cu.PARTY_ID in (
      select cu1.PARTY_ID from CORE_USER cu1
      inner join ACL_RESPONSIBILITY_SCOPE_ENTRY arse1 on arse1.PARTY_ID = cu1.PARTY_ID
      where arse1.ACL_GROUP_ID = 5
      )
      or cu.PARTY_ID in (
      select cu2.PARTY_ID from CORE_USER cu2
      inner join CORE_TEAM_MEMBER ctm on ctm.USER_ID = cu2.PARTY_ID
      inner join ACL_RESPONSIBILITY_SCOPE_ENTRY arse2 on arse2.PARTY_ID = ctm.TEAM_ID
      where arse2.ACL_GROUP_ID = 5
      );

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'we have now to set the role ROLE_TM_PROJECT_MANAGER to the corresponding users', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'core-1.8.0-feat-2699-04', '2.0.5', '3:0d0108ea67847977c9497d64786bffe4', 254);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.issue-2899-1::bsiri::(Checksum: 3:c08bdd96581f7333744b200024cb7bd1)
-- Clean up the database from dead entities that slipped through the deletion routines (mysql, postgresql)
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.issue-2899-2::bsiri::(Checksum: 3:b367799cc274a2162f41b386eec0131b)
-- Clean up the database from dead entities that slipped through the deletion routines (h2). Note :
-- 			There is no way to perform multi table delete so we must delete the tables one by one. 
-- 			
-- 			Since h2 doesn't support multi table delete we must delete the entries one table after the other
-- 			and this will cost quite a bit.
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml::tm-1.8.0.issue-2899-2-postgresql::mpagnon::(Checksum: 3:96d81e788ecc03b8906c7533dc52ebbf)
-- Clean up the database from dead entities that slipped through the deletion routines (postgresql).
delete from SIMPLE_RESOURCE
      where RES_ID not in(
       select RES_ID from REQUIREMENT_FOLDER
      );

delete from RESOURCE
      where RES_ID not in(
      select RES_ID from REQUIREMENT_FOLDER UNION
      select RES_ID from REQUIREMENT_VERSION
      );

create table atlid (ID BIGINT NOT NULL);

insert into atlid(ID) 
      select ATTACHMENT_LIST_ID 
      from ATTACHMENT_LIST 
      where ATTACHMENT_LIST_ID not in (
      select ATTACHMENT_LIST_ID from ACTION_TEST_STEP UNION
      select ATTACHMENT_LIST_ID from CAMPAIGN_LIBRARY UNION
      select ATTACHMENT_LIST_ID from CAMPAIGN_LIBRARY_NODE UNION
      select ATTACHMENT_LIST_ID from EXECUTION UNION
      select ATTACHMENT_LIST_ID from EXECUTION_STEP UNION
      select ATTACHMENT_LIST_ID from ITERATION UNION
      select ATTACHMENT_LIST_ID from PROJECT UNION
      select ATTACHMENT_LIST_ID from REQUIREMENT_LIBRARY UNION
      select ATTACHMENT_LIST_ID from RESOURCE UNION
      select ATTACHMENT_LIST_ID from TEST_CASE_LIBRARY UNION
      select ATTACHMENT_LIST_ID from TEST_CASE_LIBRARY_NODE UNION
      select ATTACHMENT_LIST_ID from TEST_SUITE
      );

delete from ATTACHMENT
      using atlid
      where ATTACHMENT_LIST_ID  = atlid.ID;

delete from ATTACHMENT_LIST
      using atlid
      where ATTACHMENT_LIST_ID  = atlid.ID;

delete from ATTACHMENT_CONTENT
      where ATTACHMENT_CONTENT_ID not in (
      select CONTENT_ID from ATTACHMENT
      );

drop table atlid;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Clean up the database from dead entities that slipped through the deletion routines (postgresql).', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.0.xml', 'tm-1.8.0.issue-2899-2-postgresql', '2.0.5', '3:96d81e788ecc03b8906c7533dc52ebbf', 255);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2::flaurens::(Checksum: 3:a80c0bc8924350b49417c17f22984eae)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.8.2' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2', '2.0.5', '3:a80c0bc8924350b49417c17f22984eae', 256);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2.feature-3120-01::flaurens::(Checksum: 3:0544e35ce7de06b104c3ec004ecf6f5a)
-- Adding denormalized field option table for editable denormalized list valued cufs
CREATE TABLE DENORMALIZED_FIELD_OPTION (DFV_ID BIGINT NOT NULL, LABEL VARCHAR(255) NOT NULL, POSITION INT NOT NULL, CODE VARCHAR(30) NOT NULL, CONSTRAINT fk_df_option_dfv FOREIGN KEY (DFV_ID) REFERENCES DENORMALIZED_FIELD_VALUE(DFV_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adding denormalized field option table for editable denormalized list valued cufs', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2.feature-3120-01', '2.0.5', '3:0544e35ce7de06b104c3ec004ecf6f5a', 257);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2.feature-3120-02::flaurens::(Checksum: 3:50583ee81c3b72676fb0b6e0654a67d8)
-- Old list valued cufs are editable as simple text cufs
UPDATE DENORMALIZED_FIELD_VALUE SET INPUT_TYPE = 'PLAIN_TEXT' WHERE INPUT_TYPE = 'DROPDOWN_LIST';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Old list valued cufs are editable as simple text cufs', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2.feature-3120-02', '2.0.5', '3:50583ee81c3b72676fb0b6e0654a67d8', 258);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2.feature-3120-03::flaurens::(Checksum: 3:5fef6b2dc7deda02148330646469a994)
-- Adding a field type column to denormalized field value table
ALTER TABLE DENORMALIZED_FIELD_VALUE ADD FIELD_TYPE CHAR(3) NOT NULL DEFAULT 'CF';

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.FIELD_TYPE IS 'CF : simple, SSF : multiple-choice';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adding a field type column to denormalized field value table', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2.feature-3120-03', '2.0.5', '3:5fef6b2dc7deda02148330646469a994', 259);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2-feat-3127-01::bsiri::(Checksum: 3:871537e3ea13f4520d42ebc1983cb96f)
-- As of now X_LIBRARY_PLUGINS are merged in the single table LIBRARY_PLUGIN_BINDING
CREATE TABLE LIBRARY_PLUGIN_BINDING (PLUGIN_BINDING_ID bigserial NOT NULL, LIBRARY_ID BIGINT, LIBRARY_TYPE CHAR(1) NOT NULL, PLUGIN_ID VARCHAR(50) NOT NULL, CONSTRAINT PK_LIBRARY_PLUGIN_BINDING PRIMARY KEY (PLUGIN_BINDING_ID));

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.PLUGIN_BINDING_ID IS 'primary key (autogenerated)';

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.LIBRARY_ID IS 'ID of the library. It is explicitely nullable because hibernate will first create the row then update this column.';

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.LIBRARY_TYPE IS 'discriminator of the library. T: test case library, R : requirement library, C : campaign library';

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.PLUGIN_ID IS 'id of the plugin. Note that those plugins aren''t stored in the database and the plugin registry is purely software                (it is basically based on the presence/absence of an OSGI services published by each plugin) so we cannot really enforce referential               integrity. Still, although technically that column cannot be a foreign key, the application uses it as if.';

ALTER TABLE LIBRARY_PLUGIN_BINDING ADD CONSTRAINT uniq_plugin_binding UNIQUE (LIBRARY_ID, LIBRARY_TYPE, PLUGIN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'As of now X_LIBRARY_PLUGINS are merged in the single table LIBRARY_PLUGIN_BINDING', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2-feat-3127-01', '2.0.5', '3:871537e3ea13f4520d42ebc1983cb96f', 260);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2-feat-3127-02::bsiri::(Checksum: 3:85c9aaac4c23f3931279ac88f3da3bef)
-- create the table LIBRARY_PLUGIN_PROPERTY
CREATE TABLE LIBRARY_PLUGIN_BINDING_PROPERTY (PLUGIN_BINDING_ID BIGINT NOT NULL, PLUGIN_BINDING_KEY VARCHAR(30) NOT NULL, PLUGIN_BINDING_VALUE VARCHAR(255) NOT NULL, CONSTRAINT fk_libplugin_property_libplugin FOREIGN KEY (PLUGIN_BINDING_ID) REFERENCES LIBRARY_PLUGIN_BINDING(PLUGIN_BINDING_ID));

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING_PROPERTY.PLUGIN_BINDING_ID IS 'foreign key to LIBRARY_PLUGIN_BINDING';

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING_PROPERTY.PLUGIN_BINDING_KEY IS 'key of this property';

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING_PROPERTY.PLUGIN_BINDING_VALUE IS 'value of this property';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'create the table LIBRARY_PLUGIN_PROPERTY', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2-feat-3127-02', '2.0.5', '3:85c9aaac4c23f3931279ac88f3da3bef', 261);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml::tm-1.8.2-feat-3127-03::bsiri::(Checksum: 3:3aefb0b60a5938f3ffc301a3a33c4e79)
-- drop the old tables
DROP TABLE TEST_CASE_LIBRARY_PLUGINS;

DROP TABLE REQUIREMENT_LIBRARY_PLUGINS;

DROP TABLE CAMPAIGN_LIBRARY_PLUGINS;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'drop the old tables', NOW(), 'Drop Table (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.8.2.xml', 'tm-1.8.2-feat-3127-03', '2.0.5', '3:3aefb0b60a5938f3ffc301a3a33c4e79', 262);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0::flaurens::(Checksum: 3:89b6f708853721fd664dabb32c4cc4e3)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.9.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0', '2.0.5', '3:89b6f708853721fd664dabb32c4cc4e3', 263);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-1::flaurens::(Checksum: 3:fb92b061d00061589d121c2caf27ed4e)
-- Adding columns to order descendants in node relationship tables
ALTER TABLE CLN_RELATIONSHIP ADD CONTENT_ORDER INT;

ALTER TABLE RLN_RELATIONSHIP ADD CONTENT_ORDER INT;

ALTER TABLE TCLN_RELATIONSHIP ADD CONTENT_ORDER INT;

ALTER TABLE REQUIREMENT_LIBRARY_CONTENT ADD CONTENT_ORDER INT;

ALTER TABLE TEST_CASE_LIBRARY_CONTENT ADD CONTENT_ORDER INT;

ALTER TABLE CAMPAIGN_LIBRARY_CONTENT ADD CONTENT_ORDER INT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Adding columns to order descendants in node relationship tables', NOW(), 'Add Column (x6)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3138-1', '2.0.5', '3:fb92b061d00061589d121c2caf27ed4e', 264);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-2::jsimon::(Checksum: 3:77ca853b3481ee33b5ba05a49009ba66)
-- Creating default order which is identical with the alphabetical order
create table TEMP_CLN_CONTENT_ORDER(
        CONTENT_ORDER BIGINT NOT NULL, 
        ANCESTOR_ID BIGINT NOT NULL, 
        DESCENDANT_ID BIGINT NOT NULL
      );

CREATE OR REPLACE FUNCTION testfunction() RETURNS text AS 
$$
DECLARE rn integer := 0-1;
rn2 integer := 0;
prevtcs bigint := 0;
r record;

BEGIN
FOR r in (select  clnr.ANCESTOR_ID, 
        clnr.DESCENDANT_ID from ( 
      	select cr.ancestor_id, cr.descendant_id 
      	from CLN_RELATIONSHIP cr
        join CAMPAIGN_LIBRARY_NODE cln on cr.DESCENDANT_ID = cln.CLN_ID 
        order by cr.ANCESTOR_ID, cln.NAME
       ) as clnr)
LOOP
	IF prevtcs  = r.ANCESTOR_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.ANCESTOR_ID;
        END IF;
       insert into TEMP_CLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.ANCESTOR_ID , r.DESCENDANT_ID  ;
END LOOP;


FOR r in (select clnrr.LIBRARY_ID, clnrr.CONTENT_ID   from (
      	select clc.LIBRARY_ID, clc.CONTENT_ID 
      	from CAMPAIGN_LIBRARY_CONTENT clc
        join CAMPAIGN_LIBRARY_NODE cln on clc.CONTENT_ID = cln.CLN_ID
        order by clc.LIBRARY_ID, cln.NAME
        ) as clnrr)
LOOP
	IF prevtcs  = r.LIBRARY_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.LIBRARY_ID;
        END IF;
       insert into TEMP_CLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.LIBRARY_ID , r.CONTENT_ID  ;
END LOOP;
return 'ok';
END
$$ LANGUAGE plpgsql;

select testfunction();
DROP FUNCTION TestFunction();

update CLN_RELATIONSHIP
      set CONTENT_ORDER = (
        select TEMP_CLN_CONTENT_ORDER.CONTENT_ORDER
        from TEMP_CLN_CONTENT_ORDER
        where TEMP_CLN_CONTENT_ORDER.ANCESTOR_ID = CLN_RELATIONSHIP.ANCESTOR_ID
          and TEMP_CLN_CONTENT_ORDER.DESCENDANT_ID = CLN_RELATIONSHIP.DESCENDANT_ID
      );

update CAMPAIGN_LIBRARY_CONTENT
      set CONTENT_ORDER = (
        select TEMP_CLN_CONTENT_ORDER.CONTENT_ORDER
        from TEMP_CLN_CONTENT_ORDER
        where TEMP_CLN_CONTENT_ORDER.ANCESTOR_ID = CAMPAIGN_LIBRARY_CONTENT.LIBRARY_ID
          and TEMP_CLN_CONTENT_ORDER.DESCENDANT_ID = CAMPAIGN_LIBRARY_CONTENT.CONTENT_ID
      );

drop table TEMP_CLN_CONTENT_ORDER;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Creating default order which is identical with the alphabetical order', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3138-2', '2.0.5', '3:77ca853b3481ee33b5ba05a49009ba66', 265);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-2::flaurens::(Checksum: 3:70d082bcf1d9413f08fb96affa048467)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-3::flaurens::(Checksum: 3:e7a212429273aed825eb0cbcaf5805d7)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-4::jsimon::(Checksum: 3:fe66b4c9da37de06e263e64be83bb7fc)
-- Creating default order which is identical with the alphabetical order
create table TEMP_RLN_CONTENT_ORDER(CONTENT_ORDER BIGINT NOT NULL, ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT
	      NULL);

create table TMP_MAP_RLN_RESOURCE(RLN_ID BIGINT NOT NULL, 
		NAME VARCHAR(255));

insert into TMP_MAP_RLN_RESOURCE(rln_id, name)
	select f.rln_id, res.name 
	from REQUIREMENT_FOLDER f
	inner join RESOURCE res on f.res_id = res.res_id;

insert into TMP_MAP_RLN_RESOURCE(rln_id,  name)
	select r.rln_id,  res.name
	from REQUIREMENT r
	inner join RESOURCE res on  r.current_version_id = res.res_id;

CREATE OR REPLACE FUNCTION testfunction() RETURNS text AS 
$$
DECLARE rn integer := 0-1;
rn2 integer := 0;
prevtcs bigint := 0;
r record;

BEGIN
FOR r in    (select rlnr.ANCESTOR_ID, rlnr.DESCENDANT_ID
	      from (
	      	select rln.ancestor_id, rln.descendant_id 
	      	from RLN_RELATIONSHIP rln
	      	inner join TMP_MAP_RLN_RESOURCE tmp on rln.descendant_id = tmp.rln_id 
	      	order by rln.ancestor_id, tmp.name  
	      ) as rlnr)
LOOP
	IF prevtcs  = r.ANCESTOR_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.ANCESTOR_ID;
        END IF;
       insert into TEMP_RLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.ANCESTOR_ID , r.DESCENDANT_ID  ;
END LOOP;


FOR r in     (select rlnr.LIBRARY_ID, rlnr.CONTENT_ID
	      from (
	      	select rlc.library_id, rlc.content_id 
	      	from REQUIREMENT_LIBRARY_CONTENT rlc
	      	inner join TMP_MAP_RLN_RESOURCE tmp on rlc.content_id = tmp.rln_id
	      	order by rlc.library_id, tmp.name
	      ) as rlnr)
LOOP
	IF prevtcs  = r.LIBRARY_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.LIBRARY_ID;
        END IF;
 	   insert into TEMP_RLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.LIBRARY_ID , r.CONTENT_ID  ;
END LOOP;
return 'ok';
END
$$ LANGUAGE plpgsql;	
select testfunction();
DROP FUNCTION TestFunction();

update RLN_RELATIONSHIP
	      set CONTENT_ORDER = (select TEMP_RLN_CONTENT_ORDER.CONTENT_ORDER
	      from TEMP_RLN_CONTENT_ORDER
	      where TEMP_RLN_CONTENT_ORDER.ANCESTOR_ID = RLN_RELATIONSHIP.ANCESTOR_ID
	      and TEMP_RLN_CONTENT_ORDER.DESCENDANT_ID = RLN_RELATIONSHIP.DESCENDANT_ID);

update REQUIREMENT_LIBRARY_CONTENT
	      set CONTENT_ORDER = (select TEMP_RLN_CONTENT_ORDER.CONTENT_ORDER
	      from TEMP_RLN_CONTENT_ORDER
	      where TEMP_RLN_CONTENT_ORDER.ANCESTOR_ID = REQUIREMENT_LIBRARY_CONTENT.LIBRARY_ID
	      and TEMP_RLN_CONTENT_ORDER.DESCENDANT_ID = REQUIREMENT_LIBRARY_CONTENT.CONTENT_ID);

drop table TEMP_RLN_CONTENT_ORDER;

drop table TMP_MAP_RLN_RESOURCE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Creating default order which is identical with the alphabetical order', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3138-4', '2.0.5', '3:fe66b4c9da37de06e263e64be83bb7fc', 266);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-4::flaurens::(Checksum: 3:23d673afa932d2662822b0c0ebb153c4)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-5::flaurens::(Checksum: 3:d72728a5247af5f160a9b2bf6ea46e06)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-6::jsimon::(Checksum: 3:e41cebe2243a27747d56b644dc107adb)
-- Creating default order which is identical with the alphabetical order
create table TEMP_TCLN_CONTENT_ORDER(CONTENT_ORDER BIGINT NOT NULL, ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT
      NULL);

CREATE OR REPLACE FUNCTION testfunction() RETURNS text AS 
$$
DECLARE rn integer := 0-1;
rn2 integer := 0;
prevtcs bigint := 0;
r record;

BEGIN
FOR r in        (select tclnr.ANCESTOR_ID, tclnr.DESCENDANT_ID
      from (
      select tr.ancestor_id, tr.descendant_id 
      from TCLN_RELATIONSHIP tr
      join TEST_CASE_LIBRARY_NODE tcln on tr.DESCENDANT_ID = tcln.TCLN_ID
      order by tr.ancestor_id, tcln.name
      ) as tclnr)
LOOP
	IF prevtcs  = r.ANCESTOR_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.ANCESTOR_ID;
        END IF;
          insert into TEMP_TCLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.ANCESTOR_ID , r.DESCENDANT_ID  ;
END LOOP;


FOR r in     (select tclnr.LIBRARY_ID, tclnr.CONTENT_ID
      from (
      	select tc.library_id, tc.content_id
      	from TEST_CASE_LIBRARY_CONTENT tc      
      	join TEST_CASE_LIBRARY_NODE tcln on tc.CONTENT_ID = tcln.TCLN_ID
      	order by tc.library_id, tcln.name
      ) as tclnr)
LOOP
	IF prevtcs  = r.LIBRARY_ID 
        THEN 
             rn2 := rn ;
             rn := rn2 + 1;
        ELSE rn := 0 ; 
             prevtcs := r.LIBRARY_ID;
        END IF;
  insert into TEMP_TCLN_CONTENT_ORDER (CONTENT_ORDER, ANCESTOR_ID, DESCENDANT_ID)
       select rn, r.LIBRARY_ID , r.CONTENT_ID  ;
END LOOP;


return 'ok';
END
$$ LANGUAGE plpgsql;

select testfunction();
DROP FUNCTION TestFunction();

update TCLN_RELATIONSHIP
      set CONTENT_ORDER = (select TEMP_TCLN_CONTENT_ORDER.CONTENT_ORDER
      from TEMP_TCLN_CONTENT_ORDER
      where TEMP_TCLN_CONTENT_ORDER.ANCESTOR_ID = TCLN_RELATIONSHIP.ANCESTOR_ID
      and TEMP_TCLN_CONTENT_ORDER.DESCENDANT_ID = TCLN_RELATIONSHIP.DESCENDANT_ID);

update TEST_CASE_LIBRARY_CONTENT
      set CONTENT_ORDER = (select TEMP_TCLN_CONTENT_ORDER.CONTENT_ORDER
      from TEMP_TCLN_CONTENT_ORDER
      where TEMP_TCLN_CONTENT_ORDER.ANCESTOR_ID = TEST_CASE_LIBRARY_CONTENT.LIBRARY_ID
      and TEMP_TCLN_CONTENT_ORDER.DESCENDANT_ID = TEST_CASE_LIBRARY_CONTENT.CONTENT_ID);

drop table TEMP_TCLN_CONTENT_ORDER;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Creating default order which is identical with the alphabetical order', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3138-6', '2.0.5', '3:e41cebe2243a27747d56b644dc107adb', 267);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-6::flaurens::(Checksum: 3:0aa920840e862570d6ed68203c8e9c61)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-7::flaurens::(Checksum: 3:f87847f25964c228c1f9f490447d43e5)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3138-8::flaurens::(Checksum: 3:791def7c4c4c0ba5de392094e2566dc7)
ALTER TABLE REQUIREMENT_VERSION_COVERAGE ALTER COLUMN  VERIFIED_REQ_VERSION_ID DROP NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Drop Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3138-8', '2.0.5', '3:791def7c4c4c0ba5de392094e2566dc7', 268);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3211-1::flaurens::(Checksum: 3:5ff38e07ec4100e97110b6a92e3de8f2)
CREATE TABLE DISABLED_EXECUTION_STATUS (CL_ID BIGINT NOT NULL, EXECUTION_STATUS VARCHAR(255) NOT NULL, CONSTRAINT FK_DISABLED_EXEC_STATUS_CL_ID FOREIGN KEY (CL_ID) REFERENCES CAMPAIGN_LIBRARY(CL_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3211-1', '2.0.5', '3:5ff38e07ec4100e97110b6a92e3de8f2', 269);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0.feature-3211-2::flaurens::(Checksum: 3:26052fb408d086effe3a014b8a09213a)
-- Inserting default disabled execution statuses for existing libraries
insert into DISABLED_EXECUTION_STATUS (CL_ID, EXECUTION_STATUS)
	select cl_id, 'ERROR' from CAMPAIGN_LIBRARY;

insert into DISABLED_EXECUTION_STATUS (CL_ID, EXECUTION_STATUS)
	select cl_id, 'WARNING' from CAMPAIGN_LIBRARY;

insert into DISABLED_EXECUTION_STATUS (CL_ID, EXECUTION_STATUS)
	select cl_id, 'NOT_RUN' from CAMPAIGN_LIBRARY;

insert into DISABLED_EXECUTION_STATUS (CL_ID, EXECUTION_STATUS)
	select cl_id, 'SETTLED' from CAMPAIGN_LIBRARY;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Inserting default disabled execution statuses for existing libraries', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0.feature-3211-2', '2.0.5', '3:26052fb408d086effe3a014b8a09213a', 270);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0-issue-3236-01::flaurens::(Checksum: 3:729c2bd9779407fdac179500120ac41d)
update DENORMALIZED_FIELD_VALUE
		set FIELD_TYPE = 'CF'
		where FIELD_TYPE = '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0-issue-3236-01', '2.0.5', '3:729c2bd9779407fdac179500120ac41d', 271);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0-issue--01::flaurens::(Checksum: 3:b648fe9256fe932650a53bc207e9b1d7)
ALTER TABLE ACTION_TEST_STEP ALTER COLUMN  ACTION DROP NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Drop Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0-issue--01', '2.0.5', '3:b648fe9256fe932650a53bc207e9b1d7', 272);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml::tm-1.9.0-issue-3140-01::mpagnon::(Checksum: 3:5ea9821a2262ebec751e750545bb7a5a)
create table TEMP_VS(
          RVC_ID BIGINT NOT NULL,
          TS_ID BIGINT NOT NULL
        );

insert into TEMP_VS(RVC_ID, TS_ID)
        select vs.REQUIREMENT_VERSION_COVERAGE_ID, vs.TEST_STEP_ID
        from VERIFYING_STEPS as vs
        group by vs.REQUIREMENT_VERSION_COVERAGE_ID, vs.TEST_STEP_ID;

delete from VERIFYING_STEPS;

insert into  VERIFYING_STEPS (REQUIREMENT_VERSION_COVERAGE_ID, TEST_STEP_ID)
        select RVC_ID , TS_ID
        from TEMP_VS;

drop table TEMP_VS;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.9.0.xml', 'tm-1.9.0-issue-3140-01', '2.0.5', '3:5ea9821a2262ebec751e750545bb7a5a', 273);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0::bsiri::(Checksum: 3:3ad9494d3bedeb8a0c6496ba0d60d083)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.10.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0', '2.0.5', '3:3ad9494d3bedeb8a0c6496ba0d60d083', 274);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-1::bsiri::(Checksum: 3:59e2894568fa1bd5fff1948666ea333e)
-- before the cleanup, we need to relax some constraints
ALTER TABLE AUTOMATED_EXECUTION_EXTENDER ALTER COLUMN  TEST_ID DROP NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'before the cleanup, we need to relax some constraints', NOW(), 'Drop Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-1', '2.0.5', '3:59e2894568fa1bd5fff1948666ea333e', 275);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-2::bsiri::(Checksum: 3:8bcc80e133df026105b743b08a0a5ccc)
-- cleaning up unused entities
create temporary table UNUSED_TA_PROJECT as 
  			(
  				select taproj.project_id as project_id
  				from TEST_AUTOMATION_PROJECT taproj 
  				where taproj.project_id not in (
  					select ta_project_id from TM_TA_PROJECTS
  				)
  			);

update AUTOMATED_EXECUTION_EXTENDER extender
  			set result_url = null,
  				test_id = null
  			where extender.test_id in (
  				select tatest.test_id 
  				from  AUTOMATED_TEST tatest 
  				inner join UNUSED_TA_PROJECT unused on tatest.project_id = unused.project_id 
  			);

update TEST_CASE tc 
  			set ta_test = null
  			where tc.ta_test in (
  				select tatest.test_id 
  				from AUTOMATED_TEST tatest 
  				inner join UNUSED_TA_PROJECT unused on tatest.project_id = unused.project_id 
  			);

delete from AUTOMATED_TEST  
			where project_id in (
				select unused.project_id from UNUSED_TA_PROJECT unused
			);

delete from TEST_AUTOMATION_PROJECT 
  			where project_id in (
  				select p.project_id from UNUSED_TA_PROJECT p
  			);

delete from TEST_AUTOMATION_SERVER 
  			where server_id not in (
  				select distinct taproj.server_id 
  				from TM_TA_PROJECTS binding 
  				inner join TEST_AUTOMATION_PROJECT taproj on binding.ta_project_id = taproj.project_id 
  			);

drop table UNUSED_TA_PROJECT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'cleaning up unused entities', NOW(), 'Custom SQL (x7)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-2', '2.0.5', '3:8bcc80e133df026105b743b08a0a5ccc', 276);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-3::bsiri::(Checksum: 3:656ef2247742ad5390b1dbd308c132b9)
-- The test automation servers are now 'auditable' (dates and authors of creation/modification are recorded) and has 
-- 		several other attributes
ALTER TABLE TEST_AUTOMATION_SERVER ADD NAME VARCHAR(50);

ALTER TABLE TEST_AUTOMATION_SERVER ADD DESCRIPTION TEXT;

ALTER TABLE TEST_AUTOMATION_SERVER ADD CREATED_BY VARCHAR(50) DEFAULT '(nobody)';

ALTER TABLE TEST_AUTOMATION_SERVER ADD CREATED_ON TIMESTAMP WITH TIME ZONE;

ALTER TABLE TEST_AUTOMATION_SERVER ADD LAST_MODIFIED_BY VARCHAR(50) DEFAULT null;

ALTER TABLE TEST_AUTOMATION_SERVER ADD LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null;

ALTER TABLE TEST_AUTOMATION_SERVER ADD MANUAL_SLAVE_SELECTION BOOLEAN NOT NULL DEFAULT FALSE;

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.NAME IS 'The name of the server';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.DESCRIPTION IS 'A description for the server. Since its of type ''CLOB'' it might not be so short after all.';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.CREATED_BY IS 'Who created this test automation server';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.CREATED_ON IS 'When was created that server';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.LAST_MODIFIED_BY IS 'Author of last edition';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.LAST_MODIFIED_ON IS 'Last date of edition';

COMMENT ON COLUMN TEST_AUTOMATION_SERVER.MANUAL_SLAVE_SELECTION IS 'Should the user select which slave will run the tests (if there are some) ?';

update TEST_AUTOMATION_SERVER
			set name = concat_ws('-', base_url, server_id);

update TEST_AUTOMATION_SERVER
			set CREATED_ON = NOW();

ALTER TABLE TEST_AUTOMATION_SERVER ALTER COLUMN  NAME SET NOT NULL;

ALTER TABLE TEST_AUTOMATION_SERVER ADD UNIQUE (NAME);

ALTER TABLE TEST_AUTOMATION_SERVER ALTER COLUMN  CREATED_ON SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The test automation servers are now ''auditable'' (dates and authors of creation/modification are recorded) and has 
		several other attributes', NOW(), 'Add Column, Custom SQL (x2), Add Not-Null Constraint, Add Unique Constraint, Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-3', '2.0.5', '3:656ef2247742ad5390b1dbd308c132b9', 277);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-4::bsiri::(Checksum: 3:d9951c7511173bf2418ccc3918d3cbe6)
-- The associative table TM_TA_PROJECTS is totally re-purposed as TEST_AUTOMATION_PROJECT 
-- 			(and the former table is ditched).
CREATE TABLE PROTO_TEST_AUTOMATION_PROJECT (TA_PROJECT_ID bigserial NOT NULL, TM_PROJECT_ID BIGINT NOT NULL, LABEL VARCHAR(50) NOT NULL, REMOTE_NAME VARCHAR(50) NOT NULL, SERVER_ID BIGINT NOT NULL, EXECUTION_ENVIRONMENTS VARCHAR(255) DEFAULT '' NOT NULL, FORMER_ID BIGINT NOT NULL, CONSTRAINT PK_PROTO_TEST_AUTOMATION_PROJECT PRIMARY KEY (TA_PROJECT_ID), CONSTRAINT fk_ta_project_tm_project FOREIGN KEY (TM_PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_ta_project_ta_server FOREIGN KEY (SERVER_ID) REFERENCES TEST_AUTOMATION_SERVER(SERVER_ID));

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.TA_PROJECT_ID IS 'the primary key';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.TM_PROJECT_ID IS 'the reference to the TM project';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.LABEL IS 'the (friendly) alias for that TA project';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.REMOTE_NAME IS 'the (real) name of the remote test automation project';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.SERVER_ID IS 'foreign key to the automated test server';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.EXECUTION_ENVIRONMENTS IS 'the list of approved slaves servers';

COMMENT ON COLUMN PROTO_TEST_AUTOMATION_PROJECT.FORMER_ID IS 'the former primary key';

insert into PROTO_TEST_AUTOMATION_PROJECT(TM_PROJECT_ID, LABEL, REMOTE_NAME, SERVER_ID, FORMER_ID) 
			select binding.tm_project_id, 
				   concat_ws('-', proj.name, binding.tm_project_id, binding.ta_project_id),
				   proj.name,
				   proj.server_id, 
				   proj.project_id
			from TM_TA_PROJECTS binding
			inner join TEST_AUTOMATION_PROJECT proj on binding.ta_project_id = proj.project_id;

DROP TABLE TM_TA_PROJECTS;

ALTER TABLE AUTOMATED_TEST DROP CONSTRAINT fk_automated_test_project;

DROP TABLE TEST_AUTOMATION_PROJECT;

ALTER TABLE PROTO_TEST_AUTOMATION_PROJECT RENAME TO TEST_AUTOMATION_PROJECT;

update AUTOMATED_TEST  
			set PROJECT_ID = (
				select tap.TA_PROJECT_ID 
				from TEST_AUTOMATION_PROJECT tap
                  inner join TEST_CASE_LIBRARY_NODE tcln on tcln.PROJECT_ID = tap.TM_PROJECT_ID
                  inner join TEST_CASE tc on tc.TCLN_ID = tcln.TCLN_ID
				where PROJECT_ID = tap.FORMER_ID
				  and TEST_ID = tc.TA_TEST
				group by tc.TA_TEST, tap.TA_PROJECT_ID 
			);

ALTER TABLE TEST_AUTOMATION_PROJECT DROP COLUMN FORMER_ID;

ALTER TABLE AUTOMATED_TEST ADD CONSTRAINT fk_automated_test_project FOREIGN KEY (PROJECT_ID) REFERENCES TEST_AUTOMATION_PROJECT (TA_PROJECT_ID);

ALTER TABLE TEST_AUTOMATION_PROJECT ADD CONSTRAINT uniq_tm_ta_project_job UNIQUE (TM_PROJECT_ID, REMOTE_NAME, SERVER_ID);

ALTER TABLE TEST_AUTOMATION_PROJECT ADD CONSTRAINT uniq_tm_ta_project_label UNIQUE (TM_PROJECT_ID, LABEL);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The associative table TM_TA_PROJECTS is totally re-purposed as TEST_AUTOMATION_PROJECT 
			(and the former table is ditched).', NOW(), 'Create Table, Custom SQL, Drop Table, Drop Foreign Key Constraint, Drop Table, Rename Table, Custom SQL, Drop Column, Add Foreign Key Constraint, Add Unique Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-4', '2.0.5', '3:d9951c7511173bf2418ccc3918d3cbe6', 278);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-5::bsiri::(Checksum: 3:616a59d39628998dd7528bcabb3d0eb6)
-- A TM project is now hard-bound to a TA server
ALTER TABLE PROJECT ADD TA_SERVER_ID BIGINT;

ALTER TABLE PROJECT ADD CONSTRAINT tm_project_ta_server FOREIGN KEY (TA_SERVER_ID) REFERENCES TEST_AUTOMATION_SERVER (SERVER_ID);

COMMENT ON COLUMN PROJECT.TA_SERVER_ID IS 'the reference to the test automation server';

ALTER TABLE PROJECT DROP COLUMN TEST_AUTOMATION_ENABLED;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'A TM project is now hard-bound to a TA server', NOW(), 'Add Column, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-5', '2.0.5', '3:616a59d39628998dd7528bcabb3d0eb6', 279);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-6::bsiri::(Checksum: 3:42bb203e9e2c144c5f898a60cebc018d)
-- migrating existing data to the new schema
update PROJECT 
			set ta_server_id = (
				select max(server.server_id) 
				from TEST_AUTOMATION_SERVER server 
				inner join TEST_AUTOMATION_PROJECT taproj on server.server_id = taproj.server_id
				where taproj.tm_project_id = project_id
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'migrating existing data to the new schema', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-6', '2.0.5', '3:42bb203e9e2c144c5f898a60cebc018d', 280);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-6::gfouquet::(Checksum: 3:8d4f03a4e80ae529bf67a2028ff9d008)
ALTER TABLE AUTOMATED_EXECUTION_EXTENDER ADD NODE_NAME VARCHAR(50) DEFAULT '';

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.NODE_NAME IS 'Name of the node which ran the test';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('gfouquet', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-6', '2.0.5', '3:8d4f03a4e80ae529bf67a2028ff9d008', 281);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-7::flaurens::(Checksum: 3:54b38dcbdbe6823bfda9c18d4df42597)
ALTER TABLE AUTOMATED_EXECUTION_EXTENDER ADD EXECUTION_EXTENDER_ORDER BIGINT;

COMMENT ON COLUMN AUTOMATED_EXECUTION_EXTENDER.EXECUTION_EXTENDER_ORDER IS 'order of automated executions extenders within an automated suite';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-7', '2.0.5', '3:54b38dcbdbe6823bfda9c18d4df42597', 282);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-8::flaurens::(Checksum: 3:cdb6aacd59519443b1ff399c56853178)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-9::flaurens::(Checksum: 3:1823888e43c13a948e083334f63d7298)
-- Creating default order which is identical with the alphabetical order
-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml::tm-1.10.0.feature-3481-postgresql::mpagnon::(Checksum: 3:d392e5a0756e8dd888c9b174fd00fba6)
-- Creating default order which is identical with the alphabetical order
create table TEMP_EXECUTION_EXTENDER_ORDER(
          EXECUTION_EXTENDER_ORDER BIGINT NOT NULL, 
          SUITE_ID TEXT NOT NULL, 
          EXTENDER_ID BIGINT NOT NULL
        );

CREATE OR REPLACE FUNCTION orderExecExtender() RETURNS text AS 
        $$
        DECLARE rn integer := 0-1;
        rn2 integer := 0;
        prevSuite text := '';
        r record;
        BEGIN
        FOR r in (select cr.SUITE_ID, cr.EXTENDER_ID from AUTOMATED_EXECUTION_EXTENDER cr order by cr.SUITE_ID, cr.EXTENDER_ID)
        LOOP
          IF prevSuite  = r.SUITE_ID 
                THEN 
                     rn2 := rn ;
                     rn := rn2 + 1;
                ELSE rn := 0 ; 
                     prevSuite := r.SUITE_ID;
                END IF;
            insert into TEMP_EXECUTION_EXTENDER_ORDER ( EXECUTION_EXTENDER_ORDER, SUITE_ID, EXTENDER_ID)
               select rn, r.SUITE_ID , r.EXTENDER_ID  ;
              
               
        
        END LOOP;
        return 'ok';
        END
        $$ LANGUAGE plpgsql;
        
        select orderExecExtender();
        DROP FUNCTION orderExecExtender();

update AUTOMATED_EXECUTION_EXTENDER
        set EXECUTION_EXTENDER_ORDER = (
          select TEMP_EXECUTION_EXTENDER_ORDER.EXECUTION_EXTENDER_ORDER
          from TEMP_EXECUTION_EXTENDER_ORDER
          where TEMP_EXECUTION_EXTENDER_ORDER.SUITE_ID = AUTOMATED_EXECUTION_EXTENDER.SUITE_ID
            and TEMP_EXECUTION_EXTENDER_ORDER.EXTENDER_ID = AUTOMATED_EXECUTION_EXTENDER.EXTENDER_ID
        );

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Creating default order which is identical with the alphabetical order', NOW(), 'Custom SQL, Create Procedure, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.0.xml', 'tm-1.10.0.feature-3481-postgresql', '2.0.5', '3:d392e5a0756e8dd888c9b174fd00fba6', 283);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.3.xml::tm-1.10.0::bsiri::(Checksum: 3:d92e91b6c8f0f2130984141e6a334f22)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.10.3' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.3.xml', 'tm-1.10.0', '2.0.5', '3:d92e91b6c8f0f2130984141e6a334f22', 284);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.3.xml::tm-1.10.3-issue-3807-3808-1::bsiri::(Checksum: 3:3f34b003a00e3d66ba23ebb758d49e6f)
-- Adding much needed indexes
CREATE INDEX idx_cfv_entity_id ON CUSTOM_FIELD_VALUE(BOUND_ENTITY_ID);

CREATE INDEX idx_cfv_entity_type ON CUSTOM_FIELD_VALUE(BOUND_ENTITY_TYPE);

CREATE INDEX idx_dfv_entity_id ON DENORMALIZED_FIELD_VALUE(DENORMALIZED_FIELD_HOLDER_ID);

CREATE INDEX idx_dfv_entity_type ON DENORMALIZED_FIELD_VALUE(DENORMALIZED_FIELD_HOLDER_TYPE);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Adding much needed indexes', NOW(), 'Create Index (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.3.xml', 'tm-1.10.3-issue-3807-3808-1', '2.0.5', '3:3f34b003a00e3d66ba23ebb758d49e6f', 285);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml::tm-1.10.5::mpagnon::(Checksum: 3:8d872fc80ee4cdeb76f181e1a76e1272)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.10.5' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml', 'tm-1.10.5', '2.0.5', '3:8d872fc80ee4cdeb76f181e1a76e1272', 286);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml::tm-1.10.5-issue-3860-1::mpagnon::(Checksum: 3:616f88306a30b38496906a242633749f)
-- Removing duplicate values
CREATE TABLE CUF_VALUES_TO_SAVE (id BIGINT);

CREATE UNIQUE INDEX idx_cuf_values_to_save ON CUF_VALUES_TO_SAVE(id);

insert into CUF_VALUES_TO_SAVE (id)
      select min(CFV_ID)
      from CUSTOM_FIELD_VALUE cfv
      where cfv.BOUND_ENTITY_TYPE = 'TEST_STEP'
      group by cfv.BOUND_ENTITY_ID, cfv.CFB_ID;

delete from CUSTOM_FIELD_VALUE
      where BOUND_ENTITY_TYPE = 'TEST_STEP' and
      not exists (select 1 from CUF_VALUES_TO_SAVE cfvts where cfvts.id = cfv_id);

DROP INDEX idx_cuf_values_to_save;

DROP TABLE CUF_VALUES_TO_SAVE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Removing duplicate values', NOW(), 'Create Table, Create Index, Custom SQL (x2), Drop Index, Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml', 'tm-1.10.5-issue-3860-1', '2.0.5', '3:616f88306a30b38496906a242633749f', 287);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml::tm-1.10.5-issue-3860-3::mpagnon::(Checksum: 3:38c89155e896864447e3b3ddef7a31c9)
-- add missing custom field values
CREATE TABLE STEPS_SHOULD_HAVE_CUF_VALUES (cuf_binding_id BIGINT, step_id BIGINT, default_value VARCHAR(255), optional BOOLEAN);

insert into STEPS_SHOULD_HAVE_CUF_VALUES (cuf_binding_id , step_id , default_value , optional )
      select
      cfb.CFB_ID, ats.TEST_STEP_ID, cf.default_value, cf.optional
      from ACTION_TEST_STEP ats, TEST_CASE_STEPS tcs,
      TEST_CASE_LIBRARY_NODE tcln, CUSTOM_FIELD_BINDING cfb, CUSTOM_FIELD cf
      where ats.TEST_STEP_ID = tcs.STEP_ID
      and
      tcln.TCLN_ID = tcs.TEST_CASE_ID
      and tcln.PROJECT_ID = cfb.BOUND_PROJECT_ID
      and cfb.CF_ID = cf.CF_ID
      and cfb.BOUND_ENTITY = 'TEST_STEP'
      and not exists (
      select 1
      from CUSTOM_FIELD_VALUE cfv
      where cfv.CFB_ID = cfb.CFB_ID
      and cfv.BOUND_ENTITY_TYPE = 'TEST_STEP'
      and
      cfv.BOUND_ENTITY_ID = ats.TEST_STEP_ID
      );

insert into CUSTOM_FIELD_VALUE ( BOUND_ENTITY_ID, BOUND_ENTITY_TYPE, CFB_ID, VALUE)
      select sshcv.step_id ,
      'TEST_STEP', sshcv.cuf_binding_id, ''
      from STEPS_SHOULD_HAVE_CUF_VALUES sshcv
      where sshcv.optional = true;

insert into CUSTOM_FIELD_VALUE ( BOUND_ENTITY_ID, BOUND_ENTITY_TYPE, CFB_ID, VALUE)
      select sshcv.step_id ,
      'TEST_STEP', sshcv.cuf_binding_id, sshcv.default_value
      from STEPS_SHOULD_HAVE_CUF_VALUES sshcv
      where sshcv.optional
      = false;

DROP TABLE STEPS_SHOULD_HAVE_CUF_VALUES;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'add missing custom field values', NOW(), 'Create Table, Custom SQL (x3), Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.10.5.xml', 'tm-1.10.5-issue-3860-3', '2.0.5', '3:38c89155e896864447e3b3ddef7a31c9', 288);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0::flaurens::(Checksum: 3:15f03859fcb795f03494e71ae0ec15f8)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.11.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0', '2.0.5', '3:15f03859fcb795f03494e71ae0ec15f8', 289);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3576-1::bsiri::(Checksum: 3:76a554ce241d733597b26c4afcc1d3ec)
-- Prepares the table CUSTOM_FIELD for possible default_values of type TEXT.
--   		Also accepts now a new value for the column FIELD_TYPE : RTF (for rich text fields) - no structural changes for that though.
ALTER TABLE CUSTOM_FIELD ADD LARGE_DEFAULT_VALUE TEXT DEFAULT null;

COMMENT ON COLUMN CUSTOM_FIELD.LARGE_DEFAULT_VALUE IS 'this column is used by rich text cufs. It contains HTML data.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Prepares the table CUSTOM_FIELD for possible default_values of type TEXT.
  		Also accepts now a new value for the column FIELD_TYPE : RTF (for rich text fields) - no structural changes for that though.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3576-1', '2.0.5', '3:76a554ce241d733597b26c4afcc1d3ec', 290);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3576-2::bsiri::(Checksum: 3:5b69b5fb7e3727632ab4479a010bf602)
-- prepares the table CUSTOM_FIELD_VALUE for values of type CLOB, and adds support for inheritance to that end.
ALTER TABLE CUSTOM_FIELD_VALUE ADD LARGE_VALUE TEXT DEFAULT null;

ALTER TABLE CUSTOM_FIELD_VALUE ADD FIELD_TYPE VARCHAR(3) NOT NULL DEFAULT 'CF';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.LARGE_VALUE IS 'this column is used by rich text cufs. It contains HTML data.';

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.FIELD_TYPE IS 'CF : simple, RTF : rich text field';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'prepares the table CUSTOM_FIELD_VALUE for values of type CLOB, and adds support for inheritance to that end.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3576-2', '2.0.5', '3:5b69b5fb7e3727632ab4479a010bf602', 291);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3576-3::bsiri::(Checksum: 3:b3dc90cd83d541e9c0bcd38ae6707e70)
-- Prepares the table DENORMALIZED_FIELD_VALUE for values of type CLOB, and adds support for inheritance to that end.
--   		Also accepts now a new value for the column FIELD_TYPE : RTF (for rich text fields) - no structural changes for that though.
ALTER TABLE DENORMALIZED_FIELD_VALUE ADD LARGE_VALUE TEXT DEFAULT null;

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.LARGE_VALUE IS 'this column is used by rich text cufs. It contains HTML data.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Prepares the table DENORMALIZED_FIELD_VALUE for values of type CLOB, and adds support for inheritance to that end.
  		Also accepts now a new value for the column FIELD_TYPE : RTF (for rich text fields) - no structural changes for that though.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3576-3', '2.0.5', '3:b3dc90cd83d541e9c0bcd38ae6707e70', 292);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3556-4::kdrifi::(Checksum: 3:d80d9ea54b2ec012b8c27e2255c8fb53)
-- Cleaning duplicates of column ROLE_USER in table core_group _authority
DELETE FROM CORE_GROUP_AUTHORITY  WHERE AUTHORITY='ROLE_USER';

DELETE FROM CORE_GROUP_AUTHORITY  WHERE GROUP_ID = 1
        and AUTHORITY='ROLE_TM_USER';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('kdrifi', 'Cleaning duplicates of column ROLE_USER in table core_group _authority', NOW(), 'Delete Data (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3556-4', '2.0.5', '3:d80d9ea54b2ec012b8c27e2255c8fb53', 293);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3577-1::mpagnon::(Checksum: 3:8ffea92786df4b390a435239641c2228)
-- Fix columns with CHAR(X) types to VARCHAR(X) type to avoid blank space filling by Postgresql
ALTER TABLE CUSTOM_FIELD ALTER COLUMN INPUT_TYPE TYPE VARCHAR(30);

ALTER TABLE CUSTOM_FIELD ALTER COLUMN FIELD_TYPE TYPE VARCHAR(3);

ALTER TABLE DENORMALIZED_FIELD_VALUE ALTER COLUMN FIELD_TYPE TYPE VARCHAR(3);

ALTER TABLE DENORMALIZED_FIELD_VALUE ALTER COLUMN INPUT_TYPE TYPE VARCHAR(30);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'Fix columns with CHAR(X) types to VARCHAR(X) type to avoid blank space filling by Postgresql', NOW(), 'Modify data type (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3577-1', '2.0.5', '3:8ffea92786df4b390a435239641c2228', 294);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3577-2::jsimon::(Checksum: 3:86851168e5900faf7c6eefe390b30c21)
-- create function to emulate group concat with separator
CREATE OR REPLACE
      FUNCTION group_concat_func(field1 TEXT, field2 TEXT)
      RETURNS TEXT AS $$
      BEGIN
      RETURN
      COALESCE(field1||','||field2, field2, field1);
      END;
      $$ LANGUAGE plpgsql;

      DROP AGGREGATE IF EXISTS group_concat(text);
      CREATE AGGREGATE group_concat(text) (
      SFUNC = group_concat_func
      ,STYPE = text
      );

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'create function to emulate group concat with separator', NOW(), 'Create Procedure', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3577-2', '2.0.5', '3:86851168e5900faf7c6eefe390b30c21', 295);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.9.0.feature-3138-2::jsimon::(Checksum: 3:a57d42d8ec0b04084c9913a8e3ded8c8)
ALTER TABLE CAMPAIGN_LIBRARY_CONTENT ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

ALTER TABLE CLN_RELATIONSHIP ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Add Not-Null Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.9.0.feature-3138-2', '2.0.5', '3:a57d42d8ec0b04084c9913a8e3ded8c8', 296);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.9.0.feature-3138-4::jsimon::(Checksum: 3:c88ef675a0232a59c1db71d28f5b7e1b)
ALTER TABLE RLN_RELATIONSHIP ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

ALTER TABLE REQUIREMENT_LIBRARY_CONTENT ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Add Not-Null Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.9.0.feature-3138-4', '2.0.5', '3:c88ef675a0232a59c1db71d28f5b7e1b', 297);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.9.0.feature-3138-6::jsimon::(Checksum: 3:b5f2d2aca472ea6d775e34406cdef2c6)
ALTER TABLE TCLN_RELATIONSHIP ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

ALTER TABLE TEST_CASE_LIBRARY_CONTENT ALTER COLUMN  CONTENT_ORDER SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Add Not-Null Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.9.0.feature-3138-6', '2.0.5', '3:b5f2d2aca472ea6d775e34406cdef2c6', 298);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3693-1::bsiri::(Checksum: 3:e03b49c622195764377e3a0f1df4c3df)
-- Adding support for call-step level management of datasets
ALTER TABLE CALL_TEST_STEP ADD CALLED_DATASET BIGINT DEFAULT null;

ALTER TABLE CALL_TEST_STEP ADD DELEGATE_PARAMETER_VALUES BOOLEAN NOT NULL DEFAULT FALSE;

COMMENT ON COLUMN CALL_TEST_STEP.CALLED_DATASET IS 'A reference to the called dataset (if any). The fk constraint must set null when the dataset is deleted.';

COMMENT ON COLUMN CALL_TEST_STEP.DELEGATE_PARAMETER_VALUES IS 'Says whether the parameters of the called test case must be set by the caller test case or not';

ALTER TABLE CALL_TEST_STEP ADD CONSTRAINT fk_call_step_dataset FOREIGN KEY (CALLED_DATASET) REFERENCES DATASET (DATASET_ID) ON DELETE SET NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Adding support for call-step level management of datasets', NOW(), 'Add Column, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3693-1', '2.0.5', '3:e03b49c622195764377e3a0f1df4c3df', 299);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3693-2::bsiri::(Checksum: 3:f584c9f6658d1d4cc49caa0ab18ce9de)
-- For back compatibility, the call steps migrating from an existing DB will now be set to delegate the parameters
UPDATE CALL_TEST_STEP SET DELEGATE_PARAMETER_VALUES = TRUE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'For back compatibility, the call steps migrating from an existing DB will now be set to delegate the parameters', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3693-2', '2.0.5', '3:f584c9f6658d1d4cc49caa0ab18ce9de', 300);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3700-1::bsiri::(Checksum: 3:add390e7eec45f884a462042b1536218)
-- Items of a campaign test plan can now reference Datasets
ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM ADD DATASET_ID BIGINT;

ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM ADD CONSTRAINT fk_camp_test_plan_item_dataset FOREIGN KEY (DATASET_ID) REFERENCES DATASET (DATASET_ID);

COMMENT ON COLUMN CAMPAIGN_TEST_PLAN_ITEM.DATASET_ID IS 'the dataset the test plan item should use so that new iterations will now use those datasets';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Items of a campaign test plan can now reference Datasets', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3700-1', '2.0.5', '3:add390e7eec45f884a462042b1536218', 301);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.feature-3701-1::bsiri::(Checksum: 3:7dbee782206c249e6d9efd793924d7e0)
-- An execution now remembers which dataset was used (or not). That new column encodes three states : 
-- 				"" -> no dataset used,
-- 				somelabel -> the label of the dataset used,
-- 				null -> the test case had no parameters anyway
ALTER TABLE EXECUTION ADD DATASET_LABEL VARCHAR(255);

COMMENT ON COLUMN EXECUTION.DATASET_LABEL IS 'the name of the dataset used';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'An execution now remembers which dataset was used (or not). That new column encodes three states : 
				"" -> no dataset used,
				somelabel -> the label of the dataset used,
				null -> the test case had no parameters anyway', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.feature-3701-1', '2.0.5', '3:7dbee782206c249e6d9efd793924d7e0', 302);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml::tm-1.11.0.issue-3914::mpagnon::(Checksum: 3:7ad84207d3fa8d6dec334c08447aa09f)
-- for some reason in postgresql generated scripts the column "VERSION" is in uppercase instead of lowercase like all other columns
ALTER TABLE test_case RENAME COLUMN "VERSION" TO "version";

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('mpagnon', 'for some reason in postgresql generated scripts the column "VERSION" is in uppercase instead of lowercase like all other columns', NOW(), 'Rename Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.11.0.xml', 'tm-1.11.0.issue-3914', '2.0.5', '3:7ad84207d3fa8d6dec334c08447aa09f', 303);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0::jsimon::(Checksum: 3:73810dd59459401f6b26a4269d32fb6e)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.12.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0', '2.0.5', '3:73810dd59459401f6b26a4269d32fb6e', 304);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3607-1::jsimon::(Checksum: 3:35fcb826269f492dfe47bb51c3a5c5fb)
-- Table for Milestones
CREATE TABLE MILESTONE (MILESTONE_ID bigserial NOT NULL, LABEL VARCHAR(30) NOT NULL, STATUS VARCHAR(30), END_DATE TIMESTAMP WITH TIME ZONE NOT NULL, DESCRIPTION TEXT, M_RANGE VARCHAR(30) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, USER_ID BIGINT NOT NULL, CONSTRAINT PK_MILESTONE PRIMARY KEY (MILESTONE_ID), CONSTRAINT fk_milestone_owner FOREIGN KEY (USER_ID) REFERENCES CORE_USER(PARTY_ID), UNIQUE (LABEL));

COMMENT ON COLUMN MILESTONE.MILESTONE_ID IS 'Primary key';

COMMENT ON COLUMN MILESTONE.LABEL IS 'Milestone label';

COMMENT ON COLUMN MILESTONE.STATUS IS 'Milestone status';

COMMENT ON COLUMN MILESTONE.END_DATE IS 'Term date';

COMMENT ON COLUMN MILESTONE.DESCRIPTION IS 'Milestone description';

COMMENT ON COLUMN MILESTONE.M_RANGE IS 'Milestone range';

COMMENT ON COLUMN MILESTONE.CREATED_BY IS 'Name of the milestone creator';

COMMENT ON COLUMN MILESTONE.CREATED_ON IS 'Date of creation.';

COMMENT ON COLUMN MILESTONE.LAST_MODIFIED_BY IS 'last modified by';

COMMENT ON COLUMN MILESTONE.LAST_MODIFIED_ON IS 'Date of last update';

COMMENT ON COLUMN MILESTONE.USER_ID IS 'the user that own the milestone';

CREATE INDEX idx_milestone ON MILESTONE(MILESTONE_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Table for Milestones', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3607-1', '2.0.5', '3:35fcb826269f492dfe47bb51c3a5c5fb', 305);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3608-1::jsimon::(Checksum: 3:0477d7c91c2d526abf01c921e3eb28a6)
-- Table for MilestoneBinding
CREATE TABLE MILESTONE_BINDING (MILESTONE_BINDING_ID bigserial NOT NULL, MILESTONE_ID BIGINT NOT NULL, PROJECT_ID BIGINT NOT NULL, CONSTRAINT PK_MILESTONE_BINDING PRIMARY KEY (MILESTONE_BINDING_ID), CONSTRAINT FK_MILESTONE_BINDING_MILESTONE FOREIGN KEY (MILESTONE_ID) REFERENCES MILESTONE(MILESTONE_ID), CONSTRAINT FK_MILESTONE_BINDING_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Table for MilestoneBinding', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3608-1', '2.0.5', '3:0477d7c91c2d526abf01c921e3eb28a6', 306);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3609-1::jsimon::(Checksum: 3:c7ead5ace5583a01da639c5bd1de18d0)
-- Table for MilestoneBindingPerimeter
CREATE TABLE MILESTONE_BINDING_PERIMETER (MILESTONE_BINDING_PERIMETER_ID bigserial NOT NULL, MILESTONE_ID BIGINT NOT NULL, PROJECT_ID BIGINT NOT NULL, CONSTRAINT PK_MILESTONE_BINDING_PERIMETER PRIMARY KEY (MILESTONE_BINDING_PERIMETER_ID), CONSTRAINT FK_MILESTONE_BINDING_PERIMETER_PROJECT FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT FK_MILESTONE_BINDING_PERIMETER_MILESTONE FOREIGN KEY (MILESTONE_ID) REFERENCES MILESTONE(MILESTONE_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', 'Table for MilestoneBindingPerimeter', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3609-1', '2.0.5', '3:c7ead5ace5583a01da639c5bd1de18d0', 307);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3823-1::bsiri::(Checksum: 3:d0b201e944377deddef2a49348f8650f)
-- Creating the values table for multi-valued custom fields, much like CUSTOM_FIELD_OPTION is. 
--   	Note : the DELETE CASCADE on the foreign key is necessary because Hibernate won't do it (as specified, see HHH-5529)
CREATE TABLE CUSTOM_FIELD_VALUE_OPTION (CFV_ID BIGINT NOT NULL, LABEL VARCHAR(255) NOT NULL, POSITION INT NOT NULL, CONSTRAINT fk_cfv_option_cfv FOREIGN KEY (CFV_ID) REFERENCES CUSTOM_FIELD_VALUE(CFV_ID) ON DELETE CASCADE);

COMMENT ON TABLE CUSTOM_FIELD_VALUE_OPTION IS 'The table.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creating the values table for multi-valued custom fields, much like CUSTOM_FIELD_OPTION is. 
  	Note : the DELETE CASCADE on the foreign key is necessary because Hibernate won''t do it (as specified, see HHH-5529)', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3823-1', '2.0.5', '3:d0b201e944377deddef2a49348f8650f', 308);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3823-2::bsiri::(Checksum: 3:10e995d6ae6e884de3a56ea3089b9b6b)
-- Same table for the denormalized field values
CREATE TABLE DENORMALIZED_FIELD_VALUE_OPTION (DFV_ID BIGINT NOT NULL, LABEL VARCHAR(255) NOT NULL, POSITION INT NOT NULL, CONSTRAINT fk_dfv_option_dfv FOREIGN KEY (DFV_ID) REFERENCES DENORMALIZED_FIELD_VALUE(DFV_ID) ON DELETE CASCADE);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Same table for the denormalized field values', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3823-2', '2.0.5', '3:10e995d6ae6e884de3a56ea3089b9b6b', 309);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feature-3823-3::bsiri::(Checksum: 3:40b71e496b617a6e1643aea07b03b466)
-- tables CUSTOM_FIELD_OPTION and DENORMALIZED_FIELD_OPTION no longer enforce the option position.
ALTER TABLE CUSTOM_FIELD_OPTION ALTER COLUMN  POSITION DROP NOT NULL;

ALTER TABLE DENORMALIZED_FIELD_OPTION ALTER COLUMN  POSITION DROP NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'tables CUSTOM_FIELD_OPTION and DENORMALIZED_FIELD_OPTION no longer enforce the option position.', NOW(), 'Drop Not-Null Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feature-3823-3', '2.0.5', '3:40b71e496b617a6e1643aea07b03b466', 310);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.issue-4017-1::bsiri::(Checksum: 3:5682a9420e1160eef49f4838d79d4de8)
-- Some columns in REQUIREMENT_PROPERTY_CHANGE are too short compared to what 
--   	they are supposed to store. This changeset makes them bigger.
ALTER TABLE REQUIREMENT_PROPERTY_CHANGE ALTER COLUMN OLD_VALUE TYPE VARCHAR(255);

ALTER TABLE REQUIREMENT_PROPERTY_CHANGE ALTER COLUMN NEW_VALUE TYPE VARCHAR(255);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Some columns in REQUIREMENT_PROPERTY_CHANGE are too short compared to what 
  	they are supposed to store. This changeset makes them bigger.', NOW(), 'Modify data type (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.issue-4017-1', '2.0.5', '3:5682a9420e1160eef49f4838d79d4de8', 311);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-1::bsiri::(Checksum: 3:84795c97ecd084f4710471c4613447f8)
-- creating the table structure for parameterized list
CREATE TABLE INFO_LIST (INFO_LIST_ID bigserial NOT NULL, LABEL VARCHAR(100), DESCRIPTION TEXT, CODE VARCHAR(30) NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_INFO_LIST PRIMARY KEY (INFO_LIST_ID), UNIQUE (LABEL), UNIQUE (CODE));

COMMENT ON COLUMN INFO_LIST.INFO_LIST_ID IS 'the ID';

COMMENT ON COLUMN INFO_LIST.LABEL IS 'the label for this list. Would noly be displayed in the administration page as the name  actually displayed to regular uses would depend on the role of that list on a given projet (criticality, nature etc)';

COMMENT ON COLUMN INFO_LIST.DESCRIPTION IS 'a description for that list';

COMMENT ON COLUMN INFO_LIST.CODE IS 'a code that helps identifying that list';

COMMENT ON COLUMN INFO_LIST.CREATED_BY IS 'username of the user who created that list';

COMMENT ON COLUMN INFO_LIST.CREATED_ON IS 'the time at when that list was created';

COMMENT ON COLUMN INFO_LIST.LAST_MODIFIED_BY IS 'username of the last user who modified one of the list attributes';

COMMENT ON COLUMN INFO_LIST.LAST_MODIFIED_ON IS 'Time when the list was touched last';

CREATE INDEX idx_info_list_code ON INFO_LIST(CODE);

CREATE TABLE INFO_LIST_ITEM (ITEM_ID bigserial NOT NULL, ITEM_TYPE VARCHAR(3) NOT NULL, LIST_ID BIGINT, ITEM_INDEX INT, LABEL VARCHAR(100) NOT NULL, CODE VARCHAR(30) NOT NULL, IS_DEFAULT BOOLEAN DEFAULT FALSE NOT NULL, ICON_NAME VARCHAR(100), CONSTRAINT PK_INFO_LIST_ITEM PRIMARY KEY (ITEM_ID), CONSTRAINT fk_info_item_list FOREIGN KEY (LIST_ID) REFERENCES INFO_LIST(INFO_LIST_ID), UNIQUE (CODE));

COMMENT ON COLUMN INFO_LIST_ITEM.ITEM_ID IS 'an ID, what did you expect ?';

COMMENT ON COLUMN INFO_LIST_ITEM.ITEM_TYPE IS 'discriminator telling whether this item is user-made or builtin in the app. Pick one of ''USR'' or ''SYS''';

COMMENT ON COLUMN INFO_LIST_ITEM.LIST_ID IS 'foreign key to the list this item belongs to. Allows ''NULL'' for Hibernate to work.';

COMMENT ON COLUMN INFO_LIST_ITEM.ITEM_INDEX IS 'the position of that item in the list. Allows ''NULL'' for Hibernate to work.';

COMMENT ON COLUMN INFO_LIST_ITEM.LABEL IS 'a label to be displayed. If the item is builtin this label will be a i18n key, else the label will be displayed verbatim';

COMMENT ON COLUMN INFO_LIST_ITEM.CODE IS 'a code that helps identifying that item';

COMMENT ON COLUMN INFO_LIST_ITEM.IS_DEFAULT IS 'whether this item is the default item for         its list. Only one item per list should have it true';

COMMENT ON COLUMN INFO_LIST_ITEM.ICON_NAME IS 'the identifier of the icon to be displayed';

CREATE INDEX idx_info_list_item_code ON INFO_LIST_ITEM(CODE);

CREATE INDEX idx_info_list_label ON INFO_LIST(LABEL);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'creating the table structure for parameterized list', NOW(), 'Create Table, Create Index, Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-1', '2.0.5', '3:84795c97ecd084f4710471c4613447f8', 312);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-2::bsiri::(Checksum: 3:a99934b9aa55714bcb7411ad75692d15)
-- Updating the definition of an execution
ALTER TABLE EXECUTION ADD TC_NAT_LABEL VARCHAR(100);

ALTER TABLE EXECUTION ADD TC_NAT_CODE VARCHAR(30);

ALTER TABLE EXECUTION ADD TC_NAT_ICON_NAME VARCHAR(100);

ALTER TABLE EXECUTION ADD TC_TYP_LABEL VARCHAR(100);

ALTER TABLE EXECUTION ADD TC_TYP_CODE VARCHAR(30);

ALTER TABLE EXECUTION ADD TC_TYP_ICON_NAME VARCHAR(100);

COMMENT ON COLUMN EXECUTION.TC_NAT_LABEL IS 'a label to be displayed. If the item is builtin this label will be a i18n key, else the label will        be displayed verbatim';

COMMENT ON COLUMN EXECUTION.TC_NAT_CODE IS 'a code that helps identifying that item. Note that unlike the original version the values for       that column will not be unique.';

COMMENT ON COLUMN EXECUTION.TC_NAT_ICON_NAME IS 'the identifier of the icon to be displayed';

COMMENT ON COLUMN EXECUTION.TC_TYP_LABEL IS 'a label to be displayed. If the item is builtin this label will be a i18n key, else the label will  be displayed verbatim';

COMMENT ON COLUMN EXECUTION.TC_TYP_CODE IS 'a code that helps identifying that item. Note that unlike the original version the values for       that column will not be unique.';

COMMENT ON COLUMN EXECUTION.TC_TYP_ICON_NAME IS 'the identifier of the icon to be displayed';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Updating the definition of an execution', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-2', '2.0.5', '3:a99934b9aa55714bcb7411ad75692d15', 313);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-3::bsiri::(Checksum: 3:ff8906f1d84a632e135428a73ad6e8b9)
-- inserting the default lists in the database
INSERT INTO INFO_LIST (CODE, CREATED_BY, CREATED_ON, DESCRIPTION, INFO_LIST_ID, LABEL, LAST_MODIFIED_BY, LAST_MODIFIED_ON) VALUES ('DEF_REQ_CAT', 'system', '2010-01-01 00:00:00', '', '1', 'infolist.category.default', 'system', '2010-01-01 00:00:00');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_FUNCTIONAL', 'def_cat_functional', FALSE, '1', '0', 'SYS', 'requirement.category.CAT_FUNCTIONAL', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_NON_FUNCTIONAL', 'def_cat_non-functional', FALSE, '2', '1', 'SYS', 'requirement.category.CAT_NON_FUNCTIONAL', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_USE_CASE', 'def_cat_use-case', FALSE, '3', '2', 'SYS', 'requirement.category.CAT_USE_CASE', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_BUSINESS', 'def_cat_business', FALSE, '4', '3', 'SYS', 'requirement.category.CAT_BUSINESS', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_TEST_REQUIREMENT', 'def_cat_test-requirement', FALSE, '5', '4', 'SYS', 'requirement.category.CAT_TEST_REQUIREMENT', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_UNDEFINED', 'def_cat_undefined', TRUE, '6', '5', 'SYS', 'requirement.category.CAT_UNDEFINED', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_ERGONOMIC', 'def_cat_ergonomic', FALSE, '7', '6', 'SYS', 'requirement.category.CAT_ERGONOMIC', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_PERFORMANCE', 'def_cat_performance', FALSE, '8', '7', 'SYS', 'requirement.category.CAT_PERFORMANCE', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_TECHNICAL', 'def_cat_technical', FALSE, '9', '8', 'SYS', 'requirement.category.CAT_TECHNICAL', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_USER_STORY', 'def_cat_user-story', FALSE, '10', '9', 'SYS', 'requirement.category.CAT_USER_STORY', '1');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('CAT_SECURITY', 'def_cat_security', FALSE, '11', '10', 'SYS', 'requirement.category.CAT_SECURITY', '1');

INSERT INTO INFO_LIST (CODE, CREATED_BY, CREATED_ON, DESCRIPTION, INFO_LIST_ID, LABEL, LAST_MODIFIED_BY, LAST_MODIFIED_ON) VALUES ('DEF_TC_NAT', 'system', '2010-01-01 00:00:00', '', '2', 'infolist.nature.default', 'system', '2010-01-01 00:00:00');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_UNDEFINED', 'noicon', TRUE, '12', '0', 'SYS', 'test-case.nature.NAT_UNDEFINED', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_FUNCTIONAL_TESTING', 'noicon', FALSE, '13', '1', 'SYS', 'test-case.nature.NAT_FUNCTIONAL_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_BUSINESS_TESTING', 'noicon', FALSE, '14', '2', 'SYS', 'test-case.nature.NAT_BUSINESS_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_USER_TESTING', 'noicon', FALSE, '15', '3', 'SYS', 'test-case.nature.NAT_USER_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_NON_FUNCTIONAL_TESTING', 'noicon', FALSE, '16', '4', 'SYS', 'test-case.nature.NAT_NON_FUNCTIONAL_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_PERFORMANCE_TESTING', 'noicon', FALSE, '17', '5', 'SYS', 'test-case.nature.NAT_PERFORMANCE_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_SECURITY_TESTING', 'noicon', FALSE, '18', '6', 'SYS', 'test-case.nature.NAT_SECURITY_TESTING', '2');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('NAT_ATDD', 'noicon', FALSE, '19', '7', 'SYS', 'test-case.nature.NAT_ATDD', '2');

INSERT INTO INFO_LIST (CODE, CREATED_BY, CREATED_ON, DESCRIPTION, INFO_LIST_ID, LABEL, LAST_MODIFIED_BY, LAST_MODIFIED_ON) VALUES ('DEF_TC_TYP', 'system', '2010-01-01 00:00:00', '', '3', 'infolist.type.default', 'system', '2010-01-01 00:00:00');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_UNDEFINED', 'noicon', TRUE, '20', '0', 'SYS', 'test-case.type.TYP_UNDEFINED', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_COMPLIANCE_TESTING', 'noicon', FALSE, '21', '1', 'SYS', 'test-case.type.TYP_COMPLIANCE_TESTING', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_CORRECTION_TESTING', 'noicon', FALSE, '22', '2', 'SYS', 'test-case.type.TYP_CORRECTION_TESTING', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_EVOLUTION_TESTING', 'noicon', FALSE, '23', '3', 'SYS', 'test-case.type.TYP_EVOLUTION_TESTING', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_REGRESSION_TESTING', 'noicon', FALSE, '24', '4', 'SYS', 'test-case.type.TYP_REGRESSION_TESTING', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_END_TO_END_TESTING', 'noicon', FALSE, '25', '5', 'SYS', 'test-case.type.TYP_END_TO_END_TESTING', '3');

INSERT INTO INFO_LIST_ITEM (CODE, ICON_NAME, IS_DEFAULT, ITEM_ID, ITEM_INDEX, ITEM_TYPE, LABEL, LIST_ID) VALUES ('TYP_PARTNER_TESTING', 'noicon', FALSE, '26', '6', 'SYS', 'test-case.type.TYP_PARTNER_TESTING', '3');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'inserting the default lists in the database', NOW(), 'Insert Row (x29)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-3', '2.0.5', '3:ff8906f1d84a632e135428a73ad6e8b9', 314);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-4::bsiri::(Checksum: 3:7f89020c83570898822dc301bf8c6cfa)
-- other structural modifications
ALTER TABLE PROJECT ADD REQ_CATEGORIES_LIST BIGINT NOT NULL DEFAULT '1';

ALTER TABLE PROJECT ADD CONSTRAINT proj_req_categories FOREIGN KEY (REQ_CATEGORIES_LIST) REFERENCES INFO_LIST (INFO_LIST_ID);

ALTER TABLE PROJECT ADD TC_NATURES_LIST BIGINT NOT NULL DEFAULT '2';

ALTER TABLE PROJECT ADD CONSTRAINT proj_tc_natures FOREIGN KEY (TC_NATURES_LIST) REFERENCES INFO_LIST (INFO_LIST_ID);

ALTER TABLE PROJECT ADD TC_TYPES_LIST BIGINT NOT NULL DEFAULT '3';

ALTER TABLE PROJECT ADD CONSTRAINT proj_tc_types FOREIGN KEY (TC_TYPES_LIST) REFERENCES INFO_LIST (INFO_LIST_ID);

COMMENT ON COLUMN PROJECT.REQ_CATEGORIES_LIST IS 'foreign key to the requirement categories used in that project';

COMMENT ON COLUMN PROJECT.TC_NATURES_LIST IS 'foreign key to the test case natures used in that project';

COMMENT ON COLUMN PROJECT.TC_TYPES_LIST IS 'foreign key to the test case types used in that project';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'other structural modifications', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-4', '2.0.5', '3:7f89020c83570898822dc301bf8c6cfa', 315);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-6::bsiri::(Checksum: 3:00562703c1781e21e3f8410c1f5b5653)
-- migrate the test cases
ALTER TABLE TEST_CASE RENAME COLUMN TC_NATURE TO TC_NATURE_OLD;

ALTER TABLE TEST_CASE ADD TC_NATURE BIGINT NOT NULL DEFAULT '12';

ALTER TABLE TEST_CASE ADD CONSTRAINT fk_tc_nature FOREIGN KEY (TC_NATURE) REFERENCES INFO_LIST_ITEM (ITEM_ID);

COMMENT ON COLUMN TEST_CASE.TC_NATURE IS 'foreign key to the info list item';

update TEST_CASE set TC_NATURE = 12 where TC_NATURE_OLD = 'UNDEFINED';

update TEST_CASE set TC_NATURE = 13 where TC_NATURE_OLD = 'FUNCTIONAL_TESTING';

update TEST_CASE set TC_NATURE = 14 where TC_NATURE_OLD = 'BUSINESS_TESTING';

update TEST_CASE set TC_NATURE = 15 where TC_NATURE_OLD = 'USER_TESTING';

update TEST_CASE set TC_NATURE = 16 where TC_NATURE_OLD = 'NON_FUNCTIONAL_TESTING';

update TEST_CASE set TC_NATURE = 17 where TC_NATURE_OLD = 'PERFORMANCE_TESTING';

update TEST_CASE set TC_NATURE = 18 where TC_NATURE_OLD = 'SECURITY_TESTING';

update TEST_CASE set TC_NATURE = 19 where TC_NATURE_OLD = 'ATDD';

ALTER TABLE TEST_CASE DROP COLUMN TC_NATURE_OLD;

ALTER TABLE TEST_CASE RENAME COLUMN TC_TYPE TO TC_TYPE_OLD;

ALTER TABLE TEST_CASE ADD TC_TYPE BIGINT NOT NULL DEFAULT '20';

ALTER TABLE TEST_CASE ADD CONSTRAINT fk_tc_type FOREIGN KEY (TC_TYPE) REFERENCES INFO_LIST_ITEM (ITEM_ID);

COMMENT ON COLUMN TEST_CASE.TC_TYPE IS 'foreign key to the info list item';

update TEST_CASE set TC_TYPE = 20 where TC_TYPE_OLD = 'UNDEFINED';

update TEST_CASE set TC_TYPE = 21 where TC_TYPE_OLD = 'COMPLIANCE_TESTING';

update TEST_CASE set TC_TYPE = 22 where TC_TYPE_OLD = 'CORRECTION_TESTING';

update TEST_CASE set TC_TYPE = 23 where TC_TYPE_OLD = 'EVOLUTION_TESTING';

update TEST_CASE set TC_TYPE = 24 where TC_TYPE_OLD = 'REGRESSION_TESTING';

update TEST_CASE set TC_TYPE = 25 where TC_TYPE_OLD = 'END_TO_END_TESTING';

update TEST_CASE set TC_TYPE = 26 where TC_TYPE_OLD = 'PARTNER_TESTING';

ALTER TABLE TEST_CASE DROP COLUMN TC_TYPE_OLD;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'migrate the test cases', NOW(), 'Rename Column, Add Column, Custom SQL, Drop Column, Rename Column, Add Column, Custom SQL, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-6', '2.0.5', '3:00562703c1781e21e3f8410c1f5b5653', 316);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-7::bsiri::(Checksum: 3:a7e3bf19f2a9795bd34d208f8a3b5c0e)
-- migrate the requirements
ALTER TABLE REQUIREMENT_VERSION RENAME COLUMN CATEGORY TO CATEGORY_OLD;

ALTER TABLE REQUIREMENT_VERSION ADD CATEGORY BIGINT NOT NULL DEFAULT '1';

ALTER TABLE REQUIREMENT_VERSION ADD CONSTRAINT fk_req_nature FOREIGN KEY (CATEGORY) REFERENCES INFO_LIST_ITEM (ITEM_ID);

COMMENT ON COLUMN REQUIREMENT_VERSION.CATEGORY IS 'foreign key to the info list item';

update REQUIREMENT_VERSION set CATEGORY = 1 where CATEGORY_OLD = 'FUNCTIONAL';

update REQUIREMENT_VERSION set CATEGORY = 2 where CATEGORY_OLD = 'NON_FUNCTIONAL';

update REQUIREMENT_VERSION set CATEGORY = 3 where CATEGORY_OLD = 'USE_CASE';

update REQUIREMENT_VERSION set CATEGORY = 4 where CATEGORY_OLD = 'BUSINESS';

update REQUIREMENT_VERSION set CATEGORY = 5 where CATEGORY_OLD = 'TEST_REQUIREMENT';

update REQUIREMENT_VERSION set CATEGORY = 6 where CATEGORY_OLD = 'UNDEFINED';

update REQUIREMENT_VERSION set CATEGORY = 7 where CATEGORY_OLD = 'ERGONOMIC';

update REQUIREMENT_VERSION set CATEGORY = 8 where CATEGORY_OLD = 'PERFORMANCE';

update REQUIREMENT_VERSION set CATEGORY = 9 where CATEGORY_OLD = 'TECHNICAL';

update REQUIREMENT_VERSION set CATEGORY = 10 where CATEGORY_OLD = 'USER_STORY';

update REQUIREMENT_VERSION set CATEGORY = 11 where CATEGORY_OLD = 'SECURITY';

ALTER TABLE REQUIREMENT_VERSION DROP COLUMN CATEGORY_OLD;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'migrate the requirements', NOW(), 'Rename Column, Add Column, Custom SQL, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-7', '2.0.5', '3:a7e3bf19f2a9795bd34d208f8a3b5c0e', 317);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-8::bsiri::(Checksum: 3:b8affe1b87f9e96de5b10ccde72af5eb)
-- migrating the columns from EXECUTION
update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_UNDEFINED',
      TC_NAT_CODE = 'NAT_UNDEFINED',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='UNDEFINED';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_FUNCTIONAL_TESTING',
      TC_NAT_CODE = 'NAT_FUNCTIONAL_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='FUNCTIONAL_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_BUSINESS_TESTING',
      TC_NAT_CODE = 'NAT_BUSINESS_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='BUSINESS_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_USER_TESTING',
      TC_NAT_CODE = 'NAT_USER_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='USER_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_NON_FUNCTIONAL_TESTING',
      TC_NAT_CODE = 'NAT_NON_FUNCTIONAL_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='NON_FUNCTIONAL_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_PERFORMANCE_TESTING',
      TC_NAT_CODE = 'NAT_PERFORMANCE_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='PERFORMANCE_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_SECURITY_TESTING',
      TC_NAT_CODE = 'NAT_SECURITY_TESTING',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='SECURITY_TESTING';

update EXECUTION
      set TC_NAT_LABEL = 'test-case.nature.NAT_ATDD',
      TC_NAT_CODE = 'NAT_ATDD',
      TC_NAT_ICON_NAME = 'noicon'
      where TC_NATURE='ATDD';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_UNDEFINED',
      TC_TYP_CODE = 'TYP_UNDEFINED',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='UNDEFINED';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_COMPLIANCE_TESTING',
      TC_TYP_CODE = 'TYP_COMPLIANCE_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='COMPLIANCE_TESTING';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_CORRECTION_TESTING',
      TC_TYP_CODE = 'TYP_CORRECTION_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='CORRECTION_TESTING';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_EVOLUTION_TESTING',
      TC_TYP_CODE = 'TYP_EVOLUTION_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='EVOLUTION_TESTING';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_REGRESSION_TESTING',
      TC_TYP_CODE = 'TYP_REGRESSION_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='REGRESSION_TESTING';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_END_TO_END_TESTING',
      TC_TYP_CODE = 'TYP_END_TO_END_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='END_TO_END_TESTING';

update EXECUTION
      set TC_TYP_LABEL = 'test-case.type.TYP_PARTNER_TESTING',
      TC_TYP_CODE = 'TYP_PARTNER_TESTING',
      TC_TYP_ICON_NAME = 'noicon'
      where TC_TYPE='PARTNER_TESTING';

ALTER TABLE EXECUTION DROP COLUMN TC_NATURE;

ALTER TABLE EXECUTION DROP COLUMN TC_TYPE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'migrating the columns from EXECUTION', NOW(), 'Custom SQL, Drop Column (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-8', '2.0.5', '3:b8affe1b87f9e96de5b10ccde72af5eb', 318);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4068-9::bsiri::(Checksum: 3:25497b1b6e1fd30ea715be83c5066f07)
-- update the sequences afterward
SELECT setval('info_list_info_list_id_seq', (SELECT MAX(info_list_id) from info_list));

SELECT setval('info_list_item_item_id_seq', (SELECT MAX(item_id) from info_list_item));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'update the sequences afterward', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4068-9', '2.0.5', '3:25497b1b6e1fd30ea715be83c5066f07', 319);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-3764-1::flaurens::(Checksum: 3:21c3ab2714d4b811be9cc596b5dc110b)
-- Tables for OAuth2 Support
CREATE TABLE oauth_client_details (CLIENT_ID VARCHAR(255) NOT NULL, CLIENT_SECRET VARCHAR(255), RESOURCE_IDS VARCHAR(255) DEFAULT null, SCOPE VARCHAR(255) DEFAULT 'location,locationhistory', AUTHORIZED_GRANT_TYPES VARCHAR(255) DEFAULT 'password,authorization_code,refresh_token,implicit', WEB_SERVER_REDIRECT_URI VARCHAR(255) DEFAULT null, AUTHORITIES VARCHAR(255) DEFAULT 'ROLE_CLIENT, ROLE_TRUSTED_CLIENT', ACCESS_TOKEN_VALIDITY BIGINT DEFAULT 60, REFRESH_TOKEN_VALIDITY BIGINT DEFAULT NULL, ADDITIONAL_INFORMATION TEXT DEFAULT null, AUTOAPPROVE VARCHAR(255), CONSTRAINT PK_OAUTH_CLIENT_DETAILS PRIMARY KEY (CLIENT_ID));

CREATE TABLE oauth_client_token (TOKEN_ID VARCHAR(255) NOT NULL, TOKEN BYTEA, AUTHENTICATION_ID VARCHAR(255), USER_NAME VARCHAR(255), CLIENT_ID VARCHAR(255), CONSTRAINT PK_OAUTH_CLIENT_TOKEN PRIMARY KEY (TOKEN_ID), UNIQUE (AUTHENTICATION_ID));

CREATE TABLE oauth_access_token (TOKEN_ID VARCHAR(255) NOT NULL, TOKEN BYTEA, AUTHENTICATION_ID VARCHAR(255), USER_NAME VARCHAR(255), CLIENT_ID VARCHAR(255), AUTHENTICATION BYTEA, REFRESH_TOKEN VARCHAR(255), CONSTRAINT PK_OAUTH_ACCESS_TOKEN PRIMARY KEY (TOKEN_ID), UNIQUE (AUTHENTICATION_ID));

CREATE TABLE oauth_refresh_token (TOKEN_ID VARCHAR(255) NOT NULL, TOKEN BYTEA, AUTHENTICATION BYTEA, CONSTRAINT PK_OAUTH_REFRESH_TOKEN PRIMARY KEY (TOKEN_ID));

CREATE TABLE oauth_code (CODE VARCHAR(255) NOT NULL, AUTHENTICATION BYTEA, CONSTRAINT PK_OAUTH_CODE PRIMARY KEY (CODE));

CREATE TABLE oauth_approvals (USERID VARCHAR(255) NOT NULL, CLIENTID VARCHAR(255) NOT NULL, SCOPE VARCHAR(255), STATUS VARCHAR(10), EXPIRESAT TIMESTAMP WITH TIME ZONE, LASTMODIFIEDAT TIMESTAMP WITH TIME ZONE);

ALTER TABLE oauth_approvals ADD CONSTRAINT PK_OAUTH_APPROVALS PRIMARY KEY (USERID, CLIENTID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('flaurens', 'Tables for OAuth2 Support', NOW(), 'Create Table (x6), Add Primary Key', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-3764-1', '2.0.5', '3:21c3ab2714d4b811be9cc596b5dc110b', 320);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-4171-1::jsimon::(Checksum: 3:dd54d7c418be3b34e621732aeec03876)
INSERT INTO CORE_CONFIG (STR_KEY, VALUE) VALUES ('uploadfilter.fileExtensions.whitelist', 'txt, doc, xls, ppt, docx, xlsx, pptx, odt, ods, odp, pdf');

INSERT INTO CORE_CONFIG (STR_KEY, VALUE) VALUES ('uploadfilter.upload.sizeLimitInBytes', '4000000');

INSERT INTO CORE_CONFIG (STR_KEY, VALUE) VALUES ('uploadfilter.upload.import.sizeLimitInBytes', '2000000');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Insert Row (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-4171-1', '2.0.5', '3:dd54d7c418be3b34e621732aeec03876', 321);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml::tm-1.12.0.feat-3611-1::bsiri::(Checksum: 3:d1140a9da46292ae1e018a543c387b8d)
-- Creating the tables modeling the relationships between milestones and test cases, requirement versions 
--     		and campaigns
CREATE TABLE MILESTONE_TEST_CASE (MILESTONE_ID BIGINT NOT NULL, TEST_CASE_ID BIGINT NOT NULL, CONSTRAINT milestone_tc_tc FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID), CONSTRAINT milestone_tc_milestone FOREIGN KEY (MILESTONE_ID) REFERENCES MILESTONE(MILESTONE_ID));

COMMENT ON COLUMN MILESTONE_TEST_CASE.MILESTONE_ID IS 'foreign key to table MILESTONE';

COMMENT ON COLUMN MILESTONE_TEST_CASE.TEST_CASE_ID IS 'foreign key to table TEST_CASE';

CREATE TABLE MILESTONE_REQ_VERSION (MILESTONE_ID BIGINT NOT NULL, REQ_VERSION_ID BIGINT NOT NULL, CONSTRAINT milestone_rqv_rqv FOREIGN KEY (REQ_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID), CONSTRAINT milestone_rqv_milestone FOREIGN KEY (MILESTONE_ID) REFERENCES MILESTONE(MILESTONE_ID));

COMMENT ON COLUMN MILESTONE_REQ_VERSION.MILESTONE_ID IS 'foreign key to table MILESTONE';

COMMENT ON COLUMN MILESTONE_REQ_VERSION.REQ_VERSION_ID IS 'foreign key to table REQUIREMENT_VERSION';

CREATE TABLE MILESTONE_CAMPAIGN (MILESTONE_ID BIGINT NOT NULL, CAMPAIGN_ID BIGINT NOT NULL, CONSTRAINT milestone_camp_camp FOREIGN KEY (CAMPAIGN_ID) REFERENCES CAMPAIGN(CLN_ID), CONSTRAINT milestone_camp_milestone FOREIGN KEY (MILESTONE_ID) REFERENCES MILESTONE(MILESTONE_ID));

COMMENT ON COLUMN MILESTONE_CAMPAIGN.MILESTONE_ID IS 'foreign key to table MILESTONE';

COMMENT ON COLUMN MILESTONE_CAMPAIGN.CAMPAIGN_ID IS 'foreign key to table CAMPAIGN';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creating the tables modeling the relationships between milestones and test cases, requirement versions 
    		and campaigns', NOW(), 'Create Table (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.0.xml', 'tm-1.12.0.feat-3611-1', '2.0.5', '3:d1140a9da46292ae1e018a543c387b8d', 322);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml::tm-1.12.3::bsiri::(Checksum: 3:a478ad13ba18ae010a18113c11d60f0e)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.12.3' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml', 'tm-1.12.3', '2.0.5', '3:a478ad13ba18ae010a18113c11d60f0e', 323);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml::tm-1.12.3-issue-5965-1-1-postgresql::bsiri::(Checksum: 3:c4a6d8c8c80fb684550109b72144ac84)
-- Fixing data in TCLN_RELATIONSHIP_CLOSURE that need to be
create table CLOSURECOPY as 
			select distinct * from TCLN_RELATIONSHIP_CLOSURE
			group by ancestor_id, descendant_id, depth
			having count(*) > 1;

delete 
			from TCLN_RELATIONSHIP_CLOSURE clos
			using CLOSURECOPY cop
			where cop.ancestor_id = clos.ancestor_id 
			and cop.descendant_id = clos.descendant_id
			and cop.depth = clos.depth;

insert into TCLN_RELATIONSHIP_CLOSURE
			select * from CLOSURECOPY;

drop table CLOSURECOPY;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Fixing data in TCLN_RELATIONSHIP_CLOSURE that need to be', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml', 'tm-1.12.3-issue-5965-1-1-postgresql', '2.0.5', '3:c4a6d8c8c80fb684550109b72144ac84', 324);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml::tm-1.12.3-issue-5965-1-2-postgresql::bsiri::(Checksum: 3:2c1331057f0eaeed64133776b0b09979)
-- Fixing data in RLN_RELATIONSHIP_CLOSURE that need to be
create table CLOSURECOPY as 
			select distinct * from RLN_RELATIONSHIP_CLOSURE
			group by ancestor_id, descendant_id, depth
			having count(*) > 1;

delete 
			from RLN_RELATIONSHIP_CLOSURE clos
			using CLOSURECOPY cop
			where cop.ancestor_id = clos.ancestor_id 
			and cop.descendant_id = clos.descendant_id
			and cop.depth = clos.depth;

insert into RLN_RELATIONSHIP_CLOSURE
			select * from CLOSURECOPY;

drop table CLOSURECOPY;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Fixing data in RLN_RELATIONSHIP_CLOSURE that need to be', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml', 'tm-1.12.3-issue-5965-1-2-postgresql', '2.0.5', '3:2c1331057f0eaeed64133776b0b09979', 325);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml::tm-1.12.3-issue-5965-1-3-postgresql::bsiri::(Checksum: 3:4823ddde2a7cade4eba0cb55cda305ed)
-- Fixing data in CLN_RELATIONSHIP_CLOSURE that need to be
create table CLOSURECOPY as 
			select distinct * from CLN_RELATIONSHIP_CLOSURE
			group by ancestor_id, descendant_id, depth
			having count(*) > 1;

delete 
			from CLN_RELATIONSHIP_CLOSURE clos
			using CLOSURECOPY cop
			where cop.ancestor_id = clos.ancestor_id 
			and cop.descendant_id = clos.descendant_id
			and cop.depth = clos.depth;

insert into CLN_RELATIONSHIP_CLOSURE
			select * from CLOSURECOPY;

drop table CLOSURECOPY;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Fixing data in CLN_RELATIONSHIP_CLOSURE that need to be', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml', 'tm-1.12.3-issue-5965-1-3-postgresql', '2.0.5', '3:4823ddde2a7cade4eba0cb55cda305ed', 326);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml::tm-1.12.3-issue-5965-2-1::bsiri::(Checksum: 3:1fa085655cb0d45f79180ec2f08f5d7a)
-- now we can add the unique constraints on the closure tables
ALTER TABLE TCLN_RELATIONSHIP_CLOSURE ADD CONSTRAINT uniq_tcln_clos UNIQUE (ancestor_id, descendant_id);

ALTER TABLE RLN_RELATIONSHIP_CLOSURE ADD CONSTRAINT uniq_rln_clos UNIQUE (ancestor_id, descendant_id);

ALTER TABLE CLN_RELATIONSHIP_CLOSURE ADD CONSTRAINT uniq_cln_clos UNIQUE (ancestor_id, descendant_id);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'now we can add the unique constraints on the closure tables', NOW(), 'Add Unique Constraint (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.12.3.xml', 'tm-1.12.3-issue-5965-2-1', '2.0.5', '3:1fa085655cb0d45f79180ec2f08f5d7a', 327);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0::bsiri::(Checksum: 3:11ec9e4fb029238efba239943dd3c527)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.13.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0', '2.0.5', '3:11ec9e4fb029238efba239943dd3c527', 328);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5155-1::jsimon::(Checksum: 3:a56f65a96f482490bde5603a06fc5621)
CREATE TABLE BUGTRACKER_PROJECT (BUGTRACKER_PROJECT_ID bigserial NOT NULL, BUGTRACKER_BINDING_ID BIGINT NOT NULL, BUGTRACKER_PROJECT_NAME VARCHAR(255), BUGTRACKER_PROJECT_ORDER INT NOT NULL, CONSTRAINT PK_BUGTRACKER_PROJECT PRIMARY KEY (BUGTRACKER_PROJECT_ID), CONSTRAINT fk_bugtracker_project_bugtracker_binding FOREIGN KEY (BUGTRACKER_BINDING_ID) REFERENCES BUGTRACKER_BINDING(BUGTRACKER_BINDING_ID));

CREATE INDEX idx_bugtracker_project ON BUGTRACKER_PROJECT(BUGTRACKER_PROJECT_ID);

insert into BUGTRACKER_PROJECT(BUGTRACKER_BINDING_ID,
			BUGTRACKER_PROJECT_NAME, BUGTRACKER_PROJECT_ORDER) select
			BUGTRACKER_BINDING_ID, PROJECT_NAME, 0 from BUGTRACKER_BINDING;

ALTER TABLE BUGTRACKER_BINDING DROP COLUMN PROJECT_NAME;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Create Table, Create Index, Custom SQL, Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5155-1', '2.0.5', '3:a56f65a96f482490bde5603a06fc5621', 329);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5162-1::bsiri::(Checksum: 3:0a9de91bdb533abb9e3e14b6a68dd6e8)
-- Now campaigns and iterations have a reference too
ALTER TABLE CAMPAIGN ADD REFERENCE VARCHAR(50) DEFAULT '';

COMMENT ON COLUMN CAMPAIGN.REFERENCE IS 'a reference lavel for a campaign';

ALTER TABLE ITERATION ADD REFERENCE VARCHAR(50) DEFAULT '';

COMMENT ON COLUMN ITERATION.REFERENCE IS 'a reference lavel for an iteration';

update ITERATION i
			set reference = (select (ci.iteration_order +
			1) from
			CAMPAIGN_ITERATION ci where ci.iteration_id = i.iteration_id
			);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Now campaigns and iterations have a reference too', NOW(), 'Add Column (x2), Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5162-1', '2.0.5', '3:0a9de91bdb533abb9e3e14b6a68dd6e8', 330);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-4022-1::jsimon::(Checksum: 3:2976df3ca9dc93cdfbfcca42bec41c0e)
ALTER TABLE PROJECT ADD ALLOW_TC_MODIF_DURING_EXEC BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-4022-1', '2.0.5', '3:2976df3ca9dc93cdfbfcca42bec41c0e', 331);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5292-issues::bsiri::(Checksum: 3:7cc7f139a4c92ab4725e8daa938c3af6)
-- creating a view that helps querying on all the issues reported in an execution because
-- 			querying EXECUTION and EXECUTION_STEP separately is just a pain in the ass.
CREATE VIEW EXECUTION_ISSUES_CLOSURE AS select exec.execution_id, issue.issue_id
			from EXECUTION exec
			inner join ISSUE issue on exec.issue_list_id = issue.issue_list_id
			UNION
			select eesteps.execution_id, issue.issue_id
			from EXECUTION_EXECUTION_STEPS eesteps
			inner join EXECUTION_STEP estep on eesteps.execution_step_id = estep.execution_step_id
			inner join ISSUE issue on estep.issue_list_id = issue.issue_list_id;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'creating a view that helps querying on all the issues reported in an execution because
			querying EXECUTION and EXECUTION_STEP separately is just a pain in the ass.', NOW(), 'Create View', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5292-issues', '2.0.5', '3:7cc7f139a4c92ab4725e8daa938c3af6', 332);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5375-1::jsimon, bsiri::(Checksum: 3:e5df9278737d833aec4f141a4842f68c)
-- The scope is a particular filter on the data : it restrict the perimeter from which the measured entities can be chosen,
-- 			for example from project X and folder Y
CREATE TABLE CHART_QUERY (CHART_QUERY_ID bigserial NOT NULL, NAME VARCHAR(100), STRATEGY VARCHAR(20), JOIN_STYLE VARCHAR(10), CONSTRAINT PK_CHART_QUERY PRIMARY KEY (CHART_QUERY_ID));

COMMENT ON COLUMN CHART_QUERY.CHART_QUERY_ID IS 'autogenerated ID';

COMMENT ON COLUMN CHART_QUERY.NAME IS 'internal usage, when this CHART_QUERY is a    CHART_COLUMN_PROTOTYPE subquery the name helps identify which one';

COMMENT ON COLUMN CHART_QUERY.STRATEGY IS 'says how the query builder should integrate this query    to a main query. Accepts values : MAIN, SUBQUERY or INLINED';

COMMENT ON COLUMN CHART_QUERY.JOIN_STYLE IS 'generally indicate whether should use inner join or left join when a    natural join is possible. Possible values : INNER_JOIN or LEFT_JOIN';

CREATE TABLE CHART_DEFINITION (CHART_ID bigserial NOT NULL, USER_ID BIGINT NOT NULL, QUERY_ID BIGINT NOT NULL, NAME VARCHAR(50), VISIBILITY VARCHAR(20), CHART_TYPE VARCHAR(20), DESCRIPTION TEXT, PROJECT_ID BIGINT NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_CHART_DEFINITION PRIMARY KEY (CHART_ID), CONSTRAINT fk_chart_query FOREIGN KEY (QUERY_ID) REFERENCES CHART_QUERY(CHART_QUERY_ID), CONSTRAINT fk_project_chart_definition_project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_chart_owner FOREIGN KEY (USER_ID) REFERENCES CORE_USER(PARTY_ID));

COMMENT ON COLUMN CHART_DEFINITION.CHART_ID IS 'autogenerated ID';

COMMENT ON COLUMN CHART_DEFINITION.USER_ID IS 'foreign key to the owner of this chart definition';

COMMENT ON COLUMN CHART_DEFINITION.QUERY_ID IS 'foreign key to a CHART_QUERY';

COMMENT ON COLUMN CHART_DEFINITION.NAME IS 'The name of this chart';

COMMENT ON COLUMN CHART_DEFINITION.VISIBILITY IS 'whether this chart is ''PRIVATE'' or ''PUBLIC''';

COMMENT ON COLUMN CHART_DEFINITION.CHART_TYPE IS 'whether this chart is a ''PIE'', ''BAR'' etc';

COMMENT ON COLUMN CHART_DEFINITION.DESCRIPTION IS 'additional informations about this chart';

COMMENT ON COLUMN CHART_DEFINITION.PROJECT_ID IS 'cle etrangere vers le projet.';

CREATE INDEX idx_chart_definition ON CHART_DEFINITION(CHART_ID);

CREATE TABLE CHART_COLUMN_PROTOTYPE (CHART_COLUMN_ID bigserial NOT NULL, COLUMN_TYPE VARCHAR(15), SUBQUERY_ID BIGINT, LABEL VARCHAR(255), ENTITY_TYPE VARCHAR(30), ENTITY_ROLE VARCHAR(40), ATTRIBUTE_NAME VARCHAR(255), DATA_TYPE VARCHAR(50), BUSINESS BOOLEAN DEFAULT TRUE, ATTRIBUTE_TYPE VARCHAR(15), CONSTRAINT PK_CHART_COLUMN_PROTOTYPE PRIMARY KEY (CHART_COLUMN_ID), CONSTRAINT fk_column_query FOREIGN KEY (SUBQUERY_ID) REFERENCES CHART_QUERY(CHART_QUERY_ID));

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.CHART_COLUMN_ID IS 'the column ID';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.COLUMN_TYPE IS 'complementary information about the nature of this column : native attribute (''ATTRIBUTE''),     computed field (''CALCULATED'') - often as a subquery -, or custom field (''CUF'')';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.SUBQUERY_ID IS 'optional foreign key to a (sub) CHART_QUERY';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.LABEL IS 'The default label for this column.';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.ENTITY_TYPE IS 'The kind of entities this column belongs to';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.ENTITY_ROLE IS 'a complementary qualifier for ENTITY_TYPE,           used when an entity has an auxialiary role regarding another entity.           For instance an InfoListItem may have a role of nature for a TestCase,           or category for a RequirementVersion. May be null if nothing special about it.';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.ATTRIBUTE_NAME IS 'The name of the attribute of the entity';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.DATA_TYPE IS 'Data type of the attribute';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.BUSINESS IS 'tells whether this column is public or internal.';

COMMENT ON COLUMN CHART_COLUMN_PROTOTYPE.ATTRIBUTE_TYPE IS 'complementary information about the nature of this column : native attribute (''ATTRIBUTE''),     computed field (''CALCULATED'') - often as a subquery -, or custom field (''CUF'')';

CREATE INDEX idx_column_prototype ON CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID);

CREATE TABLE CHART_COLUMN_ROLE (CHART_COLUMN_ID BIGINT NOT NULL, ROLE VARCHAR(255), CONSTRAINT fk_column_role_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID));

COMMENT ON COLUMN CHART_COLUMN_ROLE.CHART_COLUMN_ID IS 'foreign key to CHART_COLUMN_PROTOTYPE';

COMMENT ON COLUMN CHART_COLUMN_ROLE.ROLE IS 'name of a role for the referenced column';

CREATE TABLE CHART_MEASURE_COLUMN (CHART_COLUMN_ID BIGINT NOT NULL, QUERY_ID BIGINT NOT NULL, LABEL VARCHAR(30), MEASURE_OPERATION VARCHAR(20), MEASURE_RANK INT, CONSTRAINT fk_chart_measure_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID), CONSTRAINT fk_chart_measure_chart_query FOREIGN KEY (QUERY_ID) REFERENCES CHART_QUERY(CHART_QUERY_ID));

COMMENT ON COLUMN CHART_MEASURE_COLUMN.CHART_COLUMN_ID IS 'foreign key to the CHART_COLUMN_PROTOTYPE this measure applies to';

COMMENT ON COLUMN CHART_MEASURE_COLUMN.QUERY_ID IS 'foreign key to a CHART_QUERY';

COMMENT ON COLUMN CHART_MEASURE_COLUMN.LABEL IS 'a label for this measure. Will override the default label of the column prototype if non null.';

COMMENT ON COLUMN CHART_MEASURE_COLUMN.MEASURE_OPERATION IS 'the measure applied to the column';

COMMENT ON COLUMN CHART_MEASURE_COLUMN.MEASURE_RANK IS 'the order in which the measure will be displayed when the chart is rendered.';

CREATE TABLE CHART_FILTER (FILTER_ID bigserial NOT NULL, CHART_COLUMN_ID BIGINT NOT NULL, QUERY_ID BIGINT NOT NULL, FILTER_OPERATION VARCHAR(20), CONSTRAINT PK_CHART_FILTER PRIMARY KEY (FILTER_ID), CONSTRAINT "fk_chart_FILTER_chart_query" FOREIGN KEY (QUERY_ID) REFERENCES CHART_QUERY(CHART_QUERY_ID), CONSTRAINT fk_chart_filter_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID));

COMMENT ON COLUMN CHART_FILTER.FILTER_ID IS 'autogenerated ID';

COMMENT ON COLUMN CHART_FILTER.CHART_COLUMN_ID IS 'foreign key to a CHART_COLUMN_PROTOTYPE';

COMMENT ON COLUMN CHART_FILTER.QUERY_ID IS 'foreign key to a CHART_QUERY';

COMMENT ON COLUMN CHART_FILTER.FILTER_OPERATION IS 'a comparison operator';

CREATE INDEX idx_chart_filter ON CHART_FILTER(FILTER_ID);

CREATE TABLE CHART_FILTER_VALUES (FILTER_ID BIGINT NOT NULL, FILTER_VALUE VARCHAR(255), CONSTRAINT fk_chart_filter_value_chart_column FOREIGN KEY (FILTER_ID) REFERENCES CHART_FILTER(FILTER_ID));

COMMENT ON COLUMN CHART_FILTER_VALUES.FILTER_ID IS 'foreign key to CHART_FILTER';

COMMENT ON COLUMN CHART_FILTER_VALUES.FILTER_VALUE IS 'a value for this filter';

CREATE TABLE CHART_AXIS_COLUMN (CHART_COLUMN_ID BIGINT NOT NULL, QUERY_ID BIGINT NOT NULL, LABEL VARCHAR(100), AXIS_OPERATION VARCHAR(20), AXIS_RANK INT, CONSTRAINT fk_axis_column_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID), CONSTRAINT fk_chart_axis_chart_query FOREIGN KEY (QUERY_ID) REFERENCES CHART_QUERY(CHART_QUERY_ID));

COMMENT ON COLUMN CHART_AXIS_COLUMN.CHART_COLUMN_ID IS 'foreign key to CHART_COLUMN_PROTOTYPE';

COMMENT ON COLUMN CHART_AXIS_COLUMN.QUERY_ID IS 'foreign key to a CHART_QUERY';

COMMENT ON COLUMN CHART_AXIS_COLUMN.LABEL IS 'a label for this axis. If non null, will override the default label in the CHART_COLUMN_PROTOTYPE';

COMMENT ON COLUMN CHART_AXIS_COLUMN.AXIS_OPERATION IS 'may define an additional operation about how data are grouped on this axis, most of the time ''NONE'' is fine, however     for Timestamp columns an adequate aggregation (day, month etc) may be useful';

COMMENT ON COLUMN CHART_AXIS_COLUMN.AXIS_RANK IS 'in which order the axis are processed (if relevant)';

CREATE TABLE CHART_SCOPE (CHART_ID BIGINT NOT NULL, ENTITY_REFERENCE_TYPE VARCHAR(50), ENTITY_REFERENCE_ID INT, CONSTRAINT fk_chart_scope_chart_definition FOREIGN KEY (CHART_ID) REFERENCES CHART_DEFINITION(CHART_ID));

COMMENT ON COLUMN CHART_SCOPE.CHART_ID IS 'foreign key to a CHART_DEFINITION';

COMMENT ON COLUMN CHART_SCOPE.ENTITY_REFERENCE_TYPE IS 'the type of the referenced entity';

COMMENT ON COLUMN CHART_SCOPE.ENTITY_REFERENCE_ID IS 'the id of the referenced entity';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon, bsiri', 'The scope is a particular filter on the data : it restrict the perimeter from which the measured entities can be chosen,
			for example from project X and folder Y', NOW(), 'Create Table (x2), Create Index, Create Table, Create Index, Create Table (x3), Create Index, Create Table (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5375-1', '2.0.5', '3:e5df9278737d833aec4f141a4842f68c', 333);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5375-2::bsiri::(Checksum: 3:440e9bd08f41c2961d3f5451c56f5dbe)
-- populate the column prototype referential data (generated from src/main/script/MakeChartColumns.groovy)
-- --------------------------------------------
		-- Chart Column Prototype Definition --
		--
		-- generated by src/main/script/MakeChartColumns.groovy
		-- --------------------------------------------
		
		-- -------------------------------------------
		-- section 1 :  basic attribute columns
		-- -------------------------------------------
		
		
		-- columns for entity : REQUIREMENT --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(1, 'ATTRIBUTE', TRUE, 'REQUIREMENT_ID', 'REQUIREMENT', null, 'NUMERIC', 'id', null),
			(3, 'ATTRIBUTE', FALSE, 'REQUIREMENT_PROJECT', 'REQUIREMENT', null, 'NUMERIC', 'project.id', null),
			(4, 'ATTRIBUTE', TRUE, 'REQUIREMENT_CRITICALITY', 'REQUIREMENT', null, 'LEVEL_ENUM', 'resource.criticality', null),
			(5, 'ATTRIBUTE', TRUE, 'REQUIREMENT_STATUS', 'REQUIREMENT', null, 'LEVEL_ENUM', 'resource.status', null),
			(6, 'ATTRIBUTE', TRUE, 'REQUIREMENT_CATEGORY', 'REQUIREMENT', null, 'INFO_LIST_ITEM', 'resource.category.code', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (1, 'MEASURE'), (1, 'AXIS'), (1, 'FILTER'),
			 (4, 'MEASURE'), (4, 'AXIS'), (4, 'FILTER'),
			 (5, 'MEASURE'), (5, 'AXIS'), (5, 'FILTER'),
			 (6, 'MEASURE'), (6, 'AXIS'), (6, 'FILTER');

-- columns for entity : REQUIREMENT_VERSION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(7, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_ID', 'REQUIREMENT_VERSION', null, 'NUMERIC', 'id', null),
			(8, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_REFERENCE', 'REQUIREMENT_VERSION', null, 'STRING', 'reference', null),
			(9, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_CATEGORY', 'REQUIREMENT_VERSION', null, 'INFO_LIST_ITEM', 'category.code', null),
			(10, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_CRITICALITY', 'REQUIREMENT_VERSION', null, 'LEVEL_ENUM', 'criticality', null),
			(11, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_STATUS', 'REQUIREMENT_VERSION', null, 'LEVEL_ENUM', 'status', null),
			(12, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_CREATED_BY', 'REQUIREMENT_VERSION', null, 'STRING', 'audit.createdBy', null),
			(13, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_CREATED_ON', 'REQUIREMENT_VERSION', null, 'DATE', 'audit.createdOn', null),
			(14, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_MODIFIED_BY', 'REQUIREMENT_VERSION', null, 'STRING', 'audit.lastModifiedBy', null),
			(15, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_MODIFIED_ON', 'REQUIREMENT_VERSION', null, 'DATE', 'audit.lastModifiedOn', null),
			(16, 'ATTRIBUTE', TRUE, 'REQUIREMENT_VERSION_VERS_NUM', 'REQUIREMENT_VERSION', null, 'NUMERIC', 'versionNumber', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (7, 'MEASURE'), (7, 'AXIS'), (7, 'FILTER'),
			 (8, 'FILTER'), (8, 'AXIS'),
			 (9, 'MEASURE'), (9, 'AXIS'), (9, 'FILTER'),
			 (10, 'MEASURE'), (10, 'AXIS'), (10, 'FILTER'),
			 (11, 'MEASURE'), (11, 'AXIS'), (11, 'FILTER'),
			 (12, 'AXIS'), (12, 'FILTER'),
			 (13, 'AXIS'), (13, 'FILTER'),
			 (14, 'AXIS'), (14, 'FILTER'),
			 (15, 'AXIS'), (15, 'FILTER'),
			 (16, 'FILTER'), (16, 'MEASURE');

-- columns for entity : TEST_CASE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(19, 'ATTRIBUTE', TRUE, 'TEST_CASE_ID', 'TEST_CASE', null, 'NUMERIC', 'id', null),
			(20, 'ATTRIBUTE', TRUE, 'TEST_CASE_REFERENCE', 'TEST_CASE', null, 'STRING', 'reference', null),
			(21, 'ATTRIBUTE', TRUE, 'TEST_CASE_IMPORTANCE', 'TEST_CASE', null, 'LEVEL_ENUM', 'importance', null),
			(22, 'ATTRIBUTE', TRUE, 'TEST_CASE_NATURE', 'TEST_CASE', null, 'INFO_LIST_ITEM', 'nature.code', null),
			(23, 'ATTRIBUTE', TRUE, 'TEST_CASE_TYPE', 'TEST_CASE', null, 'INFO_LIST_ITEM', 'type.code', null),
			(24, 'ATTRIBUTE', TRUE, 'TEST_CASE_STATUS', 'TEST_CASE', null, 'LEVEL_ENUM', 'status', null),
			(25, 'ATTRIBUTE', TRUE, 'TEST_CASE_CREATED_BY', 'TEST_CASE', null, 'STRING', 'audit.createdBy', null),
			(26, 'ATTRIBUTE', TRUE, 'TEST_CASE_CREATED_ON', 'TEST_CASE', null, 'DATE', 'audit.createdOn', null),
			(27, 'ATTRIBUTE', TRUE, 'TEST_CASE_MODIFIED_BY', 'TEST_CASE', null, 'STRING', 'audit.lastModifiedBy', null),
			(28, 'ATTRIBUTE', TRUE, 'TEST_CASE_MODIFIED_ON', 'TEST_CASE', null, 'DATE', 'audit.lastModifiedOn', null),
			(29, 'ATTRIBUTE', FALSE, 'TEST_CASE_PROJECT', 'TEST_CASE', null, 'NUMERIC', 'project.id', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (19, 'MEASURE'), (19, 'AXIS'), (19, 'FILTER'),
			 (20, 'FILTER'), (20, 'AXIS'),
			 (21, 'MEASURE'), (21, 'AXIS'), (21, 'FILTER'),
			 (22, 'MEASURE'), (22, 'AXIS'), (22, 'FILTER'),
			 (23, 'MEASURE'), (23, 'AXIS'), (23, 'FILTER'),
			 (24, 'MEASURE'), (24, 'AXIS'), (24, 'FILTER'),
			 (25, 'AXIS'), (25, 'FILTER'),
			 (26, 'AXIS'), (26, 'FILTER'),
			 (27, 'AXIS'), (27, 'FILTER'),
			 (28, 'AXIS'), (28, 'FILTER');

-- columns for entity : CAMPAIGN --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(37, 'ATTRIBUTE', TRUE, 'CAMPAIGN_ID', 'CAMPAIGN', null, 'NUMERIC', 'id', null),
			(38, 'ATTRIBUTE', FALSE, 'CAMPAIGN_PROJECT', 'CAMPAIGN', null, 'NUMERIC', 'project.id', null),
			(39, 'ATTRIBUTE', TRUE, 'CAMPAIGN_REFERENCE', 'CAMPAIGN', null, 'STRING', 'reference', null),
			(40, 'ATTRIBUTE', TRUE, 'CAMPAIGN_SCHED_START', 'CAMPAIGN', null, 'DATE', 'scheduledPeriod.scheduledStartDate', null),
			(41, 'ATTRIBUTE', TRUE, 'CAMPAIGN_SCHED_END', 'CAMPAIGN', null, 'DATE', 'scheduledPeriod.scheduledEndDate', null),
			(42, 'ATTRIBUTE', TRUE, 'CAMPAIGN_ACTUAL_START', 'CAMPAIGN', null, 'DATE', 'actualPeriod.actualStartDate', null),
			(43, 'ATTRIBUTE', TRUE, 'CAMPAIGN_ACTUAL_END', 'CAMPAIGN', null, 'DATE', 'actualPeriod.actualEndDate', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (37, 'MEASURE'), (37, 'AXIS'), (37, 'FILTER'),
			 (39, 'FILTER'), (39, 'MEASURE'),
			 (40, 'AXIS'), (40, 'FILTER'),
			 (41, 'AXIS'), (41, 'FILTER'),
			 (42, 'AXIS'), (42, 'FILTER'),
			 (43, 'AXIS'), (43, 'FILTER');

-- columns for entity : ITERATION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(46, 'ATTRIBUTE', TRUE, 'ITERATION_ID', 'ITERATION', null, 'NUMERIC', 'id', null),
			(47, 'ATTRIBUTE', TRUE, 'ITERATION_REFERENCE', 'ITERATION', null, 'STRING', 'reference', null),
			(48, 'ATTRIBUTE', TRUE, 'ITERATION_SCHED_START', 'ITERATION', null, 'DATE', 'scheduledPeriod.scheduledStartDate', null),
			(49, 'ATTRIBUTE', TRUE, 'ITERATION_SCHED_END', 'ITERATION', null, 'DATE', 'scheduledPeriod.scheduledEndDate', null),
			(50, 'ATTRIBUTE', TRUE, 'ITERATION_ACTUAL_START', 'ITERATION', null, 'DATE', 'actualPeriod.actualStartDate', null),
			(51, 'ATTRIBUTE', TRUE, 'ITERATION_ACTUAL_END', 'ITERATION', null, 'DATE', 'actualPeriod.actualEndDate', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (46, 'MEASURE'), (46, 'AXIS'), (46, 'FILTER'),
			 (47, 'FILTER'), (47, 'MEASURE'),
			 (48, 'AXIS'), (48, 'FILTER'),
			 (49, 'AXIS'), (49, 'FILTER'),
			 (50, 'AXIS'), (50, 'FILTER'),
			 (51, 'AXIS'), (51, 'FILTER');

-- columns for entity : ITEM_TEST_PLAN --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(54, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_ID', 'ITEM_TEST_PLAN', null, 'NUMERIC', 'id', null),
			(55, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_LABEL', 'ITEM_TEST_PLAN', null, 'STRING', 'label', null),
			(56, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_STATUS', 'ITEM_TEST_PLAN', null, 'EXECUTION_STATUS', 'executionStatus', null),
			(57, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_LASTEXECON', 'ITEM_TEST_PLAN', null, 'DATE', 'lastExecutedOn', null),
			(58, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_DATASET_LABEL', 'ITEM_TEST_PLAN', null, 'STRING', 'referencedDataset.name', null),
			(59, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_TESTER', 'ITEM_TEST_PLAN', null, 'STRING', 'user.login', null),
			(60, 'ATTRIBUTE', TRUE, 'ITEM_TEST_PLAN_TC_ID', 'ITEM_TEST_PLAN', null, 'NUMERIC', 'referencedTestCase.id', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (54, 'MEASURE'), (54, 'AXIS'), (54, 'FILTER'),
			 (55, 'MEASURE'), (55, 'AXIS'), (55, 'FILTER'),
			 (56, 'MEASURE'), (56, 'AXIS'), (56, 'FILTER'),
			 (57, 'MEASURE'), (57, 'AXIS'), (57, 'FILTER'),
			 (58, 'MEASURE'), (58, 'AXIS'), (58, 'FILTER'),
			 (59, 'MEASURE'), (59, 'AXIS'), (59, 'FILTER'),
			 (60, 'MEASURE'), (60, 'AXIS'), (60, 'FILTER');

-- columns for entity : EXECUTION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(66, 'ATTRIBUTE', TRUE, 'EXECUTION_ID', 'EXECUTION', null, 'NUMERIC', 'id', null),
			(67, 'ATTRIBUTE', TRUE, 'EXECUTION_LABEL', 'EXECUTION', null, 'STRING', 'name', null),
			(68, 'ATTRIBUTE', TRUE, 'EXECUTION_DS_LABEL', 'EXECUTION', null, 'STRING', 'datasetLabel', null),
			(69, 'ATTRIBUTE', TRUE, 'EXECUTION_LASTEXEC', 'EXECUTION', null, 'DATE', 'lastExecutedOn', null),
			(70, 'ATTRIBUTE', TRUE, 'EXECUTION_TESTER_LOGIN', 'EXECUTION', null, 'STRING', 'lastExecutedBy', null),
			(71, 'ATTRIBUTE', TRUE, 'EXECUTION_STATUS', 'EXECUTION', null, 'EXECUTION_STATUS', 'executionStatus', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (66, 'MEASURE'), (66, 'AXIS'), (66, 'FILTER'),
			 (67, 'AXIS'), (67, 'FILTER'),
			 (68, 'AXIS'), (68, 'FILTER'),
			 (69, 'AXIS'), (69, 'FILTER'),
			 (70, 'AXIS'), (70, 'FILTER'),
			 (71, 'MEASURE'), (71, 'AXIS'), (71, 'FILTER');

-- columns for entity : ISSUE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(74, 'ATTRIBUTE', FALSE, 'ISSUE_ID', 'ISSUE', null, 'NUMERIC', 'id', null),
			(75, 'ATTRIBUTE', FALSE, 'ISSUE_REMOTE_ID', 'ISSUE', null, 'STRING', 'remoteIssueId', null),
			(76, 'ATTRIBUTE', FALSE, 'ISSUE_STATUS', 'ISSUE', null, 'STRING', 'status', null),
			(77, 'ATTRIBUTE', FALSE, 'ISSUE_SEVERITY', 'ISSUE', null, 'STRING', 'severity', null),
			(78, 'ATTRIBUTE', FALSE, 'ISSUE_BUGTRACKER', 'ISSUE', null, 'STRING', 'bugtracker', null);

-- columns for entity : TEST_CASE_STEP --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(79, 'ATTRIBUTE', FALSE, 'TEST_CASE_STEP_ID', 'TEST_CASE_STEP', null, 'NUMERIC', 'id', null),
			(80, 'ATTRIBUTE', FALSE, 'TEST_CASE_STEP_CLASS', 'TEST_CASE_STEP', null, 'NUMERIC', 'class', null);

-- columns for entity : TEST_CASE_NATURE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(81, 'ATTRIBUTE', FALSE, 'TEST_CASE_NATURE_ID', 'INFO_LIST_ITEM', 'TEST_CASE_NATURE', 'NUMERIC', 'id', null),
			(82, 'ATTRIBUTE', FALSE, 'TEST_CASE_NATURE_LABEL', 'INFO_LIST_ITEM', 'TEST_CASE_NATURE', 'STRING', 'label', null);

-- columns for entity : TEST_CASE_TYPE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(83, 'ATTRIBUTE', FALSE, 'TEST_CASE_TYPE_ID', 'INFO_LIST_ITEM', 'TEST_CASE_TYPE', 'NUMERIC', 'id', null),
			(84, 'ATTRIBUTE', FALSE, 'TEST_CASE_TYPE_LABEL', 'INFO_LIST_ITEM', 'TEST_CASE_TYPE', 'STRING', 'label', null);

-- columns for entity : REQUIREMENT_VERSION_CATEGORY --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(85, 'ATTRIBUTE', FALSE, 'REQUIREMENT_VERSION_CATEGORY_ID', 'INFO_LIST_ITEM', 'REQUIREMENT_VERSION_CATEGORY', 'NUMERIC', 'id', null),
			(86, 'ATTRIBUTE', FALSE, 'REQUIREMENT_VERSION_CATEGORY_LABEL', 'INFO_LIST_ITEM', 'REQUIREMENT_VERSION_CATEGORY', 'STRING', 'label', null);

-- columns for entity : TEST_CASE_MILESTONE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(87, 'ATTRIBUTE', FALSE, 'TEST_CASE_MILESTONE_ID', 'MILESTONE', 'TEST_CASE_MILESTONE', 'NUMERIC', 'id', null),
			(88, 'ATTRIBUTE', FALSE, 'TEST_CASE_MILESTONE_LABEL', 'MILESTONE', 'TEST_CASE_MILESTONE', 'STRING', 'label', null);

-- columns for entity : REQUIREMENT_VERSION_MILESTONE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(89, 'ATTRIBUTE', FALSE, 'REQUIREMENT_VERSION_MILESTONE_ID', 'MILESTONE', 'REQUIREMENT_VERSION_MILESTONE', 'NUMERIC', 'id', null),
			(90, 'ATTRIBUTE', FALSE, 'REQUIREMENT_VERSION_MILESTONE_LABEL', 'MILESTONE', 'REQUIREMENT_VERSION_MILESTONE', 'STRING', 'label', null);

-- columns for entity : ITERATION_TEST_PLAN_ASSIGNED_USER --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(91, 'ATTRIBUTE', FALSE, 'ITERATION_TEST_PLAN_ASSIGNED_USER_ID', 'USER', 'ITERATION_TEST_PLAN_ASSIGNED_USER', 'NUMERIC', 'id', null),
			(92, 'ATTRIBUTE', FALSE, 'ITERATION_TEST_PLAN_ASSIGNED_USER_LOGIN', 'USER', 'ITERATION_TEST_PLAN_ASSIGNED_USER', 'STRING', 'login', null);

-- columns for entity : AUTOMATED_TEST --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(93, 'ATTRIBUTE', FALSE, 'AUTOMATED_TEST_ID', 'AUTOMATED_TEST', null, 'NUMERIC', 'id', null);

-- columns for entity : AUTOMATED_EXECUTION_EXTENDER --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(94, 'ATTRIBUTE', FALSE, 'AUTOMATED_EXECUTION_EXTENDER_ID', 'AUTOMATED_EXECUTION_EXTENDER', null, 'NUMERIC', 'id', null);

-- -------------------------------------------
		-- section 2 :  subqueries
		-- -------------------------------------------
		
		-- subqueries for entity REQUIREMENT --
		
		-- subquery reqVCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (1, 'REQUIREMENT_NB_VERSIONS_SUBQUERY', 'SUBQUERY', 'INNER_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (7, 1, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (1, 1, 'NONE', 0);

-- subqueries for entity REQUIREMENT_VERSION --
		
		-- subquery rvVerifTCCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (2, 'REQUIREMENT_VERSION_TCCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (19, 2, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (7, 2, 'NONE', 0);

-- subquery rvMilesCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (3, 'REQUIREMENT_VERSION_MILCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (89, 3, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (7, 3, 'NONE', 0);

-- subqueries for entity TEST_CASE --
		
		-- subquery tcVerifVersionCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (4, 'TEST_CASE_VERSCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (7, 4, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 4, 'NONE', 0);

-- subquery tcCallStepsCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (5, 'TEST_CASE_CALLSTEPCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (79, 5, 'COUNT', 0);

insert into CHART_FILTER(FILTER_ID, CHART_COLUMN_ID, QUERY_ID, FILTER_OPERATION) values (1, 80, 5, 'EQUALS');

insert into CHART_FILTER_VALUES(FILTER_ID, FILTER_VALUE)
		values 
			(1,'2');

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 5, 'NONE', 0);

-- subquery tcStepsCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (6, 'TEST_CASE_STEPCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (79, 6, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 6, 'NONE', 0);

-- subquery tcMilesCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (7, 'TEST_CASE_VERSION_MILCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (87, 7, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 7, 'NONE', 0);

-- subquery tcIterCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (8, 'TEST_CASE_ITERCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (46, 8, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 8, 'NONE', 0);

-- subquery tcExeCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (9, 'TEST_CASE_EXECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (66, 9, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 9, 'NONE', 0);

-- subquery tcHasAutoSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (10, 'TEST_CASE_HASAUTOSCRIPT_SUBQUERY', 'INLINED', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (93, 10, 'NOT_NULL', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (19, 10, 'NONE', 0);

-- subqueries for entity CAMPAIGN --
		
		-- subquery cIterCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (11, 'CAMPAIGN_ITERCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (46, 11, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (37, 11, 'NONE', 0);

-- subquery cIssueCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (12, 'CAMPAIGN_ISSUECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (75, 12, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (37, 12, 'NONE', 0);

-- subqueries for entity ITERATION --
		
		-- subquery itItemCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (13, 'ITERATION_ITEMCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (54, 13, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (46, 13, 'NONE', 0);

-- subquery itIssueCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (14, 'ITERATION_ISSUECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (75, 14, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (46, 14, 'NONE', 0);

-- subqueries for entity ITEM_TEST_PLAN --
		
		-- subquery itpTcDeletedSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (15, 'ITEM_TEST_PLAN_TCDELETED_SUBQUERY', 'INLINED', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (19, 15, 'IS_NULL', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (54, 15, 'NONE', 0);

-- subquery itpIsExecutedSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (16, 'ITEM_TEST_PLAN_ISEXECUTED_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (66, 16, 'NOT_NULL', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (54, 16, 'NONE', 0);

-- subquery itpManExCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (17, 'ITEM_TEST_PLAN_MANEXCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (66, 17, 'COUNT', 0);

insert into CHART_FILTER(FILTER_ID, CHART_COLUMN_ID, QUERY_ID, FILTER_OPERATION) values (2, 94, 17, 'NOT_NULL');

insert into CHART_FILTER_VALUES(FILTER_ID, FILTER_VALUE)
		values 
			(2,'FALSE');

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (54, 17, 'NONE', 0);

-- subquery itpAutoExCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (18, 'ITEM_TEST_PLAN_AUTOEXCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (66, 18, 'COUNT', 0);

insert into CHART_FILTER(FILTER_ID, CHART_COLUMN_ID, QUERY_ID, FILTER_OPERATION) values (3, 94, 18, 'NOT_NULL');

insert into CHART_FILTER_VALUES(FILTER_ID, FILTER_VALUE)
		values 
			(3,'TRUE');

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (54, 18, 'NONE', 0);

-- subquery itpIssueCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (19, 'ITEM_TEST_PLAN_ISSUECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (75, 19, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (54, 19, 'NONE', 0);

-- subqueries for entity EXECUTION --
		
		-- subquery exIsAutoSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (20, 'EXECUTION_ISAUTO_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (94, 20, 'NOT_NULL', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (66, 20, 'NONE', 0);

-- subquery exIssueCountSub --
		
		insert into CHART_QUERY(CHART_QUERY_ID, NAME, STRATEGY, JOIN_STYLE) values (21, 'EXECUTION_ISSUECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

insert into CHART_MEASURE_COLUMN(CHART_COLUMN_ID, QUERY_ID, MEASURE_OPERATION, MEASURE_RANK) values (75, 21, 'COUNT', 0);

insert into CHART_AXIS_COLUMN(CHART_COLUMN_ID, QUERY_ID, AXIS_OPERATION, AXIS_RANK)  values (66, 21, 'NONE', 0);

-- subqueries for entity ISSUE --
		
		-- subqueries for entity TEST_CASE_STEP --
		
		-- subqueries for entity TEST_CASE_NATURE --
		
		-- subqueries for entity TEST_CASE_TYPE --
		
		-- subqueries for entity REQUIREMENT_VERSION_CATEGORY --
		
		-- subqueries for entity TEST_CASE_MILESTONE --
		
		-- subqueries for entity REQUIREMENT_VERSION_MILESTONE --
		
		-- subqueries for entity ITERATION_TEST_PLAN_ASSIGNED_USER --
		
		-- subqueries for entity AUTOMATED_TEST --
		
		-- subqueries for entity AUTOMATED_EXECUTION_EXTENDER --
		
		
		-- -------------------------------------------
		-- section 3 :  calculated columns
		-- -------------------------------------------
		
		
		-- columns for entity : REQUIREMENT --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(2, 'CALCULATED', TRUE, 'REQUIREMENT_NB_VERSIONS', 'REQUIREMENT', null, 'NUMERIC', 'count(requirementVersionCoverages)', 1);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (2, 'MEASURE'), (2, 'AXIS'), (2, 'FILTER');

-- columns for entity : REQUIREMENT_VERSION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(17, 'CALCULATED', TRUE, 'REQUIREMENT_VERSION_TCCOUNT', 'REQUIREMENT_VERSION', null, 'NUMERIC', 'count(requirementVersionCoverages)', 2),
			(18, 'CALCULATED', TRUE, 'REQUIREMENT_VERSION_MILCOUNT', 'REQUIREMENT_VERSION', null, 'NUMERIC', 'count(milestones)', 3);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (17, 'MEASURE'), (17, 'AXIS'), (17, 'FILTER'),
			 (18, 'MEASURE'), (18, 'AXIS'), (18, 'FILTER');

-- columns for entity : TEST_CASE --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(30, 'CALCULATED', TRUE, 'TEST_CASE_VERSCOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(requirementVersionCoverages)', 4),
			(31, 'CALCULATED', TRUE, 'TEST_CASE_CALLSTEPCOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(steps[class="CallTestStep"])', 5),
			(32, 'CALCULATED', TRUE, 'TEST_CASE_STEPCOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(steps)', 6),
			(33, 'CALCULATED', TRUE, 'TEST_CASE_MILCOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(milestones)', 7),
			(34, 'CALCULATED', TRUE, 'TEST_CASE_ITERCOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(iterations)', 8),
			(35, 'CALCULATED', TRUE, 'TEST_CASE_EXECOUNT', 'TEST_CASE', null, 'NUMERIC', 'count(executions)', 9),
			(36, 'CALCULATED', TRUE, 'TEST_CASE_HASAUTOSCRIPT', 'TEST_CASE', null, 'BOOLEAN', 'notnull(automatedTest)', 10);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (30, 'MEASURE'), (30, 'AXIS'), (30, 'FILTER'),
			 (31, 'MEASURE'), (31, 'AXIS'), (31, 'FILTER'),
			 (32, 'MEASURE'), (32, 'AXIS'), (32, 'FILTER'),
			 (33, 'MEASURE'), (33, 'AXIS'), (33, 'FILTER'),
			 (34, 'MEASURE'), (34, 'AXIS'), (34, 'FILTER'),
			 (35, 'MEASURE'), (35, 'AXIS'), (35, 'FILTER'),
			 (36, 'MEASURE'), (36, 'AXIS'), (36, 'FILTER');

-- columns for entity : CAMPAIGN --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(44, 'CALCULATED', TRUE, 'CAMPAIGN_ITERCOUNT', 'CAMPAIGN', null, 'NUMERIC', 'count(iterations)', 11),
			(45, 'CALCULATED', TRUE, 'CAMPAIGN_ISSUECOUNT', 'CAMPAIGN', null, 'NUMERIC', 'count(issues)', 12);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (44, 'MEASURE'), (44, 'AXIS'), (44, 'FILTER'),
			 (45, 'MEASURE'), (45, 'AXIS'), (45, 'FILTER');

-- columns for entity : ITERATION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(52, 'CALCULATED', TRUE, 'ITERATION_ITEMCOUNT', 'ITERATION', null, 'NUMERIC', 'count(testPlans)', 13),
			(53, 'CALCULATED', TRUE, 'ITERATION_ISSUECOUNT', 'ITERATION', null, 'NUMERIC', 'count(issues)', 14);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (52, 'MEASURE'), (52, 'AXIS'), (52, 'FILTER'),
			 (53, 'MEASURE'), (53, 'AXIS'), (53, 'FILTER');

-- columns for entity : ITEM_TEST_PLAN --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(61, 'CALCULATED', TRUE, 'ITEM_TEST_PLAN_TC_DELETED', 'ITEM_TEST_PLAN', null, 'BOOLEAN', 'isnull(referencedTestCase)', 15),
			(62, 'CALCULATED', TRUE, 'ITEM_TEST_PLAN_IS_EXECUTED', 'ITEM_TEST_PLAN', null, 'BOOLEAN', 'notnull(executions)', 16),
			(63, 'CALCULATED', TRUE, 'ITEM_TEST_PLAN_MANEXCOUNT', 'ITEM_TEST_PLAN', null, 'NUMERIC', 'count(executions[auto="false"])', 17),
			(64, 'CALCULATED', TRUE, 'ITEM_TEST_PLAN_AUTOEXCOUNT', 'ITEM_TEST_PLAN', null, 'NUMERIC', 'count(executions[auto="true"])', 18),
			(65, 'CALCULATED', TRUE, 'ITEM_TEST_PLAN_ISSUECOUNT', 'ITEM_TEST_PLAN', null, 'NUMERIC', 'count(issues)', 19);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (61, 'MEASURE'), (61, 'AXIS'), (61, 'FILTER'),
			 (62, 'MEASURE'), (62, 'AXIS'), (62, 'FILTER'),
			 (63, 'MEASURE'), (63, 'AXIS'), (63, 'FILTER'),
			 (64, 'MEASURE'), (64, 'AXIS'), (64, 'FILTER'),
			 (65, 'MEASURE'), (65, 'AXIS'), (65, 'FILTER');

-- columns for entity : EXECUTION --
		
		insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID, COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
		values
			(72, 'CALCULATED', TRUE, 'EXECUTION_ISAUTO', 'EXECUTION', null, 'BOOLEAN', 'notnull(automatedExecutionExtender)', 20),
			(73, 'CALCULATED', TRUE, 'EXECUTION_ISSUECOUNT', 'EXECUTION', null, 'NUMERIC', 'count(issues)', 21);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
		values
			 (72, 'FILTER'),
			 (73, 'MEASURE'), (73, 'AXIS'), (73, 'FILTER');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'populate the column prototype referential data (generated from src/main/script/MakeChartColumns.groovy)', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5375-2', '2.0.5', '3:440e9bd08f41c2961d3f5451c56f5dbe', 334);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5292-1::jthebault::(Checksum: 3:149c727753bc94c5ad30c43a6ba52ee3)
-- closure table for custom report library nodes. Its content is set and modified by four triggers
CREATE TABLE CUSTOM_REPORT_LIBRARY (CRL_ID bigserial NOT NULL, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT PK_CUSTOM_REPORT_LIBRARY PRIMARY KEY (CRL_ID));

COMMENT ON COLUMN CUSTOM_REPORT_LIBRARY.CRL_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_LIBRARY.ATTACHMENT_LIST_ID IS 'FK to ATTACHMENT_LIST';

CREATE INDEX IDX_CUSTOM_REPORT_LIBRARY ON CUSTOM_REPORT_LIBRARY(CRL_ID);

CREATE TABLE CUSTOM_REPORT_LIBRARY_NODE (CRLN_ID bigserial NOT NULL, NAME VARCHAR(255), ENTITY_TYPE VARCHAR(50), ENTITY_ID BIGINT, CRL_ID BIGINT, CONSTRAINT PK_CUSTOM_REPORT_LIBRARY_NODE PRIMARY KEY (CRLN_ID), CONSTRAINT fk_crln_custom_report_library_crl_id FOREIGN KEY (CRL_ID) REFERENCES CUSTOM_REPORT_LIBRARY(CRL_ID));

COMMENT ON COLUMN CUSTOM_REPORT_LIBRARY_NODE.CRLN_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_LIBRARY_NODE.CRL_ID IS 'fk to the containing CUSTOM_REPORT_LIBRARY';

CREATE TABLE CRLN_RELATIONSHIP (ANCESTOR_ID BIGINT, DESCENDANT_ID BIGINT NOT NULL, CONTENT_ORDER BIGINT, CONSTRAINT fk_crln_relationship_descendant FOREIGN KEY (DESCENDANT_ID) REFERENCES CUSTOM_REPORT_LIBRARY_NODE(CRLN_ID), CONSTRAINT fk_crln_relationship_ancestor FOREIGN KEY (ANCESTOR_ID) REFERENCES CUSTOM_REPORT_LIBRARY_NODE(CRLN_ID));

COMMENT ON COLUMN CRLN_RELATIONSHIP.ANCESTOR_ID IS 'cle etrangere vers le noeud parent';

COMMENT ON COLUMN CRLN_RELATIONSHIP.DESCENDANT_ID IS 'cle etrangere vers l''element fils.';

COMMENT ON COLUMN CRLN_RELATIONSHIP.CONTENT_ORDER IS 'numéro d''ordre du noeud dans son parent';

CREATE INDEX idx_crln_relationship_descendant ON CRLN_RELATIONSHIP(DESCENDANT_ID);

CREATE INDEX idx_crln_relationship_ancestor ON CRLN_RELATIONSHIP(ANCESTOR_ID);

CREATE TABLE CUSTOM_REPORT_FOLDER (CRF_ID bigserial NOT NULL, NAME VARCHAR(255), DESCRIPTION TEXT, PROJECT_ID BIGINT NOT NULL, CONSTRAINT PK_CRF_ID PRIMARY KEY (CRF_ID), CONSTRAINT fk_project_custom_report_folder_project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN CUSTOM_REPORT_FOLDER.CRF_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_FOLDER.PROJECT_ID IS 'cle etrangere vers le projet.';

CREATE TABLE CUSTOM_REPORT_DASHBOARD (CRD_ID bigserial NOT NULL, NAME VARCHAR(255), PROJECT_ID BIGINT NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_CRD_ID PRIMARY KEY (CRD_ID), CONSTRAINT fk_project_custom_report_dashboard_project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN CUSTOM_REPORT_DASHBOARD.CRD_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_DASHBOARD.PROJECT_ID IS 'cle etrangere vers le projet.';

CREATE TABLE CUSTOM_REPORT_CHART_BINDING (CRCB_ID bigserial NOT NULL, CRD_ID BIGINT NOT NULL, CHART_ID BIGINT NOT NULL, ROW INT, COL INT, SIZE_X INT, SIZE_Y INT, CONSTRAINT PK_CRCB_ID PRIMARY KEY (CRCB_ID), CONSTRAINT fk_chart_bindind_custom_report_dashboard_crd_id FOREIGN KEY (CRD_ID) REFERENCES CUSTOM_REPORT_DASHBOARD(CRD_ID), CONSTRAINT fk_chart_bindind_chart_definition_chart_id FOREIGN KEY (CHART_ID) REFERENCES CHART_DEFINITION(CHART_ID));

COMMENT ON COLUMN CUSTOM_REPORT_CHART_BINDING.CRCB_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_CHART_BINDING.CRD_ID IS 'cle etrangere vers le dashboard.';

COMMENT ON COLUMN CUSTOM_REPORT_CHART_BINDING.CHART_ID IS 'cle etrangere vers le chart.';

ALTER TABLE PROJECT ADD CRL_ID BIGINT;

COMMENT ON COLUMN PROJECT.CRL_ID IS 'FK FOR CUSTOM_REPORT_LIBRARY.CRL_ID';

ALTER TABLE ATTACHMENT_LIST ADD TMP_CRL_ID BIGINT;

COMMENT ON COLUMN ATTACHMENT_LIST.TMP_CRL_ID IS 'TMP FK FOR CUSTOM_REPORT_LIBRARY.CRL_ID';

CREATE TABLE CRLN_RELATIONSHIP_CLOSURE (ANCESTOR_ID BIGINT NOT NULL, DESCENDANT_ID BIGINT NOT NULL, DEPTH SMALLINT NOT NULL, CONSTRAINT fk_crln_relationship_clos_anc FOREIGN KEY (ANCESTOR_ID) REFERENCES CUSTOM_REPORT_LIBRARY_NODE(CRLN_ID), CONSTRAINT fk_crln_relationship_clos_desc FOREIGN KEY (DESCENDANT_ID) REFERENCES CUSTOM_REPORT_LIBRARY_NODE(CRLN_ID));

COMMENT ON COLUMN CRLN_RELATIONSHIP_CLOSURE.ANCESTOR_ID IS 'cle etrangere vers le noeud parent. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN CRLN_RELATIONSHIP_CLOSURE.DESCENDANT_ID IS 'cle etrangere vers l''element fils. La relation est parfois d''un noeud vers lui meme.';

COMMENT ON COLUMN CRLN_RELATIONSHIP_CLOSURE.DEPTH IS 'stores how deep is the descendant element nested in the subtree of the ancestor element';

CREATE INDEX idx_crln_relationship_clos_desc ON CRLN_RELATIONSHIP_CLOSURE(DESCENDANT_ID);

CREATE INDEX idx_crln_relationship_clos_anc ON CRLN_RELATIONSHIP_CLOSURE(ANCESTOR_ID);

ALTER TABLE CRLN_RELATIONSHIP_CLOSURE ADD UNIQUE (ANCESTOR_ID, DESCENDANT_ID);

INSERT INTO ACL_CLASS (CLASSNAME) VALUES ('org.squashtest.tm.domain.customreport.CustomReportLibrary');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectManager'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '2');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '4');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '8');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestEditor'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1024');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.ProjectViewer'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestRunner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.TestDesigner'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.AdvanceTester'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO ACL_GROUP_PERMISSION (ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) VALUES ((select ID from ACL_GROUP where QUALIFIED_NAME = 'squashtest.acl.group.tm.Validator'), (select ID from ACL_CLASS where CLASSNAME = 'org.squashtest.tm.domain.customreport.CustomReportLibrary'), '1');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'closure table for custom report library nodes. Its content is set and modified by four triggers', NOW(), 'Create Table, Create Index, Create Table (x2), Create Index (x2), Create Table (x3), Add Column (x2), Create Table, Create Index (x2), Add Unique Constraint, Insert Row (x16)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5292-1', '2.0.5', '3:149c727753bc94c5ad30c43a6ba52ee3', 335);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feat-5292-2-postgresql::jthebault::(Checksum: 3:1e52ba24506285ab542ce0b4ff18ea21)
-- postgresql-triggers for CRLN_RELATIONSHIP_CLOSURE table
drop trigger if exists ins_crln_after on CUSTOM_REPORT_LIBRARY_NODE;
		drop function if exists ins_crln_after();
		create function ins_crln_after() returns trigger as $ins_crln_after$
		begin
			insert into CRLN_RELATIONSHIP_CLOSURE
			values (new.crln_id, new.crln_id, 0);
			return new;
		end;
		$ins_crln_after$ language plpgsql;

		create trigger ins_crln_after after insert on CUSTOM_REPORT_LIBRARY_NODE
		for each row execute procedure ins_crln_after();

drop trigger if exists del_crln_before on CUSTOM_REPORT_LIBRARY_NODE;
		drop function if exists del_crln_before();
		create function del_crln_before() returns trigger as $del_crln_before$
		begin
			delete from CRLN_RELATIONSHIP_CLOSURE
			where ancestor_id = old.crln_id
			and descendant_id = old.crln_id;
			return old;
		end;
		$del_crln_before$ language plpgsql;

		create trigger del_crln_before before delete on CUSTOM_REPORT_LIBRARY_NODE
		for each row execute procedure del_crln_before();

drop trigger if exists attach_crln_after on CRLN_RELATIONSHIP;
		drop function if exists attach_crln_after();
		create function attach_crln_after() returns trigger as $attach_crln_after$
		begin
			insert into CRLN_RELATIONSHIP_CLOSURE
			select c1.ancestor_id, c2.descendant_id, c1.depth + c2.depth + 1
			from CRLN_RELATIONSHIP_CLOSURE c1
			cross join CRLN_RELATIONSHIP_CLOSURE c2
			where c1.descendant_id = new.ancestor_id
			and c2.ancestor_id = new.descendant_id;
			return new;
		end;
		$attach_crln_after$ language plpgsql;

		create trigger attach_crln_after after insert on CRLN_RELATIONSHIP
		for each row execute procedure attach_crln_after();

drop trigger if exists detach_crln_before on CRLN_RELATIONSHIP;
		drop function if exists detach_crln_before();
		create function detach_crln_before() returns trigger as $detach_crln_before$
		begin
			delete from CRLN_RELATIONSHIP_CLOSURE
			where descendant_id in ( select descendant_id from CRLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
			and ancestor_id not in ( select descendant_id from CRLN_RELATIONSHIP_CLOSURE where ancestor_id = old.descendant_id )
			;
			return old;
		end;
		$detach_crln_before$ language plpgsql;

		create trigger detach_crln_before before delete on CRLN_RELATIONSHIP
		for each row execute procedure detach_crln_before();

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'postgresql-triggers for CRLN_RELATIONSHIP_CLOSURE table', NOW(), 'Create Procedure (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feat-5292-2-postgresql', '2.0.5', '3:1e52ba24506285ab542ce0b4ff18ea21', 336);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feat-5292-3::jthebault::(Checksum: 3:57e627e737c45ca7b55a4b43a85e3321)
-- Migration for custom report workspace evolution. Mainly create the Library entities and their nodes, attachement list...
insert into CUSTOM_REPORT_LIBRARY (CRL_ID)
		select p.PROJECT_ID
		from PROJECT p;

update PROJECT p
		set CRL_ID = PROJECT_ID;

insert into ACL_OBJECT_IDENTITY (IDENTITY,CLASS_ID)
		  select CRL_ID, ID from CUSTOM_REPORT_LIBRARY,ACL_CLASS
		  where ACL_CLASS.CLASSNAME LIKE 'org.squashtest.tm.domain.customreport.CustomReportLibrary';

insert into ATTACHMENT_LIST (TMP_CRL_ID)
		select CRL_ID
		from CUSTOM_REPORT_LIBRARY crl;

update CUSTOM_REPORT_LIBRARY crl
		set ATTACHMENT_LIST_ID = (
			select ATTACHMENT_LIST_ID
			from ATTACHMENT_LIST al
			where crl.CRL_ID = al.TMP_CRL_ID
	);

insert into CUSTOM_REPORT_LIBRARY_NODE (ENTITY_ID,CRL_ID,ENTITY_TYPE)
		select CRL_ID,CRL_ID,'LIBRARY'
		from CUSTOM_REPORT_LIBRARY;

update CUSTOM_REPORT_LIBRARY_NODE
		set NAME = (
				select p.NAME
				from PROJECT p
				where ENTITY_ID = p.CRL_ID
			)
		where ENTITY_TYPE = 'LIBRARY';

ALTER TABLE ATTACHMENT_LIST DROP COLUMN TMP_CRL_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Migration for custom report workspace evolution. Mainly create the Library entities and their nodes, attachement list...', NOW(), 'Custom SQL (x4), Drop Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feat-5292-3', '2.0.5', '3:57e627e737c45ca7b55a4b43a85e3321', 337);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5292-4::bsiri::(Checksum: 3:f1cdcaaaa75c07b16f3b864ed3a28527)
-- set the foreign key constraints from project to custom report library, and from custom report_library to attachment_list
ALTER TABLE PROJECT ADD CONSTRAINT fk_project_crl FOREIGN KEY (CRL_ID) REFERENCES CUSTOM_REPORT_LIBRARY (CRL_ID);

ALTER TABLE CUSTOM_REPORT_LIBRARY ADD CONSTRAINT fk_crl_attachment_list FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST (ATTACHMENT_LIST_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'set the foreign key constraints from project to custom report library, and from custom report_library to attachment_list', NOW(), 'Add Foreign Key Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5292-4', '2.0.5', '3:f1cdcaaaa75c07b16f3b864ed3a28527', 338);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5292-5::jthebault::(Checksum: 3:be5321cb8f4ae12a1789ba66eab429d6)
-- update the sequences afterward
SELECT setval('custom_report_library_crl_id_seq', (SELECT MAX(CRL_ID) from CUSTOM_REPORT_LIBRARY));

SELECT setval('custom_report_library_node_crln_id_seq', (SELECT MAX(CRLN_ID) from CUSTOM_REPORT_LIBRARY_NODE));

SELECT setval('acl_object_identity_id_seq', (SELECT MAX(ID) from ACL_OBJECT_IDENTITY));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'update the sequences afterward', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5292-5', '2.0.5', '3:be5321cb8f4ae12a1789ba66eab429d6', 339);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5375-3::jsimon, bsiri::(Checksum: 3:6c40497eb5af9c904d9ed7b59abd9994)
-- update the sequences afterward
SELECT setval('chart_column_prototype_chart_column_id_seq', (SELECT MAX(CHART_COLUMN_ID) from CHART_COLUMN_PROTOTYPE));

SELECT setval('chart_query_chart_query_id_seq', (SELECT MAX(CHART_QUERY_ID) from CHART_QUERY));

SELECT setval('chart_filter_filter_id_seq', (SELECT MAX(FILTER_ID) from CHART_FILTER));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon, bsiri', 'update the sequences afterward', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5375-3', '2.0.5', '3:6c40497eb5af9c904d9ed7b59abd9994', 340);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5375-4::jsimon::(Checksum: 3:0f35f24cf83abba62a3a6934dd715fe2)
CREATE TABLE CHART_PROJECT_SCOPE (CHART_PROJECT_SCOPE_ID bigserial NOT NULL, CHART_ID BIGINT NOT NULL, PROJECT_SCOPE VARCHAR(15), CONSTRAINT PK_CHART_PROJECT_SCOPE PRIMARY KEY (CHART_PROJECT_SCOPE_ID), CONSTRAINT fk_chart_project_scope_chart_definition FOREIGN KEY (CHART_ID) REFERENCES CHART_DEFINITION(CHART_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jsimon', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5375-4', '2.0.5', '3:0f35f24cf83abba62a3a6934dd715fe2', 341);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5265-1::bsiri::(Checksum: 3:00802e64f31ea118f27a9aa0478ce606)
-- This table holds the optional extension for requirement, that flags them as synchronized requirement
CREATE TABLE REQUIREMENT_SYNC_EXTENDER (REQ_SYNC_ID bigserial NOT NULL, REQUIREMENT_ID BIGINT NOT NULL, BUGTRACKER_ID BIGINT NOT NULL, REMOTE_REQ_ID VARCHAR(15), REMOTE_PROJECT_ID VARCHAR(15), REMOTE_REQ_URL VARCHAR(300), LAST_SYNCHRONIZED_BY VARCHAR(50) DEFAULT null, CONSTRAINT PK_REQUIREMENT_SYNC_EXTENDER PRIMARY KEY (REQ_SYNC_ID), CONSTRAINT fk_sync_extender_bugtracker FOREIGN KEY (BUGTRACKER_ID) REFERENCES BUGTRACKER(BUGTRACKER_ID), CONSTRAINT fk_sync_extender_requirement FOREIGN KEY (REQUIREMENT_ID) REFERENCES REQUIREMENT(RLN_ID));

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REQ_SYNC_ID IS 'autogenerated key';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REQUIREMENT_ID IS 'foreign key to the (now synchronized) requirement';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.BUGTRACKER_ID IS 'foreign key to the source bugtracker';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REMOTE_REQ_ID IS 'ID of the remote requirement';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REMOTE_PROJECT_ID IS 'ID of the remote project that hosts the remote requirement';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REMOTE_REQ_URL IS 'the url of the remote requirement';

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.LAST_SYNCHRONIZED_BY IS 'the last used that synchronized that requirement with the remote manager';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This table holds the optional extension for requirement, that flags them as synchronized requirement', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5265-1', '2.0.5', '3:00802e64f31ea118f27a9aa0478ce606', 342);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml::tm-1.13.0-feature-5265-2::bsiri::(Checksum: 3:2665f041c2959aebc332280a2806f725)
-- adding a column recording how a requirement should be managed
ALTER TABLE REQUIREMENT ADD MODE VARCHAR(15) DEFAULT 'NATIVE';

COMMENT ON COLUMN REQUIREMENT.MODE IS 'Says whether a requirement is NATIVE or SYNCHRONIZED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'adding a column recording how a requirement should be managed', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.0.xml', 'tm-1.13.0-feature-5265-2', '2.0.5', '3:2665f041c2959aebc332280a2806f725', 343);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.1.xml::tm-1.13.1::jthebault::(Checksum: 3:9acf48a1aeff01d0f45dabea50329634)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.13.1' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.1.xml', 'tm-1.13.1', '2.0.5', '3:9acf48a1aeff01d0f45dabea50329634', 344);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.1.xml::tm-1.13.1-ACL-Custom-Report-Library::jthebault::(Checksum: 3:9ddc45890a0ff8b5f42b3f63d61f07f6)
DROP TABLE IF EXISTS ACL_RSE_TMP;

CREATE TEMPORARY TABLE ACL_RSE_TMP
	(
		PARTY_ID bigint,
		ACL_GROUP_ID bigint,
		OBJECT_IDENTITY_ID bigint,
		PROJECT_ID bigint,
		CRL_ID bigint,
		CRL_CLASS_ID bigint,
		CRL_OBJECT_IDENTITY_ID bigint
	);

insert into ACL_RSE_TMP (PARTY_ID,ACL_GROUP_ID,OBJECT_IDENTITY_ID,PROJECT_ID)
		select PARTY_ID,ACL_GROUP_ID,OBJECT_IDENTITY_ID,ACL_OBJECT_IDENTITY.IDENTITY
		from ACL_RESPONSIBILITY_SCOPE_ENTRY
		inner join ACL_OBJECT_IDENTITY on ACL_RESPONSIBILITY_SCOPE_ENTRY.OBJECT_IDENTITY_ID = ACL_OBJECT_IDENTITY.ID
		inner join ACL_CLASS on ACL_OBJECT_IDENTITY.CLASS_ID = ACL_CLASS.ID
		where ACL_CLASS.CLASSNAME like 'org.squashtest.tm.domain.project.Project%';

update ACL_RSE_TMP 
		set CRL_ID = (select CRL_ID from PROJECT where PROJECT.PROJECT_ID = ACL_RSE_TMP.PROJECT_ID);

update ACL_RSE_TMP 
		set CRL_CLASS_ID = (select ACL_CLASS.ID from ACL_CLASS where ACL_CLASS.CLASSNAME like 'org.squashtest.tm.domain.customreport.CustomReportLibrary');

update ACL_RSE_TMP 
		set CRL_OBJECT_IDENTITY_ID = 
			(select ACL_OBJECT_IDENTITY.ID from ACL_OBJECT_IDENTITY where ACL_OBJECT_IDENTITY.CLASS_ID = 
				(select ACL_CLASS.ID from ACL_CLASS where ACL_CLASS.CLASSNAME like 'org.squashtest.tm.domain.customreport.CustomReportLibrary')
				and ACL_OBJECT_IDENTITY.IDENTITY = ACL_RSE_TMP.CRL_ID
			);

delete from ACL_RESPONSIBILITY_SCOPE_ENTRY where ACL_RESPONSIBILITY_SCOPE_ENTRY.OBJECT_IDENTITY_ID in (select CRL_OBJECT_IDENTITY_ID from ACL_RSE_TMP);

insert into ACL_RESPONSIBILITY_SCOPE_ENTRY (PARTY_ID,ACL_GROUP_ID,OBJECT_IDENTITY_ID)
		select PARTY_ID,ACL_GROUP_ID,CRL_OBJECT_IDENTITY_ID
		from ACL_RSE_TMP;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.1.xml', 'tm-1.13.1-ACL-Custom-Report-Library', '2.0.5', '3:9ddc45890a0ff8b5f42b3f63d61f07f6', 345);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3::bsiri::(Checksum: 3:4dae33cd26a63e47b996bb8e65546fcc)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.13.3' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3', '2.0.5', '3:4dae33cd26a63e47b996bb8e65546fcc', 346);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3-feature-5265-1::bsiri::(Checksum: 3:15cde7fa51c55f82ab8795f0be8f2b7d)
-- making the capacity of plugin configuration items larger
ALTER TABLE LIBRARY_PLUGIN_BINDING_PROPERTY ALTER COLUMN PLUGIN_BINDING_VALUE TYPE TEXT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'making the capacity of plugin configuration items larger', NOW(), 'Modify data type', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3-feature-5265-1', '2.0.5', '3:15cde7fa51c55f82ab8795f0be8f2b7d', 347);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3-feature-5265-2::bsiri::(Checksum: 3:88e5cd27228c2f58998992a673248c86)
-- reworking table REQUIREMENT_SYNC_EXTENDER
ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD REMOTE_FILTER_NAME VARCHAR(150) NOT NULL;

COMMENT ON COLUMN REQUIREMENT_SYNC_EXTENDER.REMOTE_FILTER_NAME IS 'name of a filter (not its ID)';

ALTER TABLE REQUIREMENT_SYNC_EXTENDER DROP CONSTRAINT fk_sync_extender_bugtracker;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER RENAME COLUMN BUGTRACKER_ID TO SERVER_ID;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD CONSTRAINT fk_sync_extender_server FOREIGN KEY (SERVER_ID) REFERENCES BUGTRACKER (BUGTRACKER_ID) ON DELETE CASCADE;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER DROP CONSTRAINT fk_sync_extender_requirement;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD CONSTRAINT fk_sync_extender_requirement FOREIGN KEY (REQUIREMENT_ID) REFERENCES REQUIREMENT (RLN_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'reworking table REQUIREMENT_SYNC_EXTENDER', NOW(), 'Add Column, Drop Foreign Key Constraint, Rename Column, Add Foreign Key Constraint, Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3-feature-5265-2', '2.0.5', '3:88e5cd27228c2f58998992a673248c86', 348);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3-feature-5265-3::bsiri::(Checksum: 3:b9ff7b5a87f9095565612e0ce7ce4ee7)
-- adding useful indexes
CREATE INDEX idx_sync_remote_req_id ON REQUIREMENT_SYNC_EXTENDER(REMOTE_REQ_ID);

CREATE INDEX idx_sync_remote_projfilter ON REQUIREMENT_SYNC_EXTENDER(REMOTE_PROJECT_ID, REMOTE_FILTER_NAME);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'adding useful indexes', NOW(), 'Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3-feature-5265-3', '2.0.5', '3:b9ff7b5a87f9095565612e0ce7ce4ee7', 349);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3-feature-5265-4::bsiri::(Checksum: 3:a594dba7d082bd207d56bffc7d4b8bf8)
-- This view maps a requirement library node to its main resource. Some would say 
-- 			it is redundant with what can be found in tables REQUIREMENT or REQUIREMENT_FOLDER
-- 			but seriously it makes simple things likes getting the name of a generic 
-- 			REQUIREMENT_LIBRARY_NODE much simpler.
CREATE VIEW RLN_RESOURCE AS select fold.rln_id as rln_id, fold.res_id as res_id
			from REQUIREMENT_FOLDER fold 
			UNION
			select req.rln_id as rln_id, req.current_version_id as res_id
			from REQUIREMENT req;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This view maps a requirement library node to its main resource. Some would say 
			it is redundant with what can be found in tables REQUIREMENT or REQUIREMENT_FOLDER
			but seriously it makes simple things likes getting the name of a generic 
			REQUIR...', NOW(), 'Create View', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3-feature-5265-4', '2.0.5', '3:a594dba7d082bd207d56bffc7d4b8bf8', 350);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml::tm-1.13.3-feature-5265-5::bsiri::(Checksum: 3:612961ea115fe333cd6e2b995580f7ce)
-- new requirement audit trail tables for synchronization events
CREATE TABLE SYNC_REQUIREMENT_CREATION (EVENT_ID BIGINT NOT NULL, SOURCE VARCHAR(255) NOT NULL, CONSTRAINT PK_SYNC_CREATE PRIMARY KEY (EVENT_ID), CONSTRAINT fk_sync_create_audit FOREIGN KEY (EVENT_ID) REFERENCES REQUIREMENT_AUDIT_EVENT(EVENT_ID));

COMMENT ON COLUMN SYNC_REQUIREMENT_CREATION.EVENT_ID IS 'primary key, which is also a foreign key to REQUIREMENT_AUDIT_EVENT (they share that key : do not make this table autoincrement it).';

COMMENT ON COLUMN SYNC_REQUIREMENT_CREATION.SOURCE IS 'the url of the synchronized requirement at the time of creation';

CREATE TABLE SYNC_REQUIREMENT_UPDATE (EVENT_ID BIGINT NOT NULL, SOURCE VARCHAR(255) NOT NULL, CONSTRAINT PK_SYNC_UPDATE PRIMARY KEY (EVENT_ID), CONSTRAINT fk_sync_update_audit FOREIGN KEY (EVENT_ID) REFERENCES REQUIREMENT_AUDIT_EVENT(EVENT_ID));

COMMENT ON COLUMN SYNC_REQUIREMENT_UPDATE.EVENT_ID IS 'primary key, which is also a foreign key to REQUIREMENT_AUDIT_EVENT (they share that key : do not make this table autoincrement it).';

COMMENT ON COLUMN SYNC_REQUIREMENT_UPDATE.SOURCE IS 'the url of the synchronized requirement at the time of update';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'new requirement audit trail tables for synchronization events', NOW(), 'Create Table (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.3.xml', 'tm-1.13.3-feature-5265-5', '2.0.5', '3:612961ea115fe333cd6e2b995580f7ce', 351);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.5.xml::tm-1.13.5::jthebault::(Checksum: 3:a40d94c52e111a60c770d48f6b660f93)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.13.5' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.5.xml', 'tm-1.13.5', '2.0.5', '3:a40d94c52e111a60c770d48f6b660f93', 352);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.5.xml::tm-1.13.5-issue-6291::jthebault::(Checksum: 3:27e505250895da0dd2cb62cc8c6c630b)
-- Delete orphan lines in cuf values. Only for cuf values bind to a removed execution.
DELETE FROM CUSTOM_FIELD_VALUE
      WHERE cfv_id IN (
        SELECT implicit.cfv_id FROM (
          SELECT cfv.cfv_id
          FROM CUSTOM_FIELD_VALUE cfv
          LEFT JOIN EXECUTION exec
          ON exec.execution_id = cfv.bound_entity_id
          WHERE cfv.bound_entity_type = 'EXECUTION'
          AND exec.execution_id IS NULL
      ) implicit
      );

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Delete orphan lines in cuf values. Only for cuf values bind to a removed execution.', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.13.5.xml', 'tm-1.13.5-issue-6291', '2.0.5', '3:27e505250895da0dd2cb62cc8c6c630b', 353);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.0.xml::tm-1.14.0::bsiri::(Checksum: 3:233750f7f586a7f292383730fac15223)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.14.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.0.xml', 'tm-1.14.0', '2.0.5', '3:233750f7f586a7f292383730fac15223', 354);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.0.xml::tm-1.14.0-feature-5416::jthebault::(Checksum: 3:28a6956bad8e3f958f195ca715ab561f)
CREATE TABLE PARTY_PREFERENCE (PREFERENCE_ID bigserial NOT NULL, PARTY_ID BIGINT NOT NULL, PREFERENCE_KEY VARCHAR(50), PREFERENCE_VALUE VARCHAR(5000), CONSTRAINT PK_PARTY_PREFERENCE PRIMARY KEY (PREFERENCE_ID), CONSTRAINT fk_party_preference_core_party_party_id FOREIGN KEY (PARTY_ID) REFERENCES CORE_PARTY(PARTY_ID));

COMMENT ON COLUMN PARTY_PREFERENCE.PARTY_ID IS 'foreign key to the core_party table';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.0.xml', 'tm-1.14.0-feature-5416', '2.0.5', '3:28a6956bad8e3f958f195ca715ab561f', 355);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml::tm-1.14.1::bsiri::(Checksum: 3:6e42a1e9b71a995a5210b003b44cbaf7)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.14.1' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml', 'tm-1.14.1', '2.0.5', '3:6e42a1e9b71a995a5210b003b44cbaf7', 356);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml::tm-1.14.1-issue-6340-1::bsiri::(Checksum: 3:60da0cf14443db9fb651212663612c9d)
-- For the purpose of the cleanup to come, we must activate on delete cascade 
--             between DENORMALIZED_FIELD_OPTION and DENORMALIZED_FIELD_VALUE
ALTER TABLE DENORMALIZED_FIELD_OPTION DROP CONSTRAINT fk_df_option_dfv;

ALTER TABLE DENORMALIZED_FIELD_OPTION ADD CONSTRAINT fk_df_option_dfv FOREIGN KEY (DFV_ID) REFERENCES DENORMALIZED_FIELD_VALUE (DFV_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'For the purpose of the cleanup to come, we must activate on delete cascade 
            between DENORMALIZED_FIELD_OPTION and DENORMALIZED_FIELD_VALUE', NOW(), 'Drop Foreign Key Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml', 'tm-1.14.1-issue-6340-1', '2.0.5', '3:60da0cf14443db9fb651212663612c9d', 357);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml::tm-1.14.1-issue-6340-2a::bsiri::(Checksum: 3:2727be10754e0526889eb7bee67b6c9f)
-- Fixing the extraneous custom field values (for test cases) and denormalized field values (for executions)
--           for Postgresql.
--           Note about the ordering (in the partition instruction) : I've empirically found that it must be ascending 
--           for table DENORMALIZED_FIELD_VALUE and descending for CUSTOm_FIELD_VALUE because of
delete from DENORMALIZED_FIELD_VALUE
        where DFV_ID in (
            select DFV_ID from (
                select DFV_ID, ROW_NUMBER() over (partition by DENORMALIZED_FIELD_HOLDER_ID, DENORMALIZED_FIELD_HOLDER_TYPE, CODE order by DFV_ID) 
                as RNUM 
                from DENORMALIZED_FIELD_VALUE
            ) TODELETE
            where TODELETE.RNUM > 1
        );

delete from CUSTOM_FIELD_VALUE
        where CFV_ID in (
            select CFV_ID from (
                select CFV_ID, ROW_NUMBER() over (partition by BOUND_ENTITY_ID, BOUND_ENTITY_TYPE, CFB_ID order by CFV_ID desc) 
                as RNUM 
                from CUSTOM_FIELD_VALUE
            ) TODELETE
            where TODELETE.RNUM > 1	
        );

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Fixing the extraneous custom field values (for test cases) and denormalized field values (for executions)
          for Postgresql.
          Note about the ordering (in the partition instruction) : I''ve empirically found that it must be ascending 
   ...', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml', 'tm-1.14.1-issue-6340-2a', '2.0.5', '3:2727be10754e0526889eb7bee67b6c9f', 358);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml::tm-1.14.1-issue-6340-3::bsiri::(Checksum: 3:0f662c7dbe45ee5f2f8c55e544cdfc2a)
-- enforcing uniticy on the custom field values and denormalized field values - 
--           if later on there are more double insert let it fail fast
ALTER TABLE DENORMALIZED_FIELD_VALUE ADD CONSTRAINT u_dfv_id_type_code UNIQUE (DENORMALIZED_FIELD_HOLDER_ID, DENORMALIZED_FIELD_HOLDER_TYPE, CODE);

ALTER TABLE CUSTOM_FIELD_VALUE ADD CONSTRAINT u_cfv_id_type_binding UNIQUE (BOUND_ENTITY_ID, BOUND_ENTITY_TYPE, CFB_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'enforcing uniticy on the custom field values and denormalized field values - 
          if later on there are more double insert let it fail fast', NOW(), 'Add Unique Constraint (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.14.1.xml', 'tm-1.14.1-issue-6340-3', '2.0.5', '3:0f662c7dbe45ee5f2f8c55e544cdfc2a', 359);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0::jthebault::(Checksum: 3:491b8b7cb413e48bffcb92dc9104f1ce)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.15.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0', '2.0.5', '3:491b8b7cb413e48bffcb92dc9104f1ce', 360);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-feature-6365::jthebault::(Checksum: 3:f4b28600fd2a783b6589696a146d2f5e)
-- column for numeric cufs
ALTER TABLE CUSTOM_FIELD ADD NUMERIC_DEFAULT_VALUE DECIMAL(20,5);

COMMENT ON COLUMN CUSTOM_FIELD.NUMERIC_DEFAULT_VALUE IS 'a column to persist numeric cuf';

ALTER TABLE CUSTOM_FIELD_VALUE ADD NUMERIC_VALUE DECIMAL(20,5);

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.NUMERIC_VALUE IS 'a column to persist numeric cuf';

ALTER TABLE DENORMALIZED_FIELD_VALUE ADD NUMERIC_VALUE DECIMAL(20,5);

COMMENT ON COLUMN DENORMALIZED_FIELD_VALUE.NUMERIC_VALUE IS 'a column to persist denormalized numeric cuf';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'column for numeric cufs', NOW(), 'Add Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-feature-6365', '2.0.5', '3:f4b28600fd2a783b6589696a146d2f5e', 361);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-cuf-custom-report-1::jthebault::(Checksum: 3:d19c45da1f21f1cd26ebc1211d464884)
-- Denormalize the cuf ID inside the cuf values, so we don't have to make two more joins in custom reports
CREATE TABLE TEMP_CUF_ID (CFV_ID BIGINT, CF_ID BIGINT);

CREATE INDEX idx_tmp_cuf_cuf_id ON TEMP_CUF_ID(CF_ID);

CREATE INDEX idx_tmp_cuf_cfv_id ON TEMP_CUF_ID(CFV_ID);

ALTER TABLE CUSTOM_FIELD_VALUE ADD CF_ID BIGINT;

COMMENT ON COLUMN CUSTOM_FIELD_VALUE.CF_ID IS 'dernomalize the custom field id for custom report queries';

CREATE INDEX idx_cfv_custom_field_id ON CUSTOM_FIELD_VALUE(CF_ID);

insert into TEMP_CUF_ID (CFV_ID,CF_ID)
        select cfv.CFV_ID, cfb.CF_ID
        from CUSTOM_FIELD_VALUE cfv
        join CUSTOM_FIELD_BINDING cfb on cfv.CFB_ID = cfb.CFB_ID;

update CUSTOM_FIELD_VALUE
      set CF_ID = (
        select TEMP_CUF_ID.CF_ID
        from TEMP_CUF_ID
        where TEMP_CUF_ID.CFV_ID = CUSTOM_FIELD_VALUE.CFV_ID
      );

DROP TABLE TEMP_CUF_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Denormalize the cuf ID inside the cuf values, so we don''t have to make two more joins in custom reports', NOW(), 'Create Table, Create Index (x2), Add Column, Create Index, Custom SQL, Drop Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-cuf-custom-report-1', '2.0.5', '3:d19c45da1f21f1cd26ebc1211d464884', 362);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-cuf-custom-report-2::jthebault::(Checksum: 3:b69a3b17b516ce363a8e562380f16664)
-- columns prototypes for custom fields bound to execution.
insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (95,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_TEXT', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'STRING', 'value', null),
      (96,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_CHECKBOX', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'BOOLEAN_AS_STRING', 'value', null),
      (97,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_LIST', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'LIST', 'value', null),
      (98,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_DATE', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'DATE_AS_STRING', 'value', null),
      (99,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_TAG', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'TAG', 'value', null),
      (100,'CUF', TRUE, 'REQUIREMENT_VERSION_CUF_NUMERIC', 'REQUIREMENT_VERSION', 'CUSTOM_FIELD', 'NUMERIC', 'value', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
      values
      (95, 'MEASURE'), (95, 'AXIS'), (95, 'FILTER'),
      (96, 'MEASURE'), (96, 'AXIS'), (96, 'FILTER'),
      (97, 'MEASURE'), (97, 'AXIS'), (97, 'FILTER'),
      (98, 'MEASURE'), (98, 'AXIS'), (98, 'FILTER'),
      (99, 'MEASURE'), (99, 'AXIS'), (99, 'FILTER'),
      (100, 'MEASURE'), (100, 'AXIS'), (100, 'FILTER');

insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (101,'CUF', TRUE, 'TEST_CASE_CUF_TEXT', 'TEST_CASE', 'CUSTOM_FIELD', 'STRING', 'value', null),
      (102,'CUF', TRUE, 'TEST_CASE_CUF_CHECKBOX', 'TEST_CASE', 'CUSTOM_FIELD', 'BOOLEAN_AS_STRING', 'value', null),
      (103,'CUF', TRUE, 'TEST_CASE_CUF_LIST', 'TEST_CASE', 'CUSTOM_FIELD', 'LIST', 'value', null),
      (104,'CUF', TRUE, 'TEST_CASE_CUF_DATE', 'TEST_CASE', 'CUSTOM_FIELD', 'DATE_AS_STRING', 'value', null),
      (105,'CUF', TRUE, 'TEST_CASE_CUF_TAG', 'TEST_CASE', 'CUSTOM_FIELD', 'TAG', 'value', null),
      (106,'CUF', TRUE, 'TEST_CASE_CUF_NUMERIC', 'TEST_CASE', 'CUSTOM_FIELD', 'NUMERIC', 'value', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
      values
      (101, 'MEASURE'), (101, 'AXIS'), (101, 'FILTER'),
      (102, 'MEASURE'), (102, 'AXIS'), (102, 'FILTER'),
      (103, 'MEASURE'), (103, 'AXIS'), (103, 'FILTER'),
      (104, 'MEASURE'), (104, 'AXIS'), (104, 'FILTER'),
      (105, 'MEASURE'), (105, 'AXIS'), (105, 'FILTER'),
      (106, 'MEASURE'), (106, 'AXIS'), (106, 'FILTER');

insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (107,'CUF', TRUE, 'CAMPAIGN_CUF_TEXT', 'CAMPAIGN', 'CUSTOM_FIELD', 'STRING', 'value', null),
      (108,'CUF', TRUE, 'CAMPAIGN_CUF_CHECKBOX', 'CAMPAIGN', 'CUSTOM_FIELD', 'BOOLEAN_AS_STRING', 'value', null),
      (109,'CUF', TRUE, 'CAMPAIGN_CUF_LIST', 'CAMPAIGN', 'CUSTOM_FIELD', 'LIST', 'value', null),
      (110,'CUF', TRUE, 'CAMPAIGN_CUF_DATE', 'CAMPAIGN', 'CUSTOM_FIELD', 'DATE_AS_STRING', 'value', null),
      (111,'CUF', TRUE, 'CAMPAIGN_CUF_TAG', 'CAMPAIGN', 'CUSTOM_FIELD', 'TAG', 'value', null),
      (112,'CUF', TRUE, 'CAMPAIGN_CUF_NUMERIC', 'CAMPAIGN', 'CUSTOM_FIELD', 'NUMERIC', 'value', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
      values
      (107, 'MEASURE'), (107, 'AXIS'), (107, 'FILTER'),
      (108, 'MEASURE'), (108, 'AXIS'), (108, 'FILTER'),
      (109, 'MEASURE'), (109, 'AXIS'), (109, 'FILTER'),
      (110, 'MEASURE'), (110, 'AXIS'), (110, 'FILTER'),
      (111, 'MEASURE'), (111, 'AXIS'), (111, 'FILTER'),
      (112, 'MEASURE'), (112, 'AXIS'), (112, 'FILTER');

insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (113,'CUF', TRUE, 'ITERATION_CUF_TEXT', 'ITERATION', 'CUSTOM_FIELD', 'STRING', 'value', null),
      (114,'CUF', TRUE, 'ITERATION_CUF_CHECKBOX', 'ITERATION', 'CUSTOM_FIELD', 'BOOLEAN_AS_STRING', 'value', null),
      (115,'CUF', TRUE, 'ITERATION_CUF_LIST', 'ITERATION', 'CUSTOM_FIELD', 'LIST', 'value', null),
      (116,'CUF', TRUE, 'ITERATION_CUF_DATE', 'ITERATION', 'CUSTOM_FIELD', 'DATE_AS_STRING', 'value', null),
      (117,'CUF', TRUE, 'ITERATION_CUF_TAG', 'ITERATION', 'CUSTOM_FIELD', 'TAG', 'value', null),
      (118,'CUF', TRUE, 'ITERATION_CUF_NUMERIC', 'ITERATION', 'CUSTOM_FIELD', 'NUMERIC', 'value', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
      values
      (113, 'MEASURE'), (113, 'AXIS'), (113, 'FILTER'),
      (114, 'MEASURE'), (114, 'AXIS'), (114, 'FILTER'),
      (115, 'MEASURE'), (115, 'AXIS'), (115, 'FILTER'),
      (116, 'MEASURE'), (116, 'AXIS'), (116, 'FILTER'),
      (117, 'MEASURE'), (117, 'AXIS'), (117, 'FILTER'),
      (118, 'MEASURE'), (118, 'AXIS'), (118, 'FILTER');

insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (119,'CUF', TRUE, 'EXECUTION_CUF_TEXT', 'EXECUTION', 'CUSTOM_FIELD', 'STRING', 'value', null),
      (120,'CUF', TRUE, 'EXECUTION_CUF_CHECKBOX', 'EXECUTION', 'CUSTOM_FIELD', 'BOOLEAN_AS_STRING', 'value', null),
      (121,'CUF', TRUE, 'EXECUTION_CUF_LIST', 'EXECUTION', 'CUSTOM_FIELD', 'LIST', 'value', null),
      (122,'CUF', TRUE, 'EXECUTION_CUF_DATE', 'EXECUTION', 'CUSTOM_FIELD', 'DATE_AS_STRING', 'value', null),
      (123,'CUF', TRUE, 'EXECUTION_CUF_TAG', 'EXECUTION', 'CUSTOM_FIELD', 'TAG', 'value', null),
      (124,'CUF', TRUE, 'EXECUTION_CUF_NUMERIC', 'EXECUTION', 'CUSTOM_FIELD', 'NUMERIC', 'value', null);

insert into CHART_COLUMN_ROLE(CHART_COLUMN_ID, ROLE)
      values
      (119, 'MEASURE'), (119, 'AXIS'), (119, 'FILTER'),
      (120, 'MEASURE'), (120, 'AXIS'), (120, 'FILTER'),
      (121, 'MEASURE'), (121, 'AXIS'), (121, 'FILTER'),
      (122, 'MEASURE'), (122, 'AXIS'), (122, 'FILTER'),
      (123, 'MEASURE'), (123, 'AXIS'), (123, 'FILTER'),
      (124, 'MEASURE'), (124, 'AXIS'), (124, 'FILTER');

ALTER TABLE CHART_MEASURE_COLUMN ADD CUF_ID BIGINT;

COMMENT ON COLUMN CHART_MEASURE_COLUMN.CUF_ID IS 'a column to persist cuf id relative to this measure';

ALTER TABLE CHART_AXIS_COLUMN ADD CUF_ID BIGINT;

COMMENT ON COLUMN CHART_AXIS_COLUMN.CUF_ID IS 'a column to persist cuf id relative to this axis';

ALTER TABLE CHART_FILTER ADD CUF_ID BIGINT;

COMMENT ON COLUMN CHART_FILTER.CUF_ID IS 'a column to persist cuf id relative to this filter';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'columns prototypes for custom fields bound to execution.', NOW(), 'Custom SQL (x10), Add Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-cuf-custom-report-2', '2.0.5', '3:b69a3b17b516ce363a8e562380f16664', 363);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-feat-5417::jthebault::(Checksum: 3:eb7d59c34555f8f8a4aaa25dfdda5091)
ALTER TABLE CHART_DEFINITION ADD SCOPE_TYPE VARCHAR(20);

COMMENT ON COLUMN CHART_DEFINITION.SCOPE_TYPE IS 'a column to persist the scope type';

update CHART_DEFINITION
      set SCOPE_TYPE = 'PROJECTS'
      where CHART_ID in
      (select CHART_ID from CHART_SCOPE where ENTITY_REFERENCE_TYPE like 'PROJECT');

update CHART_DEFINITION
      set SCOPE_TYPE = 'CUSTOM'
      where SCOPE_TYPE IS NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Add Column, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-feat-5417', '2.0.5', '3:eb7d59c34555f8f8a4aaa25dfdda5091', 364);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-feat-5417-2::jthebault::(Checksum: 3:b302c88e1251e2a3ccf4a50c0c4ed15c)
update PARTY_PREFERENCE
      set PREFERENCE_VALUE = 'default'
      where PREFERENCE_VALUE = 'message' and PREFERENCE_KEY = 'squash.core.home.content';

update PARTY_PREFERENCE
      set PREFERENCE_KEY = 'squash.core.dashboard.content.home'
      where PREFERENCE_KEY = 'squash.core.home.content';

update PARTY_PREFERENCE
      set PREFERENCE_KEY = 'squash.core.favorite.dashboard.home'
      where PREFERENCE_KEY = 'squash.core.favorite.dashboard';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-feat-5417-2', '2.0.5', '3:b302c88e1251e2a3ccf4a50c0c4ed15c', 365);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml::tm-1.15.0-feat-5417-3::jthebault::(Checksum: 3:f9a41fbfcfe55bba82018583a5552582)
insert into CHART_COLUMN_PROTOTYPE(CHART_COLUMN_ID,COLUMN_TYPE, BUSINESS, LABEL, ENTITY_TYPE, ENTITY_ROLE, DATA_TYPE, ATTRIBUTE_NAME, SUBQUERY_ID)
      values
      (125,'ATTRIBUTE', FALSE, 'CAMPAIGN_MILESTONE_ID', 'MILESTONE', 'CAMPAIGN_MILESTONE', 'NUMERIC', 'id', null);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.15.0.xml', 'tm-1.15.0-feat-5417-3', '2.0.5', '3:f9a41fbfcfe55bba82018583a5552582', 366);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml::tm-1.16.0::jprioux::(Checksum: 3:975a078e1c0967a9ce1adf42f328e04b)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.16.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml', 'tm-1.16.0', '2.0.5', '3:975a078e1c0967a9ce1adf42f328e04b', 367);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml::tm-1.16.0-feature-6763::jprioux::(Checksum: 3:a839f67f0e2cf6a0b463d183582114ad)
-- column for last connected on
ALTER TABLE CORE_USER ADD LAST_CONNECTED_ON TIMESTAMP WITH TIME ZONE;

COMMENT ON COLUMN CORE_USER.LAST_CONNECTED_ON IS 'a column to persist the last connection date';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'column for last connected on', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml', 'tm-1.16.0-feature-6763', '2.0.5', '3:a839f67f0e2cf6a0b463d183582114ad', 368);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml::tm-1.16.0-feature-6799::jlor::(Checksum: 3:78f26ca715837f5976eb2d37bd9494fb)
CREATE TABLE REQUIREMENT_VERSION_LINK_TYPE (TYPE_ID bigserial NOT NULL, ROLE_1 VARCHAR(50), ROLE_1_CODE VARCHAR(30), ROLE_2 VARCHAR(50), ROLE_2_CODE VARCHAR(30), IS_DEFAULT BOOLEAN DEFAULT FALSE NOT NULL, CONSTRAINT PK_REQUIREMENT_VERSION_LINK_TYPE PRIMARY KEY (TYPE_ID));

COMMENT ON COLUMN REQUIREMENT_VERSION_LINK_TYPE.IS_DEFAULT IS 'Only one item per list should have it true';

CREATE TABLE REQUIREMENT_VERSION_LINK (LINK_ID bigserial NOT NULL, LINK_TYPE_ID BIGINT NOT NULL, LINK_DIRECTION BOOLEAN DEFAULT FALSE NOT NULL, REQUIREMENT_VERSION_ID BIGINT NOT NULL, RELATED_REQUIREMENT_VERSION_ID BIGINT NOT NULL, CONSTRAINT PK_REQUIREMENT_VERSION_LINK PRIMARY KEY (LINK_ID), CONSTRAINT fk_req_version_link_req_version_link_type_link_type_id FOREIGN KEY (LINK_TYPE_ID) REFERENCES REQUIREMENT_VERSION_LINK_TYPE(TYPE_ID), CONSTRAINT fk_requirement_version_link_related_requirement_version_id FOREIGN KEY (RELATED_REQUIREMENT_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID), CONSTRAINT fk_requirement_version_link_requirement_version_id FOREIGN KEY (REQUIREMENT_VERSION_ID) REFERENCES REQUIREMENT_VERSION(RES_ID));

COMMENT ON COLUMN REQUIREMENT_VERSION_LINK.LINK_TYPE_ID IS 'foreign key to the requirement_version_link_type table';

COMMENT ON COLUMN REQUIREMENT_VERSION_LINK.REQUIREMENT_VERSION_ID IS 'foreign key for requirement version to requirement_version table';

COMMENT ON COLUMN REQUIREMENT_VERSION_LINK.RELATED_REQUIREMENT_VERSION_ID IS 'foreign key for related requirement version to requirement_version table';

INSERT INTO REQUIREMENT_VERSION_LINK_TYPE (IS_DEFAULT, ROLE_1, ROLE_1_CODE, ROLE_2, ROLE_2_CODE) VALUES (TRUE, 'requirement-version.link.type.related', 'RELATED', 'requirement-version.link.type.related', 'RELATED');

INSERT INTO REQUIREMENT_VERSION_LINK_TYPE (IS_DEFAULT, ROLE_1, ROLE_1_CODE, ROLE_2, ROLE_2_CODE) VALUES (FALSE, 'requirement-version.link.type.parent', 'PARENT', 'requirement-version.link.type.child', 'CHILD');

INSERT INTO REQUIREMENT_VERSION_LINK_TYPE (IS_DEFAULT, ROLE_1, ROLE_1_CODE, ROLE_2, ROLE_2_CODE) VALUES (FALSE, 'requirement-version.link.type.duplicate', 'DUPLICATE', 'requirement-version.link.type.duplicate', 'DUPLICATE');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', '', NOW(), 'Create Table (x2), Insert Row (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.16.0.xml', 'tm-1.16.0-feature-6799', '2.0.5', '3:78f26ca715837f5976eb2d37bd9494fb', 369);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0::jthebault::(Checksum: 3:0c43f78c001b54232be6fb7d5aa1169e)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.17.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0', '2.0.5', '3:0c43f78c001b54232be6fb7d5aa1169e', 370);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-feature-6921::zyang::(Checksum: 3:d9f5ee0070ebbd5f0d2a702f2b90d274)
-- Adds a status field to campaign and iteration
ALTER TABLE CAMPAIGN ADD CAMPAIGN_STATUS VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

ALTER TABLE ITERATION ADD ITERATION_STATUS VARCHAR(30) NOT NULL DEFAULT 'UNDEFINED';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('zyang', 'Adds a status field to campaign and iteration', NOW(), 'Add Column (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-feature-6921', '2.0.5', '3:d9f5ee0070ebbd5f0d2a702f2b90d274', 371);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0::zyang::(Checksum: 3:855bbf520bbd7b0b22e94edcf382656a)
CREATE TABLE REPORT_DEFINITION (REPORT_ID bigserial NOT NULL, NAME VARCHAR(255), DESCRIPTION TEXT, PLUGIN_NAMESPACE VARCHAR(255), PARAMETERS TEXT, USER_ID BIGINT NOT NULL, PROJECT_ID BIGINT NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_REPORT_DEFINITION PRIMARY KEY (REPORT_ID), CONSTRAINT fk_project_report_definition_project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_report_owner FOREIGN KEY (USER_ID) REFERENCES CORE_USER(PARTY_ID));

COMMENT ON COLUMN REPORT_DEFINITION.REPORT_ID IS 'autogenerated ID';

COMMENT ON COLUMN REPORT_DEFINITION.NAME IS 'The name of this chart';

COMMENT ON COLUMN REPORT_DEFINITION.DESCRIPTION IS 'additional informations about this report';

COMMENT ON COLUMN REPORT_DEFINITION.PLUGIN_NAMESPACE IS 'The namespace of the report plugin';

COMMENT ON COLUMN REPORT_DEFINITION.PARAMETERS IS 'parameters to generate the report';

COMMENT ON COLUMN REPORT_DEFINITION.USER_ID IS 'foreign key to the owner of this report definition';

COMMENT ON COLUMN REPORT_DEFINITION.PROJECT_ID IS 'foreign key to the projet';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('zyang', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0', '2.0.5', '3:855bbf520bbd7b0b22e94edcf382656a', 372);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-feature-6921::cholc::(Checksum: 3:2ed5996d28258aaa745f8c90b2966702)
-- Adds a execution status field to the test suites
ALTER TABLE TEST_SUITE ADD EXECUTION_STATUS VARCHAR(255) DEFAULT 'READY';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'Adds a execution status field to the test suites', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-feature-6921', '2.0.5', '3:2ed5996d28258aaa745f8c90b2966702', 373);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-feature-sqtm-167::bsiri::(Checksum: 3:7a1442f1f4141a444ad8136edfbff065)
-- Adding the ability to use application-level credentials that allows Squash interact with a bugtracker on its own
--       (ie instead of requiring the current user to authenticate).
CREATE TABLE STORED_CREDENTIALS (CREDENTIAL_ID bigserial NOT NULL, ENC_VERSION SMALLINT, ENC_CREDENTIALS TEXT, AUTHENTICATED_SERVER BIGINT, CONSTRAINT PK_STORED_CREDENTIALS PRIMARY KEY (CREDENTIAL_ID), CONSTRAINT fk_stored_credentials_authenticated_server FOREIGN KEY (AUTHENTICATED_SERVER) REFERENCES BUGTRACKER(BUGTRACKER_ID) ON DELETE CASCADE);

COMMENT ON COLUMN STORED_CREDENTIALS.CREDENTIAL_ID IS 'primary key';

COMMENT ON COLUMN STORED_CREDENTIALS.ENC_VERSION IS 'the version of encryption service used. Possibly the value will remain to 1 forever.';

COMMENT ON COLUMN STORED_CREDENTIALS.ENC_CREDENTIALS IS 'the credentials as an encrypted string';

COMMENT ON COLUMN STORED_CREDENTIALS.AUTHENTICATED_SERVER IS 'foreign key to the server to authenticate';

ALTER TABLE BUGTRACKER ADD AUTH_POLICY VARCHAR(30) DEFAULT 'USER';

COMMENT ON COLUMN BUGTRACKER.AUTH_POLICY IS 'the policy that decides who needs to authenticate';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Adding the ability to use application-level credentials that allows Squash interact with a bugtracker on its own
      (ie instead of requiring the current user to authenticate).', NOW(), 'Create Table, Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-feature-sqtm-167', '2.0.5', '3:7a1442f1f4141a444ad8136edfbff065', 374);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-jira-sync-01::jthebault::(Checksum: 3:1dc00e1430aa55d44450f5f234cca0cc)
-- Add a remote synchronisation table in squash tm.
CREATE TABLE REMOTE_SYNCHRONISATION (REMOTE_SYNCHRONISATION_ID bigserial NOT NULL, PROJECT_ID BIGINT NOT NULL, SERVER_ID BIGINT NOT NULL, REMOTE_SYNCHRONISATION_NAME VARCHAR(255) NOT NULL, KIND VARCHAR(50) NOT NULL, REMOTE_SELECT_TYPE VARCHAR(50), REMOTE_SELECT_VALUE VARCHAR(1000), LAST_SUCCESSFUL_SYNC_DATE TIMESTAMP WITH TIME ZONE, LAST_SYNC_DATE TIMESTAMP WITH TIME ZONE, LAST_SYNC_STATUS VARCHAR(20), SYNC_STATUS VARCHAR(20), REMOTE_SYNCHRONISATION_OPTIONS TEXT, CONSTRAINT PK_REMOTE_SYNCHRONISATION PRIMARY KEY (REMOTE_SYNCHRONISATION_ID), CONSTRAINT fk_remote_sync__project__project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID), CONSTRAINT fk_remote_sync__bugtracker__bugtracker_id FOREIGN KEY (SERVER_ID) REFERENCES BUGTRACKER(BUGTRACKER_ID));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Add a remote synchronisation table in squash tm.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-jira-sync-01', '2.0.5', '3:1dc00e1430aa55d44450f5f234cca0cc', 375);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-jira-sync-02::jthebault::(Checksum: 3:52aadd9c26924da0405ef10ffddbc6af)
-- Add a remote folder synchronisation table in squash tm.
CREATE TABLE REQUIREMENT_FOLDER_SYNC_EXTENDER (RF_SYNC_EXTENDER_ID bigserial NOT NULL, REMOTE_SYNCHRONISATION_ID BIGINT NOT NULL, REMOTE_FOLDER_ID VARCHAR(255), REMOTE_FOLDER_STATUS VARCHAR(50), REQUIREMENT_FOLDER_ID BIGINT NOT NULL, TYPE VARCHAR(30) NOT NULL, CONSTRAINT PK_REQUIREMENT_FOLDER_SYNC_EXTENDER PRIMARY KEY (RF_SYNC_EXTENDER_ID), CONSTRAINT fk_req_folder_sync_extender__remote_sync_remote_sync_id FOREIGN KEY (REMOTE_SYNCHRONISATION_ID) REFERENCES REMOTE_SYNCHRONISATION(REMOTE_SYNCHRONISATION_ID), CONSTRAINT fk_req_folder_sync_extender__req_folder__rln_id FOREIGN KEY (REQUIREMENT_FOLDER_ID) REFERENCES REQUIREMENT_FOLDER(RLN_ID), UNIQUE (REQUIREMENT_FOLDER_ID));

COMMENT ON COLUMN REQUIREMENT_FOLDER_SYNC_EXTENDER.REMOTE_SYNCHRONISATION_ID IS 'Only one master folder should be targeted by a given synchronisation';

COMMENT ON COLUMN REQUIREMENT_FOLDER_SYNC_EXTENDER.REQUIREMENT_FOLDER_ID IS 'Only one extender for any folder in Squash TM';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Add a remote folder synchronisation table in squash tm.', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-jira-sync-02', '2.0.5', '3:52aadd9c26924da0405ef10ffddbc6af', 376);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-jira-sync-03::jthebault::(Checksum: 3:8a68ee95a2fb1a2575e7a2e9b3571eed)
ALTER TABLE REQUIREMENT_SYNC_EXTENDER ALTER COLUMN  REMOTE_FILTER_NAME DROP NOT NULL;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD REMOTE_SYNCHRONISATION_ID BIGINT;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD CONSTRAINT fk_req_sync_extender__remote_sync_remote_sync_id FOREIGN KEY (REMOTE_SYNCHRONISATION_ID) REFERENCES REMOTE_SYNCHRONISATION (REMOTE_SYNCHRONISATION_ID);

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD REMOTE_LAST_UPDATED TIMESTAMP WITH TIME ZONE;

ALTER TABLE REQUIREMENT_SYNC_EXTENDER ADD REMOTE_PARENT_ID VARCHAR(30);

CREATE INDEX req_sync_extender_remote_parent_id_idx ON REQUIREMENT_SYNC_EXTENDER(REMOTE_PARENT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Drop Not-Null Constraint, Add Column, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-jira-sync-03', '2.0.5', '3:8a68ee95a2fb1a2575e7a2e9b3571eed', 377);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml::tm-1.17.0-Issue-6967::jthebault::(Checksum: 3:5a27c86957398164065ff12fb0bfee1e)
CREATE INDEX tcln_name_idx ON TEST_CASE_LIBRARY_NODE(NAME);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.17.0.xml', 'tm-1.17.0-Issue-6967', '2.0.5', '3:5a27c86957398164065ff12fb0bfee1e', 378);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0::jthebault::(Checksum: 3:47ac35d6939b1e4c9d90e0ba418a4c9b)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.18.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0', '2.0.5', '3:47ac35d6939b1e4c9d90e0ba418a4c9b', 379);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-connection-log-table::aguilhem::(Checksum: 3:3ce3084744351755dfee9d7ea37c4d88)
-- Create Connection Attempt Log Table
CREATE TABLE CONNECTION_ATTEMPT_LOG (ATTEMPT_ID bigserial NOT NULL, LOGIN VARCHAR(50), CONNECTION_DATE TIMESTAMP WITH TIME ZONE NOT NULL, SUCCESS BOOLEAN NOT NULL, CONSTRAINT PK_CONNECTION_ATTEMPT_LOG PRIMARY KEY (ATTEMPT_ID));

COMMENT ON COLUMN CONNECTION_ATTEMPT_LOG.ATTEMPT_ID IS 'autogenerated ID';

COMMENT ON COLUMN CONNECTION_ATTEMPT_LOG.LOGIN IS 'login used to connect';

COMMENT ON COLUMN CONNECTION_ATTEMPT_LOG.CONNECTION_DATE IS 'Date of connection';

COMMENT ON COLUMN CONNECTION_ATTEMPT_LOG.SUCCESS IS 'if connection succeeded or not';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aguilhem', 'Create Connection Attempt Log Table', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-connection-log-table', '2.0.5', '3:3ce3084744351755dfee9d7ea37c4d88', 380);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-project-template-link::jlor::(Checksum: 3:d00607ab01c06922cbb7ce367e162848)
-- Adding a column to keep the link between a Project and a Project Template
ALTER TABLE PROJECT ADD TEMPLATE_ID BIGINT;

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_template_id FOREIGN KEY (TEMPLATE_ID) REFERENCES PROJECT (PROJECT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Adding a column to keep the link between a Project and a Project Template', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-project-template-link', '2.0.5', '3:d00607ab01c06922cbb7ce367e162848', 381);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-feature-7183.1-postgresql::jprioux::(Checksum: 3:72c9edb3f113d1af5c8ba307a971e0ec)
-- postgresql - add unique constraint for ordered list : test case steps
drop table if exists TEST_CASE_STEPS_TMP;

create table TEST_CASE_STEPS_TMP AS
                    (select TEST_CASE_ID, STEP_ID, min(STEP_ORDER) STEP_ORDER
                       from TEST_CASE_STEPS
                   group by TEST_CASE_ID, STEP_ID);

create index idx1 on TEST_CASE_STEPS_TMP(TEST_CASE_ID,STEP_ID);

update TEST_CASE_STEPS_TMP t1
           set STEP_ORDER = t2.ligne - 1
          from (select TEST_CASE_ID, STEP_ID, (select count(*)
                                                 from TEST_CASE_STEPS_TMP b
                                                where a.TEST_CASE_ID = b.TEST_CASE_ID
                                                  and a.STEP_ORDER >= b.STEP_ORDER) ligne
                  from TEST_CASE_STEPS_TMP a) t2
         where t1.TEST_CASE_ID = t2.TEST_CASE_ID and t1.STEP_ID = t2.STEP_ID;

truncate table TEST_CASE_STEPS;

insert into TEST_CASE_STEPS
        select a.TEST_CASE_ID, a.STEP_ID,
               a.STEP_ORDER + 1 - (select count(*) from TEST_CASE_STEPS_TMP b
                                where a.TEST_CASE_ID = b.TEST_CASE_ID
                                  and a.STEP_ORDER = b.STEP_ORDER
                                  and a.STEP_ID <= b.STEP_ID
                             group by b.TEST_CASE_ID, b.STEP_ORDER) STEP_ORDER
          from TEST_CASE_STEPS_TMP a;

drop table TEST_CASE_STEPS_TMP;

ALTER TABLE TEST_CASE_STEPS ADD CONSTRAINT uc_test_case_steps_order UNIQUE (TEST_CASE_ID, STEP_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'postgresql - add unique constraint for ordered list : test case steps', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-feature-7183.1-postgresql', '2.0.5', '3:72c9edb3f113d1af5c8ba307a971e0ec', 382);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-feature-7183.2-postgresql::jprioux::(Checksum: 3:8ebce11e8bd73f63a67a1a27bfdad6d2)
-- postgresql - add unique constraint for ordered list : tcs in iteration
drop table if exists ITEM_TEST_PLAN_LIST_TMP;

create table ITEM_TEST_PLAN_LIST_TMP AS
                    (select ITERATION_ID, ITEM_TEST_PLAN_ID, min(ITEM_TEST_PLAN_ORDER) ITEM_TEST_PLAN_ORDER
                       from ITEM_TEST_PLAN_LIST
                   group by ITERATION_ID, ITEM_TEST_PLAN_ID);

create index idx2 on ITEM_TEST_PLAN_LIST_TMP(ITERATION_ID, ITEM_TEST_PLAN_ID);

update ITEM_TEST_PLAN_LIST_TMP t1
        set ITEM_TEST_PLAN_ORDER = t2.ligne - 1
        from (select ITERATION_ID, ITEM_TEST_PLAN_ID, (select count(*)
                                     from ITEM_TEST_PLAN_LIST_TMP b
                                    where a.ITERATION_ID = b.ITERATION_ID
                                      and a.ITEM_TEST_PLAN_ORDER >= b.ITEM_TEST_PLAN_ORDER) ligne
                 from ITEM_TEST_PLAN_LIST_TMP a) t2
         where t1.ITERATION_ID = t2.ITERATION_ID and t1.ITEM_TEST_PLAN_ID = t2.ITEM_TEST_PLAN_ID;

truncate table ITEM_TEST_PLAN_LIST;

insert into ITEM_TEST_PLAN_LIST
        select a.ITERATION_ID, a.ITEM_TEST_PLAN_ID,
               a.ITEM_TEST_PLAN_ORDER + 1 - (select count(*) from ITEM_TEST_PLAN_LIST_TMP b
                                where a.ITERATION_ID = b.ITERATION_ID
                                  and a.ITEM_TEST_PLAN_ORDER = b.ITEM_TEST_PLAN_ORDER
                                  and a.ITEM_TEST_PLAN_ID <= b.ITEM_TEST_PLAN_ID
                             group by b.ITERATION_ID, b.ITEM_TEST_PLAN_ORDER) ITEM_TEST_PLAN_ORDER
          from ITEM_TEST_PLAN_LIST_TMP a;

drop table ITEM_TEST_PLAN_LIST_TMP;

ALTER TABLE ITEM_TEST_PLAN_LIST ADD CONSTRAINT uc_item_test_plan_list_order UNIQUE (ITERATION_ID, ITEM_TEST_PLAN_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'postgresql - add unique constraint for ordered list : tcs in iteration', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-feature-7183.2-postgresql', '2.0.5', '3:8ebce11e8bd73f63a67a1a27bfdad6d2', 383);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-feature-7183.3-postgresql::jprioux::(Checksum: 3:2813f1cb15f6c2f230fa5cc4d782f283)
-- postgresql - add unique constraint for ordered list : tcs in test suite
drop table if exists TEST_SUITE_TEST_PLAN_ITEM_TMP;

create table TEST_SUITE_TEST_PLAN_ITEM_TMP AS
                    (select SUITE_ID, TPI_ID, min(TEST_PLAN_ORDER) TEST_PLAN_ORDER
                       from TEST_SUITE_TEST_PLAN_ITEM
                   group by SUITE_ID, TPI_ID);

create index idx2 on TEST_SUITE_TEST_PLAN_ITEM_TMP(SUITE_ID, TPI_ID);

update TEST_SUITE_TEST_PLAN_ITEM_TMP t1
        set TEST_PLAN_ORDER = t2.ligne - 1
        from (select SUITE_ID, TPI_ID, (select count(*)
                                     from TEST_SUITE_TEST_PLAN_ITEM_TMP b
                                    where a.SUITE_ID = b.SUITE_ID
                                      and a.TEST_PLAN_ORDER >= b.TEST_PLAN_ORDER) ligne
                 from TEST_SUITE_TEST_PLAN_ITEM_TMP a) t2
         where t1.SUITE_ID = t2.SUITE_ID and t1.TPI_ID = t2.TPI_ID;

truncate table TEST_SUITE_TEST_PLAN_ITEM;

insert into TEST_SUITE_TEST_PLAN_ITEM
        select a.TPI_ID, a.SUITE_ID,
               a.TEST_PLAN_ORDER + 1 - (select count(*) from TEST_SUITE_TEST_PLAN_ITEM_TMP b
                                where a.SUITE_ID = b.SUITE_ID
                                  and a.TEST_PLAN_ORDER = b.TEST_PLAN_ORDER
                                  and a.TPI_ID <= b.TPI_ID
                             group by b.SUITE_ID, b.TEST_PLAN_ORDER) TEST_PLAN_ORDER
          from TEST_SUITE_TEST_PLAN_ITEM_TMP a;

drop table TEST_SUITE_TEST_PLAN_ITEM_TMP;

ALTER TABLE TEST_SUITE_TEST_PLAN_ITEM ADD CONSTRAINT uc_test_suite_test_plan_item_order UNIQUE (SUITE_ID, TEST_PLAN_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'postgresql - add unique constraint for ordered list : tcs in test suite', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-feature-7183.3-postgresql', '2.0.5', '3:2813f1cb15f6c2f230fa5cc4d782f283', 384);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-feature-7183.4-postgresql::jprioux::(Checksum: 3:c6fca95ec82aa1f6612fb4b44b23fc8d)
-- postgresql - add unique constraint for ordered list : tcs in campaign
drop table if exists CAMPAIGN_TEST_PLAN_ITEM_TMP;

create table CAMPAIGN_TEST_PLAN_ITEM_TMP AS
                    (select CTPI_ID, CAMPAIGN_ID, TEST_CASE_ID, USER_ID, min(TEST_PLAN_ORDER) TEST_PLAN_ORDER, DATASET_ID
                       from CAMPAIGN_TEST_PLAN_ITEM
                   group by CAMPAIGN_ID, CTPI_ID);

create index idx2 on CAMPAIGN_TEST_PLAN_ITEM_TMP(CAMPAIGN_ID, CTPI_ID);

update CAMPAIGN_TEST_PLAN_ITEM_TMP t1
           set TEST_PLAN_ORDER = t2.ligne - 1
          from (select CTPI_ID, CAMPAIGN_ID, TEST_CASE_ID, USER_ID, (select count(*)
                                     from CAMPAIGN_TEST_PLAN_ITEM_TMP b
                                    where a.CAMPAIGN_ID = b.CAMPAIGN_ID
                                      and a.TEST_PLAN_ORDER >= b.TEST_PLAN_ORDER) ligne, DATASET_ID
                 from CAMPAIGN_TEST_PLAN_ITEM_TMP a) t2
         where t1.CAMPAIGN_ID = t2.CAMPAIGN_ID and t1.CTPI_ID = t2.CTPI_ID;

truncate table CAMPAIGN_TEST_PLAN_ITEM;

insert into CAMPAIGN_TEST_PLAN_ITEM
        select a.CTPI_ID, a.CAMPAIGN_ID, a.TEST_CASE_ID, a.USER_ID,
               a.TEST_PLAN_ORDER + 1 - (select count(*) from CAMPAIGN_TEST_PLAN_ITEM_TMP b
                                where a.CAMPAIGN_ID = b.CAMPAIGN_ID
                                  and a.TEST_PLAN_ORDER = b.TEST_PLAN_ORDER
                                  and a.CTPI_ID <= b.CTPI_ID
                             group by b.CAMPAIGN_ID, b.TEST_PLAN_ORDER) TEST_PLAN_ORDER, a.DATASET_ID
          from CAMPAIGN_TEST_PLAN_ITEM_TMP a;

drop table CAMPAIGN_TEST_PLAN_ITEM_TMP;

ALTER TABLE CAMPAIGN_TEST_PLAN_ITEM ADD CONSTRAINT uc_campaign_test_plan_item_order UNIQUE (CAMPAIGN_ID, TEST_PLAN_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'postgresql - add unique constraint for ordered list : tcs in campaign', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-feature-7183.4-postgresql', '2.0.5', '3:c6fca95ec82aa1f6612fb4b44b23fc8d', 385);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-binding-report-to-dashboard::zyang::(Checksum: 3:2bd818310301c4e63ce1d8780b49c334)
CREATE TABLE CUSTOM_REPORT_REPORT_BINDING (CRRB_ID bigserial NOT NULL, CRD_ID BIGINT NOT NULL, REPORT_ID BIGINT NOT NULL, ROW INT, COL INT, SIZE_X INT, SIZE_Y INT, CONSTRAINT PK_CRRB_ID PRIMARY KEY (CRRB_ID), CONSTRAINT fk_report_bindind_custom_report_dashboard_crd_id FOREIGN KEY (CRD_ID) REFERENCES CUSTOM_REPORT_DASHBOARD(CRD_ID), CONSTRAINT fk_chart_bindind_report_definition_report_id FOREIGN KEY (REPORT_ID) REFERENCES REPORT_DEFINITION(REPORT_ID));

COMMENT ON COLUMN CUSTOM_REPORT_REPORT_BINDING.CRRB_ID IS 'pk genere';

COMMENT ON COLUMN CUSTOM_REPORT_REPORT_BINDING.CRD_ID IS 'cle etrangere vers le dashboard.';

COMMENT ON COLUMN CUSTOM_REPORT_REPORT_BINDING.REPORT_ID IS 'cle etrangere vers le report.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('zyang', '', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-binding-report-to-dashboard', '2.0.5', '3:2bd818310301c4e63ce1d8780b49c334', 386);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-scripted-test-case::jthebault::(Checksum: 3:1a7f2b2e849f647de429bbc7947f7d31)
-- Create the scripted execution table
CREATE TABLE SCRIPTED_TC_EXTENDER (SCRIPTED_TC_EXTENDER_ID bigserial NOT NULL, SCRIPT TEXT, LANGUAGE VARCHAR(50), TEST_CASE_ID BIGINT NOT NULL, CONSTRAINT PK_SCRIPTED_TC_EXTENDER PRIMARY KEY (SCRIPTED_TC_EXTENDER_ID), CONSTRAINT fk_scripted_extender_test_case FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE(TCLN_ID));

COMMENT ON COLUMN SCRIPTED_TC_EXTENDER.SCRIPTED_TC_EXTENDER_ID IS 'autogenerated ID';

COMMENT ON COLUMN SCRIPTED_TC_EXTENDER.SCRIPT IS 'the test case script';

COMMENT ON COLUMN SCRIPTED_TC_EXTENDER.LANGUAGE IS 'scriptLanguage of script';

COMMENT ON COLUMN SCRIPTED_TC_EXTENDER.TEST_CASE_ID IS 'foreign key to TEST_CASE';

CREATE INDEX scripted_tc_extender_test_case_id_idx ON SCRIPTED_TC_EXTENDER(TEST_CASE_ID);

CREATE TABLE SCRIPTED_EXECUTION_EXTENDER (SCRIPTED_EXECUTION_EXTENDER_ID bigserial NOT NULL, LANGUAGE VARCHAR(50), SCRIPT_NAME VARCHAR(255), EXECUTION_ID BIGINT NOT NULL, CONSTRAINT PK_SCRIPTED_EXECUTION_EXTENDER PRIMARY KEY (SCRIPTED_EXECUTION_EXTENDER_ID), CONSTRAINT fk_scripted_extender_execution FOREIGN KEY (EXECUTION_ID) REFERENCES EXECUTION(EXECUTION_ID));

COMMENT ON COLUMN SCRIPTED_EXECUTION_EXTENDER.SCRIPTED_EXECUTION_EXTENDER_ID IS 'autogenerated ID';

COMMENT ON COLUMN SCRIPTED_EXECUTION_EXTENDER.LANGUAGE IS 'scriptLanguage of script';

COMMENT ON COLUMN SCRIPTED_EXECUTION_EXTENDER.SCRIPT_NAME IS 'script name,by example feature name for Gherkin';

COMMENT ON COLUMN SCRIPTED_EXECUTION_EXTENDER.EXECUTION_ID IS 'foreign key to EXECUTION';

CREATE INDEX scripted_execution_extender_execution_id_idx ON SCRIPTED_EXECUTION_EXTENDER(EXECUTION_ID);

ALTER TABLE TEST_CASE ADD TC_KIND VARCHAR(30) NOT NULL DEFAULT 'STANDARD';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', 'Create the scripted execution table', NOW(), 'Create Table, Create Index, Create Table, Create Index, Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-scripted-test-case', '2.0.5', '3:1a7f2b2e849f647de429bbc7947f7d31', 387);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-modification-report::zyang::(Checksum: 3:438a13a6179b54a364f0ff2e2bb6fc15)
-- Adds a summary field to report definition
ALTER TABLE REPORT_DEFINITION ADD SUMMARY VARCHAR(255) NOT NULL DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('zyang', 'Adds a summary field to report definition', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-modification-report', '2.0.5', '3:438a13a6179b54a364f0ff2e2bb6fc15', 388);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-oauth1a-consumer-1::bsiri::(Checksum: 3:e0c4d5016ade1c0d4da3bfbdf4dfe414)
-- StoredCredentials can now store either credentials, either general configuration.
--         A new column appear so we can hint what is the type of the payload.
--         Also, users can now have stored credentials (even though they can't manage them yet).
--         Only one credentials can be created for a given user and a given server (bugtracker)
ALTER TABLE STORED_CREDENTIALS ADD CONTENT_TYPE VARCHAR(4) DEFAULT 'CRED';

ALTER TABLE STORED_CREDENTIALS ADD AUTHENTICATED_USER BIGINT DEFAULT null;

ALTER TABLE STORED_CREDENTIALS ADD CONSTRAINT fk_stored_credentials_user FOREIGN KEY (AUTHENTICATED_USER) REFERENCES CORE_USER (PARTY_ID);

COMMENT ON COLUMN STORED_CREDENTIALS.CONTENT_TYPE IS 'the role of the content, either CRED or CONF';

COMMENT ON COLUMN STORED_CREDENTIALS.AUTHENTICATED_USER IS 'Foreign key to the user account that owns the credentials. A NULL value means that Squash-TM               owns the credentials (app-level credentials).';

ALTER TABLE STORED_CREDENTIALS ADD CONSTRAINT uniq_stored_credentials_server_user UNIQUE (AUTHENTICATED_SERVER, AUTHENTICATED_USER, CONTENT_TYPE);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'StoredCredentials can now store either credentials, either general configuration.
        A new column appear so we can hint what is the type of the payload.
        Also, users can now have stored credentials (even though they can''t manage them yet).
...', NOW(), 'Add Column, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-oauth1a-consumer-1', '2.0.5', '3:e0c4d5016ade1c0d4da3bfbdf4dfe414', 389);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-oauth1a-consumer-2::bsiri::(Checksum: 3:ef39e53abfeb94877814ea110d50494b)
-- Bugtracker now declare which authentication protocol should be used upfront.
ALTER TABLE BUGTRACKER ADD AUTH_PROTOCOL VARCHAR(30) NOT NULL DEFAULT 'BASIC_AUTH';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Bugtracker now declare which authentication protocol should be used upfront.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-oauth1a-consumer-2', '2.0.5', '3:ef39e53abfeb94877814ea110d50494b', 390);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml::tm-1.18.0-email-column-resizing::aguilhem::(Checksum: 3:5674ed3ebb19808b8a48c27799023f4a)
ALTER TABLE CORE_USER ALTER COLUMN EMAIL TYPE VARCHAR(255);

ALTER TABLE CORE_USER ALTER COLUMN  EMAIL SET DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aguilhem', '', NOW(), 'Modify data type, Add Default Value', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.18.0.xml', 'tm-1.18.0-email-column-resizing', '2.0.5', '3:5674ed3ebb19808b8a48c27799023f4a', 391);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0::cholc::(Checksum: 3:d3d81ed256b747e5db448be4a5aefcfb)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.19.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0', '2.0.5', '3:d3d81ed256b747e5db448be4a5aefcfb', 392);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-400-info-list-item::cholc::(Checksum: 3:d584cfc9f0ba4144f5ca3bf8b2ae0368)
-- Adds a colour field to info list items
ALTER TABLE INFO_LIST_ITEM ADD COLOUR VARCHAR(7);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'Adds a colour field to info list items', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-400-info-list-item', '2.0.5', '3:d584cfc9f0ba4144f5ca3bf8b2ae0368', 393);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-400-custom-field-option::cholc::(Checksum: 3:87b21b7fc5312cc9edd70e3c9c966412)
-- Adds a colour field to custom field options
ALTER TABLE CUSTOM_FIELD_OPTION ADD COLOUR VARCHAR(7);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'Adds a colour field to custom field options', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-400-custom-field-option', '2.0.5', '3:87b21b7fc5312cc9edd70e3c9c966412', 394);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-409-iteration-test-suite-remove-constraint::cholc::(Checksum: 3:22b03dcec1047040f59f8715f3cfad6b)
-- To drop an unique constraint, you need the constraint's name, which we don't have, so here we copy the
--       column and delete the original
ALTER TABLE ITERATION_TEST_SUITE ADD TEST_SUITE_ID_TEMP BIGINT;

ALTER TABLE ITERATION_TEST_SUITE DROP CONSTRAINT fk_iteration_test_suite_suite;

UPDATE ITERATION_TEST_SUITE SET TEST_SUITE_ID_TEMP = TEST_SUITE_ID;

ALTER TABLE ITERATION_TEST_SUITE DROP COLUMN TEST_SUITE_ID;

ALTER TABLE ITERATION_TEST_SUITE RENAME COLUMN TEST_SUITE_ID_TEMP TO TEST_SUITE_ID;

ALTER TABLE ITERATION_TEST_SUITE ALTER COLUMN  TEST_SUITE_ID SET NOT NULL;

ALTER TABLE ITERATION_TEST_SUITE ADD CONSTRAINT fk_iteration_test_suite_suite FOREIGN KEY (TEST_SUITE_ID) REFERENCES TEST_SUITE (ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'To drop an unique constraint, you need the constraint''s name, which we don''t have, so here we copy the
      column and delete the original', NOW(), 'Add Column, Drop Foreign Key Constraint, Update Data, Drop Column, Rename Column, Add Not-Null Constraint, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-409-iteration-test-suite-remove-constraint', '2.0.5', '3:22b03dcec1047040f59f8715f3cfad6b', 395);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-409-iteration-test-suite-order::cholc::(Checksum: 3:c512c914417320cd100101503b18fcf3)
-- add an order to iterations' test suites
ALTER TABLE ITERATION_TEST_SUITE ADD ITERATION_TEST_SUITE_ORDER INT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'add an order to iterations'' test suites', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-409-iteration-test-suite-order', '2.0.5', '3:c512c914417320cd100101503b18fcf3', 396);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-409-iteration-test-suite-order-generation::cholc::(Checksum: 3:b73c29a780afdaf27b12d8a48e1f8fdf)
-- will compute the order of the test suites in the iterations, should work for all databases
UPDATE ITERATION_TEST_SUITE ITS
      SET
      ITERATION_TEST_SUITE_ORDER = (SELECT
      SUB_QUERY.ORDER_DEF
      FROM
      (SELECT
      ITS1.ITERATION_ID AS I_ID,
      ITS1.TEST_SUITE_ID AS TS_ID,
      (COUNT(*) - 1) AS ORDER_DEF
      FROM
      ITERATION_TEST_SUITE ITS1
      INNER JOIN ITERATION_TEST_SUITE ITS2 ON ITS1.ITERATION_ID = ITS2.ITERATION_ID
      AND ITS1.TEST_SUITE_ID >= ITS2.TEST_SUITE_ID
      GROUP BY ITS1.ITERATION_ID , ITS1.TEST_SUITE_ID) AS SUB_QUERY
      WHERE
      SUB_QUERY.I_ID = ITS.ITERATION_ID
      AND SUB_QUERY.TS_ID = ITS.TEST_SUITE_ID);

ALTER TABLE ITERATION_TEST_SUITE ADD CONSTRAINT uc_iteration_iteration_test_suite_order UNIQUE (ITERATION_ID, ITERATION_TEST_SUITE_ORDER);

ALTER TABLE ITERATION_TEST_SUITE ALTER COLUMN  ITERATION_TEST_SUITE_ORDER SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'will compute the order of the test suites in the iterations, should work for all databases', NOW(), 'Custom SQL, Add Unique Constraint, Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-409-iteration-test-suite-order-generation', '2.0.5', '3:b73c29a780afdaf27b12d8a48e1f8fdf', 397);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-up-sb2-1::bsiri::(Checksum: 3:4cc64120c97287a177d3aafad69bfea2)
-- Passwords are now much longer since we also store the salt.
ALTER TABLE AUTH_USER ALTER COLUMN PASSWORD TYPE VARCHAR(255);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Passwords are now much longer since we also store the salt.', NOW(), 'Modify data type', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-up-sb2-1', '2.0.5', '3:4cc64120c97287a177d3aafad69bfea2', 398);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-399-infolist-items-default-colours::cholc::(Checksum: 3:b8c2d1e791c8dbffaf6974dac5a9d69d)
-- Test cases types colours
UPDATE INFO_LIST_ITEM SET COLOUR = '#C3AB77' WHERE CODE = 'CAT_TEST_REQUIREMENT';

UPDATE INFO_LIST_ITEM SET COLOUR = '#CDCDCD' WHERE CODE = 'CAT_UNDEFINED';

UPDATE INFO_LIST_ITEM SET COLOUR = '#8F6057' WHERE CODE = 'CAT_ERGONOMIC';

UPDATE INFO_LIST_ITEM SET COLOUR = '#FCCA46' WHERE CODE = 'CAT_PERFORMANCE';

UPDATE INFO_LIST_ITEM SET COLOUR = '#233D4D' WHERE CODE = 'CAT_TECHNICAL';

UPDATE INFO_LIST_ITEM SET COLOUR = '#094C75' WHERE CODE = 'CAT_USER_STORY';

UPDATE INFO_LIST_ITEM SET COLOUR = '#FE7F2D' WHERE CODE = 'CAT_SECURITY';

UPDATE INFO_LIST_ITEM SET COLOUR = '#7594CD' WHERE CODE = 'CAT_FUNCTIONAL';

UPDATE INFO_LIST_ITEM SET COLOUR = '#BB5759' WHERE CODE = 'CAT_NON_FUNCTIONAL';

UPDATE INFO_LIST_ITEM SET COLOUR = '#A1C181' WHERE CODE = 'CAT_USE_CASE';

UPDATE INFO_LIST_ITEM SET COLOUR = '#619B8A' WHERE CODE = 'CAT_BUSINESS';

UPDATE INFO_LIST_ITEM SET COLOUR = '#A1C181' WHERE CODE = 'NAT_USER_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#FCCA46' WHERE CODE = 'NAT_PERFORMANCE_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#FE7F2D' WHERE CODE = 'NAT_SECURITY_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#233D4D' WHERE CODE = 'NAT_ATDD';

UPDATE INFO_LIST_ITEM SET COLOUR = '#CDCDCD' WHERE CODE = 'NAT_UNDEFINED';

UPDATE INFO_LIST_ITEM SET COLOUR = '#7594CD' WHERE CODE = 'NAT_FUNCTIONAL_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#BB5759' WHERE CODE = 'NAT_NON_FUNCTIONAL_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#619B8A' WHERE CODE = 'NAT_BUSINESS_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#CDCDCD' WHERE CODE = 'TYP_UNDEFINED';

UPDATE INFO_LIST_ITEM SET COLOUR = '#5B9367' WHERE CODE = 'TYP_COMPLIANCE_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#CD533B' WHERE CODE = 'TYP_CORRECTION_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#D8A86E' WHERE CODE = 'TYP_EVOLUTION_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#F2E77E' WHERE CODE = 'TYP_REGRESSION_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#2D5635' WHERE CODE = 'TYP_END_TO_END_TESTING';

UPDATE INFO_LIST_ITEM SET COLOUR = '#F2E2CE' WHERE CODE = 'TYP_PARTNER_TESTING';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('cholc', 'Test cases types colours', NOW(), 'Update Data (x26)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-399-infolist-items-default-colours', '2.0.5', '3:b8c2d1e791c8dbffaf6974dac5a9d69d', 399);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-453-execution-name-maxlength::jprioux::(Checksum: 3:7b31ef852637835eb24a4bac66c92278)
-- Increase max length for execution name
ALTER TABLE EXECUTION ALTER COLUMN NAME TYPE VARCHAR(308);

ALTER TABLE EXECUTION ALTER COLUMN  NAME SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Increase max length for execution name', NOW(), 'Modify data type, Add Not-Null Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-453-execution-name-maxlength', '2.0.5', '3:7b31ef852637835eb24a4bac66c92278', 400);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-508-automation-request::aboittiaux::(Checksum: 3:57688d891e39b5c6935492f33d73f598)
-- Create table AUTOMATION_REQUEST to Gherkin's test cases
CREATE TABLE AUTOMATION_REQUEST (AUTOMATION_REQUEST_ID bigserial NOT NULL, REQUEST_STATUS VARCHAR(25) DEFAULT 'WORK_IN_PROGRESS' NOT NULL, TRANSMITTED_ON TIMESTAMP WITH TIME ZONE, ASSIGNED_TO BIGINT, AUTOMATION_PRIORITY INT, ASSIGNED_ON TIMESTAMP WITH TIME ZONE, TEST_CASE_ID BIGINT, CREATED_BY BIGINT, TRANSMITTED_BY BIGINT, PROJECT_ID BIGINT NOT NULL, CONSTRAINT PK_AUTOMATION_REQUEST PRIMARY KEY (AUTOMATION_REQUEST_ID), CONSTRAINT fk_automation_request_project FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT(PROJECT_ID));

COMMENT ON COLUMN AUTOMATION_REQUEST.PROJECT_ID IS 'fk to the host project';

CREATE INDEX automation_request_assigned_to_idx ON AUTOMATION_REQUEST(ASSIGNED_TO);

CREATE INDEX automation_request_created_by_idx ON AUTOMATION_REQUEST(CREATED_BY);

CREATE INDEX automation_request_transmitted_by_idx ON AUTOMATION_REQUEST(TRANSMITTED_BY);

CREATE INDEX automation_request_test_case_id_idx ON AUTOMATION_REQUEST(TEST_CASE_ID);

ALTER TABLE AUTOMATION_REQUEST ADD CONSTRAINT fk_automation_request_automation_assigned_to FOREIGN KEY (ASSIGNED_TO) REFERENCES CORE_USER (PARTY_ID) ON DELETE SET NULL;

ALTER TABLE AUTOMATION_REQUEST ADD CONSTRAINT fk_automation_request_transmitted_by FOREIGN KEY (TRANSMITTED_BY) REFERENCES CORE_USER (PARTY_ID) ON DELETE SET NULL;

ALTER TABLE AUTOMATION_REQUEST ADD CONSTRAINT fk_automation_request_created_by FOREIGN KEY (CREATED_BY) REFERENCES CORE_USER (PARTY_ID) ON DELETE SET NULL;

ALTER TABLE AUTOMATION_REQUEST ADD CONSTRAINT fk_automation_request_test_case FOREIGN KEY (TEST_CASE_ID) REFERENCES TEST_CASE (TCLN_ID) ON DELETE SET NULL;

ALTER TABLE TEST_CASE ADD AUTOMATABLE CHAR DEFAULT 'M';

COMMENT ON COLUMN TEST_CASE.AUTOMATABLE IS 'Y: Yes, N: No, M: Maybe';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aboittiaux', 'Create table AUTOMATION_REQUEST to Gherkin''s test cases', NOW(), 'Create Table, Create Index (x4), Add Foreign Key Constraint (x4), Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-508-automation-request', '2.0.5', '3:57688d891e39b5c6935492f33d73f598', 401);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-1::bsiri::(Checksum: 3:66a8db91cecb3ecaa2a7a00b08298bcd)
-- Creating the AutomationRequestLibrary
CREATE TABLE AUTOMATION_REQUEST_LIBRARY (ARL_ID bigserial NOT NULL, ATTACHMENT_LIST_ID BIGINT, CONSTRAINT PK_AUTOMATION_REQUEST_LIBRARY PRIMARY KEY (ARL_ID), CONSTRAINT "fk_autorequestLib_attachment_list" FOREIGN KEY (ATTACHMENT_LIST_ID) REFERENCES ATTACHMENT_LIST(ATTACHMENT_LIST_ID));

COMMENT ON COLUMN AUTOMATION_REQUEST_LIBRARY.ARL_ID IS 'autoincremented primary key';

COMMENT ON COLUMN AUTOMATION_REQUEST_LIBRARY.ATTACHMENT_LIST_ID IS 'fk to the attachment list';

CREATE INDEX idx_automation_request_library ON AUTOMATION_REQUEST_LIBRARY(ARL_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creating the AutomationRequestLibrary', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-1', '2.0.5', '3:66a8db91cecb3ecaa2a7a00b08298bcd', 402);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-2::bsiri::(Checksum: 3:47c6c9e84780e5a1c588f561a12d2397)
-- New entries in the ACL infrastructure.
insert into ACL_CLASS(ID, CLASSNAME) values(7,
      'org.squashtest.tm.domain.tf.automationrequest.AutomationRequestLibrary');

insert into ACL_GROUP(ID, QUALIFIED_NAME) values(10, 'squashtest.acl.group.tm.AutomatedTestWriter');

insert into ACL_GROUP_PERMISSION(ACL_GROUP_ID, PERMISSION_MASK, CLASS_ID)
      select AGP2.ACL_GROUP_ID, AGP2.PERMISSION_MASK, 7
      from ACL_GROUP_PERMISSION AGP2
      where CLASS_ID = 3;

insert into ACL_GROUP_PERMISSION(ACL_GROUP_ID, CLASS_ID, PERMISSION_MASK) values
      (2, 7, 8192),
      (5, 7, 8192),
      (5, 7, 16384),
      (7, 7, 8192),
      (8, 7, 8192),
      (9, 7, 8192),
      (10, 2, 1),
      (10, 3, 1),
      (10, 4, 1),
      (10, 6, 1),
      (10, 7, 1),
      (10, 7, 2),
      (10, 7, 4),
      (10, 7, 8),
      (10, 7, 64),
      (10, 7, 256),
      (10, 7, 1024),
      (10, 7, 4096),
      (10, 7, 16384);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'New entries in the ACL infrastructure.', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-2', '2.0.5', '3:47c6c9e84780e5a1c588f561a12d2397', 403);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-3::bsiri::(Checksum: 3:4746725392d62c8fccf251b227540743)
-- The automation request library content table
CREATE TABLE AUTOMATION_REQUEST_LIBRARY_CONTENT (LIBRARY_ID BIGINT NOT NULL, CONTENT_ID BIGINT NOT NULL, CONSTRAINT fk_automation_rquest_lib_content_lib FOREIGN KEY (LIBRARY_ID) REFERENCES AUTOMATION_REQUEST_LIBRARY(ARL_ID), CONSTRAINT fk_automation_request_lib_content_content FOREIGN KEY (CONTENT_ID) REFERENCES AUTOMATION_REQUEST(AUTOMATION_REQUEST_ID), UNIQUE (CONTENT_ID));

COMMENT ON COLUMN AUTOMATION_REQUEST_LIBRARY_CONTENT.LIBRARY_ID IS 'Foreign key to the library';

COMMENT ON COLUMN AUTOMATION_REQUEST_LIBRARY_CONTENT.CONTENT_ID IS 'Foreign key to the content';

CREATE INDEX idx_automation_request_lib_content_content ON AUTOMATION_REQUEST_LIBRARY_CONTENT(CONTENT_ID);

CREATE INDEX idx_automation_request_lib_content_lib ON AUTOMATION_REQUEST_LIBRARY_CONTENT(LIBRARY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'The automation request library content table', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-3', '2.0.5', '3:4746725392d62c8fccf251b227540743', 404);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-4::bsiri::(Checksum: 3:245b79ba9eaa831942ab29d9cf2b13b3)
-- Add a Project fk to the AutomationRequestLibrary
ALTER TABLE PROJECT ADD ARL_ID BIGINT;

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_arl FOREIGN KEY (ARL_ID) REFERENCES AUTOMATION_REQUEST_LIBRARY (ARL_ID);

COMMENT ON COLUMN PROJECT.ARL_ID IS 'fk to the automation request library';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Add a Project fk to the AutomationRequestLibrary', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-4', '2.0.5', '3:245b79ba9eaa831942ab29d9cf2b13b3', 405);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-5::bsiri::(Checksum: 3:6fb84c3bc45cccef4e364ecbccd7f93f)
-- Create one such library for each existing projects
-- create the libraries

      insert into AUTOMATION_REQUEST_LIBRARY (ARL_ID)
      select p.PROJECT_ID from PROJECT p;

-- attachments, step 1 :
      -- create a ranking table, akin to what would ROW_NUMBER() order by id desc would say

      create table ARL_RANK as
      select alib.arl_id, count(alib2.arl_id)  as ranking
      from AUTOMATION_REQUEST_LIBRARY alib,
      AUTOMATION_REQUEST_LIBRARY alib2
      where alib.arl_id <= alib2.arl_id
      group by alib.arl_id
      order by ranking asc;

-- attachments, step 2 :
      -- create a table that pairs library ids with predictable, consecutive attachment_list_ids using the rank
      -- calculated earlier

      create table ARL_ATTACHLIST_PAIRING as
      select arl.arl_id, (select max(al.attachment_list_id) from ATTACHMENT_LIST al) + arl.ranking as attachment_list_id
      from ARL_RANK arl;

-- attachments, step 3 :
      -- insert the attachment lists and update fk in the automation request library
      insert into ATTACHMENT_LIST(ATTACHMENT_LIST_ID)
      select pair.attachment_list_id from ARL_ATTACHLIST_PAIRING pair;

update AUTOMATION_REQUEST_LIBRARY arl
      set ATTACHMENT_LIST_ID = (select pair.attachment_list_id from ARL_ATTACHLIST_PAIRING pair where pair.arl_id = arl.arl_id);

-- attachments, step 4 and final :
      -- drop the temporary tables

      drop table ARL_ATTACHLIST_PAIRING;

drop table ARL_RANK;

-- wire the project to the ARL library

      update PROJECT P
      set ARL_ID = PROJECT_ID;

-- insert the acl object identities
      insert into ACL_OBJECT_IDENTITY(IDENTITY, CLASS_ID)
      select arl.arl_id, 7 from AUTOMATION_REQUEST_LIBRARY arl;

-- add the user/team permissions in ACL_RESPONSIBILITY_SCOPE_ENTRY
      -- each user will receive the same acl_group on each arl library than on the project it depends on
      -- (this last sentence is the idea behind the auto join on acl_object_identity in this query)
      insert into ACL_RESPONSIBILITY_SCOPE_ENTRY(party_id, acl_group_id, object_identity_id)
      select distinct arse.party_id, arse.acl_group_id, arl_oid.id
      from ACL_RESPONSIBILITY_SCOPE_ENTRY arse
      inner join ACL_OBJECT_IDENTITY oid on (arse.object_identity_id = oid.id and oid.class_id = 1)
      inner join ACL_OBJECT_IDENTITY arl_oid on (oid.identity = arl_oid.identity and arl_oid.class_id = 7);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Create one such library for each existing projects', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-5', '2.0.5', '3:6fb84c3bc45cccef4e364ecbccd7f93f', 406);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-519-automation-request-library-6::bsiri::(Checksum: 3:7402acde3cde28b748a66190cdaec1d4)
-- reset postgresql sequences
select setval('automation_request_library_arl_id_seq', (select MAX(ARL_ID) from AUTOMATION_REQUEST_LIBRARY));

select setval('attachment_list_attachment_list_id_seq', (select MAX(ATTACHMENT_LIST_ID) from ATTACHMENT_LIST));

select setval('acl_object_identity_id_seq', (SELECT MAX(ID) from ACL_OBJECT_IDENTITY));

select setval('acl_responsibility_scope_entry_id_seq', (select MAX(ID) from ACL_RESPONSIBILITY_SCOPE_ENTRY));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'reset postgresql sequences', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-519-automation-request-library-6', '2.0.5', '3:7402acde3cde28b748a66190cdaec1d4', 407);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-510-add-roles-automation::aboittiaux::(Checksum: 3:ab8e4f0bb3b90cc552475eb1645e7cd0)
insert into CORE_PARTY_AUTHORITY(PARTY_ID, AUTHORITY)
      select distinct cu.PARTY_ID, 'ROLE_TF_FUNCTIONAL_TESTER' from CORE_USER cu
      left join CORE_PARTY_AUTHORITY cpa on cu.PARTY_ID = cpa.PARTY_ID
      left join CORE_GROUP_MEMBER ctm on ctm.PARTY_ID = cu.PARTY_ID
      where cpa.AUTHORITY is null and ctm.GROUP_ID = 2;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aboittiaux', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-510-add-roles-automation', '2.0.5', '3:ab8e4f0bb3b90cc552475eb1645e7cd0', 408);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-524-automation-workflow-by-project::jprioux::(Checksum: 3:b85a3cae93cd973c546f5efc43961885)
-- add a boolean in project table to activate or not the automation workflow
ALTER TABLE PROJECT ADD ALLOW_AUTOMATION_WORKFLOW BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'add a boolean in project table to activate or not the automation workflow', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-524-automation-workflow-by-project', '2.0.5', '3:b85a3cae93cd973c546f5efc43961885', 409);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-create-auth-users::bsiri::(Checksum: 3:2641b5927bdbb5fe16ab3e3ec5e0c253)
-- add the missing entries in AUTH_USER for users that only exist in CORE_USER (eg a user created by LDAP)
insert into AUTH_USER (login, password, active)
      select cu.LOGIN, '', cu.active
      from CORE_USER cu
      left join AUTH_USER au on cu.login = au.login
      where au.login is null;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'add the missing entries in AUTH_USER for users that only exist in CORE_USER (eg a user created by LDAP)', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-create-auth-users', '2.0.5', '3:2641b5927bdbb5fe16ab3e3ec5e0c253', 410);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-Mantis-7833::jprioux::(Checksum: 3:2a6554aaf36c544fe58930b1d45789be)
-- Increase remote project id limit to 100 for redmine bt project keys
ALTER TABLE REQUIREMENT_SYNC_EXTENDER ALTER COLUMN REMOTE_PROJECT_ID TYPE VARCHAR(100);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Increase remote project id limit to 100 for redmine bt project keys', NOW(), 'Modify data type', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-Mantis-7833', '2.0.5', '3:2a6554aaf36c544fe58930b1d45789be', 411);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-536-autoexec-gherkin-1::bsiri::(Checksum: 3:7ed1740df7a7a5a0426a0b898568163e)
-- Add a flag to the test automation project that tells whether it is able to run Gherkin tests.
ALTER TABLE TEST_AUTOMATION_PROJECT ADD CAN_RUN_GHERKIN BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Add a flag to the test automation project that tells whether it is able to run Gherkin tests.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-536-autoexec-gherkin-1', '2.0.5', '3:7ed1740df7a7a5a0426a0b898568163e', 412);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-543-third-party-server-1::bsiri::(Checksum: 3:76d1eb414a1cdea7e0f2ce5b02df7c31)
-- Create the table THIRD_PARTY_SERVER
CREATE TABLE THIRD_PARTY_SERVER (SERVER_ID bigserial NOT NULL, NAME VARCHAR(50) NOT NULL, URL VARCHAR(400) NOT NULL, AUTH_POLICY VARCHAR(30) DEFAULT 'USER', AUTH_PROTOCOL VARCHAR(30) DEFAULT 'BASIC_AUTH' NOT NULL, CONSTRAINT PK_THIRD_PARTY_SERVER PRIMARY KEY (SERVER_ID));

COMMENT ON TABLE THIRD_PARTY_SERVER IS 'base table for third party servers';

COMMENT ON COLUMN THIRD_PARTY_SERVER.SERVER_ID IS 'primary key, autogenerated';

COMMENT ON COLUMN THIRD_PARTY_SERVER.NAME IS 'name of the server';

COMMENT ON COLUMN THIRD_PARTY_SERVER.URL IS 'the base url';

COMMENT ON COLUMN THIRD_PARTY_SERVER.AUTH_POLICY IS 'the policy that decides who needs to authenticate';

COMMENT ON COLUMN THIRD_PARTY_SERVER.AUTH_PROTOCOL IS 'the protocol that should be used for that server';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Create the table THIRD_PARTY_SERVER', NOW(), 'Create Table', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-543-third-party-server-1', '2.0.5', '3:76d1eb414a1cdea7e0f2ce5b02df7c31', 413);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-543-third-party-server-2::bsiri::(Checksum: 3:2fbff3a4f50f14a818edf08207a3c879)
-- migrate data from table BUGTRACKER to table THIRD_PARTY_SERVER
insert into THIRD_PARTY_SERVER(SERVER_ID, NAME, URL, AUTH_POLICY, AUTH_PROTOCOL)
      select BUGTRACKER_ID, NAME, URL, AUTH_POLICY, AUTH_PROTOCOL
      from BUGTRACKER;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'migrate data from table BUGTRACKER to table THIRD_PARTY_SERVER', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-543-third-party-server-2', '2.0.5', '3:2fbff3a4f50f14a818edf08207a3c879', 414);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-543-third-party-server-3::bsiri::(Checksum: 3:ac8c104ca3c5031d05a07833278e39bf)
-- Drop the now unused columns from BUGTRACKER and create the FK from BUGTRACKER to THIRD_PARTY_SERVER
ALTER TABLE BUGTRACKER DROP COLUMN NAME;

ALTER TABLE BUGTRACKER DROP COLUMN URL;

ALTER TABLE BUGTRACKER DROP COLUMN AUTH_POLICY;

ALTER TABLE BUGTRACKER DROP COLUMN AUTH_PROTOCOL;

ALTER TABLE BUGTRACKER ADD CONSTRAINT fk_bugtracker_third_party_server FOREIGN KEY (BUGTRACKER_ID) REFERENCES THIRD_PARTY_SERVER (SERVER_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Drop the now unused columns from BUGTRACKER and create the FK from BUGTRACKER to THIRD_PARTY_SERVER', NOW(), 'Drop Column (x4), Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-543-third-party-server-3', '2.0.5', '3:ac8c104ca3c5031d05a07833278e39bf', 415);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-543-third-party-server-4::bsiri::(Checksum: 3:4139d4e521c3b5dd91b0fc95e793049f)
-- change the foreign key stored_credentials -> bugtracker to stored_credentials -> third_party_server
ALTER TABLE STORED_CREDENTIALS DROP CONSTRAINT fk_stored_credentials_authenticated_server;

CREATE INDEX idx_fk_stored_credentials_authenticated_server ON STORED_CREDENTIALS(AUTHENTICATED_SERVER);

ALTER TABLE STORED_CREDENTIALS ADD CONSTRAINT fk_stored_credentials_authenticated_server FOREIGN KEY (AUTHENTICATED_SERVER) REFERENCES THIRD_PARTY_SERVER (SERVER_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'change the foreign key stored_credentials -> bugtracker to stored_credentials -> third_party_server', NOW(), 'Drop Foreign Key Constraint, Create Index, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-543-third-party-server-4', '2.0.5', '3:4139d4e521c3b5dd91b0fc95e793049f', 416);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-543-third-party-server-5-postgres::bsiri::(Checksum: 3:e954c8eba5f821372982b5a8f7f5d8b6)
-- For PostGre, remove the autoincrement on bugtracker_id and reset the sequence for third_party_server
alter table BUGTRACKER alter column BUGTRACKER_ID drop default;

drop sequence if exists bugtracker_bugtracker_id_seq;

select setval('third_party_server_server_id_seq', (select max(SERVER_ID) from THIRD_PARTY_SERVER));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'For PostGre, remove the autoincrement on bugtracker_id and reset the sequence for third_party_server', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-543-third-party-server-5-postgres', '2.0.5', '3:e954c8eba5f821372982b5a8f7f5d8b6', 417);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-512-scm-server-management::jlor::(Checksum: 3:120666e6aa77c32bf5ad6c000dc7520a)
-- Add new table for scm (source code management) server.
CREATE TABLE SCM_SERVER (SERVER_ID BIGINT NOT NULL, KIND VARCHAR(30) NOT NULL, CONSTRAINT PK_SCM_SERVER PRIMARY KEY (SERVER_ID));

COMMENT ON COLUMN SCM_SERVER.SERVER_ID IS 'The id of the scm server.';

COMMENT ON COLUMN SCM_SERVER.KIND IS 'The kind of scm server.';

ALTER TABLE SCM_SERVER ADD CONSTRAINT fk_scm_server_third_party_server FOREIGN KEY (SERVER_ID) REFERENCES THIRD_PARTY_SERVER (SERVER_ID) ON DELETE CASCADE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Add new table for scm (source code management) server.', NOW(), 'Create Table, Add Foreign Key Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-512-scm-server-management', '2.0.5', '3:120666e6aa77c32bf5ad6c000dc7520a', 418);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-512-scm-repository-management::jlor::(Checksum: 3:aa001ff7e8ea43ea0d388358a08a6d5c)
-- Add new table for scm (source code management) repository.
CREATE TABLE SCM_REPOSITORY (SCM_REPOSITORY_ID bigserial NOT NULL, SERVER_ID BIGINT NOT NULL, NAME VARCHAR(255) NOT NULL, REPOSITORY_PATH VARCHAR(255) NOT NULL, WORKING_FOLDER_PATH VARCHAR(255), WORKING_BRANCH VARCHAR(255) NOT NULL, CONSTRAINT PK_SCM_REPOSITORY PRIMARY KEY (SCM_REPOSITORY_ID), CONSTRAINT fk_scm_repository_scm_server FOREIGN KEY (SERVER_ID) REFERENCES SCM_SERVER(SERVER_ID));

COMMENT ON COLUMN SCM_REPOSITORY.SCM_REPOSITORY_ID IS 'The auto-generated id of the scm repository.';

COMMENT ON COLUMN SCM_REPOSITORY.SERVER_ID IS 'The foreign key to the related SCM_SEVER';

COMMENT ON COLUMN SCM_REPOSITORY.NAME IS 'The name of the repository.';

COMMENT ON COLUMN SCM_REPOSITORY.REPOSITORY_PATH IS 'The absolute path to the local repository on the local server.';

COMMENT ON COLUMN SCM_REPOSITORY.WORKING_FOLDER_PATH IS 'The relative path of the working folder in which SquashTM will push.';

COMMENT ON COLUMN SCM_REPOSITORY.WORKING_BRANCH IS 'The name of the working branch on which SquashTM will push.';

ALTER TABLE SCM_REPOSITORY ADD UNIQUE (NAME, SERVER_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Add new table for scm (source code management) repository.', NOW(), 'Create Table, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-512-scm-repository-management', '2.0.5', '3:aa001ff7e8ea43ea0d388358a08a6d5c', 419);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-SQTM-512-project-scm-repository-binding::jlor::(Checksum: 3:9b16e82644b87b3692a80bce6e53b4cb)
-- Add foreign key in project table to reference a scm (source code management) repository.
ALTER TABLE PROJECT ADD SCM_REPOSITORY_ID BIGINT;

ALTER TABLE PROJECT ADD CONSTRAINT fk_project_scm_repository FOREIGN KEY (SCM_REPOSITORY_ID) REFERENCES SCM_REPOSITORY (SCM_REPOSITORY_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Add foreign key in project table to reference a scm (source code management) repository.', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-SQTM-512-project-scm-repository-binding', '2.0.5', '3:9b16e82644b87b3692a80bce6e53b4cb', 420);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-fixing-postgresql-index::jthebault::(Checksum: 3:3d725af081cefe2c5552ddf91edc09d5)
create index idx_fk_acl_grp_permission_acl_grp on acl_group_permission(acl_group_id);

create index idx_fk_acl_obj_id_acl_class on acl_object_identity(class_id);

create index idx_fk_action_test_step_attachment_list on action_test_step(attachment_list_id);

create index idx_fk_arse_party on acl_responsibility_scope_entry(party_id);

create index idx_fk_attachment_att_list on attachment(attachment_list_id);

create index idx_fk_attachment_content on attachment(content_id);

create index idx_fk_audit_event_requirement_version on requirement_audit_event(req_version_id);

create index idx_fk_auto_exec_auto_test on automated_execution_extender(test_id);

create index idx_fk_auto_exec_exec on automated_execution_extender(master_execution_id);

create index idx_fk_auto_exec_suite on automated_execution_extender(suite_id);

create index idx_fk_automated_test_project on automated_test(project_id);

create index idx_fk_automation_request_project on automation_request(project_id);

create index idx_fk_autorequestlib_attachment_list on automation_request_library(attachment_list_id);

create index idx_fk_axis_column_chart_column on chart_axis_column(chart_column_id);

create index idx_fk_bugtracker_binding_bugtracker on bugtracker_binding(bugtracker_id);

create index idx_fk_bugtracker_binding_project on bugtracker_binding(project_id);

create index idx_fk_bugtracker_project_bugtracker_binding on bugtracker_project(bugtracker_binding_id);

create index idx_fk_call_step_called_test_case on call_test_step(called_test_case_id);

create index idx_fk_call_step_dataset on call_test_step(called_dataset);

create index idx_fk_camp_iter_campaign on campaign_iteration(campaign_id);

create index idx_fk_camp_iter_iteration on campaign_iteration(iteration_id);

create index idx_fk_camp_test_plan_item_dataset on campaign_test_plan_item(dataset_id);

create index idx_fk_camp_tp_campaign on campaign_test_plan_item(campaign_id);

create index idx_fk_camp_tp_testcase on campaign_test_plan_item(test_case_id);

create index idx_fk_camp_tp_user on campaign_test_plan_item(user_id);

create index idx_fk_camplib_attachment_list on campaign_library(attachment_list_id);

create index idx_fk_campnode_attachment_list on campaign_library_node(attachment_list_id);

create index idx_fk_cf_option_cf on custom_field_option(cf_id);

create index idx_fk_cfb_bound_project on custom_field_binding(bound_project_id);

create index idx_fk_cfb_cf on custom_field_binding(cf_id);

create index idx_fk_cfb_render_loc_cfb on custom_field_rendering_location(cfb_id);

create index idx_fk_cfv_cf_binding on custom_field_value(cfb_id);

create index idx_fk_cfv_option_cfv on custom_field_value_option(cfv_id);

create index idx_fk_chart_axis_chart_query on chart_axis_column(query_id);

create index idx_fk_chart_bindind_chart_definition_chart_id on custom_report_chart_binding(chart_id);

create index idx_fk_chart_bindind_custom_report_dashboard_crd_id on custom_report_chart_binding(crd_id);

create index idx_fk_chart_bindind_report_definition_report_id on custom_report_report_binding(report_id);

create index idx_fk_chart_filter_chart_column on chart_filter(chart_column_id);

create index idx_fk_chart_filter_chart_query on chart_filter(query_id);

create index idx_fk_chart_filter_value_chart_column on chart_filter_values(filter_id);

create index idx_fk_chart_measure_chart_column on chart_measure_column(chart_column_id);

create index idx_fk_chart_measure_chart_query on chart_measure_column(query_id);

create index idx_fk_chart_owner on chart_definition(user_id);

create index idx_fk_chart_project_scope_chart_definition on chart_project_scope(chart_id);

create index idx_fk_chart_query on chart_definition(query_id);

create index idx_fk_chart_scope_chart_definition on chart_scope(chart_id);

create index idx_fk_cln_project on campaign_library_node(project_id);

create index idx_fk_column_query on chart_column_prototype(subquery_id);

create index idx_fk_column_role_chart_column on chart_column_role(chart_column_id);

create index idx_fk_crl_attachment_list on custom_report_library(attachment_list_id);

create index idx_fk_crln_custom_report_library_crl_id on custom_report_library_node(crl_id);

create index idx_fk_dataset_param_value_dataset on dataset_param_value(dataset_id);

create index idx_fk_dataset_param_value_param on dataset_param_value(param_id);

create index idx_fk_dataset_test_case on dataset(test_case_id);

create index idx_fk_df_option_dfv on denormalized_field_option(dfv_id);

create index idx_fk_dfb_render_loc_dfb on denormalized_field_rendering_location(dfv_id);

create index idx_fk_dfv_cfv_binding on denormalized_field_value(cfv_id);

create index idx_fk_dfv_option_dfv on denormalized_field_value_option(dfv_id);

create index idx_fk_disabled_exec_status_cl_id on disabled_execution_status(cl_id);

create index idx_fk_execution_attachment_list on execution(attachment_list_id);

create index idx_fk_execution_issue_list on execution(issue_list_id);

create index idx_fk_execution_step__attachment_list on execution_step(attachment_list_id);

create index idx_fk_execution_step_issue_list on execution_step(issue_list_id);

create index idx_fk_execution_test_case on execution(tcln_id);

create index idx_fk_executionstep_teststep on execution_step(test_step_id);

create index idx_fk_group_member_party on core_group_member(party_id);

create index idx_fk_grp_member_grp on core_group_member(group_id);

create index idx_fk_info_item_list on info_list_item(list_id);

create index idx_fk_issue_bugtracker on issue(bugtracker_id);

create index idx_fk_issue_issue_list on issue(issue_list_id);

create index idx_fk_iteration__attachment_list on iteration(attachment_list_id);

create index idx_fk_iteration_test_plan_item_dataset on iteration_test_plan_item(dataset_id);

create index idx_fk_iteration_test_suite_suite on iteration_test_suite(test_suite_id);

create index idx_fk_itertestplan_test_case on iteration_test_plan_item(tcln_id);

create index idx_fk_itertestplan_user on iteration_test_plan_item(user_id);

create index idx_fk_libplugin_property_libplugin on library_plugin_binding_property(plugin_binding_id);

create index idx_fk_milestone_binding_milestone on milestone_binding(milestone_id);

create index idx_fk_milestone_binding_perimeter_milestone on milestone_binding_perimeter(milestone_id);

create index idx_fk_milestone_binding_perimeter_project on milestone_binding_perimeter(project_id);

create index idx_fk_milestone_binding_project on milestone_binding(project_id);

create index idx_fk_milestone_owner on milestone(user_id);

create index idx_fk_parameter_test_case on parameter(test_case_id);

create index idx_fk_party_authority_party on core_party_authority(party_id);

create index idx_fk_party_preference_core_party_party_id on party_preference(party_id);

create index idx_fk_project_arl on project(arl_id);

create index idx_fk_project_attachment_list on project(attachment_list_id);

create index idx_fk_project_chart_definition_project_id on chart_definition(project_id);

create index idx_fk_project_cl on project(cl_id);

create index idx_fk_project_crl on project(crl_id);

create index idx_fk_project_custom_report_dashboard_project_id on custom_report_dashboard(project_id);

create index idx_fk_project_custom_report_folder_project_id on custom_report_folder(project_id);

create index idx_fk_project_report_definition_project_id on report_definition(project_id);

create index idx_fk_project_rl on project(rl_id);

create index idx_fk_project_scm_repository on project(scm_repository_id);

create index idx_fk_project_tcl on project(tcl_id);

create index idx_fk_project_template_id on project(template_id);

create index idx_fk_remote_sync__bugtracker__bugtracker_id on remote_synchronisation(server_id);

create index idx_fk_remote_sync__project__project_id on remote_synchronisation(project_id);

create index idx_fk_report_bindind_custom_report_dashboard_crd_id on custom_report_report_binding(crd_id);

create index idx_fk_report_owner on report_definition(user_id);

create index idx_fk_req_folder_simple_resource on requirement_folder(res_id);

create index idx_fk_req_folder_sync_extender__remote_sync_remote_sync_id on requirement_folder_sync_extender(remote_synchronisation_id);

create index idx_fk_req_nature on requirement_version(category);

create index idx_fk_req_sync_extender__remote_sync_remote_sync_id on requirement_sync_extender(remote_synchronisation_id);

create index idx_fk_req_version_link_req_version_link_type_link_type_id on requirement_version_link(link_type_id);

create index idx_fk_reqlib_attachment_list on requirement_library(attachment_list_id);

create index idx_fk_requirement_current_version on requirement(current_version_id);

create index idx_fk_requirement_version_link_related_requirement_version_id on requirement_version_link(related_requirement_version_id);

create index idx_fk_requirement_version_link_requirement_version_id on requirement_version_link(requirement_version_id);

create index idx_fk_requirement_version_requirement on requirement_version(requirement_id);

create index idx_fk_resource_attachment_list on resource(attachment_list_id);

create index idx_fk_resp_scope_acl_grp on acl_responsibility_scope_entry(acl_group_id);

create index idx_fk_resp_scope_obj_id on acl_responsibility_scope_entry(object_identity_id);

create index idx_fk_rln_project on requirement_library_node(project_id);

create index idx_fk_sc_auth_acl_class on acl_group_permission(class_id);

create index idx_fk_scm_repository_scm_server on scm_repository(server_id);

create index idx_fk_stored_credentials_user on stored_credentials(authenticated_user);

create index idx_fk_sync_extender_requirement on requirement_sync_extender(requirement_id);

create index idx_fk_sync_extender_server on requirement_sync_extender(server_id);

create index idx_fk_ta_project_ta_server on test_automation_project(server_id);

create index idx_fk_ta_project_tm_project on test_automation_project(tm_project_id);

create index idx_fk_tc_nature on test_case(tc_nature);

create index idx_fk_tc_type on test_case(tc_type);

create index idx_fk_tclib_attachment_list on test_case_library(attachment_list_id);

create index idx_fk_tcln_project on test_case_library_node(project_id);

create index idx_fk_tcnode_attachment_list on test_case_library_node(attachment_list_id);

create index idx_fk_team_member_team on core_team_member(team_id);

create index idx_fk_team_member_user on core_team_member(user_id);

create index idx_fk_test_case_ta_test on test_case(ta_test);

create index idx_fk_test_suite_attachment_list on test_suite(attachment_list_id);

create index idx_fk_test_suite_test_plan_item_test_plan_item on test_suite_test_plan_item(tpi_id);

create index idx_fk_test_suite_test_plan_item_test_suite on test_suite_test_plan_item(suite_id);

create index idx_fk_verified_req_version on requirement_version_coverage(verified_req_version_id);

create index idx_fk_verifying_step_action_test_step on verifying_steps(test_step_id);

create index idx_fk_verifying_step_requirement_version_coverage on verifying_steps(requirement_version_coverage_id);

create index idx_fk_verifying_test_case on requirement_version_coverage(verifying_test_case_id);

create index idx_milestone_camp_camp on milestone_campaign(campaign_id);

create index idx_milestone_camp_milestone on milestone_campaign(milestone_id);

create index idx_milestone_rqv_milestone on milestone_req_version(milestone_id);

create index idx_milestone_rqv_rqv on milestone_req_version(req_version_id);

create index idx_milestone_tc_milestone on milestone_test_case(milestone_id);

create index idx_milestone_tc_tc on milestone_test_case(test_case_id);

create index idx_proj_req_categories on project(req_categories_list);

create index idx_proj_tc_natures on project(tc_natures_list);

create index idx_proj_tc_types on project(tc_types_list);

create index idx_tm_project_ta_server on project(ta_server_id);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jthebault', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-fixing-postgresql-index', '2.0.5', '3:3d725af081cefe2c5552ddf91edc09d5', 421);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml::tm-1.19.0-Mantis-7547::jprioux::(Checksum: 3:19cf83bd7a0118717487ca10078f58d9)
-- Increase remote req id limit to 50 for jira
ALTER TABLE REQUIREMENT_SYNC_EXTENDER ALTER COLUMN REMOTE_REQ_ID TYPE VARCHAR(50);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Increase remote req id limit to 50 for jira', NOW(), 'Modify data type', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.19.0.xml', 'tm-1.19.0-Mantis-7547', '2.0.5', '3:19cf83bd7a0118717487ca10078f58d9', 422);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0::jprioux::(Checksum: 3:b937644b7cb0f46c1e1f7e40a1eda3f0)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.20.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0', '2.0.5', '3:b937644b7cb0f46c1e1f7e40a1eda3f0', 423);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-176-custom-report-custom-export::jlor::(Checksum: 3:e3569bc7ec6c776e5ace367c27859806)
-- Create new object CustomExport in Custom Report Workspace
CREATE TABLE CUSTOM_REPORT_CUSTOM_EXPORT (CRCE_ID bigserial NOT NULL, NAME VARCHAR(255), PROJECT_ID BIGINT NOT NULL, CREATED_BY VARCHAR(50) NOT NULL, CREATED_ON TIMESTAMP WITH TIME ZONE NOT NULL, LAST_MODIFIED_BY VARCHAR(50) DEFAULT null, LAST_MODIFIED_ON TIMESTAMP WITH TIME ZONE DEFAULT null, CONSTRAINT PK_CUSTOM_REPORT_CUSTOM_EXPORT PRIMARY KEY (CRCE_ID), CONSTRAINT fk_custom_export_project_id FOREIGN KEY (PROJECT_ID) REFERENCES PROJECT (PROJECT_ID));

COMMENT ON COLUMN CUSTOM_REPORT_CUSTOM_EXPORT.CRCE_ID IS 'The auto-generated id';

COMMENT ON COLUMN CUSTOM_REPORT_CUSTOM_EXPORT.NAME IS 'The name of the Custom Export';

COMMENT ON COLUMN CUSTOM_REPORT_CUSTOM_EXPORT.PROJECT_ID IS 'Foreign key to the Project';

CREATE INDEX idx_fk_custom_export_project_id ON CUSTOM_REPORT_CUSTOM_EXPORT(PROJECT_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Create new object CustomExport in Custom Report Workspace', NOW(), 'Create Table, Create Index', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-176-custom-report-custom-export', '2.0.5', '3:e3569bc7ec6c776e5ace367c27859806', 424);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-125-use-tm-tree-structure-in-scm-repository::jlor::(Checksum: 3:3e5f82716b6e4832798a9be1ba640f6b)
-- Add an option in Project automation settings to use the tm tree structure when transmitting test cases to a scm repository
ALTER TABLE PROJECT ADD USE_TREE_STRUCTURE_IN_SCM_REPO BOOLEAN NOT NULL DEFAULT TRUE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Add an option in Project automation settings to use the tm tree structure when transmitting test cases to a scm repository', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-125-use-tm-tree-structure-in-scm-repository', '2.0.5', '3:3e5f82716b6e4832798a9be1ba640f6b', 425);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-220-add-missing-role-automation::agu::(Checksum: 3:9793655635dd0f28284ac5f78b231108)
-- Add missing automation role following changeset tm-1.19.0-SQTM-510-add-roles-automation
INSERT INTO CORE_PARTY_AUTHORITY(PARTY_ID, AUTHORITY)
      SELECT cpa.PARTY_ID, 'ROLE_TF_FUNCTIONAL_TESTER' from CORE_PARTY_AUTHORITY cpa
      INNER JOIN CORE_PARTY_AUTHORITY cpa2 on cpa.PARTY_ID = cpa2.PARTY_ID
      WHERE cpa.AUTHORITY = 'ROLE_TM_USER'
      GROUP BY cpa.PARTY_ID
      HAVING COUNT(cpa.PARTY_ID) = 1;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('agu', 'Add missing automation role following changeset tm-1.19.0-SQTM-510-add-roles-automation', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-220-add-missing-role-automation', '2.0.5', '3:9793655635dd0f28284ac5f78b231108', 426);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-91-custom-export-column::jlor::(Checksum: 3:55b397d1565faa0dc6162f5a64f2e124)
-- Create new tables to store the scope and the columns of a custom export
CREATE TABLE CUSTOM_EXPORT_SCOPE (CUSTOM_EXPORT_ID BIGINT NOT NULL, ENTITY_REFERENCE_TYPE VARCHAR(50), ENTITY_REFERENCE_ID BIGINT, CONSTRAINT fk_custom_export_scope_custom_export_id FOREIGN KEY (CUSTOM_EXPORT_ID) REFERENCES CUSTOM_REPORT_CUSTOM_EXPORT (CRCE_ID));

COMMENT ON COLUMN CUSTOM_EXPORT_SCOPE.CUSTOM_EXPORT_ID IS 'Foreign key to the Custom Export';

CREATE TABLE CUSTOM_EXPORT_COLUMN (CUSTOM_EXPORT_ID BIGINT NOT NULL, LABEL VARCHAR(255), CUF_ID BIGINT, CONSTRAINT fk_custom_export_column_custom_export_id FOREIGN KEY (CUSTOM_EXPORT_ID) REFERENCES CUSTOM_REPORT_CUSTOM_EXPORT (CRCE_ID));

COMMENT ON COLUMN CUSTOM_EXPORT_COLUMN.CUSTOM_EXPORT_ID IS 'Foreign key to the Custom Export';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Create new tables to store the scope and the columns of a custom export', NOW(), 'Create Table (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-91-custom-export-column', '2.0.5', '3:55b397d1565faa0dc6162f5a64f2e124', 427);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-13-add-conflict-association-ismanual::amk::(Checksum: 3:b006570f2144465d7445aaeb856f3509)
ALTER TABLE AUTOMATION_REQUEST ADD CONFLICT_ASSOCIATION TEXT DEFAULT null;

ALTER TABLE AUTOMATION_REQUEST ADD IS_MANUAL BOOLEAN NOT NULL DEFAULT FALSE;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', '', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-13-add-conflict-association-ismanual', '2.0.5', '3:b006570f2144465d7445aaeb856f3509', 428);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-13-update-is-manual::amk::(Checksum: 3:fc915e0d25c55ed07a819c85fefab933)
UPDATE AUTOMATION_REQUEST ar SET IS_MANUAL = true
      WHERE TEST_CASE_ID in (SELECT tc.TCLN_ID FROM TEST_CASE tc WHERE ar.TEST_CASE_ID = tc.TCLN_ID AND tc.TA_TEST IS NOT null);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-13-update-is-manual', '2.0.5', '3:fc915e0d25c55ed07a819c85fefab933', 429);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-13-association-auto-cdt-script-auto::amk::(Checksum: 3:e8da5b14d399690b2a11539f85ca27a1)
ALTER TABLE TEST_CASE ADD UUID VARCHAR(36);

ALTER TABLE TEST_CASE ADD CONSTRAINT uc_test_case_uuid UNIQUE (UUID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', '', NOW(), 'Add Column, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-13-association-auto-cdt-script-auto', '2.0.5', '3:e8da5b14d399690b2a11539f85ca27a1', 430);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-13-create-uuid-module-postgresql::aguilhem::(Checksum: 3:c094c64ac4969a0b782b8933b1b49f99)
-- create uuid extension if not exist (for postgresql > 9.1
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aguilhem', 'create uuid extension if not exist (for postgresql > 9.1', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-13-create-uuid-module-postgresql', '2.0.5', '3:c094c64ac4969a0b782b8933b1b49f99', 431);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-13-update-uuid-postgresql::amk::(Checksum: 3:2e212950f4618b282a43bcaeed4aacdd)
-- generate uuid if it's null
UPDATE TEST_CASE SET UUID =  uuid_generate_v4() WHERE UUID is NULL;

ALTER TABLE TEST_CASE ALTER COLUMN UUID SET NOT NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'generate uuid if it''s null', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-13-update-uuid-postgresql', '2.0.5', '3:2e212950f4618b282a43bcaeed4aacdd', 432);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-503-clean-campaign-test-plan-item-table::aguilhem::(Checksum: 3:0788589d8120dbbe8145f9e1a85f3a48)
-- Clean CAMPAIGN_TEST_PLAN_ITEM table from line with null value in CAMPAIGN_ID
DELETE FROM CAMPAIGN_TEST_PLAN_ITEM WHERE CAMPAIGN_ID IS NULL;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('aguilhem', 'Clean CAMPAIGN_TEST_PLAN_ITEM table from line with null value in CAMPAIGN_ID', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-503-clean-campaign-test-plan-item-table', '2.0.5', '3:0788589d8120dbbe8145f9e1a85f3a48', 433);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-180::abo::(Checksum: 3:c36f737b1eb8ae1cf6aaf22a4b7b2c35)
-- Change dataType for RequirementStatus
UPDATE CHART_COLUMN_PROTOTYPE SET DATA_TYPE = 'REQUIREMENT_STATUS'
      WHERE LABEL = 'REQUIREMENT_STATUS' OR LABEL = 'REQUIREMENT_VERSION_STATUS';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('abo', 'Change dataType for RequirementStatus', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-180', '2.0.5', '3:c36f737b1eb8ae1cf6aaf22a4b7b2c35', 434);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-00::bsiri::(Checksum: 3:613679307e297f935cf5d93eca3cd011)
-- Preparatory step : dropping foreign keys pointing to CHART_QUERY and CHART_COLUMN_PROTOTYPE.
ALTER TABLE CHART_DEFINITION DROP CONSTRAINT fk_chart_query;

ALTER TABLE CHART_COLUMN_PROTOTYPE DROP CONSTRAINT fk_column_query;

ALTER TABLE CHART_AXIS_COLUMN DROP CONSTRAINT fk_chart_axis_chart_query;

ALTER TABLE CHART_FILTER DROP CONSTRAINT "fk_chart_FILTER_chart_query";

ALTER TABLE CHART_MEASURE_COLUMN DROP CONSTRAINT fk_chart_measure_chart_query;

ALTER TABLE CHART_COLUMN_ROLE DROP CONSTRAINT fk_column_role_chart_column;

ALTER TABLE CHART_AXIS_COLUMN DROP CONSTRAINT fk_axis_column_chart_column;

ALTER TABLE CHART_FILTER DROP CONSTRAINT fk_chart_filter_chart_column;

ALTER TABLE CHART_MEASURE_COLUMN DROP CONSTRAINT fk_chart_measure_chart_column;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Preparatory step : dropping foreign keys pointing to CHART_QUERY and CHART_COLUMN_PROTOTYPE.', NOW(), 'Drop Foreign Key Constraint (x9)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-00', '2.0.5', '3:613679307e297f935cf5d93eca3cd011', 435);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-01b-h2-pg::bsiri::(Checksum: 3:39c4a51a7aeab50ab97e4598ddd78df5)
-- Rename CHART_QUERY and CHART_COLUMN_PROTOTYPE and their primary keys
create or replace function __liquibase_drop_pk(tableName text) returns void as $$ declare pkname text; sql text; begin pkname = c.conname from pg_class r, pg_constraint c where r.oid = c.conrelid and contype = 'p' and relname ilike tableName; sql = 'alter table ' || tableName || ' drop constraint ' || pkname; execute sql; end; $$ language plpgsql; select __liquibase_drop_pk('CHART_QUERY'); drop function __liquibase_drop_pk(tableName text);

create or replace function __liquibase_drop_pk(tableName text) returns void as $$ declare pkname text; sql text; begin pkname = c.conname from pg_class r, pg_constraint c where r.oid = c.conrelid and contype = 'p' and relname ilike tableName; sql = 'alter table ' || tableName || ' drop constraint ' || pkname; execute sql; end; $$ language plpgsql; select __liquibase_drop_pk('CHART_COLUMN_PROTOTYPE'); drop function __liquibase_drop_pk(tableName text);

ALTER TABLE CHART_QUERY RENAME TO QUERY_MODEL;

ALTER TABLE CHART_COLUMN_PROTOTYPE RENAME TO QUERY_COLUMN_PROTOTYPE;

ALTER TABLE QUERY_MODEL RENAME COLUMN CHART_QUERY_ID TO QUERY_MODEL_ID;

ALTER TABLE QUERY_COLUMN_PROTOTYPE RENAME COLUMN CHART_COLUMN_ID TO QUERY_COLUMN_ID;

ALTER TABLE QUERY_MODEL ADD CONSTRAINT pk_query_model PRIMARY KEY (QUERY_MODEL_ID);

ALTER TABLE QUERY_COLUMN_PROTOTYPE ADD CONSTRAINT pk_query_column_prototype PRIMARY KEY (QUERY_COLUMN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Rename CHART_QUERY and CHART_COLUMN_PROTOTYPE and their primary keys', NOW(), 'Drop Primary Key (x2), Rename Table (x2), Rename Column (x2), Add Primary Key (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-01b-h2-pg', '2.0.5', '3:39c4a51a7aeab50ab97e4598ddd78df5', 436);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-01c::bsiri::(Checksum: 3:71c736728cbdf3a00f21545b808ccb51)
-- Adding unique constraint on QUERY_COLUMN_PROTOTYPE.LABEL since its likely to act as
--   		a surrogate primary key.
ALTER TABLE QUERY_COLUMN_PROTOTYPE ALTER COLUMN  LABEL SET NOT NULL;

ALTER TABLE QUERY_COLUMN_PROTOTYPE ADD UNIQUE (LABEL);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Adding unique constraint on QUERY_COLUMN_PROTOTYPE.LABEL since its likely to act as
  		a surrogate primary key.', NOW(), 'Add Not-Null Constraint, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-01c', '2.0.5', '3:71c736728cbdf3a00f21545b808ccb51', 437);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-02::bsiri::(Checksum: 3:3c67da2863694ee856e17df852d8424a)
-- This table indicates how the projected columns are ordered.
CREATE TABLE QUERY_PROJECTION_COLUMN (QUERY_COLUMN_ID BIGINT NOT NULL, QUERY_MODEL_ID BIGINT NOT NULL, LABEL VARCHAR(30), PROJECTION_OPERATION VARCHAR(20), PROJECTION_RANK INT, CUF_ID BIGINT, CONSTRAINT fk_query_projection_query_model FOREIGN KEY (QUERY_MODEL_ID) REFERENCES QUERY_MODEL(QUERY_MODEL_ID), CONSTRAINT fk_query_projection_query_column FOREIGN KEY (QUERY_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE(QUERY_COLUMN_ID));

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.QUERY_COLUMN_ID IS 'foreign key to the QUERY_COLUMN_PROTOTYPE this projection applies to';

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.QUERY_MODEL_ID IS 'foreign key to a QUERY_MODEL';

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.LABEL IS 'A label for this projected column. Will override the default label of the column prototype if non null.';

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.PROJECTION_OPERATION IS 'the operation applied to the column, if any.';

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.PROJECTION_RANK IS 'the order in which this projected column in the returned tuple.';

COMMENT ON COLUMN QUERY_PROJECTION_COLUMN.CUF_ID IS 'the custom field id for this projection column, if the referenced column is a custom field.';

CREATE TABLE QUERY_AGGREGATION_COLUMN (QUERY_MODEL_ID BIGINT NOT NULL, QUERY_COLUMN_ID BIGINT NOT NULL, LABEL VARCHAR(30), AGGREGATION_OPERATION VARCHAR(20), AGGREGATION_RANK INT, CUF_ID BIGINT, CONSTRAINT fk_query_aggr_query_model FOREIGN KEY (QUERY_MODEL_ID) REFERENCES QUERY_MODEL(QUERY_MODEL_ID), CONSTRAINT fk_query_aggr_query_column FOREIGN KEY (QUERY_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE(QUERY_COLUMN_ID));

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.QUERY_MODEL_ID IS 'foreign key to a QUERY_MODEL.';

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.QUERY_COLUMN_ID IS 'foreign key to the QUERY_COLUMN_PROTOTYPE which must be aggregated on';

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.LABEL IS 'A label for this projected column. Will override the default label of the column prototype if non null.';

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.AGGREGATION_OPERATION IS 'the operation applied to the column, if any.';

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.AGGREGATION_RANK IS 'the order in which this projected column in the returned tuple.';

COMMENT ON COLUMN QUERY_AGGREGATION_COLUMN.CUF_ID IS 'the custom field id for this projection column, if the referenced column is a custom field.';

CREATE TABLE QUERY_FILTER_COLUMN (QUERY_FILTER_ID bigserial NOT NULL, QUERY_COLUMN_ID BIGINT NOT NULL, QUERY_MODEL_ID BIGINT NOT NULL, FILTER_OPERATION VARCHAR(20), CUF_ID BIGINT, CONSTRAINT PK_QUERY_FILTER_COLUMN PRIMARY KEY (QUERY_FILTER_ID), CONSTRAINT fk_query_filter_query_model FOREIGN KEY (QUERY_MODEL_ID) REFERENCES QUERY_MODEL(QUERY_MODEL_ID), CONSTRAINT fk_query_filter_query_column FOREIGN KEY (QUERY_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE(QUERY_COLUMN_ID));

COMMENT ON COLUMN QUERY_FILTER_COLUMN.QUERY_FILTER_ID IS 'autogenerated ID';

COMMENT ON COLUMN QUERY_FILTER_COLUMN.QUERY_COLUMN_ID IS 'foreign key to a QUERY_COLUMN_PROTOTYPE';

COMMENT ON COLUMN QUERY_FILTER_COLUMN.QUERY_MODEL_ID IS 'foreign key to a QUERY_MODEL';

COMMENT ON COLUMN QUERY_FILTER_COLUMN.FILTER_OPERATION IS 'a comparison operator';

COMMENT ON COLUMN QUERY_FILTER_COLUMN.CUF_ID IS 'the custom field id for this filter column, if the referenced column is a custom field.';

CREATE INDEX idx_query_filter ON QUERY_FILTER_COLUMN(QUERY_FILTER_ID);

CREATE TABLE QUERY_FILTER_VALUES (QUERY_FILTER_ID BIGINT NOT NULL, FILTER_VALUE VARCHAR(255), CONSTRAINT fk_query_filter_value_query_filter FOREIGN KEY (QUERY_FILTER_ID) REFERENCES QUERY_FILTER_COLUMN(QUERY_FILTER_ID));

COMMENT ON COLUMN QUERY_FILTER_VALUES.QUERY_FILTER_ID IS 'foreign key to QUERY_FILTER_COLUMN';

COMMENT ON COLUMN QUERY_FILTER_VALUES.FILTER_VALUE IS 'a value for this filter';

CREATE TABLE QUERY_ORDERING_COLUMN (QUERY_MODEL_ID BIGINT NOT NULL, QUERY_COLUMN_ID BIGINT NOT NULL, ORDER_OPERATION VARCHAR(20), ORDER_RANK INT, ORDER_DIR CHAR(3) DEFAULT 'ASC', CUF_ID BIGINT, CONSTRAINT fk_query_order_query_column FOREIGN KEY (QUERY_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE(QUERY_COLUMN_ID), CONSTRAINT fk_query_order_query_model FOREIGN KEY (QUERY_MODEL_ID) REFERENCES QUERY_MODEL(QUERY_MODEL_ID));

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.QUERY_MODEL_ID IS 'foreign key to a QUERY_MODEL. Note that this is a denormalization : that value could be retrieved via the referenced projection column';

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.QUERY_COLUMN_ID IS 'foreign key to the QUERY_COLUMN_PROTOTYPE which must be ordered';

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.ORDER_OPERATION IS 'the operation applied to the column, if any. It must mirror the operation applied to the column they reference in the projection/aggregation clause.';

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.ORDER_RANK IS 'the order in which this ordering instruction must be treated.';

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.ORDER_DIR IS 'either ASC or DESC';

COMMENT ON COLUMN QUERY_ORDERING_COLUMN.CUF_ID IS 'the custom field id for this filter column, if the referenced column is a custom field.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'This table indicates how the projected columns are ordered.', NOW(), 'Create Table (x3), Create Index, Create Table (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-02', '2.0.5', '3:3c67da2863694ee856e17df852d8424a', 438);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-03::bsiri::(Checksum: 3:28c51705fab9a500fe5cb63fe01a4c1e)
-- Now the fun part : migrate the former content into the new content
-- --------------------
      -- migration of axis --
      -- --------------------

      insert into QUERY_AGGREGATION_COLUMN (query_model_id, label, aggregation_operation, aggregation_rank, cuf_id, query_column_id)
      select cac.query_id, cac.label, cac.axis_operation, cac.axis_rank, cac.cuf_id, cac.chart_column_id
      from CHART_AXIS_COLUMN cac
      inner join QUERY_MODEL qm on cac.query_id = qm.query_model_id
      where qm.strategy != 'MAIN';

insert into QUERY_ORDERING_COLUMN (query_model_id, query_column_id, order_rank, order_dir, cuf_id, order_operation)
      select qac.query_model_id, qac.query_column_id, qac.aggregation_rank, 'ASC', qac.cuf_id, qac.aggregation_operation
      from QUERY_AGGREGATION_COLUMN qac;

-- ------------------------
      -- migration of measures --
      -- ------------------------

      insert into QUERY_PROJECTION_COLUMN (query_column_id, query_model_id, label, projection_operation, cuf_id, projection_rank)
      select cmc.chart_column_id, cmc.query_id, cmc.label, cmc.measure_operation, cmc.cuf_id, cmc.measure_rank
      from CHART_MEASURE_COLUMN cmc
      inner join QUERY_MODEL qm on cmc.query_id = qm.query_model_id
      where qm.strategy != 'MAIN';

insert into QUERY_ORDERING_COLUMN(query_model_id, query_column_id, order_dir, cuf_id, order_operation, order_rank)
      select cmc.query_id, cmc.chart_column_id, 'ASC', cmc.cuf_id, cmc.measure_operation, cmc.measure_rank + (
        select count(*) from CHART_AXIS_COLUMN cac where cac.query_id = cmc.query_id
      ) as adjust_rank
      from CHART_MEASURE_COLUMN cmc
      inner join QUERY_MODEL qm on cmc.query_id = qm.query_model_id
      where qm.strategy != 'MAIN';

-- -----------------------
      -- migration of filters --
      -- -----------------------

      insert into QUERY_FILTER_COLUMN (query_column_id, query_model_id, filter_operation, cuf_id)
      select cfc.chart_column_id, cfc.query_id, cfc.filter_operation, cfc.cuf_id
      from CHART_FILTER cfc
      inner join QUERY_MODEL qm on cfc.query_id = qm.query_model_id
      where qm.strategy != 'MAIN';

insert into QUERY_FILTER_VALUES (filter_value, query_filter_id)
      select cfv.filter_value, qfc.query_filter_id
      from CHART_FILTER_VALUES cfv
      inner join CHART_FILTER cfc on cfv.filter_id = cfc.filter_id
      inner join QUERY_MODEL qm on cfc.query_id = qm.query_model_id
      inner join QUERY_FILTER_COLUMN qfc on (
        cfc.chart_column_id = qfc.query_column_id and
        cfc.query_id = qfc.query_model_id and
        cfc.filter_operation = qfc.filter_operation
      )
      where qm.strategy != 'MAIN';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Now the fun part : migrate the former content into the new content', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-03', '2.0.5', '3:28c51705fab9a500fe5cb63fe01a4c1e', 439);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-04a::bsiri::(Checksum: 3:b80a3dbdf7226d13a33f7b4d58347c2d)
-- Creating the new foreign keys from CHART_X_COLUMNS tables, to CHART_DEFINITION. Initially nullable.
ALTER TABLE CHART_AXIS_COLUMN ADD CHART_DEFINITION_ID BIGINT;

ALTER TABLE CHART_AXIS_COLUMN ADD CONSTRAINT fk_chart_axis_chart_def FOREIGN KEY (CHART_DEFINITION_ID) REFERENCES CHART_DEFINITION (CHART_ID);

COMMENT ON COLUMN CHART_AXIS_COLUMN.CHART_DEFINITION_ID IS 'foreign key to the chart_definition';

ALTER TABLE CHART_FILTER ADD CHART_DEFINITION_ID BIGINT;

ALTER TABLE CHART_FILTER ADD CONSTRAINT fk_chart_filter_chart_def FOREIGN KEY (CHART_DEFINITION_ID) REFERENCES CHART_DEFINITION (CHART_ID);

COMMENT ON COLUMN CHART_FILTER.CHART_DEFINITION_ID IS 'foreign key to the chart_definition';

ALTER TABLE CHART_MEASURE_COLUMN ADD CHART_DEFINITION_ID BIGINT;

ALTER TABLE CHART_MEASURE_COLUMN ADD CONSTRAINT fk_chart_meas_chart_def FOREIGN KEY (CHART_DEFINITION_ID) REFERENCES CHART_DEFINITION (CHART_ID);

COMMENT ON COLUMN CHART_MEASURE_COLUMN.CHART_DEFINITION_ID IS 'foreign key to the chart_definition';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Creating the new foreign keys from CHART_X_COLUMNS tables, to CHART_DEFINITION. Initially nullable.', NOW(), 'Add Column (x3)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-04a', '2.0.5', '3:b80a3dbdf7226d13a33f7b4d58347c2d', 440);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-04b-postgresql::bsiri::(Checksum: 3:462475bd167dc7ae0569abc3c2544f7e)
-- Populating the new foreign keys from the tables CHART_X_COLUMN  to CHART_DEFINITION
update CHART_AXIS_COLUMN
      set chart_definition_id = cd.chart_id
      from QUERY_MODEL qm
      inner join CHART_DEFINITION cd on qm.query_model_id = cd.query_id
      where qm.strategy = 'MAIN'
      and CHART_AXIS_COLUMN.query_id = qm.query_model_id;

update CHART_FILTER
      set chart_definition_id = cd.chart_id
      from QUERY_MODEL qm
      inner join CHART_DEFINITION cd on qm.query_model_id = cd.query_id
      where qm.strategy = 'MAIN'
      and CHART_FILTER.query_id = qm.query_model_id;

update CHART_MEASURE_COLUMN
      set chart_definition_id = cd.chart_id
      from QUERY_MODEL qm
      inner join CHART_DEFINITION cd on qm.query_model_id = cd.query_id
      where qm.strategy = 'MAIN'
      and CHART_MEASURE_COLUMN.query_id = qm.query_model_id;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Populating the new foreign keys from the tables CHART_X_COLUMN  to CHART_DEFINITION', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-04b-postgresql', '2.0.5', '3:462475bd167dc7ae0569abc3c2544f7e', 441);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-04c::bsiri::(Checksum: 3:51fb1d72057ab9b0f7fad9e7161ac8db)
-- also delete the former QUERY_MODELs that previously had user data,
--       because now the CHART_X_COLUMNS now solely rely on their CHART_DEFINITION
delete from CHART_FILTER_VALUES
      where filter_id in (
      select filter_id from CHART_FILTER where chart_definition_id is null
      );

delete from CHART_FILTER where chart_definition_id is null;

delete from CHART_AXIS_COLUMN where chart_definition_id is null;

delete from CHART_MEASURE_COLUMN where chart_definition_id is null;

delete from QUERY_MODEL where strategy = 'MAIN';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'also delete the former QUERY_MODELs that previously had user data,
      because now the CHART_X_COLUMNS now solely rely on their CHART_DEFINITION', NOW(), 'Custom SQL (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-04c', '2.0.5', '3:51fb1d72057ab9b0f7fad9e7161ac8db', 442);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-04d::bsiri::(Checksum: 3:ab13e31e7ef0823a5e1ecd90dddf317d)
-- Now dropping the now useless columns that pointed to QUERY_MODEL
ALTER TABLE CHART_AXIS_COLUMN DROP COLUMN QUERY_ID;

ALTER TABLE CHART_FILTER DROP COLUMN QUERY_ID;

ALTER TABLE CHART_MEASURE_COLUMN DROP COLUMN QUERY_ID;

ALTER TABLE CHART_DEFINITION DROP COLUMN QUERY_ID;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Now dropping the now useless columns that pointed to QUERY_MODEL', NOW(), 'Drop Column (x4)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-04d', '2.0.5', '3:ab13e31e7ef0823a5e1ecd90dddf317d', 443);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-05::bsiri::(Checksum: 3:4d9860d29f71395a9be0d4e77a8fc2d9)
-- Rewiring the remaining foreign keys.
ALTER TABLE QUERY_COLUMN_PROTOTYPE ADD CONSTRAINT fk_query_col_query_model FOREIGN KEY (SUBQUERY_ID) REFERENCES QUERY_MODEL (QUERY_MODEL_ID);

ALTER TABLE CHART_COLUMN_ROLE ADD CONSTRAINT fk_column_role_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE (QUERY_COLUMN_ID);

ALTER TABLE CHART_AXIS_COLUMN ADD CONSTRAINT fk_axis_column_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE (QUERY_COLUMN_ID);

ALTER TABLE CHART_FILTER ADD CONSTRAINT fk_chart_filter_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE (QUERY_COLUMN_ID);

ALTER TABLE CHART_MEASURE_COLUMN ADD CONSTRAINT fk_chart_measure_chart_column FOREIGN KEY (CHART_COLUMN_ID) REFERENCES QUERY_COLUMN_PROTOTYPE (QUERY_COLUMN_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'Rewiring the remaining foreign keys.', NOW(), 'Add Foreign Key Constraint (x5)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-05', '2.0.5', '3:4d9860d29f71395a9be0d4e77a8fc2d9', 444);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-05b::bsiri::(Checksum: 3:61e4eab681aa9f8f0f240d697bb0b43f)
-- For postgresql, we need to explicitly create the index on foreign key columns and ensure sequence order.
CREATE INDEX idx_fk_query_projection_query_column ON QUERY_PROJECTION_COLUMN(QUERY_COLUMN_ID);

CREATE INDEX idx_fk_query_projection_query_model ON QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID);

CREATE INDEX idx_fk_query_aggr_query_column ON QUERY_AGGREGATION_COLUMN(QUERY_COLUMN_ID);

CREATE INDEX idx_fk_query_aggr_query_model ON QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID);

CREATE INDEX idx_fk_query_filter_query_column ON QUERY_FILTER_COLUMN(QUERY_COLUMN_ID);

CREATE INDEX idx_fk_query_filter_query_model ON QUERY_FILTER_COLUMN(QUERY_MODEL_ID);

CREATE INDEX idx_fk_query_order_query_column ON QUERY_ORDERING_COLUMN(QUERY_COLUMN_ID);

CREATE INDEX idx_fk_query_order_query_model ON QUERY_ORDERING_COLUMN(QUERY_MODEL_ID);

CREATE INDEX idx_fk_chart_axis_chart_def ON CHART_AXIS_COLUMN(CHART_DEFINITION_ID);

CREATE INDEX idx_fk_chart_filter_chart_def ON CHART_FILTER(CHART_DEFINITION_ID);

CREATE INDEX idx_fk_chart_meas_chart_def ON CHART_MEASURE_COLUMN(CHART_DEFINITION_ID);

DROP SEQUENCE chart_query_chart_query_id_seq CASCADE;

CREATE SEQUENCE query_model_query_model_id_seq INCREMENT BY 1 OWNED BY QUERY_MODEL.QUERY_MODEL_ID;

ALTER TABLE QUERY_MODEL ALTER COLUMN QUERY_MODEL_ID SET DEFAULT nextval('query_model_query_model_id_seq');

SELECT setval('query_model_query_model_id_seq', (SELECT MAX(QUERY_MODEL_ID) from QUERY_MODEL));

DROP SEQUENCE chart_column_prototype_chart_column_id_seq CASCADE;

CREATE SEQUENCE query_column_prototype_query_column_id_seq INCREMENT BY 1 OWNED BY QUERY_COLUMN_PROTOTYPE.QUERY_COLUMN_ID;

ALTER TABLE QUERY_COLUMN_PROTOTYPE ALTER COLUMN QUERY_COLUMN_ID SET DEFAULT nextval('query_column_prototype_query_column_id_seq');

SELECT setval('query_column_prototype_query_column_id_seq', (SELECT MAX(QUERY_COLUMN_ID) from QUERY_COLUMN_PROTOTYPE));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'For postgresql, we need to explicitly create the index on foreign key columns and ensure sequence order.', NOW(), 'Create Index (x11), Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-05b', '2.0.5', '3:61e4eab681aa9f8f0f240d697bb0b43f', 445);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-06::bsiri::(Checksum: 3:eba5dafc64d9c19d5fcc261c72208226)
-- For the subqueries we have to use (w)hacky SQL. This is because we need to select-insert from no table,
--     which is supported with specific syntax by each table but aren't compatible together (we would need to
--       'select from dual' in postgresql for example).
-- ----------------------------------------------- --
      -- Inserting first the attribute columns. Some of  --
      -- them will be used in new query models, declared --
      -- just after them.                                --
      -- 												 --
      -- Also the first new columns declared are Entity  --
      -- columns : they represent the entity itself and  --
      -- have a COLUMN_TYPE = 'ENTITY'. Only the most 	 --
      -- common entities are represented, entities like  --
      -- RequirementVersionCoverage (for example) aren't --
      -- declared.
      -- ----------------------------------------------- --

      INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS) VALUES

      ('ENTITY', 'REQUIREMENT', NULL, 'REQUIREMENT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'REQUIREMENT_VERSION', NULL, 'REQUIREMENT_VERSION_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'TEST_CASE', NULL, 'TEST_CASE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'CAMPAIGN', NULL, 'CAMPAIGN_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ITERATION', NULL, 'ITERATION_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ITEM_TEST_PLAN', NULL, 'ITEM_TEST_PLAN_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'EXECUTION', NULL, 'EXECUTION_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ISSUE', NULL, 'ISSUE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'TEST_CASE_STEP', NULL, 'TEST_CASE_STEP_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'INFO_LIST_ITEM', 'TEST_CASE_NATURE', 'TEST_CASE_NATURE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'INFO_LIST_ITEM', 'TEST_CASE_TYPE', 'TEST_CASE_TYPE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'INFO_LIST_ITEM', 'REQUIREMENT_VERSION_CATEGORY', 'REQUIREMENT_VERSION_CATEGORY_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'USER', 'ITERATION_TEST_PLAN_ASSIGNED_USER', 'ITERATION_TEST_PLAN_ASSIGNED_USER_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'MILESTONE', 'TEST_CASE_MILESTONE', 'TEST_CASE_MILESTONE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'MILESTONE', 'REQUIREMENT_VERSION_MILESTONE', 'REQUIREMENT_VERSION_MILESTONE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'MILESTONE', 'CAMPAIGN_MILESTONE', 'CAMPAIGN_MILESTONE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'AUTOMATED_TEST', NULL, 'AUTOMATED_TEST_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'AUTOMATED_EXECUTION_EXTENDER', NULL, 'AUTOMATED_EXECUTION_EXTENDER_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT_LIST', 'TEST_CASE_ATTLIST', 'TEST_CASE_ATTLIST_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT_LIST', 'REQUIREMENT_VERSION_ATTLIST', 'REQUIREMENT_VERSION_ATTLIST_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT_LIST', 'CAMPAIGN_ATTLIST', 'CAMPAIGN_ATTLIST_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT', 'TEST_CASE_ATTACHMENT', 'TEST_CASE_ATTACHMENT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT', 'CAMPAIGN_ATTACHMENT', 'CAMPAIGN_ATTACHMENT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'ATTACHMENT', 'REQUIREMENT_VERSION_ATTACHMENT', 'REQUIREMENT_VERSION_ATTACHMENT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'DATASET', NULL, 'DATASET_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'PARAMETER', NULL, 'PARAMETER_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'PROJECT', 'TEST_CASE_PROJECT', 'TEST_CASE_PROJECT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'PROJECT', 'REQUIREMENT_PROJECT', 'REQUIREMENT_PROJECT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'PROJECT', 'CAMPAIGN_PROJECT', 'CAMPAIGN_PROJECT_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'TEST_SUITE', 'ITEM_SUITE', 'ITEM_SUITE_ENTITY', NULL, 'ENTITY', FALSE),
      ('ENTITY', 'AUTOMATION_REQUEST', NULL, 'AUTOMATION_REQUEST_ENTITY', NULL, 'ENTITY', FALSE),


      ('ATTRIBUTE', 'MILESTONE', 'CAMPAIGN_MILESTONE', 'CAMPAIGN_MILESTONE_LABEL', 'label', 'STRING', FALSE),


      ('ATTRIBUTE', 'PROJECT', 'TEST_CASE_PROJECT', 'TEST_CASE_PROJECT_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'PROJECT', 'TEST_CASE_PROJECT', 'TEST_CASE_PROJECT_NAME', 'name', 'STRING', FALSE),
      ('ATTRIBUTE', 'PROJECT', 'REQUIREMENT_PROJECT', 'REQUIREMENT_PROJECT_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'PROJECT', 'REQUIREMENT_PROJECT', 'REQUIREMENT_PROJECT_NAME', 'name', 'STRING', FALSE),
      ('ATTRIBUTE', 'PROJECT', 'CAMPAIGN_PROJECT', 'CAMPAIGN_PROJECT_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'PROJECT', 'CAMPAIGN_PROJECT', 'CAMPAIGN_PROJECT_NAME', 'name', 'STRING', FALSE),


      ('ATTRIBUTE', 'ATTACHMENT_LIST', 'TEST_CASE_ATTLIST', 'TEST_CASE_ATTLIST_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'ATTACHMENT_LIST', 'REQUIREMENT_VERSION_ATTLIST', 'REQUIREMENT_VERSION_ATTLIST_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'ATTACHMENT_LIST', 'CAMPAIGN_ATTLIST', 'CAMPAIGN_ATTLIST_ID', 'id', 'NUMERIC', FALSE),

      ('ATTRIBUTE', 'ATTACHMENT', 'TEST_CASE_ATTACHMENT', 'TEST_CASE_ATTACHMENT_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'ATTACHMENT', 'REQUIREMENT_VERSION_ATTACHMENT', 'REQUIREMENT_VERSION_ATTACHMENT_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'ATTACHMENT', 'CAMPAIGN_ATTACHMENT', 'CAMPAIGN_ATTACHMENT_ID', 'id', 'NUMERIC', FALSE),

      ('ATTRIBUTE', 'DATASET', NULL, 'DATASET_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'PARAMETER', NULL, 'PARAMETER_ID', 'id', 'NUMERIC', FALSE),

      ('ATTRIBUTE', 'MILESTONE', 'TEST_CASE_MILESTONE',   'TEST_CASE_MILESTONE_STATUS', 'status', 'LEVEL_ENUM', FALSE),
      ('ATTRIBUTE', 'MILESTONE', 'TEST_CASE_MILESTONE',   'TEST_CASE_MILESTONE_END_DATE', 'endDate', 'DATE', FALSE),
      ('ATTRIBUTE', 'MILESTONE', 'REQUIREMENT_VERSION_MILESTONE', 'REQUIREMENT_VERSION_MILESTONE_STATUS', 'status', 'LEVEL_ENUM', FALSE),
      ('ATTRIBUTE', 'MILESTONE', 'REQUIREMENT_VERSION_MILESTONE', 'REQUIREMENT_VERSION_MILESTONE_END_DATE', 'endDate', 'DATE', FALSE),
      ('ATTRIBUTE', 'MILESTONE', 'CAMPAIGN_MILESTONE',    'CAMPAIGN_MILESTONE_STATUS', 'status', 'LEVEL_ENUM', FALSE),
      ('ATTRIBUTE', 'MILESTONE', 'CAMPAIGN_MILESTONE',    'CAMPAIGN_MILESTONE_END_DATE', 'endDate', 'DATE', FALSE),

      ('ATTRIBUTE', 'AUTOMATION_REQUEST', NULL, 'AUTOMATION_REQUEST_ID', 'id', 'NUMERIC', FALSE),
      ('ATTRIBUTE', 'AUTOMATION_REQUEST', NULL, 'AUTOMATION_REQUEST_STATUS', 'requestStatus', 'LEVEL_ENUM', FALSE),

      ('ATTRIBUTE', 'REQUIREMENT_VERSION', NULL, 'REQUIREMENT_VERSION_NAME', 'name', 'STRING', FALSE),
      ('ATTRIBUTE', 'REQUIREMENT_VERSION', NULL, 'REQUIREMENT_VERSION_DESCRIPTION', 'description', 'STRING', FALSE),

      ('ATTRIBUTE', 'TEST_CASE', NULL, 'TEST_CASE_NAME', 'name', 'STRING', FALSE),
      ('ATTRIBUTE', 'TEST_CASE', NULL, 'TEST_CASE_DESCRIPTION', 'description', 'STRING', FALSE),
      ('ATTRIBUTE', 'TEST_CASE', NULL, 'TEST_CASE_KIND', 'kind', 'LEVEL_ENUM', FALSE),
      ('ATTRIBUTE', 'TEST_CASE', NULL, 'TEST_CASE_PREQUISITE', 'prerequisite', 'STRING', FALSE),
      ('ATTRIBUTE', 'TEST_CASE', NULL, 'TEST_CASE_AUTOMATABLE', 'automatable', 'LEVEL_ENUM', FALSE),

      ('ATTRIBUTE', 'CAMPAIGN', NULL, 'CAMPAIGN_NAME', 'name', 'STRING', FALSE),

      ('ATTRIBUTE', 'ITERATION', NULL, 'ITERATION_NAME', 'name', 'STRING', FALSE),

      ('ATTRIBUTE', 'TEST_SUITE', 'ITEM_SUITE', 'ITEM_SUITE_ID', 'id', 'NUMERIC', FALSE),

      ('ATTRIBUTE', 'EXECUTION', NULL, 'EXECUTION_EXECUTION_MODE', 'executionMode', 'LEVEL_ENUM', FALSE),
      ('ATTRIBUTE', 'EXECUTION', NULL, 'EXECUTION_LAST_EXECUTED_ON', 'lastExecutedOn', 'DATE', FALSE),

      ('ATTRIBUTE', 'EXECUTION', NULL, 'ITEM_TEST_PLAN_LASTEXECBY', 'lastExecutedBy', 'STRING', FALSE);

-- ----------------------------------------------- --
      -- Inserting subqueries that implement the         --
      -- 'CALCULATED' columns defined right after them   --
      -- ----------------------------------------------- --


      -- requirement version attachment count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('REQUIREMENT_VERSION_ATTCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
        select
          (select max(QUERY_MODEL_ID) from QUERY_MODEL),
          (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'REQUIREMENT_VERSION_ID'),
          'NONE', 0
        from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
        select
          (select max(QUERY_MODEL_ID) from QUERY_MODEL),
          (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'REQUIREMENT_VERSION_ATTACHMENT_ID'),
          'COUNT', 0
        from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
        select
          'CALCULATED', 'REQUIREMENT_VERSION', NULL, 'REQUIREMENT_VERSION_ATTCOUNT', 'count(attachment)', 'NUMERIC', FALSE,
          (select max(QUERY_MODEL_ID) from QUERY_MODEL)
        from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

-- test case attachment count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('TEST_CASE_ATTCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
        select
          (select max(QUERY_MODEL_ID) from QUERY_MODEL),
          (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'TEST_CASE_ID'),
          'NONE', 0
        from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
        select
          (select max(QUERY_MODEL_ID) from QUERY_MODEL),
          (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'TEST_CASE_ATTACHMENT_ID'),
          'COUNT', 0
        from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
      select
      'CALCULATED', 'TEST_CASE', NULL, 'TEST_CASE_ATTCOUNT', 'count(attachment)', 'NUMERIC', FALSE,
      (select max(QUERY_MODEL_ID) from QUERY_MODEL)
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

-- test case parameter count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('TEST_CASE_PARAMCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'TEST_CASE_ID'),
      'NONE', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'PARAMETER_ID'),
      'COUNT', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
      select
      'CALCULATED', 'TEST_CASE', NULL, 'TEST_CASE_PARAMCOUNT', 'count(parameter)', 'NUMERIC', FALSE,
      (select max(QUERY_MODEL_ID) from QUERY_MODEL)
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

-- test case dataset count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('TEST_CASE_DATASETCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'TEST_CASE_ID'),
      'NONE', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'DATASET_ID'),
      'COUNT', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
      select
      'CALCULATED', 'TEST_CASE', NULL, 'TEST_CASE_DATASETCOUNT', 'count(dataset)', 'NUMERIC', FALSE,
      (select max(QUERY_MODEL_ID) from QUERY_MODEL)
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

-- item suite count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('ITEM_TEST_PLAN_SUITECOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'ITEM_TEST_PLAN_ID'),
      'NONE', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'ITEM_SUITE_ID'),
      'COUNT', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
      select
      'CALCULATED', 'ITEM_TEST_PLAN', NULL, 'ITEM_TEST_PLAN_SUITECOUNT', 'count(testSuites)', 'NUMERIC', FALSE,
      (select max(QUERY_MODEL_ID) from QUERY_MODEL)
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

-- item dataset count subquery
      -- the inserts follow the order : query_model, aggregation, projection and finally the query_column_prototype

      INSERT INTO QUERY_MODEL (NAME, STRATEGY, JOIN_STYLE) values ('ITEM_TEST_PLAN_DSCOUNT_SUBQUERY', 'SUBQUERY', 'LEFT_JOIN');

INSERT INTO QUERY_AGGREGATION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, AGGREGATION_OPERATION, AGGREGATION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'ITEM_TEST_PLAN_ID'),
      'NONE', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_PROJECTION_COLUMN(QUERY_MODEL_ID, QUERY_COLUMN_ID, PROJECTION_OPERATION, PROJECTION_RANK)
      select
      (select max(QUERY_MODEL_ID) from QUERY_MODEL),
      (select QUERY_COLUMN_ID from QUERY_COLUMN_PROTOTYPE where label = 'DATASET_ID'),
      'COUNT', 0
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO QUERY_COLUMN_PROTOTYPE (COLUMN_TYPE, ENTITY_TYPE, ENTITY_ROLE, LABEL, ATTRIBUTE_NAME, DATA_TYPE, BUSINESS, SUBQUERY_ID)
      select
      'CALCULATED', 'ITEM_TEST_PLAN', NULL, 'ITEM_TEST_PLAN_DSCOUNT', 'count(datasets)', 'NUMERIC', FALSE,
      (select max(QUERY_MODEL_ID) from QUERY_MODEL)
      from QUERY_COLUMN_PROTOTYPE where query_column_id = 1;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('bsiri', 'For the subqueries we have to use (w)hacky SQL. This is because we need to select-insert from no table,
    which is supported with specific syntax by each table but aren''t compatible together (we would need to
      ''select from dual'' in postgresql fo...', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-06', '2.0.5', '3:eba5dafc64d9c19d5fcc261c72208226', 446);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::create_index_fulltext_mysql::abo::(Checksum: 3:dd1d6ef3f13ce57105cdd4d5816d4532)
-- Create fulltext index on specific columns to search on it
CREATE INDEX resource_description_fulltext_idx ON RESOURCE USING GIN(to_tsvector('simple',DESCRIPTION));

CREATE INDEX tcln_description_fulltext_idx ON TEST_CASE_LIBRARY_NODE USING GIN(to_tsvector('simple',DESCRIPTION));

CREATE INDEX tc_prerequisite_fulltext_idx ON TEST_CASE USING GIN(to_tsvector('simple',PREREQUISITE));

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('abo', 'Create fulltext index on specific columns to search on it', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'create_index_fulltext_mysql', '2.0.5', '3:dd1d6ef3f13ce57105cdd4d5816d4532', 447);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::update_datatype_to_fulltext_search::abo::(Checksum: 3:8b0f61037589f2c94bbd3cbe2d39db8f)
UPDATE QUERY_COLUMN_PROTOTYPE SET DATA_TYPE = 'TEXT' WHERE LABEL IN ('TEST_CASE_DESCRIPTION', 'REQUIREMENT_VERSION_DESCRIPTION', 'TEST_CASE_PREQUISITE');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('abo', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'update_datatype_to_fulltext_search', '2.0.5', '3:8b0f61037589f2c94bbd3cbe2d39db8f', 448);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml::tm-1.20.0-TM-282-delete-lastindexing-properties::jprioux::(Checksum: 3:32d0bfb9bce4e8ddd926e1917d15933b)
-- Delete all lastindexing properties from core config
DELETE FROM CORE_CONFIG WHERE STR_KEY LIKE 'lastindexing.%';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Delete all lastindexing properties from core config', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.20.0.xml', 'tm-1.20.0-TM-282-delete-lastindexing-properties', '2.0.5', '3:32d0bfb9bce4e8ddd926e1917d15933b', 449);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0::jprioux::(Checksum: 3:3de25266fed570b489278e0a0ef2a4e9)
-- Update TM database version number
UPDATE CORE_CONFIG SET VALUE = '1.21.0' WHERE STR_KEY = 'squashtest.tm.database.version';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Update TM database version number', NOW(), 'Update Data', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0', '2.0.5', '3:3de25266fed570b489278e0a0ef2a4e9', 450);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-244-remote-automation-request-extender::jlor::(Checksum: 3:8dc9c229686aa18dc95cebf28a023310)
-- Create new table for RemoteAutomationRequestExtender
CREATE TABLE REMOTE_AUTOMATION_REQUEST_EXTENDER (REMOTE_AUTOMATION_REQUEST_EXTENDER_ID bigserial NOT NULL, AUTOMATION_REQUEST_ID BIGINT NOT NULL, SERVER_ID BIGINT, REMOTE_STATUS VARCHAR(255), REMOTE_ISSUE_KEY VARCHAR(255) NOT NULL, REMOTE_REQUEST_URL VARCHAR(300), REMOTE_ASSIGNED_TO VARCHAR(300) NOT NULL, CONSTRAINT PK_REMOTE_AUTOMATION_REQUEST_EXTENDER PRIMARY KEY (REMOTE_AUTOMATION_REQUEST_EXTENDER_ID), CONSTRAINT fk_remote_automation_request_extender_automation_request_id FOREIGN KEY (AUTOMATION_REQUEST_ID) REFERENCES AUTOMATION_REQUEST (AUTOMATION_REQUEST_ID), CONSTRAINT fk_remote_automation_request_extender_server_id FOREIGN KEY (SERVER_ID) REFERENCES BUGTRACKER (BUGTRACKER_ID));

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.REMOTE_AUTOMATION_REQUEST_EXTENDER_ID IS 'The auto-generated id';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.AUTOMATION_REQUEST_ID IS 'The automation request this extender extends';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.SERVER_ID IS 'The bugtracker to which the automation request is linked';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.REMOTE_STATUS IS 'The remote status as defined in the bugtracker';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.REMOTE_ISSUE_KEY IS 'The remote issue key as generated by Jira';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.REMOTE_REQUEST_URL IS 'The Url to the remote request';

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.REMOTE_ASSIGNED_TO IS 'email of the assigned';

CREATE INDEX idx_fk_remote_automation_request_extender_automation_request_id ON REMOTE_AUTOMATION_REQUEST_EXTENDER(AUTOMATION_REQUEST_ID);

CREATE INDEX idx_fk_remote_automation_request_extender_server_id ON REMOTE_AUTOMATION_REQUEST_EXTENDER(SERVER_ID);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Create new table for RemoteAutomationRequestExtender', NOW(), 'Create Table, Create Index (x2)', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-244-remote-automation-request-extender', '2.0.5', '3:8dc9c229686aa18dc95cebf28a023310', 451);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-248-automation-workflow-type::jlor::(Checksum: 3:db8a1bb56c55f31ba9457217ce21c542)
-- Modify column ALLOW_AUTOMATION_WORKFLOW into AUTOMATION_WORKFLOW_TYPE
ALTER TABLE PROJECT ADD AUTOMATION_WORKFLOW_TYPE VARCHAR(25) NOT NULL DEFAULT 'NONE';

COMMENT ON COLUMN PROJECT.AUTOMATION_WORKFLOW_TYPE IS 'This column precises which workflow type is used.';

update PROJECT
      set AUTOMATION_WORKFLOW_TYPE =
      case
      when ALLOW_AUTOMATION_WORKFLOW = true then 'NATIVE'
      else 'NONE'
      end;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Modify column ALLOW_AUTOMATION_WORKFLOW into AUTOMATION_WORKFLOW_TYPE', NOW(), 'Add Column, Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-248-automation-workflow-type', '2.0.5', '3:db8a1bb56c55f31ba9457217ce21c542', 452);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-248-plugin-type::amk::(Checksum: 3:a8abe06a93bad7ac3cfb96da0a4c8996)
-- add new column PLUGIN_TYPE into LIBRARY_PLUGIN_BINDING
ALTER TABLE LIBRARY_PLUGIN_BINDING ADD PLUGIN_TYPE VARCHAR(25);

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.PLUGIN_TYPE IS 'This column specifies which type of plugin is used. for now only one type used: Automation.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column PLUGIN_TYPE into LIBRARY_PLUGIN_BINDING', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-248-plugin-type', '2.0.5', '3:a8abe06a93bad7ac3cfb96da0a4c8996', 453);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-211-active::amk::(Checksum: 3:6593378e5c157e88a01677406ab8b96c)
-- add new column ACTIVE into LIBRARY_PLUGIN_BINDING
ALTER TABLE LIBRARY_PLUGIN_BINDING ADD ACTIVE BOOLEAN DEFAULT TRUE;

COMMENT ON COLUMN LIBRARY_PLUGIN_BINDING.ACTIVE IS 'This column specifies if plugin is enable or disable for a project .';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column ACTIVE into LIBRARY_PLUGIN_BINDING', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-211-active', '2.0.5', '3:6593378e5c157e88a01677406ab8b96c', 454);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-649-sync-enable::api::(Checksum: 3:5e0a2ca525eb084a42d1283a70cc8bf1)
-- add new column Sync_Enable into REMOTE_SYNCHONISATION
ALTER TABLE REMOTE_SYNCHRONISATION ADD SYNC_ENABLE BOOLEAN NOT NULL DEFAULT TRUE;

COMMENT ON COLUMN REMOTE_SYNCHRONISATION.SYNC_ENABLE IS 'This column specifies if synchronisation is enable or disable for a project';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('api', 'add new column Sync_Enable into REMOTE_SYNCHONISATION', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-649-sync-enable', '2.0.5', '3:5e0a2ca525eb084a42d1283a70cc8bf1', 455);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-211-last-sync-date::amk::(Checksum: 3:524769522739ee35799e2ab2bff89c54)
-- add new column LAST-SYNC-DATE into REMOTE_AUTOMATION_REQUEST_EXTENDER
ALTER TABLE REMOTE_AUTOMATION_REQUEST_EXTENDER ADD LAST_SYNC_DATE TIMESTAMP WITH TIME ZONE DEFAULT null;

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.LAST_SYNC_DATE IS 'Date of the last synchronisation.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column LAST-SYNC-DATE into REMOTE_AUTOMATION_REQUEST_EXTENDER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-211-last-sync-date', '2.0.5', '3:524769522739ee35799e2ab2bff89c54', 456);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-725-add-committer-mail-in-scm-server::jlor::(Checksum: 3:d14262f9fcaa9ca9142c9e0f8ff05628)
-- Add column COMMITTER_MAIL in SCM_SERVER
ALTER TABLE SCM_SERVER ADD COMMITTER_MAIL VARCHAR(255) NOT NULL DEFAULT '';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'Add column COMMITTER_MAIL in SCM_SERVER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-725-add-committer-mail-in-scm-server', '2.0.5', '3:d14262f9fcaa9ca9142c9e0f8ff05628', 457);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-713-add-axis_and_measure-to-execution_is_auto::abo::(Checksum: 3:9b88c6309933383f5446526b1a2623e5)
INSERT INTO CHART_COLUMN_ROLE (CHART_COLUMN_ID, ROLE) values ((SELECT QUERY_COLUMN_ID FROM QUERY_COLUMN_PROTOTYPE WHERE QUERY_COLUMN_PROTOTYPE.LABEL = 'EXECUTION_ISAUTO'), 'MEASURE'),
      ((SELECT QUERY_COLUMN_ID FROM QUERY_COLUMN_PROTOTYPE WHERE QUERY_COLUMN_PROTOTYPE.LABEL = 'EXECUTION_ISAUTO'), 'AXIS');

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('abo', '', NOW(), 'Custom SQL', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-713-add-axis_and_measure-to-execution_is_auto', '2.0.5', '3:9b88c6309933383f5446526b1a2623e5', 458);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-211-sent-value-for-sync::amk::(Checksum: 3:c35d46bb8ab7fe59bccae017807cf6b6)
-- add new column SENT_VALUE_FOR_SYNC into REMOTE_AUTOMATION_REQUEST_EXTENDER
ALTER TABLE REMOTE_AUTOMATION_REQUEST_EXTENDER ADD SENT_VALUE_FOR_SYNC TEXT DEFAULT null;

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.SENT_VALUE_FOR_SYNC IS 'The values ​​of the test case fields sent during synchronization.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column SENT_VALUE_FOR_SYNC into REMOTE_AUTOMATION_REQUEST_EXTENDER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-211-sent-value-for-sync', '2.0.5', '3:c35d46bb8ab7fe59bccae017807cf6b6', 459);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-916-918-synchronizable-issue-status::amk::(Checksum: 3:27e3ce65341d7b7624b5d8b7db75c1d6)
-- add new column SYNCHRONIZABLE_ISSUE_STATUS into REMOTE_AUTOMATION_REQUEST_EXTENDER
ALTER TABLE REMOTE_AUTOMATION_REQUEST_EXTENDER ADD SYNCHRONIZABLE_ISSUE_STATUS VARCHAR(25);

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.SYNCHRONIZABLE_ISSUE_STATUS IS 'this column can be set to: TO SYNCHRONIZE, DELETED, MOVED_PROJECT and MOVED_ISSUE_TYPE ; and it is updated after each synchronization.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column SYNCHRONIZABLE_ISSUE_STATUS into REMOTE_AUTOMATION_REQUEST_EXTENDER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-916-918-synchronizable-issue-status', '2.0.5', '3:27e3ce65341d7b7624b5d8b7db75c1d6', 460);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-875-last-sync-date-squash::amk::(Checksum: 3:2d4677a94faf63e4cefd653582757c6e)
-- add new column LAST-SYNC-DATE into REMOTE_AUTOMATION_REQUEST_EXTENDER
ALTER TABLE REMOTE_AUTOMATION_REQUEST_EXTENDER ADD LAST_SYNC_DATE_SQUASH TIMESTAMP WITH TIME ZONE DEFAULT null;

COMMENT ON COLUMN REMOTE_AUTOMATION_REQUEST_EXTENDER.LAST_SYNC_DATE_SQUASH IS 'Date of the last synchronisation squash to remote server.';

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('amk', 'add new column LAST-SYNC-DATE into REMOTE_AUTOMATION_REQUEST_EXTENDER', NOW(), 'Add Column', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-875-last-sync-date-squash', '2.0.5', '3:2d4677a94faf63e4cefd653582757c6e', 461);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-846.1-postgresql::jlor::(Checksum: 3:b200ec6ad53f362677ba6d8925425026)
-- PostgreSQL - Add unique constraint on order column for iterations in campaign
drop table if exists CAMPAIGN_ITERATION_TMP;

create table CAMPAIGN_ITERATION_TMP AS
          (select
            CAMPAIGN_ID,
            ITERATION_ID,
            min(ITERATION_ORDER) ITERATION_ORDER
          from CAMPAIGN_ITERATION
          group by CAMPAIGN_ID, ITERATION_ID);

create index idx1 on CAMPAIGN_ITERATION_TMP(CAMPAIGN_ID, ITERATION_ID);

update CAMPAIGN_ITERATION_TMP t1
        set ITERATION_ORDER = t2.line - 1
        from (
          select
            CAMPAIGN_ID,
            ITERATION_ID,
            (select count(*)
            from CAMPAIGN_ITERATION_TMP b
            where a.CAMPAIGN_ID = b.CAMPAIGN_ID
            and a.ITERATION_ORDER >= b.ITERATION_ORDER) line
          from CAMPAIGN_ITERATION_TMP a) t2
          where t1.CAMPAIGN_ID = t2.CAMPAIGN_ID
          and t1.ITERATION_ID = t2.ITERATION_ID;

truncate table CAMPAIGN_ITERATION;

insert into CAMPAIGN_ITERATION
        select
          a.CAMPAIGN_ID,
          a.ITERATION_ID,
          a.ITERATION_ORDER + 1 - (select count(*)
                              from CAMPAIGN_ITERATION_TMP b
                              where a.CAMPAIGN_ID = b.CAMPAIGN_ID
                              and a.ITERATION_ORDER = b.ITERATION_ORDER
                              and a.ITERATION_ID <= b.ITERATION_ID
                              group by
                                b.CAMPAIGN_ID,
                                b.ITERATION_ORDER) ITERATION_ORDER
          from CAMPAIGN_ITERATION_TMP a;

drop table CAMPAIGN_ITERATION_TMP;

ALTER TABLE CAMPAIGN_ITERATION ADD UNIQUE (CAMPAIGN_ID, ITERATION_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'PostgreSQL - Add unique constraint on order column for iterations in campaign', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-846.1-postgresql', '2.0.5', '3:b200ec6ad53f362677ba6d8925425026', 462);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-846.2-postgresql::jlor::(Checksum: 3:8cf67086e57245fed8fa7ed9d5c65498)
-- PostgreSQL - Add unique constraint on order column for executions in itpi
drop table if exists ITEM_TEST_PLAN_EXECUTION_TMP;

create table ITEM_TEST_PLAN_EXECUTION_TMP AS
          (select
            ITEM_TEST_PLAN_ID,
            EXECUTION_ID,
            min(EXECUTION_ORDER) EXECUTION_ORDER
          from ITEM_TEST_PLAN_EXECUTION
          group by ITEM_TEST_PLAN_ID, EXECUTION_ID);

create index idx1 on ITEM_TEST_PLAN_EXECUTION_TMP(ITEM_TEST_PLAN_ID, EXECUTION_ID);

update ITEM_TEST_PLAN_EXECUTION_TMP t1
        set EXECUTION_ORDER = t2.line - 1
        from (
          select
            ITEM_TEST_PLAN_ID,
            EXECUTION_ID,
            (select count(*)
            from ITEM_TEST_PLAN_EXECUTION_TMP b
            where a.ITEM_TEST_PLAN_ID = b.ITEM_TEST_PLAN_ID
            and a.EXECUTION_ORDER >= b.EXECUTION_ORDER) line
          from ITEM_TEST_PLAN_EXECUTION_TMP a) t2
          where t1.ITEM_TEST_PLAN_ID = t2.ITEM_TEST_PLAN_ID
          and t1.EXECUTION_ID = t2.EXECUTION_ID;

truncate table ITEM_TEST_PLAN_EXECUTION;

insert into ITEM_TEST_PLAN_EXECUTION
        select
          a.ITEM_TEST_PLAN_ID,
          a.EXECUTION_ID,
          a.EXECUTION_ORDER + 1 - (select count(*)
                              from ITEM_TEST_PLAN_EXECUTION_TMP b
                              where a.ITEM_TEST_PLAN_ID = b.ITEM_TEST_PLAN_ID
                              and a.EXECUTION_ORDER = b.EXECUTION_ORDER
                              and a.EXECUTION_ID <= b.EXECUTION_ID
                              group by
                                b.ITEM_TEST_PLAN_ID,
                                b.EXECUTION_ORDER) EXECUTION_ORDER
          from ITEM_TEST_PLAN_EXECUTION_TMP a;

drop table ITEM_TEST_PLAN_EXECUTION_TMP;

ALTER TABLE ITEM_TEST_PLAN_EXECUTION ADD UNIQUE (ITEM_TEST_PLAN_ID, EXECUTION_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'PostgreSQL - Add unique constraint on order column for executions in itpi', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-846.2-postgresql', '2.0.5', '3:8cf67086e57245fed8fa7ed9d5c65498', 463);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-846.3-postgresql::jlor::(Checksum: 3:2f76bdfe0c1356227273fa9cd9f8b37b)
-- PostgreSQL - Add unique constraint on order column for steps in execution
drop table if exists EXECUTION_EXECUTION_STEPS_TMP;

create table EXECUTION_EXECUTION_STEPS_TMP AS
          (select
            EXECUTION_ID,
            EXECUTION_STEP_ID,
            min(EXECUTION_STEP_ORDER) STEP_ORDER
          from EXECUTION_EXECUTION_STEPS
          group by EXECUTION_ID, EXECUTION_STEP_ID);

create index idx1 on EXECUTION_EXECUTION_STEPS_TMP(EXECUTION_ID, EXECUTION_STEP_ID);

update EXECUTION_EXECUTION_STEPS_TMP t1
        set STEP_ORDER = t2.line - 1
        from (
          select
            EXECUTION_ID,
            EXECUTION_STEP_ID,
            (select count(*)
            from EXECUTION_EXECUTION_STEPS_TMP b
            where a.EXECUTION_ID = b.EXECUTION_ID
            and a.STEP_ORDER >= b.STEP_ORDER) line
          from EXECUTION_EXECUTION_STEPS_TMP a) t2
          where t1.EXECUTION_ID = t2.EXECUTION_ID
          and t1.EXECUTION_STEP_ID = t2.EXECUTION_STEP_ID;

truncate table EXECUTION_EXECUTION_STEPS;

insert into EXECUTION_EXECUTION_STEPS
        select
          a.EXECUTION_ID,
          a.EXECUTION_STEP_ID,
          a.STEP_ORDER + 1 - (select count(*)
                              from EXECUTION_EXECUTION_STEPS_TMP b
                              where a.EXECUTION_ID = b.EXECUTION_ID
                              and a.STEP_ORDER = b.STEP_ORDER
                              and a.EXECUTION_STEP_ID <= b.EXECUTION_STEP_ID
                              group by
                                b.EXECUTION_ID,
                                b.STEP_ORDER) STEP_ORDER
          from EXECUTION_EXECUTION_STEPS_TMP a;

drop table EXECUTION_EXECUTION_STEPS_TMP;

ALTER TABLE EXECUTION_EXECUTION_STEPS ADD UNIQUE (EXECUTION_ID, EXECUTION_STEP_ORDER);

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jlor', 'PostgreSQL - Add unique constraint on order column for steps in execution', NOW(), 'Custom SQL, Add Unique Constraint', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-846.3-postgresql', '2.0.5', '3:2f76bdfe0c1356227273fa9cd9f8b37b', 464);

-- Changeset /var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml::tm-1.21.0-TM-996-modify-entity-reference-id-type::jprioux::(Checksum: 3:491b75f0d8e7a01f40349242dc8d7a42)
-- Modify ENTITY_REFERENCE_ID data type in CHART_SCOPE
ALTER TABLE CHART_SCOPE ALTER COLUMN ENTITY_REFERENCE_ID TYPE BIGINT;

INSERT INTO databasechangelog (AUTHOR, COMMENTS, DATEEXECUTED, DESCRIPTION, EXECTYPE, FILENAME, ID, LIQUIBASE, MD5SUM, ORDEREXECUTED) VALUES ('jprioux', 'Modify ENTITY_REFERENCE_ID data type in CHART_SCOPE', NOW(), 'Modify data type', 'EXECUTED', '/var/lib/jenkins/jobs/build-squash-tm-distros-1.21/workspace/standalone/target/maven-shared-archive-resources/tm/tm.changelog-1.21.0.xml', 'tm-1.21.0-TM-996-modify-entity-reference-id-type', '2.0.5', '3:491b75f0d8e7a01f40349242dc8d7a42', 465);


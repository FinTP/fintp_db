/*
* FinTP - Financial Transactions Processing Application
* Copyright (C) 2013 Business Information Systems (Allevo) S.R.L.
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>
* or contact Allevo at : 031281 Bucuresti, 23C Calea Vitan, Romania,
* phone +40212554577, office@allevo.ro <mailto:office@allevo.ro>, www.allevo.ro.
*/

--Table: fincfg.feedbackcodes

--DROP TABLE fincfg.feedbackcodes;

CREATE TABLE fincfg.feedbackcodes (
  guid         integer NOT NULL,
  code         varchar(5) NOT NULL,
  description  varchar(200) NOT NULL,
  category     varchar(10) NOT NULL,
  source       varchar(10) NOT NULL,
  useraction   varchar(200),
  /* Keys */
  CONSTRAINT "PK_FBCODES_GUID"
    PRIMARY KEY (guid), 
  CONSTRAINT "UK_FBCODES_CODE"
    UNIQUE (code, source)
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.feedbackcodes
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.feedbackcodes
TO fincfg;

GRANT SELECT
  ON fincfg.feedbackcodes
TO findata;
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

--Table: fincfg.routingkeywords

--DROP TABLE fincfg.routingkeywords;

CREATE TABLE fincfg.routingkeywords (
  guid         integer NOT NULL,
  keyword      varchar(50) NOT NULL,
  comparer     varchar(200) NOT NULL,
  selector     varchar(200),
  description  varchar(200),
  selectoriso  varchar(200),
  /* Keys */
  CONSTRAINT "PK_RK_GUID"
    PRIMARY KEY (guid), 
  CONSTRAINT "UK_RK_KEYWORD"
    UNIQUE (keyword)
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.routingkeywords
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.routingkeywords
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.routingkeywords
TO fincfg;
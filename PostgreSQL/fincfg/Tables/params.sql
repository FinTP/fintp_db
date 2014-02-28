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

--Table: fincfg.params

--DROP TABLE fincfg.params;

CREATE TABLE fincfg.params (
  "name"       varchar(35) NOT NULL,
  value        varchar(300),
  description  varchar(50),
  category     varchar(35),
  /* Keys */
  CONSTRAINT "PK_PARAMS_NAME"
    PRIMARY KEY ("name")
    USING INDEX TABLESPACE fincfgtbs
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.params
  OWNER TO fincfg;

GRANT SELECT
  ON fincfg.params
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.params
TO fincfg;

GRANT SELECT
  ON fincfg.params
TO findata;
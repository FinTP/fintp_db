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

--Table: fincfg.queuetypes

--DROP TABLE fincfg.queuetypes;

CREATE TABLE fincfg.queuetypes (
  typeid    integer NOT NULL,
  typename  varchar(50),
  /* Keys */
  CONSTRAINT "PK_QUEUETL_GUID"
    PRIMARY KEY (typeid), 
  CONSTRAINT "UK_QT_TYPENAME"
    UNIQUE (typename)
) WITH (
    OIDS = TRUE
  );

ALTER TABLE fincfg.queuetypes
  OWNER TO fincfg;

GRANT SELECT
  ON fincfg.queuetypes
TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.queuetypes
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.queuetypes
TO fincfg;
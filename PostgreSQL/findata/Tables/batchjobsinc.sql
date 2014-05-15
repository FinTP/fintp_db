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


--Table: findata.batchjobsinc

--DROP TABLE findata.batchjobsinc;

CREATE TABLE findata.batchjobsinc (
  sender      varchar(12) NOT NULL,
  combatchid  varchar(35) NOT NULL,
  batchtype   varchar(50),
  insertdate  timestamp WITHOUT TIME ZONE,
  /* Keys */
  CONSTRAINT "PK_BJI_SENBATCH"
    PRIMARY KEY (sender, combatchid)
    USING INDEX TABLESPACE fincfgtbs
) WITH (
    OIDS = FALSE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.batchjobsinc
  OWNER TO findata;

GRANT SELECT
  ON findata.batchjobsinc
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.batchjobsinc
TO findata;
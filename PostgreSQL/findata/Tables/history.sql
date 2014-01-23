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

--Table: findata.history

--DROP TABLE findata.history;

CREATE TABLE findata.history (
  guid              varchar(30) NOT NULL,
  payload           text NOT NULL,
  batchid           varchar(35),
  correlationid     varchar(30) NOT NULL,
  sessionid         varchar(30),
  requestorservice  varchar(30) NOT NULL,
  responderservice  varchar(30),
  requesttype       varchar(30) NOT NULL,
  priority          integer NOT NULL DEFAULT 5,
  holdstatus        integer NOT NULL DEFAULT 1,
  "sequence"        integer DEFAULT 0,
  insertdate        timestamp WITHOUT TIME ZONE,
  feedback          varchar(40),
  /* Keys */
  CONSTRAINT "PK_HIST_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE findatatbs
) WITH (
    OIDS = FALSE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.history
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON findata.history
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.history
TO findata;
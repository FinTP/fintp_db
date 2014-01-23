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

--Table: findata.entryqueue

--DROP TABLE findata.entryqueue;

CREATE TABLE findata.entryqueue (
  guid              varchar(30) NOT NULL,
  payload           text NOT NULL,
  batchid           varchar(35),
  correlationid     varchar(30) NOT NULL,
  requestorservice  varchar(30) NOT NULL,
  responderservice  varchar(30),
  requesttype       varchar(30) NOT NULL,
  priority          integer DEFAULT 5,
  holdstatus        integer NOT NULL DEFAULT 0,
  "sequence"        integer NOT NULL DEFAULT 0,
  feedback          varchar(40),
  sessionid         varchar(30),
  status            integer DEFAULT 1,
  queuename         varchar(35),
  /* Keys */
  CONSTRAINT "PK_EQ_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE findatatbs, 
  CONSTRAINT "UK_EQ_CORRELID"
    UNIQUE (correlationid)
    USING INDEX TABLESPACE findatatbs
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;


ALTER TABLE findata.entryqueue
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRUNCATE
  ON findata.entryqueue
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.entryqueue
TO findata;
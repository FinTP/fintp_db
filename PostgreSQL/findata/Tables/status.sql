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

--Table: findata.status

--DROP TABLE findata.status;

CREATE TABLE findata.status (
  guid            varchar(30) NOT NULL,
  service         integer NOT NULL,
  correlationid   varchar(30) NOT NULL,
  "type"          varchar(20) NOT NULL,
  machine         varchar(30) NOT NULL,
  eventdate       timestamp WITHOUT TIME ZONE NOT NULL,
  insertdate      timestamp WITHOUT TIME ZONE NOT NULL,
  message         varchar(256) NOT NULL,
  "class"         varchar(20),
  innerexception  varchar(4000),
  additionalinfo  varchar(4000),
  sessionid       varchar(30),
  /* Keys */
  CONSTRAINT "PK_STS_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE findatatbs
) WITH (
    OIDS = FALSE
  )
  TABLESPACE findatatbs;

CREATE INDEX idx_status
  ON findata.status
  (correlationid);

ALTER TABLE findata.status
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.status
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.status
TO findata;
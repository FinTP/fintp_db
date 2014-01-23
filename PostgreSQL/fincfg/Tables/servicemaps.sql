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

--Table: fincfg.servicemaps

--DROP TABLE fincfg.servicemaps;

CREATE TABLE fincfg.servicemaps (
  friendlyname       varchar(30),
  serviceid          integer NOT NULL,
  status             integer NOT NULL,
  lastsessionid      integer,
  heartbeatinterval  integer NOT NULL,
  lastheartbeat      timestamp(6) WITHOUT TIME ZONE,
  version            varchar(255),
  partner            varchar(255),
  servicetype        integer,
  ioidentifier       integer,
  exitpoint          varchar(300),
  sessionid          varchar(26),
  duplicatecheck     integer,
  duplicateq         varchar(50),
  duplicatemap       varchar(50),
  duplicatenotifq    varchar(50),
  delayednotifq      varchar(50),
  /* Keys */
  CONSTRAINT "PK_SM_SERVID"
    PRIMARY KEY (serviceid), 
  CONSTRAINT "UK_SM_NAME"
    UNIQUE (friendlyname)
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.servicemaps
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.servicemaps
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.servicemaps
TO fincfg;
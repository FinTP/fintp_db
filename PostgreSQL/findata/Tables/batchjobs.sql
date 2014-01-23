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

--Table: findata.batchjobs

--DROP TABLE findata.batchjobs;

CREATE TABLE findata.batchjobs (
  batchid       varchar(16) NOT NULL,
  userid        varchar(35) NOT NULL,
  batchcount    integer NOT NULL,
  batchamount   varchar(20) NOT NULL,
  combatchid    varchar(35) NOT NULL,
  defjobcount   integer NOT NULL,
  batchstatus   integer NOT NULL,
  insertdate    timestamp WITHOUT TIME ZONE NOT NULL,
  routingpoint  varchar(50) NOT NULL,
  reason        varchar(500),
  combatchamt   numeric(20,2),
  batchtype     varchar(50),
  batchuid      varchar(32),
  /* Keys */
  CONSTRAINT "PK_BJ_BATCHID"
    PRIMARY KEY (combatchid), 
  CONSTRAINT "UK_BJ_CONST"
    UNIQUE (batchid, userid, batchcount, batchamount, batchuid)
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.batchjobs
  OWNER TO findata;

GRANT SELECT
  ON findata.batchjobs
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.batchjobs
TO findata;
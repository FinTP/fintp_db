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

--Table: findata.routingjobs

--DROP TABLE findata.routingjobs;

CREATE TABLE findata.routingjobs (
  guid          varchar(30) NOT NULL,
  status        integer NOT NULL DEFAULT 0,
  backout       integer NOT NULL DEFAULT 0,
  priority      integer NOT NULL DEFAULT 10,
  routingpoint  varchar(50),
  "function"    varchar(200) NOT NULL,
  userid        varchar(35),
  /* Keys */
  CONSTRAINT "PK_RJ_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE findatatbs
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.routingjobs
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON findata.routingjobs
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.routingjobs
TO findata;
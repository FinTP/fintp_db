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

--Table: findata.mtcqtab

--DROP TABLE findata.mtcqtab;

CREATE TABLE findata.mtcqtab (
  correlid     varchar(30) NOT NULL,
  msgtype      varchar(50),
  issdate      varchar(6),
  amount       varchar(50),
  currency     varchar(3),
  dbtaccount   varchar(50),
  cdtaccount   varchar(50),
  dbtcustname  varchar(50),
  cdtcustname  varchar(50),
  dbtid        varchar(50),
  /* Keys */
  CONSTRAINT "PK_MTCQTAB_CORRELID"
    PRIMARY KEY (correlid)
    USING INDEX TABLESPACE findatatbs,
  /* Foreign keys */
  CONSTRAINT "FK_MTCQ_RM_CORRELID"
    FOREIGN KEY (correlid)
    REFERENCES findata.routedmessages(correlationid)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) WITH (
    OIDS = FALSE
  );

ALTER TABLE findata.mtcqtab
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.mtcqtab
TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.mtcqtab
TO finuiuser;
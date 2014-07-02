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

--Table: fincfg.queues

--DROP TABLE fincfg.queues;

CREATE TABLE fincfg.queues (
  guid           integer NOT NULL,
  "name"         varchar(50) NOT NULL,
  holdstatus     integer NOT NULL,
  connector      integer,
  typeid         integer,
  batchno        integer,
  description    varchar(100),
  priority       integer,
  autobatchtime  varchar(50),
  /* Keys */
  CONSTRAINT "PK_QUEUES_GUID"
    PRIMARY KEY (guid), 
  CONSTRAINT "UK_QUEUES_NAME"
    UNIQUE ("name"),
  /* Foreign keys */
  CONSTRAINT "FK_QUEUETL_QUEUES_TYPEID"
    FOREIGN KEY (typeid)
    REFERENCES fincfg.queuetypes(typeid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.queues
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.queues
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.queues
TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.queues
TO findata;
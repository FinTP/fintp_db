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


--Table: fincfg.routingrules

--DROP TABLE fincfg.routingrules;

CREATE TABLE fincfg.routingrules (
  guid         integer NOT NULL,
  queueid      integer NOT NULL,
  schemaguid   integer NOT NULL,
  "sequence"   integer,
  ruletype     integer,
  description  varchar(70),
  msgcond      varchar(500),
  funccond     varchar(500),
  metacond     varchar(500),
  "action"     varchar(500) NOT NULL,
  /* Keys */
  CONSTRAINT "PK_RR_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE fincfgtbs, 
  CONSTRAINT uk_rr_qidseq
    UNIQUE (queueid, "sequence"),
  /* Foreign keys */
  CONSTRAINT "FK_RR_Q_QUEUEID"
    FOREIGN KEY (queueid)
    REFERENCES fincfg.queues(guid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 
  CONSTRAINT "FK_RR_RS_SCHEMAGUID"
    FOREIGN KEY (schemaguid)
    REFERENCES fincfg.routingschemas(guid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.routingrules
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.routingrules
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.routingrules
TO fincfg;
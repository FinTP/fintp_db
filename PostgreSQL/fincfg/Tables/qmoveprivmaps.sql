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

--Table: fincfg.qmoveprivmaps

--DROP TABLE fincfg.qmoveprivmaps;

CREATE TABLE fincfg.qmoveprivmaps (
  mapid          integer NOT NULL,
  sourcequeueid  integer NOT NULL,
  destqueueid    integer NOT NULL,
  /* Keys */
  CONSTRAINT "PK_QPM_MAPID"
    PRIMARY KEY (mapid)
    USING INDEX TABLESPACE fincfgtbs,
  /* Foreign keys */
  CONSTRAINT "FK_QMP_Q_DQID"
    FOREIGN KEY (destqueueid)
    REFERENCES fincfg.queues(guid)
    ON DELETE CASCADE
    ON UPDATE NO ACTION, 
  CONSTRAINT "FK_QMP_Q_SQID"
    FOREIGN KEY (sourcequeueid)
    REFERENCES fincfg.queues(guid)
    ON DELETE CASCADE
    ON UPDATE NO ACTION
) WITH (
    OIDS = FALSE
  );

ALTER TABLE fincfg.qmoveprivmaps
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.qmoveprivmaps
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.qmoveprivmaps
TO fincfg;
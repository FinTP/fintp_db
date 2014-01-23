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

--Table: fincfg.qtypeactionmaps

--DROP TABLE fincfg.qtypeactionmaps;

CREATE TABLE fincfg.qtypeactionmaps (
  mapid      integer NOT NULL,
  qtypeid    integer NOT NULL,
  qactionid  integer NOT NULL,
  /* Keys */
  CONSTRAINT "PK_QAM_MAPID"
    PRIMARY KEY (mapid),
  /* Foreign keys */
  CONSTRAINT "FK_QTA_QAL_ACTID"
    FOREIGN KEY (qactionid)
    REFERENCES fincfg.queueactions(actionid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 
  CONSTRAINT "FK_QTA_QTL_QTYPEID"
    FOREIGN KEY (qtypeid)
    REFERENCES fincfg.queuetypes(typeid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.qtypeactionmaps
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.qtypeactionmaps
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.qtypeactionmaps
TO fincfg;
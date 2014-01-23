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
-- Table: fincfg.routingrules

-- DROP TABLE fincfg.routingrules;

CREATE TABLE fincfg.routingrules
(
  guid integer NOT NULL,
  queueid integer NOT NULL,
  schemaguid integer NOT NULL,
  sequence integer,
  ruletype integer,
  description character varying(70),
  msgcond character varying(500),
  funccond character varying(500),
  metacond character varying(500),
  action character varying(500) NOT NULL,
  CONSTRAINT "PK_RR_GUID" PRIMARY KEY (guid)
  USING INDEX TABLESPACE fincfgtbs,
  CONSTRAINT "FK_RR_Q_QUEUEID" FOREIGN KEY (queueid)
      REFERENCES fincfg.queues (guid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_RR_RS_SCHEMAGUID" FOREIGN KEY (schemaguid)
      REFERENCES fincfg.routingschemas (guid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=TRUE
)
TABLESPACE fincfgtbs;
ALTER TABLE fincfg.routingrules
  OWNER TO fincfg;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE fincfg.routingrules TO finuiuser;
GRANT ALL ON TABLE fincfg.routingrules TO fincfg;

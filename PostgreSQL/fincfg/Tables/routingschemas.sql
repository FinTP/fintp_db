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

--Table: fincfg.routingschemas

--DROP TABLE fincfg.routingschemas;
-- Table: fincfg.routingschemas

-- DROP TABLE fincfg.routingschemas;

CREATE TABLE fincfg.routingschemas
(
  name character varying(10) NOT NULL,
  description character varying(250),
  active integer NOT NULL,
  guid integer NOT NULL,
  startlimit integer NOT NULL,
  stoplimit integer NOT NULL,
  sessioncode character varying(10),
  isvisible character varying(1),
  CONSTRAINT "PK_RS_SCHEMAGUID" PRIMARY KEY (guid)
  USING INDEX TABLESPACE fincfgtbs,
  CONSTRAINT "FK_RS_TL_START" FOREIGN KEY (startlimit)
      REFERENCES fincfg.timelimits (guid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "FK_RS_TL_STOP" FOREIGN KEY (stoplimit)
      REFERENCES fincfg.timelimits (guid) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT "UK_RS_NAME" UNIQUE (name)
  USING INDEX TABLESPACE fincfgtbs
)
WITH (
  OIDS=TRUE
)
TABLESPACE fincfgtbs;
ALTER TABLE fincfg.routingschemas
  OWNER TO fincfg;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE fincfg.routingschemas TO finuiuser;
GRANT ALL ON TABLE fincfg.routingschemas TO fincfg;

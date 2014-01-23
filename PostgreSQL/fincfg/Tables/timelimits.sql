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

--Table: fincfg.timelimits

--DROP TABLE fincfg.timelimits;

CREATE TABLE fincfg.timelimits
(
  guid integer NOT NULL,
  limitname character varying(100) NOT NULL,
  limittime timestamp without time zone NOT NULL,
  CONSTRAINT "PK_TL_GUID" PRIMARY KEY (guid)
  USING INDEX TABLESPACE fincfgtbs,
  CONSTRAINT "UK_TL_NAME" UNIQUE (limitname)
  USING INDEX TABLESPACE fincfgtbs
)
WITH (
  OIDS=TRUE
)
TABLESPACE fincfgtbs;
ALTER TABLE fincfg.timelimits
  OWNER TO fincfg;
GRANT SELECT, UPDATE, INSERT, DELETE ON TABLE fincfg.timelimits TO finuiuser;
GRANT ALL ON TABLE fincfg.timelimits TO fincfg;

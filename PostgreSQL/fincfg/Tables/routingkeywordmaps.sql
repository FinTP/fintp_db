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


--Table: fincfg.routingkeywordmaps

--DROP TABLE fincfg.routingkeywordmaps;

CREATE TABLE fincfg.routingkeywordmaps (
  keywordid  integer NOT NULL,
  tag        varchar(200) NOT NULL,
  mt         varchar(35) NOT NULL,
  selector   varchar(11) NOT NULL,
  mapid      integer NOT NULL,
  /* Keys */
  CONSTRAINT "PK_RKM_MAPID"
    PRIMARY KEY (mapid),
  /* Foreign keys */
  CONSTRAINT "FK_RKM_RK_KID"
    FOREIGN KEY (keywordid)
    REFERENCES fincfg.routingkeywords(guid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = TRUE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.routingkeywordmaps
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON fincfg.routingkeywordmaps
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.routingkeywordmaps
TO fincfg;
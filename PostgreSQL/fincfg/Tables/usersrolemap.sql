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


--Table: fincfg.usersrolemap

--DROP TABLE fincfg.usersrolemap;

CREATE TABLE fincfg.usersrolemap (
  mapid   integer NOT NULL,
  userid  integer,
  roleid  integer NOT NULL,
  /* Keys */
  CONSTRAINT "PK_USERSROLEMAP_MAPID"
    PRIMARY KEY (mapid), 
  CONSTRAINT uk_urm_ur
    UNIQUE (userid, roleid),
  /* Foreign keys */
  CONSTRAINT "FK_ROLES_URM_ROLEID"
    FOREIGN KEY (roleid)
    REFERENCES fincfg.roles(roleid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION, 
  CONSTRAINT "FK_USERS_URM_USERID"
    FOREIGN KEY (userid)
    REFERENCES fincfg.users(userid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = FALSE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.usersrolemap
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.usersrolemap
TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.usersrolemap
TO finuiuser;
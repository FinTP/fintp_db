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

--Table: fincfg.roles

--DROP TABLE fincfg.roles;

CREATE TABLE fincfg.roles (
  roleid       integer NOT NULL,
  "name"       varchar(100) NOT NULL,
  description  varchar(300),
  usercreated  integer NOT NULL,
  /* Keys */
  CONSTRAINT "PK_ROLES_ROLEID"
    PRIMARY KEY (roleid), 
  CONSTRAINT uk_roles_rname
    UNIQUE ("name")
) WITH (
    OIDS = FALSE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.roles
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.roles
TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.roles
TO finuiuser;
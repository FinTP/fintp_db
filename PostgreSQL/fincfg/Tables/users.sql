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

--Table: fincfg.users

--DROP TABLE fincfg.users;

CREATE TABLE fincfg.users (
  userid       integer NOT NULL,
  username     varchar(20) NOT NULL,
  "password"   varchar(100) NOT NULL,
  firstname    varchar(20),
  lastname     varchar(30),
  skincolor    varchar(20) DEFAULT 'Blue'::character varying,
  islocked     integer DEFAULT 0,
  noretry      integer DEFAULT 0,
  email        varchar(150),
  passdate     date,
  paymsetpref  varchar(50),
  qsetpref     varchar(50),
  /* Keys */
  CONSTRAINT "PK_USERS_USERID"
    PRIMARY KEY (userid), 
  CONSTRAINT uk_users_uname
    UNIQUE (username)
) WITH (
    OIDS = FALSE
  )
  TABLESPACE fincfgtbs;

ALTER TABLE fincfg.users
  OWNER TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON fincfg.users
TO fincfg;

GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE
  ON fincfg.users
TO finuiuser;
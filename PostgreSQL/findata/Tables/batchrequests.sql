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


--Table: findata.batchrequests

--DROP TABLE findata.batchrequests;

CREATE TABLE findata.batchrequests (
  groupkey   varchar(100),
  batchuid   varchar(35),
  requestid  serial NOT NULL,
  userid     integer,
  /* Keys */
  CONSTRAINT batchrequests_pkey
    PRIMARY KEY (requestid),
  /* Foreign keys */
  CONSTRAINT fk_u_br_uid
    FOREIGN KEY (userid)
    REFERENCES fincfg.users(userid)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.batchrequests
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.batchrequests
TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON findata.batchrequests
TO finuiuser;
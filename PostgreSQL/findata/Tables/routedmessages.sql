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

--Table: findata.routedmessages

--DROP TABLE findata.routedmessages;

CREATE TABLE findata.routedmessages (
  guid           varchar(30) NOT NULL,
  correlationid  varchar(30),
  insertdate     timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  ack            integer DEFAULT 0,
  msgtype        varchar(50),
  currentqueue   integer,
  sender         varchar(35),
  receiver       varchar(35),
  trn            varchar(35) NOT NULL,
  senderapp      varchar(35),
  receiverapp    varchar(35),
  userid         integer,
  amount         varchar(50),
  /* Keys */
  CONSTRAINT "PK_RM_GUID"
    PRIMARY KEY (guid)
    USING INDEX TABLESPACE findatatbs, 
  CONSTRAINT "UK_RM_CORRELID"
    UNIQUE (correlationid)
    USING INDEX TABLESPACE findatatbs
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.routedmessages
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.routedmessages
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.routedmessages
TO findata;
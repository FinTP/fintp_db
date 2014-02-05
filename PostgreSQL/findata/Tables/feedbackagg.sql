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

--Table: findata.feedbackagg

--DROP TABLE findata.feedbackagg;

CREATE TABLE findata.feedbackagg (
  requestor      varchar(50),
  wmqid          varchar(32),
  correlid       varchar(30) NOT NULL,
  interfacecode  varchar(10),
  networkcode    varchar(10),
  correspcode    varchar(10),
  appcode        varchar(10),
  payload        text,
  swiftmir       varchar(30),
  insertdate     timestamp WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  batchid        varchar(35),
  batchseq       integer,
  trn            varchar(35),
  osession       varchar(10),
  isession       varchar(10),
  issuer         varchar(12),
  obatchid       varchar(35),
  /* Keys */
  CONSTRAINT pk_fb_correlid
    PRIMARY KEY (correlid)
) WITH (
    OIDS = TRUE
  )
  TABLESPACE findatatbs;

ALTER TABLE findata.feedbackagg
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.feedbackagg
TO finuiuser;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.feedbackagg
TO findata;
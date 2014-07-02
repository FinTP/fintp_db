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


--Table: findata.blobsqueue

--DROP TABLE findata.blobsqueue;

CREATE TABLE findata.blobsqueue (
  guid           varchar(30),
  payload        bytea,
  imageref       varchar(30),
  correlationid  varchar(30) NOT NULL,
  batchid        varchar(35),
  insertdate     date DEFAULT CURRENT_DATE
) WITH (
    OIDS = FALSE
  );

ALTER TABLE findata.blobsqueue
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.blobsqueue
TO findata;

GRANT SELECT
  ON findata.blobsqueue
TO finuiuser;
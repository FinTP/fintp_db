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


--View: findata.mtundefinedview

--DROP VIEW findata.mtundefinedview;

CREATE VIEW findata.mtundefinedview
(
  guid,
  batchid,
  requestorservice,
  correlationid,
  queuename,
  payload
)
AS
SELECT 
  entryqueue.guid, 
  entryqueue.batchid, 
  entryqueue.requestorservice, 
  entryqueue.correlationid, 
  entryqueue.queuename, 
  entryqueue.payload 
FROM findata.entryqueue 
WHERE
  (
    NOT (
      (entryqueue.correlationid)::text IN (SELECT 
        routedmessages.correlationid 
      FROM findata.routedmessages)
    )
  );

ALTER TABLE findata.mtundefinedview
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.mtundefinedview
TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE
  ON findata.mtundefinedview
TO finuiuser;
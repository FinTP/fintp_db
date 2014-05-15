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

--View: findata.mt103view

--DROP VIEW findata.mt103view;

CREATE VIEW findata.mt103view
(  guid,
  msgtype,
  sender,
  receiver,
  trn,
  insertdate,
  amount,
  currency,
  valuedate,
  service,
  queuename,
  payload
  
)
AS
SELECT 
  eq.guid, 
  rm.msgtype, 
  rm.sender, 
  rm.receiver, 
  rm.trn, 
  rm.insertdate, 
  to_number(CASE 
    WHEN (
      rtrim((mt.amount)::text) IS NULL
    ) THEN '0,00'::text 
    WHEN (
      rtrim((mt.amount)::text) = ''::text
    ) THEN '0,00'::text 
    WHEN (
      rtrim((mt.amount)::text) = ','::text
    ) THEN '0,00'::text 
    ELSE replace(rtrim((mt.amount)::text), ','::text, '.'::text) 
  END, 'FM99999999999999999D99'::text) AS amount, 
  mt.currency, 
  mt.valuedate, 
  mt.service,
  eq.queuename, 
  eq.payload 
FROM (((SELECT 
  rm.msgtype, 
  rm.sender, 
  rm.receiver, 
  rm.trn, 
  rm.correlationid,
  rm.insertdate
FROM routedmessages rm 
WHERE
  (
    (rm.currentqueue = 1) AND
    (
      (rm.msgtype)::text = '103'::text
    )
  )) rm 
  LEFT JOIN (SELECT 
    mt103tab.correlid, 
    mt103tab.amount, 
    mt103tab.currency, 
    mt103tab.valuedate, 
    mt103tab.service 
  FROM mt103tab) mt ON 
    (
      (
        (rm.correlationid)::text = (mt.correlid)::text
      )
    )) 
  LEFT JOIN (SELECT 
    entryqueue.guid, 
    entryqueue.correlationid, 
    entryqueue.queuename, 
    entryqueue.payload 
  FROM entryqueue) eq ON 
    (
      (
        (mt.correlid)::text = (eq.correlationid)::text
      )
    ));

ALTER TABLE findata.mt103view
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.mt103view
TO findata;

GRANT SELECT
  ON findata.mt103view
TO finuiuser;
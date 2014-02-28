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

--View: findata.repstatft

--DROP VIEW findata.repstatft;

CREATE VIEW findata.repstatft
(
  msgtype,
  sender,
  receiver,
  trn,
  valuedate,
  amount,
  currency,
  dbtaccount,
  dbtcustname,
  ordbank,
  benbank,
  cdtaccount,
  cdtcustname,
  service,
  insertdate,
  direction,
  batchid,
  userid,
  state,
  errcode
)
AS
SELECT 
  ba.msgtype, 
  ba.sender, 
  ba.receiver, 
  ba.trn, 
  ba.valuedate, 
  ba.amount, 
  ba.currency, 
  ba.dbtaccount, 
  ba.dbtcustname, 
  ba.ordbank, 
  ba.benbank, 
  ba.cdtaccount, 
  ba.cdtcustname, 
  ba.service, 
  ba.insertdate, 
  ba.direction, 
  fb.batchid, 
  ba.userid, 
  fb.state, 
  fb.errcode 
FROM ((SELECT 
  fincfg.getmsgtypebusinessname(rm.msgtype) AS msgtype, 
  rm.sender, 
  rm.receiver, 
  rm.trn, 
  mt.valuedate, 
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
  mt.dbtaccount, 
  mt.dbtcustname, 
  mt.ordbank, 
  mt.benbank, 
  mt.cdtaccount, 
  mt.cdtcustname, 
  mt.service, 
  mt.correlid, 
  rm.insertdate, 
  CASE 
    WHEN (
      (rm.senderapp)::text ~~ '%Out'::text
    ) THEN 'Outgoing'::text 
    ELSE 'Incoming'::text 
  END AS direction, 
  rm.userid 
FROM ((SELECT 
  routedmessages.msgtype, 
  routedmessages.trn, 
  routedmessages.correlationid, 
  routedmessages.sender, 
  routedmessages.receiver, 
  routedmessages.userid, 
  routedmessages.insertdate, 
  routedmessages.senderapp 
FROM routedmessages) rm 
  JOIN (SELECT 
    mtfitoficstmrcdttrftab.correlid, 
    mtfitoficstmrcdttrftab.msgtype, 
    mtfitoficstmrcdttrftab.valuedate, 
    mtfitoficstmrcdttrftab.amount, 
    mtfitoficstmrcdttrftab.currency, 
    mtfitoficstmrcdttrftab.dbtaccount, 
    mtfitoficstmrcdttrftab.dbtcustname, 
    mtfitoficstmrcdttrftab.ordbank, 
    mtfitoficstmrcdttrftab.benbank, 
    mtfitoficstmrcdttrftab.cdtaccount, 
    mtfitoficstmrcdttrftab.cdtcustname, 
    'n/a' AS service 
  FROM mtfitoficstmrcdttrftab) mt ON 
    (
      (
        (rm.correlationid)::text = (mt.correlid)::text
      )
    ))) ba 
  LEFT JOIN (SELECT 
    feedbackagg.correlid, 
    feedbackagg.batchid, 
    CASE 
      WHEN (
        (
          (
            (
              (feedbackagg.mqid IS NULL) AND
              (feedbackagg.interfacecode IS NULL)
            ) AND
            (feedbackagg.networkcode IS NULL)
          ) AND
          (feedbackagg.correspcode IS NULL)
        ) AND
        (feedbackagg.appcode IS NULL)
      ) THEN 'New'::text 
      WHEN (
        (
          (feedbackagg.mqid IS NOT NULL) AND
          (feedbackagg.interfacecode IS NULL)
        ) AND
        (feedbackagg.appcode IS NULL)
      ) THEN 'Sent'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP09'::text
      ) THEN 'Rejected by user'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP19'::text
      ) THEN 'Rejected by client'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP10'::text
      ) THEN 'Closed'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP12'::text
      ) THEN 'Reactivated'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'RRD01'::text
      ) THEN 'AML Rejected (Blocking funds)'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'RRD02'::text
      ) THEN 'AML Rejected (Refusal to Pay)'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'RRD01'::text
      ) THEN 'AML Rejected (Reinitiate)'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP08'::text
      ) THEN 'Rejected after COT'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'PDM00'::text
      ) THEN 'Possible duplicate'::text 
      WHEN (
        (feedbackagg.interfacecode)::text = 'FTP00'::text
      ) THEN 'Received'::text 
      WHEN (
        (feedbackagg.interfacecode)::text = ANY (ARRAY['275'::text, 'FTP02'::text])
      ) THEN 'Interface success'::text 
      WHEN (
        (feedbackagg.interfacecode)::text <> ALL (ARRAY['275'::text, 'FTP02'::text])
      ) THEN 'Interface error '::text 
      WHEN (
        (feedbackagg.networkcode)::text = ANY (ARRAY['0'::text, 'FTP02'::text])
      ) THEN 'Network accepted'::text 
      WHEN (
        (feedbackagg.networkcode)::text <> ALL (ARRAY['0'::text, 'FTP02'::text])
      ) THEN 'Network error'::text 
      WHEN (
        (feedbackagg.correspcode)::text <> ALL (ARRAY['FTP02'::text, 'CSM00'::text])
      ) THEN 'Rejected'::text 
      WHEN (
        (feedbackagg.correspcode)::text = ANY (ARRAY['FTP02'::text, 'CSM00'::text])
      ) THEN 'Settled'::text 
      ELSE 'Unknown'::text 
    END AS state, 
    CASE 
      WHEN (
        (feedbackagg.interfacecode)::text <> ALL (ARRAY['275'::text, 'FTP02'::text])
      ) THEN feedbackagg.interfacecode 
      WHEN (
        (feedbackagg.networkcode)::text <> ALL (ARRAY['0'::text, 'FTP02'::text])
      ) THEN feedbackagg.networkcode 
      WHEN (
        (feedbackagg.correspcode)::text <> ALL (ARRAY['FTP02'::text, 'CSM00'::text])
      ) THEN feedbackagg.correspcode 
      ELSE NULL::character varying 
    END AS errcode, 
    feedbackagg.interfacecode, 
    feedbackagg.networkcode, 
    feedbackagg.correspcode, 
    feedbackagg.appcode 
  FROM feedbackagg) fb ON 
    (
      (
        (ba.correlid)::text = (fb.correlid)::text
      )
    ));

ALTER TABLE findata.repstatft
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.repstatft
TO findata;

GRANT SELECT
  ON findata.repstatft
TO finuiuser;
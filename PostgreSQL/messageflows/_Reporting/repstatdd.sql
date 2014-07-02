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

--View: findata.repstatdd

--DROP VIEW findata.repstatdd;

CREATE VIEW findata.repstatdd
(
  correlid,
  msgtype,
  sender,
  receiver,
  trn,
  valuedate,
  amount,
  currency,
  dbtaccount,
  dbtcustname,
  cdtid,
  cdtaccount,
  cdtcustname,
  insertdate,
  direction,
  batchid,
  userid,
  state,
  errcode
)
AS
SELECT 
  fb.correlid, 
  ba.msgtype, 
  ba.sender, 
  ba.receiver, 
  ba.trn, 
  ba.valuedate, 
  ba.amount, 
  ba.currency, 
  ba.dbtaccount, 
  ba.dbtcustname, 
  ba.cdtid, 
  ba.cdtaccount, 
  ba.cdtcustname, 
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
  mt.cdtaccount, 
  mt.cdtcustname, 
  mt.cdtid, 
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
FROM findata.routedmessages) rm 
  JOIN (SELECT 
    mt104tab.correlid, 
    mt104tab.msgtype, 
    mt104tab.valuedate, 
    mt104tab.amount, 
    mt104tab.currency, 
    mt104tab.dbtaccount, 
    mt104tab.dbtcustname, 
    mt104tab.cdtid, 
    mt104tab.cdtaccount, 
    mt104tab.cdtcustname 
  FROM findata.mt104tab 
  UNION
  SELECT 
    mt104rtab.correlid, 
    mt104rtab.msgtype, 
    'n/a'::character varying AS valuedate, 
    NULL::character varying AS amount, 
    'n/a'::character varying AS currency, 
    'n/a'::character varying AS dbtaccount, 
    'n/a'::character varying AS dbtcustname, 
    'n/a'::character varying AS cdtid, 
    'n/a'::character varying AS cdtaccount, 
    'n/a'::character varying AS cdtcustname 
  FROM findata.mt104rtab) mt ON 
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
          (
            (
              (feedbackagg.mqid IS NOT NULL) AND
              (feedbackagg.interfacecode IS NULL)
            ) AND
            (feedbackagg.networkcode IS NULL)
          ) AND
          (feedbackagg.correspcode IS NULL)
        ) AND
        (feedbackagg.appcode IS NULL)
      ) THEN 'Sent'::text 
      WHEN (
        (
          (feedbackagg.interfacecode)::text = 'FTP00'::text
        ) AND
        (feedbackagg.correspcode IS NULL)
      ) THEN 'Received'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP09'::text
      ) THEN 'Rejected by user'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP19'::text
      ) THEN 'Rejected by client'::text 
      WHEN (
        (feedbackagg.correspcode)::text = 'FTP02'::text
      ) THEN 'Settled'::text 
      WHEN (
        (feedbackagg.correspcode)::text = 'RFD'::text
      ) THEN 'Refused'::text 
      WHEN (
        (feedbackagg.correspcode)::text <> ALL (
          ARRAY[('QPI02'::character varying)::text, ('RFD'::character varying)::text]
        )
      ) THEN
        (
          (
            'Rejected ['::text ||
            (feedbackagg.correspcode)::text
          ) || ']'::text
        ) 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP12'::text
      ) THEN 'Reactivated'::text 
      WHEN (
        (feedbackagg.interfacecode)::text = ANY (ARRAY['275'::text, 'FTM00'::text])
      ) THEN 'Interface success'::text 
      WHEN (
        (feedbackagg.interfacecode)::text <> ALL (ARRAY['275'::text, 'FTM00'::text, 'FTP00'::text])
      ) THEN
        (
          (
            'Interface error ['::text ||
            (feedbackagg.interfacecode)::text
          ) || ']'::text
        ) 
      ELSE 'Unknown'::text 
    END AS state, 
    CASE 
      WHEN (
        (feedbackagg.interfacecode)::text <> ALL (ARRAY['275'::text, 'FTM00'::text, 'FTP00'::text])
      ) THEN feedbackagg.interfacecode 
      WHEN (
        (feedbackagg.correspcode)::text <> ALL (
          ARRAY[('FTP02'::character varying)::text, ('RFD'::character varying)::text]
        )
      ) THEN feedbackagg.correspcode 
      ELSE NULL::character varying 
    END AS errcode, 
    feedbackagg.interfacecode, 
    feedbackagg.networkcode, 
    feedbackagg.correspcode, 
    feedbackagg.appcode 
  FROM findata.feedbackagg) fb ON 
    (
      (
        (ba.correlid)::text = (fb.correlid)::text
      )
    ));

ALTER TABLE findata.repstatdd
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.repstatdd
TO findata;

GRANT SELECT
  ON findata.repstatdd
TO finuiuser;
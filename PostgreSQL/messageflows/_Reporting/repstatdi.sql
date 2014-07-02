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


--View: findata.repstatdi

--DROP VIEW findata.repstatdi;

CREATE VIEW findata.repstatdi
(
  correlid,
  msgtype,
  sender,
  receiver,
  trn,
  issdate,
  matdate,
  amount,
  currency,
  dbtaccount,
  dbtcustname,
  dbtid,
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
  ba.issdate, 
  ba.matdate, 
  ba.amount, 
  ba.currency, 
  ba.dbtaccount, 
  ba.dbtcustname, 
  ba.dbtid, 
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
  mt.issdate, 
  mt.matdate, 
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
  mt.dbtid, 
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
  JOIN (
    (
      (
        (
          (SELECT 
            mtcqtab.correlid, 
            mtcqtab.msgtype, 
            mtcqtab.issdate, 
            'n/a'::character varying AS matdate, 
            mtcqtab.amount, 
            mtcqtab.currency, 
            mtcqtab.dbtaccount, 
            mtcqtab.dbtcustname, 
            mtcqtab.dbtid, 
            mtcqtab.cdtaccount, 
            mtcqtab.cdtcustname 
          FROM findata.mtcqtab 
          UNION
          SELECT 
            mtpntab.correlid, 
            mtpntab.msgtype, 
            mtpntab.issdate, 
            mtpntab.matdate, 
            mtpntab.amount, 
            mtpntab.currency, 
            mtpntab.dbtaccount, 
            mtpntab.dbtcustname, 
            mtpntab.dbtid, 
            mtpntab.cdtaccount, 
            mtpntab.cdtcustname 
          FROM findata.mtpntab) 
        UNION
        SELECT 
          mtbetab.correlid, 
          mtbetab.msgtype, 
          mtbetab.issdate, 
          mtbetab.matdate, 
          mtbetab.amount, 
          mtbetab.currency, 
          mtbetab.dbtaccount, 
          mtbetab.dbtcustname, 
          mtbetab.dbtid, 
          mtbetab.cdtaccount, 
          mtbetab.cdtcustname 
        FROM findata.mtbetab) 
      UNION
      SELECT 
        mtrcqtab.correlid, 
        mtrcqtab.msgtype, 
        'n/a'::character varying AS issdate, 
        'n/a'::character varying AS matdate, 
        mtrcqtab.amount, 
        mtrcqtab.currency, 
        'n/a'::character varying AS dbtaccount, 
        'n/a'::character varying AS dbtcustname, 
        'n/a'::character varying AS dbtid, 
        'n/a'::character varying AS cdtaccount, 
        'n/a'::character varying AS cdtcustname 
      FROM findata.mtrcqtab) 
    UNION
    SELECT 
      mtrpntab.correlid, 
      mtrpntab.msgtype, 
      'n/a'::character varying AS issdate, 
      'n/a'::character varying AS matdate, 
      mtrpntab.amount, 
      mtrpntab.currency, 
      'n/a'::character varying AS dbtaccount, 
      'n/a'::character varying AS dbtcustname, 
      'n/a'::character varying AS dbtid, 
      'n/a'::character varying AS cdtaccount, 
      'n/a'::character varying AS cdtcustname 
    FROM findata.mtrpntab) 
  UNION
  SELECT 
    mtrbetab.correlid, 
    mtrbetab.msgtype, 
    'n/a'::character varying AS issdate, 
    'n/a'::character varying AS matdate, 
    mtrbetab.amount, 
    mtrbetab.currency, 
    'n/a'::character varying AS dbtaccount, 
    'n/a'::character varying AS dbtcustname, 
    'n/a'::character varying AS dbtid, 
    'n/a'::character varying AS cdtaccount, 
    'n/a'::character varying AS cdtcustname 
  FROM findata.mtrbetab) mt ON 
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
        (feedbackagg.appcode)::text = 'FTP09'::text
      ) THEN 'Rejected by user'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'PDM00'::text
      ) THEN 'Rejected as duplicate'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP19'::text
      ) THEN 'Rejected by client'::text 
      WHEN (
        (
          (
            (feedbackagg.interfacecode)::text = 'FTP00'::text
          ) AND
          (feedbackagg.networkcode IS NULL)
        ) AND
        (feedbackagg.correspcode IS NULL)
      ) THEN 'Received'::text 
      WHEN (
        (
          (feedbackagg.correspcode)::text <> ALL (
            ARRAY[('FTP02'::character varying)::text, ('FTP12'::character varying)::text, ('RFD'::character varying)::text]
          )
        ) AND
        (feedbackagg.correspcode IS NOT NULL)
      ) THEN 'Rejected'::text 
      WHEN (
        (feedbackagg.appcode)::text = 'FTP12'::text
      ) THEN 'Reactivated'::text 
      WHEN (
        (feedbackagg.networkcode IS NULL) AND
        (
          (feedbackagg.correspcode)::text = 'FTP02'::text
        )
      ) THEN 'Settled'::text 
      WHEN (
        (
          (feedbackagg.networkcode)::text = 'RFD'::text
        ) AND
        (feedbackagg.correspcode IS NULL)
      ) THEN 'Partially refused'::text 
      WHEN (
        (
          (feedbackagg.networkcode)::text = 'RFD'::text
        ) AND
        (
          (feedbackagg.correspcode)::text = 'FTP02'::text
        )
      ) THEN 'Partially settled'::text 
      WHEN (
        (feedbackagg.correspcode)::text = 'RFD'::text
      ) THEN 'Refused'::text 
      WHEN (
        (feedbackagg.interfacecode)::text <> 'FTM00'::text
      ) THEN 'Interface error'::text 
      WHEN (
        (
          (
            (feedbackagg.interfacecode)::text = 'FTM00'::text
          ) AND
          (feedbackagg.networkcode IS NULL)
        ) AND
        (feedbackagg.correspcode IS NULL)
      ) THEN 'Interface success'::text 
      ELSE NULL::text 
    END AS state, 
    CASE 
      WHEN (
        (feedbackagg.interfacecode)::text <> ALL (ARRAY['FTM00'::text, 'FTP00'::text])
      ) THEN feedbackagg.interfacecode 
      WHEN (
        (feedbackagg.correspcode)::text <> ALL (
          ARRAY[('FTP02'::character varying)::text, ('FTP12'::character varying)::text, ('RFD'::character varying)::text]
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

ALTER TABLE findata.repstatdi
  OWNER TO findata;

GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES, TRIGGER, TRUNCATE
  ON findata.repstatdi
TO findata;

GRANT SELECT
  ON findata.repstatdi
TO finuiuser;
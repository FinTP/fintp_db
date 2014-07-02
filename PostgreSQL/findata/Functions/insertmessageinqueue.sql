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

--Function: findata.insertmessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, inqueuename varchar)

--DROP FUNCTION findata.insertmessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, inqueuename varchar);

CREATE OR REPLACE FUNCTION findata.insertmessageinqueue
(
  IN  inguid         varchar,
  IN  inpayload      text,
  IN  inbatchid      varchar,
  IN  incorrelid     varchar,
  IN  insessid       varchar,
  IN  inreqservice   varchar,
  IN  inrespservice  varchar,
  IN  inreqtype      varchar,
  IN  inpriority     integer,
  IN  inholdstatus   integer,
  IN  insequence     integer,
  IN  infeedback     varchar,
  IN  inqueuename    varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
                       27.May.2014, DenisaN         
  Created:             09.Aug.2013, LucianP 7698
  Description:         Inserts a message into one given queue (as entry queue)
  Parameters:                      inGuid - message identifier
                                   inPayload  - message payload
                                   inBatchID  - batch identifier
                                   inCorrelID  - correlation identifier
                                   inReqService  - requestor service
                                   inRespService   - responder service
                                   inReqType  - request type
                                   inPriority   - processing priority
                                   inHoldstatus  - hold status 1/0
                                   inSequence - routing rule sequence
                                   inFeedback  - message feedback
                                   inSessID - session identifier                    
                                  inQueueName -  destination queue name                       
  Returns:              n/a
  Used:                 FinTP/BASE/RE
***********************************************/

BEGIN

    insert into findata.entryqueue (guid, payload, batchid, correlationid, requestorservice, responderservice, requesttype, priority, holdstatus, sequence, feedback, sessionid, queuename)
                    values (inGuid, inPayload, inBatchID, inCorrelID, inReqService, inRespService, inReqType, inPriority, inHoldstatus, inSequence, inFeedback, inSessID, inQueueName);
    update findata.routedmessages set currentqueue = 1 where correlationid =  inCorrelID;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while inserting message. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.insertmessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, inqueuename varchar)
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.insertmessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, inqueuename varchar)
TO findata;
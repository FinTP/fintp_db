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


--Function: findata.updatemessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar)

--DROP FUNCTION findata.updatemessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar);

CREATE OR REPLACE FUNCTION findata.updatemessageinqueue
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
  IN  infeedback     varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:             08.Aug.2013, LucianP 7698
  Description:         Updates message specific information for a message in queue
  Parameters:          inGuid - message identifier
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
  Returns:             n/a
  Used:                FinTP/BASE/RE
***********************************************/   

BEGIN

       update findata.entryqueue set  payload = inPayload, 
			              batchid = inBatchID , 
			              correlationid = inCorrelID, 
			              requestorservice = inReqService, 
			              responderservice = inRespService, 
                                      requesttype = inReqType, 
                                      priority = inPriority, 
                                      holdstatus = inHoldstatus, 
                                      sequence = inSequence, 
                                      feedback = inFeedback
       where guid = inGuid;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while updating message. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.updatemessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar)
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.updatemessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar)
TO findata;
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


--Function: findata.modifymessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, intoqueuename varchar)

--DROP FUNCTION findata.modifymessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, intoqueuename varchar);

CREATE OR REPLACE FUNCTION findata.modifymessageinqueue
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
  IN  intoqueuename  varchar
)
RETURNS void AS
$$
DECLARE
                                                                                                                                       
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:             09.Aug.2013, LucianP 7698
  Description:         Updates message specific information for a message in queue, along with changing the source queue name.
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
                       inToQueueName - destination queue name                                    
  Returns:             n/a
  Used:                FinTP/BASE/RE
***********************************************/

BEGIN

    perform findata.updatemessageinqueue(inGuid,  inPayload, inBatchID,  inCorrelID, inSessID, inReqService,  inRespService, inReqType,  inPriority,  inHoldstatus,  inSequence,  inFeedback);
    perform findata.movemessageinqueue(inGuid,  inTOQueueName,  '');  


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while modifying message. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.modifymessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, intoqueuename varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.modifymessageinqueue(inguid varchar, inpayload text, inbatchid varchar, incorrelid varchar, insessid varchar, inreqservice varchar, inrespservice varchar, inreqtype varchar, inpriority integer, inholdstatus integer, insequence integer, infeedback varchar, intoqueuename varchar)
TO findata;
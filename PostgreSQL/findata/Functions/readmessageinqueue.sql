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


--Function: findata.readmessageinqueue(Output outretcursor refcursor, Input inguid varchar, Input inqueuename varchar)

--DROP FUNCTION findata.readmessageinqueue(OUT outretcursor "refcursor", IN inguid varchar, IN inqueuename varchar);

CREATE OR REPLACE FUNCTION findata.readmessageinqueue
(
  OUT  outretcursor  "refcursor",
  IN   inguid        varchar,
  IN   inqueuename   varchar    
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         20.Aug.2013, LucianP 7164
  Description:     Extract data for one given message in queue
  Parameters:      inGuid - message identifier
                   inQueueName - current queue name [not used]                                  
  Returns:         outRetCursor parameter representing cursor result set
  Used:            FinTP/BASE/RE
***********************************************/

BEGIN  

open outRetCursor for  
    select guid, payload, batchid, correlationid, sessionid, requestorservice, responderservice, requesttype,	
           priority, holdstatus, sequence, feedback	
    from findata.entryqueue where guid = inGuid and queuename = inQueueName;	
  
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while reading queue: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.readmessageinqueue(OUT outretcursor "refcursor", IN inguid varchar, IN inqueuename varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.readmessageinqueue(OUT outretcursor "refcursor", IN inguid varchar, IN inqueuename varchar)
TO findata;
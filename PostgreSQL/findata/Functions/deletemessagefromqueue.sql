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

--Function: findata.deletemessagefromqueue(inguid varchar, inqueuename varchar, inisreply integer)

--DROP FUNCTION findata.deletemessagefromqueue(inguid varchar, inqueuename varchar, inisreply integer);

CREATE OR REPLACE FUNCTION findata.deletemessagefromqueue
(
  IN  inguid       varchar,
  IN  inqueuename  varchar,
  IN  inisreply    integer
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:      dd.mon.yyyy  --  author  --   description
                       20.Mar.2014, DenisaN 8303
  Created:             09.Aug.2013, LucianP 7163
  Description:         Removes messages from queue [message has been routed to the end point] or
                                   removes reply messages from queue.  
  Parameters:          inGuid - message identifier
                       inQueueName -  destination queue name [null]
                       inIsReply - 1/0 values whether the message is a reply                                   
  Returns:             n/a
  Used:                FinTP/BASE/RE
***********************************************/


BEGIN
    if inIsReply = 0 then
        
        update findata.routedmessages set currentqueue = null where correlationid = (select correlationid from entryqueue where guid = inGuid);
        delete from findata.entryqueue where guid = inGuid;
        
    elsif inIsReply = 1 then    
        delete from findata.entryqueue where guid = inGuid;             
    end if;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while moving message. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.deletemessagefromqueue(inguid varchar, inqueuename varchar, inisreply integer)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.deletemessagefromqueue(inguid varchar, inqueuename varchar, inisreply integer)
TO findata;
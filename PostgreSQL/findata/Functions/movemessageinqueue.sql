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


--Function: findata.movemessageinqueue(inguid varchar, intoqueuename varchar, infromqueuename varchar)

--DROP FUNCTION findata.movemessageinqueue(inguid varchar, intoqueuename varchar, infromqueuename varchar);

CREATE OR REPLACE FUNCTION findata.movemessageinqueue
(
  IN  inguid           varchar,
  IN  intoqueuename    varchar,
  IN  infromqueuename  varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
                                    09.Aug.2013, LucianP 7698
  Created:            09.Aug..2013, LucianP 7163
  Description:        Changes source queue for one given messages [virtually moving one message to other queue]
  Parameters:         inGuid - message identifier
                      inTOQueueName -  destination queue name
                      inFROMQueueName - current queue name [not used]                                      
  Returns:            n/a
  Used:               FinTP/BASE/RE
***********************************************/

BEGIN

       update findata.entryqueue set queuename = inTOQueueName, sequence = 0 where guid=inGuid;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while moving message. Message is:%', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.movemessageinqueue(inguid varchar, intoqueuename varchar, infromqueuename varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.movemessageinqueue(inguid varchar, intoqueuename varchar, infromqueuename varchar)
TO findata;
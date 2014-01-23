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

--Function: findata.updatermackbatch(inbatchid varchar)

--DROP FUNCTION findata.updatermackbatch(inbatchid varchar);

CREATE OR REPLACE FUNCTION findata.updatermackbatch
(
  IN  inbatchid  varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:   dd.mon.yyyy  --  author  --   description
  Created:          28.Aug.2013, LucianP
  Description:      Sets the number of replies to 1; used for transactions in one given batch 
  Parameters:       inBatchID   - batch identifier
  Returns:          n/a
  Used:             FinTP/BASE/RE
***********************************************/   

BEGIN

      update findata.routedmessages set ack=1
                          where correlationid in (select correlid from findata.feedbackagg where batchid = inBatchID);

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing reply. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.updatermackbatch(inbatchid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.updatermackbatch(inbatchid varchar)
TO findata;
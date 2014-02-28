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


--Function: findata.insertincomingbatch(inbatchid varchar, inmessageid varchar, innamespace varchar)

--DROP FUNCTION findata.insertincomingbatch(inbatchid varchar, inmessageid varchar, innamespace varchar);

CREATE OR REPLACE FUNCTION findata.insertincomingbatch
(
  IN  inbatchid    varchar,
  IN  inmessageid  varchar,
  IN  innamespace  varchar
)
RETURNS void AS
$$
DECLARE


/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         27.Mar.2013, DenisaN
  Description:     Recording incoming batch info. 
  Parameters:      inBatchID  - batch identifier
                   inMessageID  - message identifier
                   inNamespace - batch namespace
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/ 


v_Sender varchar(12);

BEGIN

  select sender into v_Sender from findata.routedmessages where guid = inMessageID;

  insert into findata.batchjobsinc  (sender, combatchid, batchtype, insertdate)
                             values (v_Sender, inBatchID, inNamespace, now());
                                                                        
      
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing batch: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.insertincomingbatch(inbatchid varchar, inmessageid varchar, innamespace varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.insertincomingbatch(inbatchid varchar, inmessageid varchar, innamespace varchar)
TO findata;
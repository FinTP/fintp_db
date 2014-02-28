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


--Function: findata.inserthash(inservicename varchar, inmessageid varchar, inhash varchar)

--DROP FUNCTION findata.inserthash(inservicename varchar, inmessageid varchar, inhash varchar);

CREATE OR REPLACE FUNCTION findata.inserthash
(
  IN  inservicename  varchar,
  IN  inmessageid    varchar,
  IN  inhash         varchar
)
RETURNS void AS
$$
DECLARE


/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         06.Feb.2014, DenisaN 8192
  Description:     Inserts hashes for every given message 
  Parameters:      inServiceID  - service identifier
                   inMessageID  - message identifier
                   inHash       - message hash          
  Returns:         n/a
  Used:            FinTP/2D/RE
***********************************************/

BEGIN


    insert into findata.messagehashes (servicename, messageid, hash, insertdate, recvorder)
                                      (select  inServiceName, inMessageID, inHash, now(), count(inServiceName)+1 from findata.messagehashes where servicename=inServiceName and hash=inHash );
      
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while storing message hash: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.inserthash(inservicename varchar, inmessageid varchar, inhash varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.inserthash(inservicename varchar, inmessageid varchar, inhash varchar)
TO findata;
--Function: findata.gethash(Input inservicename varchar, Input inmessageid varchar, Output outcount integer)
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


--DROP FUNCTION findata.gethash(IN inservicename varchar, IN inmessageid varchar, OUT outcount integer);

CREATE OR REPLACE FUNCTION findata.gethash
(
  IN   inservicename  varchar,
  IN   inmessageid    varchar,
  OUT  outcount       integer
)
RETURNS integer AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         17.Feb.2014, DenisaN
  Description:     Gets the total number of identical hashes, for one given message    
  Parameters:      inServiceName - service identifier   
                   inMessageID -  message identifier
  Returns:         no. of appearances
  Used:            FinTP/2D/RE
***********************************************/

BEGIN
          
          
  select count (*) into outCount  from findata.messagehashes where  servicename = inServiceName
             and hash = (select hash from findata.messagehashes where servicename = inServiceName and messageid = inMessageID );
          



EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while getting hash: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.gethash(IN inservicename varchar, IN inmessageid varchar, OUT outcount integer)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.gethash(IN inservicename varchar, IN inmessageid varchar, OUT outcount integer)
TO findata;
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

--Function: fincfg.getservicestate()

--DROP FUNCTION fincfg.getservicestate();

CREATE OR REPLACE FUNCTION fincfg.getservicestate()
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         06.Dec.2013, DenisaN
  Description:     Collects service statistic data
  Parameters:      n/a
  Returns:         outRetCursor  cursor  representing service info
  Used:            FinTP/BASE/RE
***********************************************/

v_cursor REFCURSOR := 'getservicestate';

BEGIN
 
   
  open v_cursor for
     select serviceid, status, friendlyname, heartbeatinterval, sessionid from fincfg.servicemaps;
  return (v_cursor);
     
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving active schemas: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getservicestate()
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getservicestate()
TO fincfg;
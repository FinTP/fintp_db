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


--Function: fincfg.getactiveschemas(incurrenttime varchar)

--DROP FUNCTION fincfg.getactiveschemas(incurrenttime varchar);

CREATE OR REPLACE FUNCTION fincfg.getactiveschemas
(
  IN  incurrenttime  varchar
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         29.May.2013, DenisaN 7496
  Description:     Gets active routing schemas  info at invoke time
  Parameters:      inCurrentTime - current time [format:HH24:MI:SS]
  Returns:         cursor representing schema info    
  Used:            FinTP/BASE/RE
***********************************************/

 v_currentTime timestamp;
 v_cursor      refcursor;
  
BEGIN
 
   v_currentTime := to_timestamp( inCurrentTime,'HH24:MI:SS' );
   
  open v_cursor for
     select guid, name, sessioncode from fincfg.routingschemas where
        startlimit in ( select guid from fincfg.timelimits where ( limittime - date_trunc( 'day', limittime ) ) < ( v_currentTime - date_trunc( 'day', v_currentTime ) ) )
       and 
        stoplimit in ( select guid from fincfg.timelimits where ( limittime - date_trunc( 'day', limittime ) ) > ( v_currentTime - date_trunc( 'day', v_currentTime ) ) );
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

ALTER FUNCTION fincfg.getactiveschemas(incurrenttime varchar)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getactiveschemas(incurrenttime varchar)
TO fincfg;
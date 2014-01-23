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

--Function: findata.updatermvaluedate(incorrelid varchar, invaluedate varchar)

--DROP FUNCTION findata.updatermvaluedate(incorrelid varchar, invaluedate varchar);

CREATE OR REPLACE FUNCTION findata.updatermvaluedate
(
  IN  incorrelid   varchar,
  IN  invaluedate  varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         20.May.2013, DenisaN 7164
  Description:     Updates the currency date for one given message 
  Parameters:      inCorrelID   - correlation identifier
                   inValueDate - message currency date
  Returns:       n/a
  Used:           FinTP/BASE/RE
***********************************************/   
v_tablename        varchar(35);

BEGIN
	select distinct storage into v_tablename from fincfg.msgtypes where messagetype in 
		(select msgtype from findata.routedmessages where correlationid =  inCorrelID); 
	       
        execute 'update findata.'||v_tablename||' set valuedate = $1 where correlid = $2' using inValueDate, inCorrelID;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing message: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.updatermvaluedate(incorrelid varchar, invaluedate varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.updatermvaluedate(incorrelid varchar, invaluedate varchar)
TO findata;
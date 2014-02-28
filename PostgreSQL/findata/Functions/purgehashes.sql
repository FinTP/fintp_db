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


--Function: findata.purgehashes(inint integer)

--DROP FUNCTION findata.purgehashes(inint integer);

CREATE OR REPLACE FUNCTION findata.purgehashes
(
  IN  inint  integer
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         06.Feb.2014, DenisaN - 8192
  Description:     Maintaining the duplicate detection time window
  Parameters:      n/a
  Returns:         n/a
  Used:            FinTP/2D/RE
***********************************************/

v_date             date;
v_count            integer;
v_period           integer;

BEGIN
        
    select to_number(value, '99999') into v_period from fincfg.params where replace(upper(name),' ','')='DUPLICATEDETECTIONPERIOD'; 
    
    v_date := fincfg.getlastbusinessday(current_date, v_period);

     --TO BE ARCHIVED
     delete from findata.messagehashes where  insertdate  < v_date;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while purging hashes: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.purgehashes(inint integer)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.purgehashes(inint integer)
TO PUBLIC;

GRANT EXECUTE
  ON FUNCTION findata.purgehashes(inint integer)
TO findata;
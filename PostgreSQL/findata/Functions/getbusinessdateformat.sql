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

-- Function: findata.getbusinessdateformat(character varying)

-- DROP FUNCTION findata.getbusinessdateformat(character varying);

CREATE OR REPLACE FUNCTION findata.getbusinessdateformat(indate character varying)
  RETURNS character varying AS
$BODY$
DECLARE
                                                                             
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description                 
  Created:         03.Feb.2014, DenisaN 
  Description:     Returns business standard date format  
  Parameters:      inDate - date to be formatted		 
  Returns:         [yymmdd]
  Used:            FinTP/BASE/DB
***********************************************/


BEGIN

        
    if length(inDate) = 8 then
        return substr(inDate,3,6);
    elsif inDate like '%-%'  then 
        return substr(replace(inDate,'-',''),3,6);
    else
        return inDate;
    end if;
                   

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while inserting message: %', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION findata.getbusinessdateformat(character varying)
  OWNER TO findata;
GRANT EXECUTE ON FUNCTION findata.getbusinessdateformat(character varying) TO findata;

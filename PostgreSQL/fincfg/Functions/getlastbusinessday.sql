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

--Function: fincfg.getlastbusinessday(indate date, innoofdays integer)

--DROP FUNCTION fincfg.getlastbusinessday(indate date, innoofdays integer);

CREATE OR REPLACE FUNCTION fincfg.getlastbusinessday
(
  IN  indate      date,
  IN  innoofdays  integer
)
RETURNS date AS
$$
DECLARE


/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         06.Feb.2014, DenisaN 8192
  Description:     Returns the last business day, given a number of days (to decrease or increase)
  Parameters:      inDate - starting date
                   inNoOfDays - days to decrease/increase                                
  Returns:         date
  Used:            FinTP/BASE/BD
***********************************************/


v_lastBusinessDay   date;
v_count             integer default 0; 


BEGIN

  v_lastBusinessDay := inDate - inNoOfDays;

  if inNoOfDays > 0 then 

       --number of non working days in the interval (before)
        select count(*) into v_count from fincfg.nbdcalendar where nbddate < inDate and nbddate >= (inDate - inNoOfDays);
        
        if v_count = 0 then
            return v_lastBusinessDay;
        else
            return fincfg.getlastbusinessday(v_lastBusinessDay, v_count);
        end if;


  else  
    
         --number of non working days in the interval (ahead)
        select count(*) into v_count from fincfg.nbdcalendar where nbddate > inDate and nbddate <= (inDate - inNoOfDays);
        
        if v_count = 0 then
            return v_lastBusinessDay;
        else
            return fincfg.getlastbusinessday(v_lastBusinessDay, v_count*(-1));
        end if;
  
  end if;
  

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while reading the calendar: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getlastbusinessday(indate date, innoofdays integer)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getlastbusinessday(indate date, innoofdays integer)
TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getlastbusinessday(indate date, innoofdays integer)
TO findata;
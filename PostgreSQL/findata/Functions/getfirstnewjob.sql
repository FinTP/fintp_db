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


--Function: findata.getfirstnewjob(Output outretcursor refcursor)

--DROP FUNCTION findata.getfirstnewjob(OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION findata.getfirstnewjob
(
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         17.May.2013, DenisaN 7164
  Description:     Returns first new job by highest priority and marks it as 'in process' 
  Parameters:      n/a
  Returns:         cursor result set
  Used:            FinTP/BASE/RE
***********************************************/

v_guid      findata.routingjobs.guid%type;

BEGIN

  update findata.routingjobs set status = -1 where guid in 
   (select guid from (select guid from findata.routingjobs where status=0 order by priority desc)rj limit 1) 
  returning guid into v_guid;
  
  open outretcursor for
    select guid, status,  backout,  priority,  routingpoint, function, userid
    from findata.routingjobs where guid = v_guid;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering job: % ', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getfirstnewjob(OUT outretcursor "refcursor")
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getfirstnewjob(OUT outretcursor "refcursor")
TO findata;
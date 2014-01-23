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


--Function: fincfg.getqueues(Output outretcursor refcursor)

--DROP FUNCTION fincfg.getqueues(OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION fincfg.getqueues
(
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         27.Mar.2013, DenisaN
  Description:     Gets all queues and all service maps non/associated
  Parameters:      n/a
  Returns:         cursor result set
  Used:            FinTP/BASE/RE
***********************************************/

BEGIN

   open outretcursor  for
             select  q.guid, q.name,  sm.exitpoint,  sm.friendlyname,  sm.serviceid, sm.duplicateq, q.holdstatus, sm.duplicatenotifq, sm.delayednotifq 
              from  fincfg.queues q
              left join fincfg.servicemaps sm
              on q.connector = sm.serviceid;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving queues: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getqueues(OUT outretcursor "refcursor")
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getqueues(OUT outretcursor "refcursor")
TO fincfg;
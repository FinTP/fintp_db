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


--Function: findata.abortjob(injobid varchar)

--DROP FUNCTION findata.abortjob(injobid varchar);

CREATE OR REPLACE FUNCTION findata.abortjob
(
  IN  injobid  varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history: dd.mon.yyyy  --  author  --   description
  Created:        17.May.2013,DenisaN - 7164
  Description:    Removes one given routing job.Reason:aborted;
  Parameters:     inJobID - routing job identifier
  Returns:        n/a
  Used:          FinTP/BASE/RE
***********************************************/

BEGIN

   delete from findata.routingjobs where findata.routingjobs.guid = inJobID;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while deleting job: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.abortjob(injobid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.abortjob(injobid varchar)
TO findata;
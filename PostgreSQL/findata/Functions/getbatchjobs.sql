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

--Function: findata.getbatchjobs(Output outretcursor refcursor, Input incombatchid varchar)

--DROP FUNCTION findata.getbatchjobs(OUT outretcursor "refcursor", IN incombatchid varchar);

CREATE OR REPLACE FUNCTION findata.getbatchjobs
(
  OUT  outretcursor  "refcursor",
  IN   incombatchid  varchar    
)
RETURNS "refcursor" AS
$$
DECLARE
                                                                                                    
                                                                                                         
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         02.Dec.2013, DenisaN
  Description:     Gathers info for one batch job not yet completed.
  Parameters:      inCombatchID - computed batch identifier
  Returns:         outRetCursor parameter representing cursor result set
  Used:            FinTP/BASE/RE
***********************************************/

BEGIN

 open outRetCursor for
    select tbj.jobid guid,   tbj.sequence,  tbj.correlationid, tbj.feedback,
                 tbj.xformitem, bj.routingpoint,  bj.batchcount,   bj.batchamount
    from findata.tempbatchjobs tbj 
    left  join findata.batchjobs bj on tbj.combatchid = bj.combatchid 
    where tbj.combatchid = inCombatchID;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering job info. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getbatchjobs(OUT outretcursor "refcursor", IN incombatchid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getbatchjobs(OUT outretcursor "refcursor", IN incombatchid varchar)
TO findata;
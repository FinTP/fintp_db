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

--Function: findata.getoriginalpayload(Output outrefcursor refcursor, Input inmsgid varchar)

--DROP FUNCTION findata.getoriginalpayload(OUT outrefcursor "refcursor", IN inmsgid varchar);

CREATE OR REPLACE FUNCTION findata.getoriginalpayload
(
  OUT  outrefcursor  "refcursor",
  IN   inmsgid       varchar    
)
RETURNS "refcursor" AS
$$
DECLARE
                                                                                                    
                                                                                                         
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         17.May.2013, DenisaN 7164
  Description:     Returns the original message payload
  Parameters:      inMsgID -  message  identifier
  Returns:         cursor result set
  Used:            FinTP/BASE/RE
***********************************************/

BEGIN

 open outrefcursor for
    select payload from findata.history where guid = inMsgID;

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

ALTER FUNCTION findata.getoriginalpayload(OUT outrefcursor "refcursor", IN inmsgid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getoriginalpayload(OUT outrefcursor "refcursor", IN inmsgid varchar)
TO PUBLIC;

GRANT EXECUTE
  ON FUNCTION findata.getoriginalpayload(OUT outrefcursor "refcursor", IN inmsgid varchar)
TO findata;
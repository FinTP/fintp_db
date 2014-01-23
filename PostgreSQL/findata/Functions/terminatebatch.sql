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

--Function: findata.terminatebatch(incombatchid varchar, inbatchtype varchar, instatus integer, inreason varchar)

--DROP FUNCTION findata.terminatebatch(incombatchid varchar, inbatchtype varchar, instatus integer, inreason varchar);

CREATE OR REPLACE FUNCTION findata.terminatebatch
(
  IN  incombatchid  varchar,
  IN  inbatchtype   varchar,
  IN  instatus      integer,
  IN  inreason      varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         21.Aug.2013, LucianP
  Description:     Marks batch final status and remove temporary related data.
  Parameters:      inCombatchID - batch identifier
                   inBatchType - batch type
                   inStatus  - batch state      
                   inReason - reason of failure
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/   


BEGIN

  update findata.batchjobs set batchstatus = inStatus, reason = substr(inReason, 1, 499 ), batchtype = inBatchType
          where combatchid = inCombatchID;
   
  delete from findata.tempbatchjobs where combatchid = inCombatchID;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing batch. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.terminatebatch(incombatchid varchar, inbatchtype varchar, instatus integer, inreason varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.terminatebatch(incombatchid varchar, inbatchtype varchar, instatus integer, inreason varchar)
TO findata;
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

--Function: fincfg.getrule(Input inruleid integer, Output outretcursor refcursor)

--DROP FUNCTION fincfg.getrule(IN inruleid integer, OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION fincfg.getrule
(
  IN   inruleid      integer,
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE
                                                                              
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         29.May.2013, DenisaN 7496
  Description:     Gets a routing rule by its identifier
  Parameters:      inRuleID - identifier of the rule being retrieved
  Returns:         cursor  representing  specified routing rule
  Used:            FinTP/BASE/RE
***********************************************/

BEGIN

   open outretcursor for
      select guid, queueid queue, description, msgcond cond_msg, funccond cond_func,  metacond cond_meta,  action
        from  fincfg.routingrules where  guid = inRuleID;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving routing rule: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getrule(IN inruleid integer, OUT outretcursor "refcursor")
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getrule(IN inruleid integer, OUT outretcursor "refcursor")
TO fincfg;
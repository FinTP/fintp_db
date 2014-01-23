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

--Function: fincfg.getrulesforschema(Output outretcursor refcursor, Input inschemaname varchar)

--DROP FUNCTION fincfg.getrulesforschema(OUT outretcursor "refcursor", IN inschemaname varchar);

CREATE OR REPLACE FUNCTION fincfg.getrulesforschema
(
  OUT  outretcursor  "refcursor",
  IN   inschemaname  varchar    
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         29.May.2013, DenisaN 7496
  Description:     Gets routing definition for the specified routing schema
  Parameters:      inSchemaName - name of the routing schema
  Returns:         cursor  representing the routing definition
  Used:            FinTP/BASE/RE
***********************************************/    
 
BEGIN

   open outretcursor for
        select rr.guid guid_rule, rr.sequence, rr.ruletype from fincfg.routingrules rr
       join fincfg.routingschemas rs on rs.guid = rr.schemaguid and  rs.name = inschemaname;
       
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving rules: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getrulesforschema(OUT outretcursor "refcursor", IN inschemaname varchar)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getrulesforschema(OUT outretcursor "refcursor", IN inschemaname varchar)
TO fincfg;
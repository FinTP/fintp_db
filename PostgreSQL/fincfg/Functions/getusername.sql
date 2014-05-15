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


--Function: fincfg.getusername(inuserid integer)

--DROP FUNCTION fincfg.getusername(inuserid integer);

CREATE OR REPLACE FUNCTION fincfg.getusername
(
  IN  inuserid  integer
)
RETURNS varchar AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:        21.Mar.2014, DenisaN 8307
  Description:    Returns the user name for given user identifier
  Parameters:     user identifier
  Returns:        user name
  Used:           FinTP/BASE/DB
***********************************************/

v_uname varchar;

BEGIN

     select username into v_uname from fincfg.users where userid = inuserid;
     return v_uname;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving username: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getusername(inuserid integer)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getusername(inuserid integer)
TO PUBLIC;

GRANT EXECUTE
  ON FUNCTION fincfg.getusername(inuserid integer)
TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getusername(inuserid integer)
TO findata;

GRANT EXECUTE
  ON FUNCTION fincfg.getusername(inuserid integer)
TO finuiuser;
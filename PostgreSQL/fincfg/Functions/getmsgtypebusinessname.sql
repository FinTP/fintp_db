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


--Function: fincfg.getmsgtypebusinessname(inmsgtype varchar)

--DROP FUNCTION fincfg.getmsgtypebusinessname(inmsgtype varchar);

CREATE OR REPLACE FUNCTION fincfg.getmsgtypebusinessname
(
  IN  inmsgtype  varchar
)
RETURNS varchar AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:        10.Nov.2013, DenisaN
  Description:    Returns the friendly/business name for one given message type
  Parameters:     message type internal name
  Returns:        message type friendly name
  Used:           FinTP/BASE/DB
***********************************************/

v_fname varchar;

BEGIN

     select friendlyname into v_fname from fincfg.msgtypes where messagetype = inMsgType;
     return v_fname;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving messagetype: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.getmsgtypebusinessname(inmsgtype varchar)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getmsgtypebusinessname(inmsgtype varchar)
TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.getmsgtypebusinessname(inmsgtype varchar)
TO findata;
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


--Function: fincfg.updateservicestate(inserviceid integer, instatus integer, insessionid varchar)

--DROP FUNCTION fincfg.updateservicestate(inserviceid integer, instatus integer, insessionid varchar);

CREATE OR REPLACE FUNCTION fincfg.updateservicestate
(
  IN  inserviceid  integer,
  IN  instatus     integer,
  IN  insessionid  varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         29.May.2013, DenisaN
  Description:     Updates the state of the specified service
  Parameters:      inServiceID - service identifier to be updated
                   inStatus - service new state
                   inSessionID - session identifier
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/ 

BEGIN

  update fincfg.servicemaps set status = inStatus, sessionid = inSessionID where serviceid = inServiceID;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while updating service status: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION fincfg.updateservicestate(inserviceid integer, instatus integer, insessionid varchar)
  OWNER TO fincfg;

GRANT EXECUTE
  ON FUNCTION fincfg.updateservicestate(inserviceid integer, instatus integer, insessionid varchar)
TO fincfg;
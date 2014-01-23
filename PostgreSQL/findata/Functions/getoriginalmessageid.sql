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

--Function: findata.getoriginalmessageid(Input incorrelid varchar, Output outmsgid varchar)

--DROP FUNCTION findata.getoriginalmessageid(IN incorrelid varchar, OUT outmsgid varchar);

CREATE OR REPLACE FUNCTION findata.getoriginalmessageid
(
  IN   incorrelid  varchar,
  OUT  outmsgid    varchar
)
RETURNS varchar AS
$$
DECLARE
                                                                                                        
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         17.May.2013, DenisaN 7164
  Description:     Gets the original message identifier [ guid ]
  Parameters:      inCorrelID -  message correlation identifier
  Returns:         message guid
  Used:            FinTP/BASE/RE
***********************************************/


BEGIN

  select guid into outMsgID from findata.routedmessages where correlationid=inCorrelID;

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

ALTER FUNCTION findata.getoriginalmessageid(IN incorrelid varchar, OUT outmsgid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getoriginalmessageid(IN incorrelid varchar, OUT outmsgid varchar)
TO findata;
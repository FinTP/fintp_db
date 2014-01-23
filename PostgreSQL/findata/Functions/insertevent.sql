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

--Function: findata.insertevent(inguid varchar, inservice integer, incorrelid varchar, insession varchar, inevtype varchar, inmachine varchar, inevdate varchar, inmessage varchar, inclass varchar, inaddinfo varchar, ininnerex varchar)

--DROP FUNCTION findata.insertevent(inguid varchar, inservice integer, incorrelid varchar, insession varchar, inevtype varchar, inmachine varchar, inevdate varchar, inmessage varchar, inclass varchar, inaddinfo varchar, ininnerex varchar);

CREATE OR REPLACE FUNCTION findata.insertevent
(
  IN  inguid      varchar,
  IN  inservice   integer,
  IN  incorrelid  varchar,
  IN  insession   varchar,
  IN  inevtype    varchar,
  IN  inmachine   varchar,
  IN  inevdate    varchar,
  IN  inmessage   varchar,
  IN  inclass     varchar,
  IN  inaddinfo   varchar,
  IN  ininnerex   varchar
)
RETURNS void AS
$$
DECLARE
                                                                       
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         17.May.2013, DenisaN  7164
  Description:     Auditing one event. 
  Parameters:   inGuid         - generated identifier
	        inService      - audited service
	        inCorrelID     - message correlation identifier
	        inSession      - session identifier
	        inEvType       - Info, Warning, Error
	        inMachine      - host machine
	        inEvDate       - event date [format: "YYYY-MM-DD-HH24.MI.SS"]
	        inMessage      - event text
	        inClass        - [not used] 
	        inAddInfo      - event additional info 
	        inInnerEx      - related subevents
  Returns:      n/a
  Used:         FinTP/BASE/RE/Conn
***********************************************/   

BEGIN

   insert into status ( guid, service,  sessionid, correlationid,  additionalinfo, type, class,  machine, 
                        eventdate,  insertdate,  message, innerexception )
               values ( inGuid, inService, inSession, inCorrelID, inAddinfo, inEvtype, inClass, inMachine,
                        to_timestamp( inEvDate, 'YYYY-MM-DD-HH24.MI.SS' ), now(), inMessage, inInnerex);

EXCEPTION
  WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while auditing: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.insertevent(inguid varchar, inservice integer, incorrelid varchar, insession varchar, inevtype varchar, inmachine varchar, inevdate varchar, inmessage varchar, inclass varchar, inaddinfo varchar, ininnerex varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.insertevent(inguid varchar, inservice integer, incorrelid varchar, insession varchar, inevtype varchar, inmachine varchar, inevdate varchar, inmessage varchar, inclass varchar, inaddinfo varchar, ininnerex varchar)
TO findata;
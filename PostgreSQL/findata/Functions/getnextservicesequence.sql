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

--Function: findata.getnextservicesequence(Input inservice integer, Output outsequence integer)

--DROP FUNCTION findata.getnextservicesequence(IN inservice integer, OUT outsequence integer);

CREATE OR REPLACE FUNCTION findata.getnextservicesequence
(
  IN   inservice    integer,
  OUT  outsequence  integer
)
RETURNS integer AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         27.Aug.2013, LucianP
  Description:     Gets the next sequence (used in batch identifier) for the specified service
  Parameters:      inService -  service identifier
  Returns:         outSequence parameter representing the sequence to be used
  Used:            FinTP/BASE/RE
***********************************************/

v_service    fincfg.servicemaps.friendlyname%type;

BEGIN

  select friendlyname into v_service from fincfg.servicemaps where serviceid = inService;

  select nextval('findata.commbatchseq') into outSequence;

EXCEPTION
   WHEN NO_DATA_FOUND THEN 
         RAISE EXCEPTION 'Service not found.';
   WHEN OTHERS THEN
         RAISE EXCEPTION 'Unexpected error occured while generating batch sequence. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getnextservicesequence(IN inservice integer, OUT outsequence integer)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getnextservicesequence(IN inservice integer, OUT outsequence integer)
TO findata;
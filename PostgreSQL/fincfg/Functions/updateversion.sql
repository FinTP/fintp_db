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


CREATE OR REPLACE FUNCTION fincfg.updateversion(inServiceName    varchar,
                                                                                                                      inName                     varchar,
                                                                                                                      inVersion                  varchar,
                                                                                                                      inMachine               varchar,
                                                                                                                      inHash                       varchar)
  RETURNS void AS
$BODY$

DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         
  Description:     <work in progress> 
  Parameters:                             
  Returns:         n/a
  Used:            FinTP/BASE/
***********************************************/


BEGIN

   select 1;
         

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while configuring queue: %', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fincfg.updateversion(varchar, varchar, varchar, varchar, varchar)
  OWNER TO fincfg;
REVOKE ALL ON FUNCTION fincfg.updateversion(varchar, varchar, varchar, varchar, varchar) FROM public;
GRANT EXECUTE ON FUNCTION fincfg.updateversion(varchar, varchar, varchar, varchar, varchar) TO fincfg;

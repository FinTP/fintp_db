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


-- Function: fincfg.updateversion(character varying, character varying, character varying, character varying, character varying)

-- DROP FUNCTION fincfg.updateversion(character varying, character varying, character varying, character varying, character varying);

CREATE OR REPLACE FUNCTION fincfg.updateversion(inservicename character varying, inname character varying, inversion character varying, inmachine character varying, inhash character varying)
  RETURNS void AS
$BODY$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         18.Feb.2014, DenisaN
  Description:     Update app service version 
  Parameters:      inservicename  - service name
                   inname - short description
                   inversion - current version
                    inmachine - hosting machine
                   inhash - hash value                         
  Returns:         n/a
  Used:            FinTP/BASE/EW
***********************************************/

v_count integer;

BEGIN

  select count(servicename) into v_Count from fincfg.versions where servicename=inServiceName;

  if v_Count > 0 then
     
        update fincfg.versions set servicename=inServiceName, versions.name=inName,
                versions.version=inVersion, machine=inMachine, hash=inHash where servicename=inServiceName;
         
     else
     
        insert into fincfg.versions( servicename, versions.name, versions.version, machine, hash ) 
                             values( inServiceName, inName, inVersion, inMachine, inHash );
        
  end if;
     
         

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while config app: %', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION fincfg.updateversion(character varying, character varying, character varying, character varying, character varying)
  OWNER TO fincfg;
GRANT EXECUTE ON FUNCTION fincfg.updateversion(character varying, character varying, character varying, character varying, character varying) TO fincfg;

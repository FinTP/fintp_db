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

--Function: findata.trg_insertroutingjob()

--DROP FUNCTION findata.trg_insertroutingjob();

CREATE OR REPLACE FUNCTION findata.trg_insertroutingjob()
RETURNS trigger AS
$$
BEGIN
	insert into findata.routingjobs( guid, status, backout, priority, routingpoint, function, userid )
                                 values( new.guid, 0, 0, new.priority, new.queuename, 'F=Route', null );

    RETURN NULL; 
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.trg_insertroutingjob()
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.trg_insertroutingjob()
TO findata;
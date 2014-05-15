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

--Function: findata.getbatchtype(Input inbatchid varchar, Input intablename varchar, Input insender varchar, Output outbatchtype varchar)

--DROP FUNCTION findata.getbatchtype(IN inbatchid varchar, IN intablename varchar, IN insender varchar, OUT outbatchtype varchar);

CREATE OR REPLACE FUNCTION findata.getbatchtype
(
  IN   inbatchid     varchar,
  IN   intablename   varchar,
  IN   insender      varchar,
  OUT  outbatchtype  varchar
)
RETURNS varchar AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         20.Aug.2013, LucianP
  Description:     Gets the batch type for one given batch
  Parameters:      inBatchID  - batch identifier
                   inTableName - batch table
                   inSender - sender bank BIC
  Returns:         outBatchType  parameter representing the batch type
  Used:            FinTP/BASE/RE
***********************************************/          

v_stmt  character varying(250);

BEGIN

      if inSender = '' then           
         --  get batch type from outgoing batch storage
         v_stmt := 'select batchtype from findata.' || inTableName || ' t where combatchid = $1'; 
         execute v_stmt into outBatchType using inBatchID;
      else
        -- get batch type from incoming batch storage
         v_stmt := 'select batchtype from findata.' || inTableName || ' t where combatchid = $1 and sender = $2';
         execute v_stmt into outBatchType using inBatchID, inSender ;
      end if;

EXCEPTION
   WHEN NO_DATA_FOUND THEN 
         RAISE EXCEPTION 'Batch not found: %', SQLERRM;

   WHEN OTHERS THEN
         RAISE EXCEPTION 'Unexpected error occured while retrieving batch type. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getbatchtype(IN inbatchid varchar, IN intablename varchar, IN insender varchar, OUT outbatchtype varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getbatchtype(IN inbatchid varchar, IN intablename varchar, IN insender varchar, OUT outbatchtype varchar)
TO findata;
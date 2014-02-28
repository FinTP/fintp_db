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


--Function: findata.getoriginalref(Input intrn varchar, Input inbatchid varchar, Output outref varchar)

--DROP FUNCTION findata.getoriginalref(IN intrn varchar, IN inbatchid varchar, OUT outref varchar);

CREATE OR REPLACE FUNCTION findata.getoriginalref
(
  IN   intrn      varchar,
  IN   inbatchid  varchar,
  OUT  outref     varchar
)
RETURNS varchar AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description                              
  Created:         10.Feb.2014, DenisaN
  Description:     Gets the refusal transaction reference.
  Parameters:      inTrn -  original message transaction reference
                   inBatchID - refusal batch identifier
  Returns:         outRef parameter reperesenting refusal transaction reference 
  Used:            FinTP/BASE/RE
***********************************************/



v_storage varchar(35);
v_stmt    varchar(1000);

BEGIN

        --get original message type & storage        
        select storage into v_storage from fincfg.msgtypes where messagetype in (select msgtype  from findata.routedmessages where trn = inTRN);
         
       --get refusal reference
       v_stmt :=  ' select trn from '||
                                   ' ( select correlid, trn from feedbackagg.feedbackagg where batchid = $1 ) fb '||
                            ' join '|| 
                                    ' ( select correlid from findata.'||v_storage||' where origref = $2 ) mt '||
                             ' on fb.correlid = mt.correlid ';   
      execute v_stmt into outRef using inBatchID, inTrn;
      
      
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while retrieving reference: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getoriginalref(IN intrn varchar, IN inbatchid varchar, OUT outref varchar)
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.getoriginalref(IN intrn varchar, IN inbatchid varchar, OUT outref varchar)
TO findata;
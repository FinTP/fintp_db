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


--Function: findata.updaterefusalfbcode(inbatchid varchar, incode varchar)

--DROP FUNCTION findata.updaterefusalfbcode(inbatchid varchar, incode varchar);

CREATE OR REPLACE FUNCTION findata.updaterefusalfbcode
(
  IN  inbatchid  varchar,
  IN  incode     varchar
)
RETURNS void AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description                                    
  Created:         14.Feb.2014  --  DenisaN
  Description:     Updates Correspondent/Network codes of original msg when refusal received
  Parameters:      inBatchid   - refusal batch identifier
                   inCode - refusal code
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/   

v_origBatchID         varchar(35);
v_origRef             varchar(30);
v_amount              numeric(17, 2);
v_storage             varchar(35);
v_msgtype             varchar(35);

--all the refusals in one batch
v_cursor cursor( v_batchid varchar) for
   select correlid from findata.feedbackagg where batchid = v_batchid;

BEGIN

       --get original message type and storage
     select distinct msgtype into v_msgtype from findata.routedmessages 
            where correlationid = (select correlid from findata.feedbackagg where batchid = inBatchID);
     select storage into v_storage from fincfg.msgtypes where messagetype =  v_msgtype;                  

if v_msgtype in ('RCQ', 'RPN', 'RBE') then

     for rec in v_cursor (inBatchID) loop                

        execute ' select origbatchid, origref, to_number(case  when amount is null then ''0,00'' '|| 
                                                             ' when amount = '''' then ''0,00'' '|| 
                                                             ' when amount = '','' then ''0,00'' '|| 
                                                             ' else replace(amount, '','', ''.'') '|| 
                                                        ' end, ''FM99999999999999999D99'') '||                   
                ' from findata.'||v_storage||' where correlid = '''||rec.correlid||'''' 
        into v_origBatchID, v_origRef, v_amount using rec.correlid; 
            
        if v_amount = 0 then
           --mark total amount refusal
           update findata.feedbackagg set correspcode = inCode where batchid = v_origBatchID and trn = v_origRef;
        else
           --mark partial amount refusal
           update findata.feedbackagg set networkcode = inCode where batchid = v_origBatchID  and  trn = v_origRef;
        end if;            
                
     end loop;

else

   for rec in v_cursor (inBatchID) loop                

        execute ' select origbatchid, origref '||                   
                ' from findata.'||v_storage||' where correlid = '''||rec.correlid||'''' 
        into v_origBatchID, v_origRef using rec.correlid; 

       update findata.feedbackagg set correspcode = inCode where batchid = v_origBatchID and trn = v_origRef;
       
   end loop;
	

end if;


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

ALTER FUNCTION findata.updaterefusalfbcode(inbatchid varchar, incode varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.updaterefusalfbcode(inbatchid varchar, incode varchar)
TO findata;
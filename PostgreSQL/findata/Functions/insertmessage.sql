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

--Function: findata.insertmessage(inmsgtype varchar, insenderapp varchar, inreceiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[])

--DROP FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, inreceiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[]);

CREATE OR REPLACE FUNCTION findata.insertmessage
(
  IN  inmsgtype      varchar,
  IN  insenderapp    varchar,
  IN  inreceiverapp  varchar,
  IN  inguid         varchar,
  IN  incorrelid     varchar,
  IN  inkwnames      varchar[]
)
RETURNS void AS
$$
DECLARE
                                                                             
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
                   03.Feb.2014, DenisaN - date format
  Created:         20.May.2013, DenisaN - 7164
  Description:     Inserts every routed message into common table and specific tables.  
  Parameters:    inMsgType       - message type to be inserted
		         inSenderApp     - sender application service
                 inGuid          - unique identifier
		         inCorrelID      - correlation identifier  
		         inKWNames       - message keywords [see cfg.routingkeywordmapps] followed by their values
  Returns:       n/a
  Used:          FinTP/BASE/RE
***********************************************/


v_ReferenceIdx     integer default 0;
v_SenderIdx        integer default 0;
v_ReceiverIdx      integer default 0;
v_AmountIdx        integer default 0;
v_tablename        varchar(35);
v_insertfields     varchar(2000) default '(';
v_insertvalues     varchar(2000) default '(';
v_half             integer;
v_kwvalues         varchar[];
v_dateformat       varchar(6);            


BEGIN

     v_half:= array_length(inKWNames,1)/2;
     
     for i in 1..v_half loop
         
         v_kwvalues[i]:= inKWNames[i+v_half];
     
     end loop;

  
     for i in 1..array_length(inKWNames,1)/2 loop
            
            case  
                     --extract message common info 
                      when inKWNames[i] = 'Reference' then v_ReferenceIdx:=i;
                      when inKWNames[i] = 'Sender' then v_SenderIdx:=i;
                      when inKWNames[i] = 'Receiver' then v_ReceiverIdx:=i;
                                            
            else 
                      --extract message specific info
                      v_insertfields:= v_insertfields||inKWNames[i];

                     if v_kwvalues[i] is null then 
					    v_insertvalues:= v_insertvalues||''''||'null'||'''';
					    
					  --standard date format
					 elsif inKWNames[i] like '%Date' then                          
                        select findata.getbusinessdateformat(v_kwvalues[i]) into v_dateformat;  
                        v_insertvalues:= v_insertvalues||''''||v_dateformat||'''';
                          
                     else
       				    v_insertvalues:= v_insertvalues||''''||v_kwvalues[i]||'''';
       				    
                     end if;
                                 
                     v_insertfields:=v_insertfields||',';
                     v_insertvalues:=v_insertvalues||','; 
            end case; 
            
             --extract transaction amount /if any
           if inKWNames[i] = 'Amount' then v_AmountIdx:=i; end if;                       
            
     end loop;  


    --retrieve specific message table storage                                           
   select distinct storage into  v_tablename from fincfg.msgtypes where messagetype =  inMsgType;         
   
   --insert message info into storage tables    
   insert into findata.routedmessages (currentqueue, guid, correlationid, msgtype, sender, receiver, trn, senderapp, receiverapp, amount) 
                               values (1, inGuid, inCorrelID, inMsgType, v_kwvalues[v_SenderIdx], v_kwvalues[v_ReceiverIdx], v_kwvalues[v_ReferenceIdx], inSenderApp, inReceiverApp, v_kwvalues[v_AmountIdx]);                                                                       
 execute 'insert into findata.'||v_tablename||' '||v_insertfields||' correlid, msgtype) values '||v_insertvalues||' $1, $2 )'using inCorrelID, inMsgType;

	

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while inserting message: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, inreceiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[])
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, inreceiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[])
TO findata;
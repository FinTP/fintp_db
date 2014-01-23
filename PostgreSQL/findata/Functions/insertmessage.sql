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

--Function: findata.insertmessage(inmsgtype varchar, insenderapp varchar, receiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[], inkwvalues varchar[])

--DROP FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, receiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[], inkwvalues varchar[]);

CREATE OR REPLACE FUNCTION findata.insertmessage
(
  IN  inmsgtype    varchar,
  IN  insenderapp  varchar,
  IN  receiverapp  varchar,
  IN  inguid       varchar,
  IN  incorrelid   varchar,
  IN  inkwnames    varchar[],
  IN  inkwvalues   varchar[]
)
RETURNS void AS
$$
DECLARE
                                                                             
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         20.May.2013, DenisaN - 7164
  Description:     Inserts every routed message into common table and specific tables.  
  Parameters:    inMsgType       - message type to be inserted
		 inSenderApp     - sender application service
		 inGuid          - unique identifier
		 inCorrelID      - correlation identifier  
		 inKWNames       - message keywords [see cfg.routingkeywordmapps]
		 inKWValues      - message keyword values  
  Returns:       n/a
  Used:          FinTP/BASE/RE
***********************************************/


v_ReferenceIdx     integer default 0;
v_SenderIdx        integer default 0;
v_ReceiverIdx      integer default 0;
v_AmountIdx        integer default 0;
v_tablename        varchar(35);
v_insertfields     varchar(2000) default ' ';
v_insertvalues     varchar(2000) default ' ';


BEGIN

  
     for i in 1..array_length(inKWNames,1) loop
            
            case  
                     --extract message common info 
                     when inKWNames[i] = 'Reference' then v_ReferenceIdx:=i;
                      when inKWNames[i] = 'Sender' then v_SenderIdx:=i;
                      when inKWNames[i] = 'Receiver' then v_ReceiverIdx:=i;
                      
                      else 
                                 --extract message specific info
                                 v_insertfields:= v_insertfields||inKWNames[i];
                                 v_insertvalues:=v_insertvalues||''''||inKWValues[i]||'''';
                                 
                                 v_insertfields:=v_insertfields||',';
                                 v_insertvalues:=v_insertvalues||','; 
            end case; 
            
             --extract transaction amount /if any
           if inKWNames(i) = 'Amount' then v_AmountIdx:=i; end if;                       
            
     end loop;  


    --retrieve specific message table storage                                           
   select distinct storage into  v_tablename from fincfg.msgtypes where messagetype =  inMsgType;         
   
   --insert message info into storage tables    
   insert into findata.routedmessages (guid, correlationid, msgtype, sender, receiver, trn, senderapp, receiverapp, amount) 
                               values (inGuid, inCorrelID, inMsgType, inKWValues[v_SenderIdx], inKWValues[v_ReceiverIdx], inKWValues[v_ReferenceIdx], inSenderApp, inReceiverApp, inKWValues(v_AmountIdx));                                                                       
   execute 'insert into findata.'||v_tablename||' ( '||v_insertfields||' correlid, msgtype) values ( '||v_insertvalues||' $1, $2 )' using inCorrelID, inMsgType;



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

ALTER FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, receiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[], inkwvalues varchar[])
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.insertmessage(inmsgtype varchar, insenderapp varchar, receiverapp varchar, inguid varchar, incorrelid varchar, inkwnames varchar[], inkwvalues varchar[])
TO findata;
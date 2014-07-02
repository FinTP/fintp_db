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

-- Function: findata.direfusalgetall(character varying, character varying)

-- DROP FUNCTION findata.direfusalgetall(character varying, character varying);

CREATE OR REPLACE FUNCTION findata.direfusalgetall(OUT outretcursor refcursor, IN inmsgid character varying, IN inqueuename character varying)
  RETURNS refcursor AS
$BODY$
DECLARE
                                                                                                                                       
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         30.Mar.2014, DenisaN 8380
  Description:     Returns RDI original message payload; 
                   Configurable in RE config.     
  Parameters:     inMsgID - refusal message identifier
                  inQueueName - not used / FB default                         
  Returns:        cursor
  Used:           FinTP/ID/RE Assemble(Refusal) routing rule
***********************************************/

 v_batchID     findata.feedbackagg.batchid%type;
 v_trn         findata.routedmessages.trn%type;
 v_mtstorage   varchar(35);

  
BEGIN

  -- get message specific storage
  select storage into v_mtstorage from fincfg.msgtypes 
    where messagetype = (select msgtype from findata.routedmessages where guid = inMsgID);
  
  
  --get original msg payload, given the correlation keywords
 execute ' select trn, origbatchid from '||
	' (select trn, correlationid from findata.routedmessages where guid = $1) rm '||
	' join '||
	' (select origbatchid, correlid from '||v_mtstorage||') mt '||
	' on mt.correlid = rm.correlationid '
 into v_trn, v_batchID using inmsgid; 	
        

  open outretcursor for
     select correlid guid, payload  
       from findata.feedbackagg where batchID = v_batchID and trn=v_trn;
  

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering original message. Message is: %', SQLERRM;
       
END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION findata.direfusalgetall(character varying, character varying)
  OWNER TO findata;
GRANT EXECUTE ON FUNCTION findata.direfusalgetall(character varying, character varying) TO findata;
GRANT EXECUTE ON FUNCTION findata.direfusalgetall(character varying, character varying) TO finuiuser;

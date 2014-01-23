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

--Function: findata.loadqpcms(Input inhash varchar, Input inmessage text, Input intablename varchar, Input inbuffersize integer, Output outresultcode varchar, Output outresultmessage varchar)

--DROP FUNCTION findata.loadqpcms(IN inhash varchar, IN inmessage text, IN intablename varchar, IN inbuffersize integer, OUT outresultcode varchar, OUT outresultmessage varchar);

CREATE OR REPLACE FUNCTION findata.loadqpcms
(
  IN   inhash            varchar,
  IN   inmessage         text,
  IN   intablename       varchar,
  IN   inbuffersize      integer,
  OUT  outresultcode     varchar,
  OUT  outresultmessage  varchar
)
RETURNS record AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
                                   
  Created:     12.Mar.2013, DenisaN - 7164  
  Description: Extracting and routing message to entry queue (+ history);
  Parameters: inHash  - message computed hash value
              inMessage  - xml format message
              inTableName   - message entry queue
              inBufferSize  - 
  Returns:    outResultCode, outResultMessage 
  Used:       FinTP/BASE/Conn
***********************************************/             

  v_XMLData                  xml;
  v_PayloadOrg               text;
  v_PayloadTrf               text;
  v_Guid                     varchar(30);
  v_BatchId                  varchar(35);
  v_CorrelId                 varchar(30);
  v_SessionId                varchar(30);
  v_RequestorService         varchar(30);
  v_Hash                     xml;
  v_ResponderService         varchar(30);
  v_RequestType              varchar(30);
  v_Feedback                 varchar(40);
  v_priority                 integer;

BEGIN

select xmlparse(DOCUMENT inMessage) into v_XMLData;

select (xpath('/qPCMessageSchema/Message/Payload/Original/text()', v_XMLData))[1]::varchar into v_PayloadOrg;
select (xpath('/qPCMessageSchema/Message/Payload/Transformed/text()', v_XMLData))[1]::varchar into v_PayloadTrf;
select (xpath('/qPCMessageSchema/Message/Guid/text()', v_XMLData))[1]::varchar into v_Guid;
select (xpath('/qPCMessageSchema/Message/BatchId/text()', v_XMLData))[1]::varchar into v_BatchId; --nullable
select (xpath('/qPCMessageSchema/Message/CorrelationId/text()', v_XMLData))[1]::varchar into v_CorrelId;
select (xpath('/qPCMessageSchema/Message/SessionId/text()', v_XMLData))[1]::varchar into v_SessionId;
select (xpath('/qPCMessageSchema/Message/RequestorService/text()', v_XMLData))[1]::varchar into v_RequestorService;
select (xpath('/qPCMessageSchema/Message/ResponderService/text()', v_XMLData))[1]::varchar into v_ResponderService; --nullable
select (xpath('/qPCMessageSchema/Message/RequestType/text()', v_XMLData))[1]::varchar into v_RequestType;
select (xpath('/qPCMessageSchema/Message/Feedback/text()', v_XMLData))[1]::varchar into v_Feedback;
  
--det dup? -test: daca funct fara calc hashului/det dup
/*  if inHash is not null  then
    inserthash( v_RequestorService, v_Guid, trim( inHash ) );
  else
    v_Hash := v_XMLData.extract('/qPCMessageSchema/Message/Hash/text()');
    if v_Hash is not null then inserthash( v_RequestorService, v_Guid, v_Hash.getStringVal() ); end if;
  end if; */


insert into findata.history (guid, payload, batchid, correlationid, sessionid, requestorservice, responderservice, requesttype, feedback, insertdate)
                     values (v_Guid, v_PayloadOrg, v_BatchId, v_CorrelId, v_SessionId, v_RequestorService, v_ResponderService, v_RequestType, v_Feedback, current_timestamp);

select priority into v_priority from fincfg.queues where name=inTableName;
insert into findata.entryqueue (guid, payload, batchid, correlationid, sessionid, requestorservice, responderservice, requesttype, feedback, queuename, priority ) 
                        values (v_Guid, v_PayloadTrf, v_BatchId, v_CorrelId, v_SessionId, v_RequestorService, v_ResponderService, v_RequestType, v_Feedback, inTableName, v_priority  );


outResultCode    := '0';
outResultMessage := 'OK';

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while processing message: %', SQLERRM;
--change output values?

END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.loadqpcms(IN inhash varchar, IN inmessage text, IN intablename varchar, IN inbuffersize integer, OUT outresultcode varchar, OUT outresultmessage varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.loadqpcms(IN inhash varchar, IN inmessage text, IN intablename varchar, IN inbuffersize integer, OUT outresultcode varchar, OUT outresultmessage varchar)
TO findata;
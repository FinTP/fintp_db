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

--Function: findata.getbatchstatus(Input inbatchid varchar, Input inuserid varchar, Input inbatchcount integer, Input inbatchamount varchar, Input inserviceid integer, Input inroutingpoint varchar, Input inbatchuid varchar, Output outbatchstatus integer, Output outcombatchid varchar)

--DROP FUNCTION findata.getbatchstatus(IN inbatchid varchar, IN inuserid integer, IN inbatchcount integer, IN inbatchamount varchar, IN inserviceid integer, IN inroutingpoint varchar, IN inbatchuid varchar, OUT outbatchstatus integer, OUT outcombatchid varchar);

CREATE OR REPLACE FUNCTION findata.getbatchstatus
(
  IN   inbatchid       varchar,
  IN   inuserid        varchar,
  IN   inbatchcount    integer,
  IN   inbatchamount   varchar,
  IN   inserviceid     integer,
  IN   inroutingpoint  varchar,
  IN   inbatchuid      varchar,
  OUT  outbatchstatus  integer,
  OUT  outcombatchid   varchar
)
RETURNS record AS
$$
DECLARE

/************************************************
  Change history:   dd.mon.yyyy  --  author  --   description
                    28.Jan.2014, DenisaN 
  Created:          20.Aug.2013, LucianP
  Description:      Creates a batch job, if none existing with the given values   
  Parameters:       inBatchID   - batch identifier
                    inUserID   - user identifier
                    inBatchCount  - no of messages in batch
                    inBatchAmount  - batch total amount
                    inServiceID   - service identifier
                    inRoutingPoint   - queue name
                    inBatchUID   - 
  Returns:          outBatchStatus,  outComBatchID 
                    parameters representing batch identifier and status
  Used:             FinTP/BASE/RE
***********************************************/        

v_comBatchId  character varying(35);
v_serviceSeq  integer;

BEGIN

  -- this select may fail if the batch was not created
  select into outBatchStatus, outComBatchID  
	 batchstatus, combatchid 
  from findata.batchjobs where batchid = inBatchID and userid = inUserID
                           and batchcount = inBatchCount and batchamount = inBatchAmount
                           and batchuid = inBatchUID ;

  if outBatchStatus is null and outComBatchID is null then 

          --get batchid sequence - service specific
    select findata.getnextservicesequence(inServiceID) into v_serviceSeq; 
    v_comBatchId := inBatchID ||substr(to_char(v_serviceSeq,'0000'),2);

	outBatchStatus := 0; 
  
          --create batching job
	 insert into findata.batchjobs (batchid,   userid,   batchcount, batchamount,  combatchid,  defjobcount,   batchstatus,
                                    insertdate,  combatchamt,  routingpoint, batchtype,  batchuid)
                                 values (inBatchID, inUserID,  inBatchCount,  inBatchAmount, v_comBatchId,  0, outBatchStatus, 
                                         now(),  0,  inRoutingPoint, 'UnknownType',  inBatchUID)
     returning combatchid into outComBatchID;

 end if;


EXCEPTION
WHEN OTHERS THEN
         RAISE EXCEPTION 'Unexpected error occured while retrieving batch status. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getbatchstatus(IN inbatchid varchar, IN inuserid varchar, IN inbatchcount integer, IN inbatchamount varchar, IN inserviceid integer, IN inroutingpoint varchar, IN inbatchuid varchar, OUT outbatchstatus integer, OUT outcombatchid varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getbatchstatus(IN inbatchid varchar, IN inuserid varchar, IN inbatchcount integer, IN inbatchamount varchar, IN inserviceid integer, IN inroutingpoint varchar, IN inbatchuid varchar, OUT outbatchstatus integer, OUT outcombatchid varchar)
TO findata;
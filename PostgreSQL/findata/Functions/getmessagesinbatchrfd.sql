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


--Function: findata.getmessagesinbatchrfd(Output outretcursor refcursor, Input inbatchid varchar, Input inbatchissuer varchar)

--DROP FUNCTION findata.getmessagesinbatchrfd(OUT outretcursor "refcursor", IN inbatchid varchar, IN inbatchissuer varchar);

CREATE OR REPLACE FUNCTION findata.getmessagesinbatchrfd
(
  OUT  outretcursor   "refcursor",
  IN   inbatchid      varchar,
  IN   inbatchissuer  varchar    
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history: dd.mon.yyyy  --  author  --   description                        
  Created:        19.May.2014, DenisaN
  Description:    Returns all messages in given batch that are not refused; 
                  used for msgs accepting refusal. 
  Parameters:     inBatchID      - batch identifier
                  inBatchIssuer  - batch issuer bank
  Returns:        cursor
  Used:           FinTP/BASE/RE
***********************************************/  


BEGIN

--if issuer is specified
if  length( inBatchIssuer ) > 0  then
  
  open outRetCursor for
    select correlid, batchseq, trn, requestor from findata.feedbackagg 
        where batchid = inBatchID and issuer = inBatchIssuer 
         and (correspcode not like 'RFD%' or correspcode is null) ;

--if issuer is not specified
else    

  open outRetCursor for   
    select correlid, batchseq, trn, requestor from findata.feedbackagg
           where batchid = inBatchID and (correspcode not like 'RFD%' or correspcode is null);
           
end if;
  
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering messages in batch: %', SQLERRM;

END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getmessagesinbatchrfd(OUT outretcursor "refcursor", IN inbatchid varchar, IN inbatchissuer varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getmessagesinbatchrfd(OUT outretcursor "refcursor", IN inbatchid varchar, IN inbatchissuer varchar)
TO findata;
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


--Function: findata.batchjob(Input injobid varchar, Input insequence integer, Input incombatchid varchar, Input incorrelid varchar, Input infeedback varchar, Input inxformitem text, Output outbatchstatus integer)

--DROP FUNCTION findata.batchjob(IN injobid varchar, IN insequence integer, IN incombatchid varchar, IN incorrelid varchar, IN infeedback varchar, IN inxformitem text, OUT outbatchstatus integer);

CREATE OR REPLACE FUNCTION findata.batchjob
(
  IN   injobid         varchar,
  IN   insequence      integer,
  IN   incombatchid    varchar,
  IN   incorrelid      varchar,
  IN   infeedback      varchar,
  IN   inxformitem     text,
  OUT  outbatchstatus  integer
)
RETURNS integer AS
$$
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         27.Mar.2013, DenisaN
  Description:     Includes a message in a batch and updates totals
  Parameters:      inJobID  -  routing job identifier          
                   inSequence   -  rule sequence
                   inComBatchID   -  batch identifier
                   inCorrelID  - message correlation identifier        
                   inFeedback   -    feedback code
                   inXformItem  -  transformed (xslt) payload                              
  Returns:         outBatchStatus parameter representing the batch status 
  Used:            FinTP/BASE/RE
***********************************************/

DECLARE

BEGIN

   update findata.batchjobs set batchstatus = case when defjobcount = batchcount - 1 and  batchstatus < 15  then 15
					           when batchstatus = 0 then 10
						   else batchstatus                     
					      end, 
			        defjobcount = defjobcount + 1,  
			        insertdate = now()
   where combatchid = inComBatchID returning batchstatus into outBatchStatus;   

   -- defer job, if batch not completed/failed
   if outBatchStatus = 10 or outBatchStatus = 15 then
      perform findata.deferbatchjob(inJobID,  inCombatchID, inCorrelID,  inFeedback,  inSequence,  inXformItem); 
   end if;

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while creating batch: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.batchjob(IN injobid varchar, IN insequence integer, IN incombatchid varchar, IN incorrelid varchar, IN infeedback varchar, IN inxformitem text, OUT outbatchstatus integer)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.batchjob(IN injobid varchar, IN insequence integer, IN incombatchid varchar, IN incorrelid varchar, IN infeedback varchar, IN inxformitem text, OUT outbatchstatus integer)
TO findata;
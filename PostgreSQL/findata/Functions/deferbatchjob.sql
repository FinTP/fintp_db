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


--Function: findata.deferbatchjob(injobid varchar, inbatchid varchar, incorrelid varchar, infeedback varchar, insequence integer, inxformitem text)

--DROP FUNCTION findata.deferbatchjob(injobid varchar, inbatchid varchar, incorrelid varchar, infeedback varchar, insequence integer, inxformitem text);

CREATE OR REPLACE FUNCTION findata.deferbatchjob
(
  IN  injobid      varchar,
  IN  inbatchid    varchar,
  IN  incorrelid   varchar,
  IN  infeedback   varchar,
  IN  insequence   integer,
  IN  inxformitem  text   
)
RETURNS void AS
$$
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         27.Mar.2013, DenisaN
  Description:     Deffers one given batch job;
  Parameters:      inJobID - routing job identifier
                   inBatchID - batch identifier - computed by RE
                   inCorrelID  -  correlation identifier
                   inFeedback - feedback code
                   inSequence - routing sequence
                   inXformItem - 
  Returns:         n/a
  Used:            FinTP/BASE/RE
***********************************************/

DECLARE


BEGIN

  insert into findata.tempbatchjobs (jobid, sequence, combatchid, correlationId, feedback, xformitem) 
                            values  (inJobID, inSequence, inBatchID, inCorrelID, inFeedback, inXformItem);

EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while deffering job. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.deferbatchjob(injobid varchar, inbatchid varchar, incorrelid varchar, infeedback varchar, insequence integer, inxformitem text)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.deferbatchjob(injobid varchar, inbatchid varchar, incorrelid varchar, infeedback varchar, insequence integer, inxformitem text)
TO findata;
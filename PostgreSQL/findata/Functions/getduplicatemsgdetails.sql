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

--Function: findata.getduplicatemsgdetails(Input inmsgid varchar, Input inlivearch integer, Input inqueuename varchar, Output outretcursor refcursor)

--DROP FUNCTION findata.getduplicatemsgdetails(IN inmsgid varchar, IN inlivearch integer, IN inqueuename varchar, OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION findata.getduplicatemsgdetails
(
  IN   inmsgid       varchar,
  IN   inlivearch    integer,
  IN   inqueuename   varchar,
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         05.Jun.2014, DenisaN - 8442
  Description:     Gets message details and feedback for all duplicates of one given message 
  Parameters:      inMsgID      - message identifier      
                   inLiveArch   - 1- live message/ 0- archived message      
                   inQueueName  - duplicate queue name / if null, message selected from Duplicate Report      
  Returns:         cursor
  Used:            FinTP/2D/UI
***********************************************/     

v_hash         varchar(32);
v_dupQueue     varchar(35);
v_stmt         varchar(3000);
v_senderapp    varchar(35);
v_insertdate   date;
v_startdate    date;
v_enddate      date;
v_period       integer;



BEGIN


  --TODO: enable archive search

if inLiveArch = 1 then

with  
    MH    as ( select   messageid, hash, date_trunc('day', insertdate) insertdate from findata.messagehashes 
                        where messageid = inmsgid and length(hash)>0) ,
    RM    as ( select guid, correlationid, msgtype, senderapp  from findata.routedmessages where guid =  inmsgid)
        select    mh.hash, rm.senderapp, mh.insertdate 
             into v_hash, v_senderapp, v_insertdate
         from  mh  
            join rm on mh.messageid = rm.guid;  
/*          
else   
  with  
    MH    as ( select   messageid, hash, date_trunc('day', insertdate) insertdate  from messagehashes   where messageid= inMsgID
                   union 
                   select   messageid, hash, date_trunc('day', insertdate) insertdate  from finarch.messagehashes   where messageid= inMsgID 
             ) ,
    RM   as ( select guid, correlationid, msgtype, senderapp from finarch.routedmessages where guid =  inMsgID),
 select mh.hash, senderapp, insertdate 
  into v_hash,  v_senderapp, v_insertdate
 from  mh  
 join bm on messageid = rm.guid;
*/
end if;


    --get duplicate detection period for optimizing the search
    select value::integer into v_period from fincfg.params where replace(upper(name),' ','') = 'DUPLICATEDETECTIONPERIOD';
    v_startdate := fincfg.getlastbusinessday(v_insertdate,v_period);
    v_enddate := fincfg.getlastbusinessday(v_insertdate,-1 * v_period);

v_stmt:='with  '||
          ' MHASHES as ( select messageid from messagehashes where hash = $1  and date_trunc(''day'', insertdate) >= $2'||
                                                             ' and date_trunc(''day'', insertdate) <= $3) ,'||
           ' RMLIVE   as ( select guid, trn, msgtype, correlationid, 1 LiveArch from routedmessages ),'||           
           ' FBLIVE   as ( select correlid, payload, '||
                             '   case '||
                             '     when mqid is null and interfacecode is null and networkcode is null and correspcode is null and appcode is null then ''New'' '||
                             '     when interfacecode = ''FTP00'' then ''Received'' '||
                             '     when appcode is not null and appcode!= ''FTP12'' then ''User action: ''||appcode '||
                             '     when mqid is not null and interfacecode != ''FTP00'' then ''Sent: ''||coalesce(appcode, correspcode, networkcode, interfacecode,'' '') '||
                             '     else ''Unknown'' '||
                             '  end feedback  '||
                         ' from feedbackagg ) '||     
        ' select rmlive.guid, rmlive.correlationid, coalesce(rmlive.trn,'' '') trn, rmlive.livearch, fblive.feedback '||
        ' from  mhashes  '||
        ' join rmlive on mhashes.messageid = rmlive.guid  '||
        ' join fblive on rmlive.correlationid = fblive.correlid ';
                      
v_stmt:=' select dup.guid, dup.correlationid, dup.trn, dup.livearch, dup.feedback, '|| 
                 ' case '||
                 ' when dup.guid='''||inmsgid||''' then 2 '||
                 ' else case '||
                 '        when q.guid is null then 0 '||
                 '        else 1 '||
                       ' end '||
                                 ' end dupQueue from ('||v_stmt;
v_stmt:=v_stmt||'  ) dup left join (select correlationid, guid from entryqueue where queuename = $4) q on dup.correlationid = q.correlationid' ;
      
--dupQueue: 2-original message; 1- message in queue; 0- message not in queue    
if inQueueName is not null then 
    --duplicate queue message details        
   open outRetCursor for execute v_stmt using v_hash, v_startdate, v_enddate, inQueueName;
        
else 
   --duplicate report message details       
   select duplicateq into v_dupQueue from fincfg.servicemaps where friendlyname = v_senderapp;
   open outRetCursor for execute v_stmt using v_hash, v_startdate, v_enddate, v_dupQueue;

end if;


EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering messages. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getduplicatemsgdetails(IN inmsgid varchar, IN inlivearch integer, IN inqueuename varchar, OUT outretcursor "refcursor")
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getduplicatemsgdetails(IN inmsgid varchar, IN inlivearch integer, IN inqueuename varchar, OUT outretcursor "refcursor")
TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getduplicatemsgdetails(IN inmsgid varchar, IN inlivearch integer, IN inqueuename varchar, OUT outretcursor "refcursor")
TO finuiuser;
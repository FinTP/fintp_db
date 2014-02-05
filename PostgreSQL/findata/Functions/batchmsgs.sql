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
--Function: findata.batchmsgs(Input inreceiver varchar, Input inmsgtype varchar, Input inrref varchar, Input inccydate varchar, Input inuserid varchar, Input inqueuename varchar, Input inmaxbatchcount integer, Input inqueuetype integer, Input inroutetype varchar, Output outbatches integer, Output outbatchuids varchar)

--DROP FUNCTION findata.batchmsgs(IN inreceiver varchar, IN inmsgtype varchar, IN inrref varchar, IN inccydate varchar, IN inuserid varchar, IN inqueuename varchar, IN inmaxbatchcount integer, IN inqueuetype integer, IN inroutetype varchar, OUT outbatches integer, OUT outbatchuids varchar);

CREATE OR REPLACE FUNCTION findata.batchmsgs
(
  IN   inreceiver       varchar,
  IN   inmsgtype        varchar,
  IN   inrref           varchar,
  IN   inccydate        varchar,
  IN   inuserid         varchar,
  IN   inqueuename      varchar,
  IN   inmaxbatchcount  integer,
  IN   inqueuetype      integer,
  IN   inroutetype      varchar,
  OUT  outbatches       integer,
  OUT  outbatchuids     varchar
)
RETURNS record AS
$$
DECLARE

/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
                   19.Jan.2014, DenisaN - review
  Created:         15.Jan.2014, DenisaN - 8150
  Description:     Assigns routing jobs to create message batches.
  Parameters:         
  Returns:               
  Used:            FinTP/BASE/RE
***********************************************/

 v_priority         integer default 60;
 v_batchuid         varchar(30);
 v_batchuidold      varchar(30) default 'X';
 v_batches          integer default 0;
 v_stmt             varchar(4000);
 v_guid             varchar(30);
 v_func             varchar(1000);
 v_msgs             refcursor;
 
 
BEGIN

outbatchuids:=' ';

if inRouteType = 'Route' then --[Batch]  
                  
         --config for  FIToFICstmrCdtTrf flow                                
          v_stmt := 'select guid, ceil( to_number( tm::char, ''FM99999999999999999D99'')/$1) batchno, '||
                                        '  ''F=Route, F=Unhold, P=GroupOrder(''|| ( row_number() over ( partition by ceil(rn/$2 ) order by rn) ) || '||
                                      ' ''), P=GroupCount('' || ( count( rn ) over ( partition by ceil(rn/$3) ) )  || '||
                                      ' ''), P=BatchID('' || trim( max( guid ) over ( partition by ceil(rn/$4) ) ) || '||
                                      ' ''), P=BatchSum('' || to_char(sum(  to_number(CASE 
    WHEN (
      rtrim((amount)::text) IS NULL
    ) THEN ''0,00''::text 
    WHEN (
      rtrim((amount)::text) = ''''::text
    ) THEN ''0,00''::text 
    WHEN (
      rtrim((amount)::text) = '',''::text
    ) THEN ''0,00''::text 
    ELSE replace(rtrim((amount)::text), '',''::text, ''.''::text) 
  END, ''FM99999999999999999D99''::text))  over ( partition by ceil(rn/1000) ), ''FM999999999999999990D99'')  || '||
                                      ' ''), P=BatchRef('' || substr( $6, 1, 4 ) || to_char(current_date, ''yyyymmd'') || '')'' func, '||
                                         ' trim( max (guid) over ( partition by ceil(rn/$7) ) ) batchuid  '||                   
                           '  from '||
                             ' ( select guid, amount, row_number() over () rn, count(receiver) over (partition by receiver) tm  '||
                                '  from mtfitoficstmrcdttrfview ' ||
                                ' where queuename = $8 and receiver = $9 and valuedate = $10) t ';     -- grouping keywords                   
                                                     
             
   open v_msgs for execute v_stmt using inMaxBatchCount, inMaxBatchCount, inMaxBatchCount, inMaxBatchCount,  inMaxBatchCount, inReceiver,
                                        inMaxBatchCount, inQueueName,  inReceiver, inCcyDate;     
             
       loop          
           fetch v_msgs into v_guid, v_batches, v_func, v_batchuid;
           exit when not found;
                  
           insert into routingjobs ( guid, status, priority, backout, routingpoint, function, userid )  
                            values ( v_guid, 0, v_priority, 0, inQueueName, v_func, inUserid );
                        
            if (v_batchuidold != v_batchuid and v_batchuid is not null) then
                       outbatchUIDs := outbatchUIDs || '''' || v_batchuid || ''',';
                   v_batchuidold := v_batchuid;
            end if;         
            
            outbatches := v_batches;    
            
       end loop;
       
    close v_msgs;
       
end if;
   
   
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while creating batch. Message is: %', SQLERRM;
       
END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.batchmsgs(IN inreceiver varchar, IN inmsgtype varchar, IN inrref varchar, IN inccydate varchar, IN inuserid varchar, IN inqueuename varchar, IN inmaxbatchcount integer, IN inqueuetype integer, IN inroutetype varchar, OUT outbatches integer, OUT outbatchuids varchar)
  OWNER TO findata;


GRANT EXECUTE
  ON FUNCTION findata.batchmsgs(IN inreceiver varchar, IN inmsgtype varchar, IN inrref varchar, IN inccydate varchar, IN inuserid varchar, IN inqueuename varchar, IN inmaxbatchcount integer, IN inqueuetype integer, IN inroutetype varchar, OUT outbatches integer, OUT outbatchuids varchar)
TO findata;
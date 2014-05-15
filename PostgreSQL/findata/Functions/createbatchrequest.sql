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

--Function: findata.createbatchrequest(inqueuename varchar, inmsgtype varchar, ingroupkey varchar, intimekey varchar, infield1val varchar, infield2val varchar, infield3val varchar, infield4val varchar, infield5val varchar, inusername varchar)

--DROP FUNCTION findata.createbatchrequest(inqueuename varchar, inmsgtype varchar, ingroupkey varchar, intimekey varchar, infield1val varchar, infield2val varchar, infield3val varchar, infield4val varchar, infield5val varchar, inusername varchar);

CREATE OR REPLACE FUNCTION findata.createbatchrequest
(
  IN  inqueuename  varchar,
  IN  inmsgtype    varchar,
  IN  ingroupkey   varchar,
  IN  intimekey    varchar,
  IN  infield1val  varchar,
  IN  infield2val  varchar,
  IN  infield3val  varchar,
  IN  infield4val  varchar,
  IN  infield5val  varchar,
  IN  inusername   varchar
)
RETURNS void AS
$$
DECLARE


/************************************************
  Change history: dd.mon.yyyy  --  author  --   description                        
  Created:        02.Apr.2014, DenisaN 7488
  Description:   Initiates the batching mechanism; gathers messages in given group and assignes routing jobs.  
  Parameters:    inqueuename   - queue name
                 inmsgtype     - message type [for messages in group]
                 ingroupkey    - message group key [unique hash]
                 intimekey     - message group time reference
                 infield1val   - kword1 group value 
                 infield2val   - kword2 group value
                 infield3val   - kword3 group value
                 infield4val   - kword4 group value
                 infield5val   - kword5 group value
                 inusername    - user name 
  Returns:       cursor
  Used:          FinTP/BASE/UI
***********************************************/             

v_groupkey        varchar(100);
v_filterfields    varchar(1000);
v_qreportingview  varchar(35);
v_maxbatchcnt     integer;
v_priority        integer;
v_batchuid        varchar(30);
v_batchuidold     varchar(30) default 'X';
v_guid            varchar(30);
v_func            varchar(1000);
v_msgs            refcursor;
v_userid          integer;

    
BEGIN

  --get specific storage
  select reportingstorage into v_qreportingview from fincfg.msgtypes where messagetype = inmsgtype;


  --get specific filter fields
  select case when kword1 is not null then ' and '||kword1||' = '''||infield1val||'''' else ' ' end ||
         case when kword2 is not null then ' and '||kword2||' = '''||infield2val||'''' else ' ' end ||
         case when kword3 is not null then ' and '||kword3||' = '''||infield3val||'''' else ' ' end ||
         case when kword4 is not null then ' and '||kword4||' = '''||infield4val||'''' else ' ' end ||
         case when kword5 is not null then ' and '||kword5||' = '''||infield5val||'''' else ' ' end         
  into v_filterfields
  from fincfg.queuemsggroups where msgtype = inmsgtype;

  --recompute group key
  execute 
 ' select md5(string_agg(guid,'''' order by guid)) '||
 ' from findata.'||v_qreportingview||' where queuename = $1 '||
         ' and insertdate <= $2'||v_filterfields
  into v_groupkey
  using inqueuename, to_timestamp(intimekey, 'ddmmyyyyhh24:mi:ss');
   
if v_groupkey = ingroupkey then
     
     --user identifier
     select userid into v_userid from fincfg.users where lower(username) = lower(inusername);
     
     --max msgs per batch
     select batchno, priority into v_maxbatchcnt, v_priority from fincfg.queues where name = inqueuename;
     
  --insert Batch routing jobs
  open v_msgs for execute
     ' select guid, '||      
       ' ''F=Route, F=Unhold,''|| '||
       ' ''P=GroupOrder(''|| ( row_number() over ( partition by ceil(rn/$1 ) order by rn) ) ||''), ''|| '||
       ' ''P=GroupCount('' || ( count( rn ) over ( partition by ceil(rn/$1) ) )  || ''), ''|| '||
       ' ''P=BatchID('' || trim( max( guid ) over ( partition by ceil(rn/$1) ) ) || ''), ''|| '||
       ' ''P=BatchSum('' || to_char(sum(  to_number(CASE 
                       WHEN (rtrim((amount)::text) IS NULL) THEN ''0,00''::text 
                       WHEN (rtrim((amount)::text) = ''''::text) THEN ''0,00''::text 
                       WHEN (rtrim((amount)::text) = '',''::text) THEN ''0,00''::text 
                       ELSE replace(rtrim((amount)::text), '',''::text, ''.''::text) END, ''FM99999999999999999D99''::text))  
                      over ( partition by ceil(rn/$1) ), ''FM999999999999999990D99'')||''), ''|| '||
       ' ''P=BatchRef('' || substr( receiver, 1, 4 ) || to_char(current_date, ''yyyymmdd'') || '')'' func, '||
       ' trim( max (guid) over ( partition by ceil(rn/$1) ) ) batchuid '||                 
    ' from '||
      '( select guid, receiver, amount, row_number() over () rn, count(receiver) over (partition by receiver) tm '||
       ' from findata.'||v_qreportingview|| ' where queuename = $2 and insertdate <= $3 '||v_filterfields||
     ' ) tmp '  
  using  v_maxbatchcnt, inQueueName, to_timestamp(intimekey, 'ddmmyyyyhh24:mi:ss');       
  loop          
     fetch v_msgs into v_guid, v_func, v_batchuid;
     exit when not found;
                  
     insert into findata.routingjobs(guid, status, priority, backout, routingpoint, function, userid)  
                              values(v_guid, 0, v_priority, 0, inQueueName, v_func, v_userid);
             
     --register batch request / batchuid - group key correlation                   
     if (v_batchuidold != v_batchuid and v_batchuid is not null) then
         
         insert into findata.batchrequests(groupkey, batchuid, userid) 
                                    values(v_groupkey, v_batchuid, v_userid);     
         v_batchuidold := v_batchuid;
     end if;                      
  end loop;
       
  close v_msgs;   
    
else 
    raise exception 'data_changed';
  
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

ALTER FUNCTION findata.createbatchrequest(inqueuename varchar, inmsgtype varchar, ingroupkey varchar, intimekey varchar, infield1val varchar, infield2val varchar, infield3val varchar, infield4val varchar, infield5val varchar, inusername varchar)
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.createbatchrequest(inqueuename varchar, inmsgtype varchar, ingroupkey varchar, intimekey varchar, infield1val varchar, infield2val varchar, infield3val varchar, infield4val varchar, infield5val varchar, inusername varchar)
TO findata;

GRANT EXECUTE
  ON FUNCTION findata.createbatchrequest(inqueuename varchar, inmsgtype varchar, ingroupkey varchar, intimekey varchar, infield1val varchar, infield2val varchar, infield3val varchar, infield4val varchar, infield5val varchar, inusername varchar)
TO finuiuser;
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
--Function: findata.getgroupsformtqueue(Input inqueuename varchar, Input inmsgtype varchar, Input inamount numeric, Input inreference varchar, Output outretcursor refcursor)

--DROP FUNCTION findata.getgroupsformtqueue(IN inqueuename varchar, IN inmsgtype varchar, IN inamount numeric, IN inreference varchar, OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION findata.getgroupsformtqueue
(
  IN   inqueuename   varchar,
  IN   inmsgtype     varchar,
  IN   inamount      numeric,
  IN   inreference   varchar,
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history: dd.mon.yyyy  --  author  --   description
                  22.Aug.2014, DenisaN 8539                        
  Created:        27.Mar.2014, DenisaN 7488
  Description:    Returns the group header / grouping criteria for the given message type;
                  may filter trx in groups
  Parameters:     inqueuename - queue name
                  inmsgtype - message type
                  inamount  - filter: trx amount
                  inreference - filter: reference
  Returns:        cursor
  Used:           FinTP/BASE/UI
***********************************************/             

v_groupfields          varchar(1000);
v_groupaliasfields     varchar(1000);
v_qreportingview       varchar(35);
v_timekey              varchar(17);

  
  
BEGIN

  --timekey
  select to_char(now(), 'ddmmyyyyhh24:mi:ss') into v_timekey;

  --get specific storage
  select reportingstorage into v_qreportingview from fincfg.msgtypes where messagetype = inmsgtype;

  --get specific group fields
  select case when kword1 is not null then lower(kword1) else ' ' end ||
         case when kword2 is not null then ', '||lower(kword2) else ' ' end ||
         case when kword3 is not null then ', '||lower(kword3) else ' ' end ||
         case when kword4 is not null then ', '||lower(kword4) else ' ' end ||
         case when kword5 is not null then ', '||lower(kword5) else ' ' end, 
         case when kword1 is not null then kword1 else ' ' end ||
         case when kword2 is not null then ', '||kword2 else ' ' end ||
         case when kword3 is not null then ', '||kword3 else ' ' end ||
         case when kword4 is not null then ', '||kword4 else ' ' end ||
         case when kword5 is not null then ', '||kword5 else ' ' end
  into v_groupaliasfields, v_groupfields
  from fincfg.queuemsggroups where msgtype = inmsgtype;


  --get tx groups (if defined) along with assigned keys
  if v_groupfields is null then
     open outretcursor for execute 
        'select ''X'' where 1 = 2';
  else     
     open outretcursor for execute 
        ' select '||v_groupaliasfields||', sum(amount) totamt, count(*) cnt, '||
              ''''||v_timekey||''' timekey, md5(string_agg(guid,'''' order by guid)) groupkey '||
        ' from findata.'||v_qreportingview||' where queuename = $1 '||
        ' and ($2 is null or (upper(trn) like (''%''||$3||''%'') or amount = $4))'||
        ' group by '||v_groupfields||
        ' order by '||v_groupfields
     using inqueuename, inreference, inreference, inamount;
  end if;
  
  
EXCEPTION
WHEN OTHERS THEN
   RAISE EXCEPTION 'Unexpected error occured while gathering messages: %', SQLERRM;

END;
$$
LANGUAGE 'plpgsql'
VOLATILE
CALLED ON NULL INPUT
SECURITY INVOKER
COST 100;

ALTER FUNCTION findata.getgroupsformtqueue(IN inqueuename varchar, IN inmsgtype varchar, IN inamount numeric, IN inreference varchar, OUT outretcursor "refcursor")
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getgroupsformtqueue(IN inqueuename varchar, IN inmsgtype varchar, IN inamount numeric, IN inreference varchar, OUT outretcursor "refcursor")
TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getgroupsformtqueue(IN inqueuename varchar, IN inmsgtype varchar, IN inamount numeric, IN inreference varchar, OUT outretcursor "refcursor")
TO finuiuser; 

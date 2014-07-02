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


--Function: findata.getgroupsheaderformtqueue(Input inmsgtype varchar, Input inheadertype varchar, Output outretcursor refcursor)

--DROP FUNCTION findata.getgroupsheaderformtqueue(IN inmsgtype varchar, IN inheadertype varchar, OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION findata.getgroupsheaderformtqueue
(
  IN   inmsgtype     varchar,
  IN   inheadertype  varchar,
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE

/************************************************
  Change history: dd.mon.yyyy  --  author  --   description                        
  Created:        27.Mar.2014, DenisaN 7488
  Description:    Returns the group header / grouping criteria for the given message type
  Parameters:     inmsgtype - message type
                  inheadertype - T - transaction level
                                 G - transaction group level
  Returns:        cursor
  Used:           FinTP/BASE/UI
***********************************************/             

  
BEGIN

if inheadertype = 'G' then 

open outretcursor for 
    select kwn.description kfname, lower(fields.kword) kname, rnum from
     (select kword, row_number() over() rnum from
             ( select unnest(string_to_array(xx,',')) kword from
               (select coalesce(kword1,' ')||','||coalesce(kword2,' ')||','||
                       coalesce(kword3,' ')||','||coalesce(kword4,' ')||','||
                       coalesce(kword5, ' ') xx
                from  fincfg.queuemsggroups where msgtype = inmsgtype
               )kwarr
             )kws
      ) fields                  
   join fincfg.routingkeywords kwn
   on fields.kword = kwn.keyword
    union
   select 'Total Amount' kfname, 'totamt' kname, 6 rnum
    union
   select 'No. of transactions' kfname, 'cnt' kname, 7 rnum 
  order by rnum;


elsif inheadertype = 'T' and inmsgtype = 'undefined' then

     open outretcursor for 
        select 	'Batch ID', 'batchid', 1 rn union select 'Requestor Service', 'requestorservice', 2 rn 
          union select 'Internal ID', 'correlationid', 3 rn
        order by rn asc;


elsif inheadertype = 'T' and inmsgtype = 'FIToFICstmrCdtTrf' then

     open outretcursor for 
         select 'Reference', 'trn', 3 rn
         union select 'Value Date', 'valuedate', 4 rn union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6rn
        order by rn asc;
   
elsif inheadertype = 'T' and inmsgtype in ('103', '202', 'CoreBlkLrgRmtCdtTrf') then

      open outretcursor for 
       select 'Reference', 'trn', 3 rn
         union select 'Value Date', 'valuedate', 4 rn union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6rn
         union select 'Service', 'service', 7 rn
        order by rn asc;
        
elsif inheadertype = 'T' and inmsgtype in ('BE', 'PN') then

     open outretcursor for 
        select 'Reference', 'trn', 3 rn
         union select 'Maturity Date', 'matdate', 4 rn union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6rn
        order by rn asc;      
        
elsif inheadertype = 'T' and inmsgtype in ('CQ') then

     open outretcursor for 
         select 'Reference', 'trn', 3 rn
         union select 'Issuance Date', 'issdate', 4 rn union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6rn
        order by rn asc;          
        
elsif inheadertype = 'T' and inmsgtype in ('RBE', 'RPN', 'RCQ') then

     open outretcursor for 
         select 'Reference', 'trn', 3 rn
         union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6rn
        order by rn asc; 

elsif inheadertype = 'T' and inmsgtype in ('104') then

      open outretcursor for 
        select 'Reference', 'trn', 3 rn
         union select 'Value Date', 'valuedate', 4 rn union select 'Amount', 'amount', 5 rn union select 'Currency', 'currency', 6 rn
        order by rn asc;

elsif inheadertype = 'T' and inmsgtype in ('104R') then

      open outretcursor for 
       select 'Reference', 'trn', 3 rn
         union select 'Original Batch ID', 'origbatchid', 4 rn
        order by rn asc;       

elsif inheadertype = 'T' and inmsgtype in ('950E', '940E') then

      open outretcursor for 
       select 'Time', 'insertdate', 1 rn       
         union select 'Transaction reference', 'trn', 2 rn
         union select 'Value date', 'valuedate', 3 rn
         union select 'Amount', 'amount', 4 rn
         union select 'Currency', 'currency', 5 rn 
       order by rn asc;           
                         
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

ALTER FUNCTION findata.getgroupsheaderformtqueue(IN inmsgtype varchar, IN inheadertype varchar, OUT outretcursor "refcursor")
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getgroupsheaderformtqueue(IN inmsgtype varchar, IN inheadertype varchar, OUT outretcursor "refcursor")
TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getgroupsheaderformtqueue(IN inmsgtype varchar, IN inheadertype varchar, OUT outretcursor "refcursor")
TO finuiuser;
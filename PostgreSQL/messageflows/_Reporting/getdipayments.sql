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


--Function: findata.getdipayments(Input insdatemin varchar, Input insdatemax varchar, Input inmsgtype varchar, Input insender varchar, Input inreceiver varchar, Input inref varchar, Input inissdate varchar, Input inmatdate varchar, Input inamtmin numeric, Input inamtmax numeric, Input inccy varchar, Input indacc varchar, Input indcname varchar, Input indbtid varchar, Input incacc varchar, Input inccname varchar, Input indirect varchar, Input instate varchar, Input inbatchid varchar, Input inuserid integer, Input inordfield varchar, Input inorddir varchar, Input inllimit integer, Input inulimit integer, Output outretcursor refcursor)

--DROP FUNCTION findata.getdipayments(IN insdatemin varchar, IN insdatemax varchar, IN inmsgtype varchar, IN insender varchar, IN inreceiver varchar, IN inref varchar, IN inissdate varchar, IN inmatdate varchar, IN inamtmin numeric, IN inamtmax numeric, IN inccy varchar, IN indacc varchar, IN indcname varchar, IN indbtid varchar, IN incacc varchar, IN inccname varchar, IN indirect varchar, IN instate varchar, IN inbatchid varchar, IN inuserid integer, IN inordfield varchar, IN inorddir varchar, IN inllimit integer, IN inulimit integer, OUT outretcursor "refcursor");

CREATE OR REPLACE FUNCTION findata.getdipayments
(
  IN   insdatemin    varchar,
  IN   insdatemax    varchar,
  IN   inmsgtype     varchar,
  IN   insender      varchar,
  IN   inreceiver    varchar,
  IN   inref         varchar,
  IN   inissdate     varchar,
  IN   inmatdate     varchar,
  IN   inamtmin      numeric,
  IN   inamtmax      numeric,
  IN   inccy         varchar,
  IN   indacc        varchar,
  IN   indcname      varchar,
  IN   indbtid       varchar,
  IN   incacc        varchar,
  IN   inccname      varchar,
  IN   indirect      varchar,
  IN   instate       varchar,
  IN   inbatchid     varchar,
  IN   inuserid      integer,
  IN   inordfield    varchar,
  IN   inorddir      varchar,
  IN   inllimit      integer,
  IN   inulimit      integer,
  OUT  outretcursor  "refcursor"
)
RETURNS "refcursor" AS
$$
DECLARE
                                                                                                                                       
/************************************************
  Change history:  dd.mon.yyyy  --  author  --   description
  Created:         25.Mar.2014, DenisaN 8307
  Description:    Gathers data for the Debit Instruments reporting according to the given filtering     
  Parameters:     insdatemin - low date interval value
                  insdatemax - high date interval value
                  inmsgtype  - message type
                  insender   - sender BIC
                  inreceiver - receiver BIC
                  inref      - tx reference
                  inissdate  - issuance date
                  inmatdate  - maturity date
                  inamtmin   - low amount interval value
                  inamtmax   - high amount interval value
                  inccy      - currency
                  indacc     - dbt account
                  indcname   - dbt cust name
                  incacc     - cdt account
                  inccname   - cdt cust name
                  indirect   - I/O direction
                  instate    - tx state
                  inbatchid  - batchid
                  inuserid   - user identifier
                  inordfield - order by field
                  inorddir   - order by direction 
                  inllimit   - low limit / msg per page
                  inulimit   - upper limit / msg per page                          
  Returns:        cursor
  Used:           FinTP/BASE/UI Direct Debit
***********************************************/

BEGIN

open outretcursor for execute
 'select * from ('||
 ' select tmp.*, max(tmp.rnum) over() rnummax'||
 ' from ( '||
 ' select  row_number() over (order by '||coalesce(inordfield, 'insertdate ')||' '||coalesce(inorddir, ' desc')||' ) rnum, '||   
         ' insertdate, msgtype, sender, receiver, trn, issdate, matdate, amount, currency,	'||
         ' dbtaccount, dbtcustname, dbtid, cdtaccount, cdtcustname, '||
         ' direction, case when errcode is null then state '||
                         ' else state||'' [''||errcode||'']'' '||
                    ' end state, batchid, userid, correlid ' ||
  ' from findata.repstatdi '||
  ' where insertdate >= to_timestamp($1,''dd mm yyyy hh24:mi:ss'') and insertdate <= to_timestamp($2,''dd mm yyyy hh24:mi:ss'') '||
       ' and  ( $3 is null or  msgtype = $4 )'||
       ' and  ( $5 is null or lower(sender) = lower($6) ) '||       
       ' and  ( $7 is null or lower(receiver) = lower($8) ) '||       
       ' and  ( $9 is null or lower(trn) like lower(''%''||$10||''%'')) '||
       ' and  ( $11 is null or issdate = $12) ' ||
       ' and  ( $13 is null or matdate = $14) ' ||
       ' and ( (amount >= coalesce($15,0) and amount <= coalesce($16,99999999999999999999) ) )'||
       ' and ( $17 is null or currency = $18 ) ' ||
       ' and ( $19 is null or lower(dbtaccount) like lower(''%''||$20||''%'')) ' ||
       ' and ( $21 is null or lower(dbtcustname) like lower(''%''||$22||''%'') ) ' ||
       ' and ( $23 is null or lower(dbtid) like lower(''%''||$24||''%'') ) ' ||
       ' and ( $25 is null or lower(cdtaccount) like lower(''%''||$26||''%'')) ' ||
       ' and ( $27 is null or lower(cdtcustname) like lower(''%''||$28||''%'')) ' ||
       ' and ( $29 is null or direction = $30) ' ||
       ' and ( $31 is null or state = $32) ' ||
       ' and ( $33 is null or lower(batchid) like lower(''%''||$34||''%'')) ' ||
       ' and ( $35 is null or userid = $36 ) ' ||
  ' order by '||coalesce(inordfield, 'insertdate')||' '||coalesce(inorddir, 'desc')||') tmp ) tmp1'||
  ' where rnum > coalesce($37,0) and rnum <= coalesce($38,100)+ coalesce($39,0)'
using insdatemin, insdatemax, inmsgtype, inmsgtype, insender, insender, inreceiver, inreceiver, inref, inref,  inissdate, inissdate, 
      inmatdate, inmatdate, inamtmin, inamtmax, inccy, inccy, indacc, indacc, indcname, indcname, indbtid, indbtid, incacc, incacc, inccname, inccname, 
      indirect, indirect, instate, instate, inbatchid, inbatchid,  inuserid, inuserid,  inllimit, inulimit, inllimit;


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

ALTER FUNCTION findata.getdipayments(IN insdatemin varchar, IN insdatemax varchar, IN inmsgtype varchar, IN insender varchar, IN inreceiver varchar, IN inref varchar, IN inissdate varchar, IN inmatdate varchar, IN inamtmin numeric, IN inamtmax numeric, IN inccy varchar, IN indacc varchar, IN indcname varchar, IN indbtid varchar, IN incacc varchar, IN inccname varchar, IN indirect varchar, IN instate varchar, IN inbatchid varchar, IN inuserid integer, IN inordfield varchar, IN inorddir varchar, IN inllimit integer, IN inulimit integer, OUT outretcursor "refcursor")
  OWNER TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getdipayments(IN insdatemin varchar, IN insdatemax varchar, IN inmsgtype varchar, IN insender varchar, IN inreceiver varchar, IN inref varchar, IN inissdate varchar, IN inmatdate varchar, IN inamtmin numeric, IN inamtmax numeric, IN inccy varchar, IN indacc varchar, IN indcname varchar, IN indbtid varchar, IN incacc varchar, IN inccname varchar, IN indirect varchar, IN instate varchar, IN inbatchid varchar, IN inuserid integer, IN inordfield varchar, IN inorddir varchar, IN inllimit integer, IN inulimit integer, OUT outretcursor "refcursor")
TO findata;

GRANT EXECUTE
  ON FUNCTION findata.getdipayments(IN insdatemin varchar, IN insdatemax varchar, IN inmsgtype varchar, IN insender varchar, IN inreceiver varchar, IN inref varchar, IN inissdate varchar, IN inmatdate varchar, IN inamtmin numeric, IN inamtmax numeric, IN inccy varchar, IN indacc varchar, IN indcname varchar, IN indbtid varchar, IN incacc varchar, IN inccname varchar, IN indirect varchar, IN instate varchar, IN inbatchid varchar, IN inuserid integer, IN inordfield varchar, IN inorddir varchar, IN inllimit integer, IN inulimit integer, OUT outretcursor "refcursor")
TO finuiuser;
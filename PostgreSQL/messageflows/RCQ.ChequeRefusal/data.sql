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


INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (13, 'RCQ', 'ChequeRefusal', 13, 'MTRCQTAB', 'Debit Instruments/ refusals', 'MTRCQview');
COMMIT;



INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32A/@tagValue', 'RCQ', 'selector', 95);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32A/@tagValue', 'RCQ', 'selector', 96);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag20/@tagValue', 'RCQ', 'selector', 97);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (127, '//smt:MessageText/smt:tag70/@tagValue', 'RCQ', 'selector', 98);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (124, '//sg:UserHeader/sg:tag108/@tagValue', 'RCQ', 'selector', 99);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (125, '//smt:MessageText/smt:tag21/@tagValue', 'RCQ', 'selector', 100);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', 'RCQ', 'selector', 103);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', 'RCQ', 'selector', 102);
COMMIT;


INSERT INTO fincfg.queuemsggroups (msgtype, kword1, kword2, kword3, kword4, kword5) VALUES ('RCQ', 'Receiver', 'OrigBatchID', NULL, NULL, NULL);
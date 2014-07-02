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



INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (9, 'BE', 'BillOfExchange', 9, 'MTBETAB', 'Debit Instruments', 'MTBEview');
COMMIT;



INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (132, '//smt:MessageText/smt:tag32A/@tagValue', 'BE', 'selector', 54);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (110, '//smt:MessageText/smt:tag50K/@tagValue', 'BE', 'selector', 55);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (129, '//smt:MessageText/smt:tag59/@tagValue', 'BE', 'selector', 56);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (109, '//smt:MessageText/smt:tag59/@tagValue', 'BE', 'selector', 57);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (128, '//smt:MessageText/smt:tagM02D/@tagValue', 'BE', 'selector', 58);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32A/@tagValue', 'BE', 'selector', 59);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32A/@tagValue', 'BE', 'selector', 60);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag21/@tagValue', 'BE', 'selector', 61);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', 'BE', 'selector', 62);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', 'BE', 'selector', 63);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (105, '//smt:MessageText/smt:tag59/@tagValue', 'BE', 'selector', 64);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (106, '//smt:MessageText/smt:tag50K/@tagValue', 'BE', 'selector', 101);
COMMIT;

INSERT INTO fincfg.queuemsggroups (msgtype, kword1, kword2, kword3, kword4, kword5) VALUES ('BE', 'Receiver', 'MatDate', NULL, NULL, NULL);
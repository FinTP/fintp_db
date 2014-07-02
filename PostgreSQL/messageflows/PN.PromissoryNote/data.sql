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



INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (8, 'PN', 'PromissoryNote', 8, 'MTPNTAB', 'Debit Instruments', 'MTPNview');
COMMIT;



INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (132, '//smt:MessageText/smt:tag32A/@tagValue', 'PN', 'selector', 76);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (110, '//smt:MessageText/smt:tag50K/@tagValue', 'PN', 'selector', 77);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (106, '//smt:MessageText/smt:tag50K/@tagValue', 'PN', 'selector', 78);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (129, '//smt:MessageText/smt:tag59/@tagValue', 'PN', 'selector', 79);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (109, '//smt:MessageText/smt:tag59/@tagValue', 'PN', 'selector', 80);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (129, '//smt:MessageText/smt:tagM02D/@tagValue', 'PN', 'selector', 81);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32A/@tagValue', 'PN', 'selector', 82);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32A/@tagValue', 'PN', 'selector', 83);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag21/@tagValue', 'PN', 'selector', 84);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', 'PN', 'selector', 85);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', 'PN', 'selector', 86);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (105, '//smt:MessageText/smt:tag59/@tagValue', 'PN', 'selector', 87);
COMMIT;

INSERT INTO fincfg.queuemsggroups (msgtype, kword1, kword2, kword3, kword4, kword5) VALUES ('PN', 'Receiver', 'MatDate', NULL, NULL, NULL);
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



INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (23, 'CoreBlkLrgRmtCdtTrf', 'Customer Credit Transfer', NULL, 'MTCoreBlkLrgRmtCdtTrfTAB', 'Funds Transfer', 'MTCoreBlkLrgRmtCdtTrfView');
COMMIT;




INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag20/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 154);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', 'CoreBlkLrgRmtCdtTrf', 'selector', 155);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', 'CoreBlkLrgRmtCdtTrf', 'selector', 168);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (102, '//smt:MessageText/smt:tag32A/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 156);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32A/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 157);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32A/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 158);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (105, '//smt:MessageText/smt:tag50K/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 159);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (109, '//smt:MessageText/smt:tag50K/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 160);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (107, '//smt:MessageText/smt:tag52A/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 161);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (108, '//smt:MessageText/smt:tag57A/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 162);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (106, '//smt:MessageText/smt:tag59/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 163);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (110, '//smt:MessageText/smt:tag59/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 164);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (111, '//sg:UserHeader/sg:tag103/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 165);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (117, '//sg:UserHeader/sg:tag108/@tagValue', 'CoreBlkLrgRmtCdtTrf', 'selector', 166);
COMMIT;

INSERT INTO fincfg.queuemsggroups (msgtype, kword1, kword2, kword3, kword4, kword5) VALUES ('CoreBlkLrgRmtCdtTrf', 'Receiver', NULL, NULL, NULL, NULL);
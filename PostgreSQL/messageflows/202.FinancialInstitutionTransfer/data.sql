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



INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (2, '202', 'Financial Institution Transfer', NULL, 'MT202TAB', 'Funds Transfer', 'MT202TAB');
COMMIT;


INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', '202', 'selector', 29);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113,'//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', '202', 'selector', 30);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag20/@tagValue', '202', 'selector', 31);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (102, '//smt:MessageText/smt:tag32A/@tagValue', '202', 'selector', 32);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32A/@tagValue', '202', 'selector', 33);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32A/@tagValue', '202', 'selector', 34);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (107, '//smt:MessageText/smt:tag52A/@tagValue', '202', 'selector', 35);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (108, '//smt:MessageText/smt:tag58A/@tagValue', '202', 'selector', 36);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (111, '//sg:UserHeader/sg:tag103/@tagValue', '202', 'selector', 37);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (117, '//sg:UserHeader/sg:tag108/@tagValue', '202', 'selector', 38);
COMMIT;


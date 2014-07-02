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



INSERT INTO msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (21, '104', 'DirectDebit', NULL, 'MT104TAB', 'Direct Debit', 'MT104view');
COMMIT;


INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', '104', 'selector', 115);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (133, '//smt:MessageText/smt:tag50K/@tagValue', '104', 'selector', 125);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (110, '//smt:MessageText/smt:tag50K/@tagValue', '104', 'selector', 124);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (106, '//smt:MessageText/smt:tag50K/@tagValue', '104', 'selector', 123);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (109, '//smt:MessageText/smt:tag59/@tagValue', '104', 'selector', 122);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (105, '//smt:MessageText/smt:tag59/@tagValue', '104', 'selector', 121);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', '104', 'selector', 116);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag20/@tagValue', '104', 'selector', 117);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (102, '//smt:MessageText/smt:tag30/@tagValue', '104', 'selector', 118);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//smt:MessageText/smt:tag32B/@tagValue', '104', 'selector', 119);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//smt:MessageText/smt:tag32B/@tagValue', '104', 'selector', 120);



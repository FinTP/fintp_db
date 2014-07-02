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



INSERT INTO msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (22, '104R', 'DirectDebitRefusal', NULL, 'MT104RTAB', 'Direct Debit', 'MT104Rview');
COMMIT;


INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (125, '//smt:MessageText/smt:tag21/@tagValue', '104R', 'selector', 130);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (127, '//smt:MessageText/smt:tag70/@tagValue', '104R', 'selector', 129);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//sg:BasicHeader/@SenderLT', '104R', 'selector', 128);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//sg:ApplicationHeaderInput/@ReceiverLT|//sg:ApplicationHeaderOutput/@ReceiverLT', '104R', 'selector', 127);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//smt:MessageText/smt:tag20/@tagValue', '104R', 'selector', 126);
INSERT INTO routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (124, '//sg:UserHeader/sg:tag108/@tagValue', '104R', 'selector', 131);
COMMIT;



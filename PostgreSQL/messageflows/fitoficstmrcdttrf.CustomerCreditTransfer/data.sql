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



INSERT INTO fincfg.msgtypes (mtid, messagetype, friendlyname, displayorder, "storage", businessarea, reportingstorage) VALUES (5, 'FIToFICstmrCdtTrf', 'CustomerCreditTransfer', 5, 'MTFIToFICstmrCdtTrfTAB', 'Treasury Markets', 'MTFIToFICstmrCdtTrfTAB');
COMMIT;


INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (112, '//x:GrpHdr/x:InstgAgt/x:FinInstnId/x:BIC/text()|//x:CdtTrfTxInf/x:DbtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 16);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (113, '//x:GrpHdr/x:InstdAgt/x:FinInstnId/x:BIC/text()|//x:CdtTrfTxInf/x:CdtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 17);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//x:CdtTrfTxInf/x:PmtId/x:TxId/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 18);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (106, '//x:CdtTrfTxInf/x:CdtrAcct/x:Id/x:IBAN/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 25);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (127, '//x:TxInfAndSts/x:RtrRsnInf/x:Rsn/x:Cd/text()', 'FIToFIPmtStsRpt', 'selectoriso', 147);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (134, '//x:TxInfAndSts/x:OrgnlInstrId/text()', 'FIToFIPmtStsRpt', 'selectoriso', 148);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (101, '//x:TxInfAndSts/x:StsId/text()', 'FIToFIPmtStsRpt', 'selectoriso', 149);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (124, '//x:TxInfAndSts/x:OrgnlTxId/text()', 'FIToFIPmtStsRpt', 'selectoriso', 150);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (125, '//x:OrgnlGrpInfAndSts/x:OrgnlMsgId/text()', 'FIToFIPmtStsRpt', 'selectoriso', 151);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (102, '//x:GrpHdr/x:IntrBkSttlmDt/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 19);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (103, '//x:CdtTrfTxInf/x:IntrBkSttlmAmt/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 20);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (104, '//x:CdtTrfTxInf/x:IntrBkSttlmAmt/@Ccy', 'FIToFICstmrCdtTrf', 'selectoriso', 21);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (105, '//x:CdtTrfTxInf/x:DbtrAcct/x:Id/x:IBAN/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 22);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (107, '//x:CdtTrfTxInf/x:DbtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 23);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (108, '//x:CdtTrfTxInf/x:CdtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 24);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (109, '//x:CdtTrfTxInf/x:Dbtr/x:Nm/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 26);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (110, '//x:CdtTrfTxInf/x:Cdtr/x:Nm/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 27);
INSERT INTO fincfg.routingkeywordmaps (keywordid, tag, mt, selector, mapid) VALUES (126, '//x:CdtTrfTxInf/x:PmtId/x:InstrId/text()', 'FIToFICstmrCdtTrf', 'selectoriso', 28);
Insert into FINCFG.ROUTINGKEYWORDMAPS (KEYWORDID, TAG, MT, SELECTOR, MAPID) Values (113, '//x:InstdAgt/x:FinInstnId/x:BIC/text()|//x:CdtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFIPmtStsRpt', 'selectoriso', 152);
Insert into FINCFG.ROUTINGKEYWORDMAPS (KEYWORDID, TAG, MT, SELECTOR, MAPID) Values (112, '//x:DbtrAgt/x:FinInstnId/x:BIC/text()', 'FIToFIPmtStsRpt', 'selectoriso', 153);
COMMIT;





INSERT INTO fincfg.queuemsggroups (msgtype, kword1, kword2, kword3, kword4, kword5) VALUES ('FIToFICstmrCdtTrf', 'Receiver', 'ValueDate', NULL, NULL, NULL);



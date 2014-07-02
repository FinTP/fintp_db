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



INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('MSGTYPES_MTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QMOVEPRIVMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QTYPEACTIONMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ERRORCODES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROLES_ROLEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('BATCHREQUESTS_REQUESTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUETYPES_TYPEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEPERFORMANCE_SERVICEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERSROLEMAP_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDMAPS_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGRULES_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUEACTIONS_ACTIONID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('SERVICEMAPS_SERVICEID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGKEYWORDS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ROUTINGSCHEMAS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('TIMELIMITS_GUID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('QUEUESROLEMAP_MAPID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('ALERTS_ALERTID', 999);
INSERT INTO fincfg.idgenlist (tabcolname, idvalue) VALUES ('USERS_USERID', 999);
COMMIT;


INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (0, 'Authorize', '', 1, 1, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (6, 'Create Refusal Message', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (12, 'Security:Pass', '', 0, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (13, 'Security:Fail', '', 1, 0, 0, 80, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (14, 'Move to Edit', '', 0, 0, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (3, 'Reject', '', 1, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (4, 'Reject after COT', '', 0, 0, 1, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (7, 'Client Reject', '', 0, 1, 0, 70, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (16, 'View Possible Duplicates', '', 1, 0, 0, NULL, 0);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (1, 'Batch', '', 0, 1, 1, 60, 1);
INSERT INTO fincfg.queueactions (actionid, "action", description, currmsg, selmsg, groupmsg, priority, addoptions) VALUES (2, 'Move', '', 1, 1, 0, 50, 1);
COMMIT;


INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (101, 'Payment');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (102, 'Duplicate');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (103, 'Investigation');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (104, 'Sanction');
INSERT INTO fincfg.queuetypes (typeid, typename) VALUES (105, 'History');
COMMIT;


INSERT INTO fincfg.routingkeywords (guid, keyword, comparer, selector, description, selectoriso) VALUES
  (134, 'OrigInstrID', 'string', '(?<value>.*)', 'Original Instructed ID', '(?<value>.*)'),
  (117, 'TTC', 'string', '(?<value>.*)', 'Transaction type code', '(?<value>.*)'),  
  (124, 'OrigRef', 'string', '(?<value>.*)', 'Original transaction reference', '(?<value>.*)'),
  (125, 'OrigBatchID', 'string', '(?<value>.*)', 'Original batch identifier', '(?<value>.*)'),
  (126, 'RelRef', 'string', '(?<value>.*)', 'Related transaction reference', '(?<value>.*)'),
  (127, 'RCode', 'string', '(?<value>.*)', 'Reason code', '(?<value>.*)'),
  (129, 'DbtID', 'string', E'(?:[^\\n]*\\n)*(?<value>.*)$', 'Debtor ID', '(?<value>.*)'),
  (102, 'ValueDate', 'string', E'(?<value>\\d{6,8})', 'Value Date', E'(?<value>\\d{6,8}|\\d{4}[-]\\d{2}[-]\\d{2})'),
  (101, 'Reference', 'string', '(?<value>.*)', 'Reference', '(?<value>.*)'),
  (103, 'Amount', 'string', E'(?<value>[\\d,\\.]{1,})$', 'Amount', E'(?<value>[\\d,\\.]{1,})$'),
  (104, 'Currency', 'string', '(?<value>[A-Z]{3})', 'Currency', '(?<value>[A-Z]{3})'),
  (105, 'DbtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Debtor Account', '(?<value>.*)'),
  (106, 'CdtAccount', 'string', E'[^\\/]*\\/(?<value>\\w+)', 'Creditor Account', '(?<value>.*)'),
  (132, 'IssDate', 'date', '(?<value>d{6,8})', 'Issuance Date', '(?<value>.*)'),
  (107, 'OrdBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Ordering Bank', '(?<value>[A-Z 0-9]{8})'),
  (108, 'BenBank', 'string', '(?<value>[A-Z 0-9]{8})', 'Beneficiary Bank', '(?<value>[A-Z 0-9]{8})'),
  (128, 'MatDate', 'date', '(?<value>.*)', 'Maturity Date', '(?<value>.*)'),
  (109, 'DbtCustName', 'string', E'[^\\n]*\\n(?<value>[^\\n]*)\\n.*', 'Debtor Customer Name', '(?<value>.*)'),
  (110, 'CdtCustName', 'string', E'[^\n]*\n(?<value>[^\n]*)[\n]*.*', 'Creditor Customer Name', '(?<value>.*)'),
  (111, 'Service', 'string', '(?<value>.*)', 'Service', '(?<value>.*)'),
  (112, 'Sender', 'string', '(?<value>[A-Z 0-9]{8})', 'Sender', '(?<value>[A-Z 0-9]{8})'),
  (113, 'Receiver', 'string', '(?<value>[A-Z 0-9]{8})', 'Receiver', '(?<value>.*)'),
  (133, 'CdtID', 'string', E'(?:[^\\n]*\\n)*(?<value>.*)$', 'Creditor ID', '(?<value>.*)');
COMMIT;



INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (2, 'Administrator', 'n/a', 0);
INSERT INTO fincfg.roles (roleid, name, description, usercreated) VALUES (3, 'Reports', 'n/a', 0);


INSERT INTO fincfg.params (name, value, description, category) VALUES ('Duplicate Detection Period', '999', '*business days', 'ARCHIVE');
COMMIT;

INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Blocking funds)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Refusal to Pay)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('AML Rejected (Reinitiate)', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Interface sucess', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Interface error', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Network accepted', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Network error', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('New', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Partially refused', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Partially settled', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Possible Duplicate', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Reactivated', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Received', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Refused', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected by user', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected by client', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Rejected after COT', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Sent', NULL);
INSERT INTO fincfg.reportingtxstates (status, description) VALUES ('Settled', NULL);
COMMIT;



INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('EventsWatcher', 1, 3, 0, 0, now(), NULL, NULL, 0, NULL, NULL, '538c2a62-19c55082-7e820001', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('RoutingEngine', 3, 3, 0, 0, now(), NULL, NULL, 0, NULL, NULL, '538c2a62-83ec5082-b63b0001', NULL, NULL, NULL, NULL, NULL);
INSERT INTO fincfg.servicemaps (friendlyname, serviceid, status, lastsessionid, heartbeatinterval, lastheartbeat, "version", partner, servicetype, ioidentifier, exitpoint, sessionid, duplicatecheck, duplicateq, duplicatemap, duplicatenotifq, delayednotifq) VALUES ('FinTPDB000', 10, 3, 0, 50, now(), NULL, 'DB Service', 1, NULL, NULL, '538c2a63-308a5082-23320001', NULL, NULL, NULL, NULL, NULL);

INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (10, now(), 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (1, now(), 0, 0, 0, 0, 0, 0, 0, 0);
INSERT INTO findata.serviceperformance (serviceid, insertdate, mintransactiontime, maxtransactiontime, meantransactiontime, sequenceno, ioidentifier, sessionid, commitedtrns, abortedtrns) VALUES (3, now(), 0, 0, 0, 0, 0, 0, 0, 0);
